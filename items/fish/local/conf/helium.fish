fish_add_path /opt/homebrew/bin \
              /opt/homebrew/opt/rustup/bin \
              /opt/homebrew/opt/llvm@20/bin \
              "$HOME/.local/bin" \
              "$HOME/.cargo/bin" \
              "/Library/Input Methods/Fcitx5.app/Contents/bin"

set -gx LLVM_HOME "/opt/homebrew/opt/llvm@20"
set -gx RUSTFLAGS "$RUSTFLAGS -A dead_code"
set -gx MallocNanoZone=0
