# ============================================================================
# LLVM 编译器配置
# ============================================================================

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LIBRARY_PATH="/opt/homebrew/opt/llvm/lib:$LIBRARY_PATH"
export CC=/opt/homebrew/opt/llvm/bin/clang
export CXX=/opt/homebrew/opt/llvm/bin/clang++
