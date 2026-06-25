set -gx LANG                    en_US.UTF-8
set -gx LC_CTYPE                zh_CN.UTF-8
set -gx LC_TIME                 C.UTF-8
set -gx LESSCHARSET             UTF-8
set -gx DEBUGINFOD_CACHE_PATH   ~/.cache/gdb-symbols

# force C++ colored diagnostic output
set -gx CFLAGS                  "$CFLAGS -fdiagnostics-color=always"
set -gx CXXFLAGS                "$CXXFLAGS -fdiagnostics-color=always"
set -gx CCFLAGS                 "$CCFLAGS -fdiagnostics-color=always"
# force C, C++, Cpp (pre-processor) colored diagnostic output
set -gx CPPFLAGS                "$CPPFLAGS -fdiagnostics-color=always"

alias z="zathura"
alias pdb="python -m pdb"
alias grep='rg'
alias vi-git="$HOME/.local/opt/nvim/bin/nvim"

# pnpm
set -gx                         PNPM_HOME "$HOME/.local/share/pnpm"
contains "$PNPM_HOME" $PATH; or fish_add_path "$PNPM_HOME"
# pnpm end

fish_add_path "$HOME/.luarocks/bin" "$HOME/.cargo/bin" "$HOME/.zvm/bin"
set -gx VCPKG_ROOT "$HOME/.local/opt/vcpkg"
