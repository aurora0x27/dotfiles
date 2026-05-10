fish_add_path /opt/homebrew/bin \
              /opt/homebrew/opt/rustup/bin \
              /opt/homebrew/opt/llvm@20/bin \
              "$HOME/.local/bin" \
              "$HOME/.cargo/bin" \
              "/Library/Input Methods/Fcitx5.app/Contents/bin"

set -gx LLVM_HOME "/opt/homebrew/opt/llvm@20"
set -gx RUSTFLAGS "$RUSTFLAGS -A dead_code"
set -gx MallocNanoZone 0

set -gx CPLUS_INCLUDE_PATH "$HOME/.local/include"
set -gx HTTP_PROXY 'http://127.0.0.1:2080'
set -gx HTTPS_PROXY 'http://127.0.0.1:2080'
set -gx VCPKG_ROOT "$HOME/.local/opt/vcpkg"

fish_add_path /opt/homebrew/opt/openjdk@17/bin
fish_add_path /opt/homebrew/opt/texinfo/bin

alias vi-git '~/.local/opt/nvim/bin/nvim'

alias z=zathura
