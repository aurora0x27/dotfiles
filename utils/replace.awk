# Replace the `${{name}}` marked variable with pre-defined variables in another awk file
BEGIN {
    # Load pre-defined variables
    if (ARGC < 3) {
        print "Usage: awk -f replace.awk <variables file> <template file>" > "/dev/stderr"
        exit 1
    }
    
    while ((getline line < ARGV[1]) > 0) {
        if (match(line, /^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*=[[:space:]]*("([^"]*)"|([^[:space:]#]*))/, arr)) {
            variable_name = arr[1]
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
        result = result substr(line, offset, RSTART - 1)
        
        var_name = arr[1]
        if (var_name in variables) {
            result = result variables[var_name]
        } else {
            # Undefined variable
            result = result arr[0]
            print "Warn: Undefined variable '" var_name "'" > "/dev/stderr"
        }
        
        offset += RSTART + RLENGTH - 1
    }
    
    result = result substr(line, offset)
    print result
}
