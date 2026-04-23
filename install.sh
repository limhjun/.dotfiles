#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_PACKAGES=(zsh bash git vim ssh)

# ── 1. Xcode Command Line Tools ──────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "[install] Xcode Command Line Tools가 없습니다."
  echo "          터미널에서 다음을 실행한 뒤 설치가 완료되면 이 스크립트를 다시 실행하세요:"
  echo "          xcode-select --install"
  exit 1
fi
echo "[ok] Xcode CLT"

# ── 2. Homebrew ───────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "[install] Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon: 현재 shell에 brew 경로 추가
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
echo "[ok] Homebrew"

# ── 3. Brewfile ───────────────────────────────────────────────────────────────
echo "[install] brew bundle 실행 중..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "[ok] Brewfile"

# ── 4. 충돌 감지 ─────────────────────────────────────────────────────────────
# stow가 링크를 만들 자리에 일반 파일이 있으면 덮어쓰지 않고 중단
CONFLICT=0
for pkg in "${STOW_PACKAGES[@]}"; do
  while IFS= read -r -d '' src; do
    # src: e.g. ~/.dotfiles/zsh/.zshrc → target: ~/.zshrc
    rel="${src#$DOTFILES_DIR/$pkg/}"
    target="$HOME/$rel"
    if [[ -e "$target" && ! -L "$target" ]]; then
      echo "[conflict] $target 이 이미 일반 파일로 존재합니다. 백업 후 삭제하세요."
      CONFLICT=1
    fi
  done < <(find "$DOTFILES_DIR/$pkg" -type f -print0)
done
if [[ $CONFLICT -eq 1 ]]; then
  echo ""
  echo "충돌을 해결한 뒤 이 스크립트를 다시 실행하세요."
  exit 1
fi
echo "[ok] 충돌 없음"

# ── 5. Stow ───────────────────────────────────────────────────────────────────
echo "[install] stow 심볼릭 링크 생성 중..."
cd "$DOTFILES_DIR"
stow --restow "${STOW_PACKAGES[@]}"
echo "[ok] stow (${STOW_PACKAGES[*]})"

# ── 6. 완료 ──────────────────────────────────────────────────────────────────
echo ""
echo "완료. 새 터미널을 열어서 환경이 정상 로드되는지 확인하세요."
