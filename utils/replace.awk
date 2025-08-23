# 輸入一個變量定義文件和一個模板文件, 並將模板文件中的'${{name}}'
# 替換成 name 變量的值
BEGIN {
    # 加载变量定义文件
    if (ARGC < 3) {
        print "Usage: awk -f replace.awk <variables file> <template file>" > "/dev/stderr"
        exit 1
    }
    
    # 处理变量文件
    while ((getline line < ARGV[1]) > 0) {
        if (match(line, /^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*=[[:space:]]*("([^"]*)"|([^[:space:]#]*))/, arr)) {
            variable_name = arr[1]
            # 使用带引号的值或无引号的值
            variable_value = arr[3] ? arr[3] : arr[4]
            variables[variable_name] = variable_value
        }
    }
    close(ARGV[1])
    delete ARGV[1]
}

{
    line = $0
    offset = 1
    result = ""
    
    while (match(substr(line, offset), /\$\{\{([^{}]+)\}\}/, arr)) {
        # 添加匹配前的内容
        result = result substr(line, offset, RSTART - 1)
        
        var_name = arr[1]
        if (var_name in variables) {
            # 添加变量值
            result = result variables[var_name]
        } else {
            # 变量未定义，保留原占位符
            result = result arr[0]
            print "警告: 未定义的变量 '" var_name "'" > "/dev/stderr"
        }
        
        offset += RSTART + RLENGTH - 1
    }
    
    # 添加剩余内容
    result = result substr(line, offset)
    print result
}
