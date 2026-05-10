function fcp --description "Copy file(s) as Finder items (or text path) to clipboard"
    if not set -q argv[1]
        echo "Usage: fcp [--text] <file> [file2...]" >&2
        return 1
    end

    set -l mode "file"
    if test "$argv[1]" = "--text"
        set mode "text"
        set -e argv[1]
        if not set -q argv[1]
            echo "fcp: missing file argument after --text" >&2
            return 1
        end
    end

    set -l abs_paths
    for f in $argv
        set -l abs_path (builtin realpath "$f" 2>/dev/null; or readlink -f "$f" 2>/dev/null; or begin
            if test -e "$f"
                if string match -q -- '/*' "$f"
                    set abs_path "$f"
                else
                    set abs_path "$PWD/$f"
                end
            else
                echo "fcp: file '$f' does not exist" >&2
                return 1
            end
        end)
        if test -z "$abs_path"
            echo "fcp: cannot resolve path for '$f'" >&2
            return 1
        end
        set -a abs_paths "$abs_path"
    end

    switch $mode
        case text
            set -l text (string join "\n" $abs_paths)
            echo -n "$text" | pbcopy
        case file
            set -l apple_script_parts
            for p in $abs_paths
                set -l escaped (string replace -a '\\' '\\\\' "$p" | string replace -a '"' '\\"')
                set -a apple_script_parts "POSIX file \"$escaped\""
            end
            set -l script "set the clipboard to {"(string join ", " $apple_script_parts)"}"
            osascript -e "$script" 2>/dev/null
            if test $status -ne 0
                echo "fcp: osascript failed (invalid characters in path?)" >&2
                return 1
            end
    end

    echo "copied: "(string join ", " $abs_paths) (test "$mode" = text && echo "(as text)" || echo "(as file)")
end
