// getSdfRoundedRectangle 函数:
// 计算点 `p` 到一个圆角矩形的有符号距离。
// `xy` 是矩形的中心，`b` 是矩形半宽/半高，`r` 是圆角半径。
float getSdfRoundedRectangle(in vec2 p, in vec2 xy, in vec2 b, in float r)
{
    // 基础矩形 SDF 计算
    vec2 d = abs(p - xy) - b + r;
    // 返回点到圆角矩形的有符号距离
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0) - r;
}

// getSdfTaperedCapsule 函数:
// 计算点 p 到一个两端收束的胶囊体的有符号距离。
// `a` 和 `b` 是胶囊体的起点和终点，`r` 是最大半径。
float getSdfTaperedCapsule(in vec2 p, in vec2 a, in vec2 b, in float r)
{
    vec2 pa = p - a, ba = b - a;
    // h 是点 p 在线段 ab 上的投影的插值位置（从 0.0 到 1.0）
    float h = clamp(dot(pa,ba) / dot(ba,ba), 0.0, 1.0);

    // --- 关键修改部分 ---
    // 让半径从起点（h=0）的一个非常小的值，线性插值到终点（h=1）的最大半径 r。
    // 这将创建一个从尖端到平直底边的三角形或楔形效果。
    // 0.01 是起始的最小半径，防止完全消失
    float currentRadius = mix(0.01 * r, r, h);
    // 如果你觉得线性过渡太生硬，可以使用 smoothstep 让过渡更平滑：
    // float currentRadius = mix(0.01 * r, r, smoothstep(0.0, 1.0, h));
    // --- 关键修改部分结束 ---

    // 返回点 p 到投影点的距离，减去动态半径，得到有符号距离。
    return length(pa - h*ba) - currentRadius;
}

// normalize 函数:
vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

// antialising 函数:
float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

// getRectangleCenter 函数:
vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

// ease 函数:
float ease(float x) {
    return pow(1.0 - x, 3.0);
}

// saturate 函数:
vec4 saturate(vec4 color, float factor) {
    float gray = dot(color, vec4(0.299, 0.587, 0.114, 0.)); // luminance
    return mix(vec4(gray), color, factor);
}

vec4 TRAIL_COLOR = iCurrentCursorColor;
const float DURATION = 0.2; //IN SECONDS

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);

    // 计算光标圆角半径
    float cursorRadius = currentCursor.w * 0.5; // 圆角半径等于光标高度的一半

    // 计算轨迹的最大宽度（即胶囊体的最大半径）
    float cursorDistance = distance(centerCC, centerCP);
    const float maxDistance = 0.2;
    float taperFactor = smoothstep(0.0, maxDistance, cursorDistance);

    // 关键改动：调整 `maxTrailRadius` 的混合参数
    // 将快速移动时的宽度从 0.8 减小到 0.4
    // 将缓慢移动时的宽度从 1.5 减小到 1.0
    // 这会让轨迹整体更细，动画效果更内敛。
    float maxTrailRadius = mix(cursorRadius * 0.9, cursorRadius * 1.0, 1.0 - taperFactor);

    // 使用 getSdfTaperedCapsule 函数来绘制柳叶形状的轨迹
    float sdfTrail = getSdfTaperedCapsule(vu, centerCP, centerCC, maxTrailRadius);

    // 使用新的圆角矩形 SDF 函数绘制光标
    float sdfCurrentCursor = getSdfRoundedRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5, cursorRadius);

    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float easedProgress = ease(progress);
    float lineLength = distance(centerCC, centerCP);

    vec4 newColor = vec4(fragColor);
    vec4 trail = TRAIL_COLOR;
    trail = saturate(trail, 2.5);

    // 绘制轨迹
    newColor = mix(newColor, trail, antialising(sdfTrail));
    // 绘制当前光标
    newColor = mix(newColor, trail, antialising(sdfCurrentCursor));

    newColor = mix(newColor, fragColor, step(sdfCurrentCursor, 0.));

    fragColor = mix(fragColor, newColor, step(sdfCurrentCursor, easedProgress * lineLength));
}
