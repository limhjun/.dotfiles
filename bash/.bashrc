# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash"

# alias
alias ll='ls -la'

# vim path 
export PATH="/opt/homebrew/bin:$PATH"

# color
export TERM=xterm-256color

. "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="/Users/hyungjunlim/.antigravity/antigravity/bin:$PATH"
