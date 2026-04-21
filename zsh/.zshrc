# 기본 옵션
setopt NO_BEEP
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# 자동완성
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C  # 캐시 사용 (빠름)
fi

# 프롬프트 (간단하고 빠르게)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %F{green}$%f '

# PATH 설정
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# LLVM Toolchain (C++ 개발용)
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export SDKROOT=$(xcrun --show-sdk-path)

# Aliases
alias ll='ls -la'

# SDKMAN (lazy loading)
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
    unset -f sdk
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
}

# Bun (lazy loading)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
_bun_init() {
    unset -f _bun_init
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
}
# 첫 bun completion 시 로드
compdef _bun_init bun

# FZF (lazy loading)
if [[ -f ~/.fzf.zsh ]]; then
    _fzf_init() {
        unset -f _fzf_init
        source ~/.fzf.zsh
    }
    # Ctrl+R 누를 때 로드
    zle -N _fzf_init
    bindkey '^R' _fzf_init
fi

# Direnv (lazy loading)
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# opencode
export PATH=/Users/hyungjunlim/.opencode/bin:$PATH


# bun completions
[ -s "/Users/hyungjunlim/.bun/_bun" ] && source "/Users/hyungjunlim/.bun/_bun"
