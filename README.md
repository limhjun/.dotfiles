# dotfiles

Apple Silicon Mac 개발 환경을 선언적으로 관리하는 개인 dotfiles.  
`install.sh` 하나로 새 맥에서 동일 환경을 재현할 수 있다.

## 구조

```
~/.dotfiles/
├── bash/        # .bashrc
├── git/         # .gitconfig, .gitignore_global
├── ssh/         # .ssh/config (키 파일은 포함하지 않음)
├── vim/         # .vimrc
├── zsh/         # .zshrc, .zshenv, .zprofile
├── Brewfile     # Homebrew 패키지 목록
└── install.sh   # 부트스트랩 스크립트
```

심볼릭 링크는 [GNU Stow](https://www.gnu.org/software/stow/)로 관리한다.  
각 디렉토리가 하나의 stow 패키지이며, `stow <패키지명>` 한 번으로 홈 디렉토리에 링크가 생성된다.

## 새 맥에서 설치

```bash
git clone git@github.com:limhjun/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

`install.sh`가 순서대로 처리한다:

1. Xcode Command Line Tools 확인
2. Homebrew 설치 (없을 경우)
3. `brew bundle`로 Brewfile 패키지 설치
4. 기존 dotfile 충돌 감지
5. `stow`로 심볼릭 링크 일괄 생성

## 설치 후 수동 작업

**SSH 키** — repo에 포함하지 않는다. 1Password 또는 직접 복사 후 권한을 맞춘다.

```bash
chmod 600 ~/.ssh/id_ed25519
```

**머신 전용 설정** — `~/.zshrc.local`을 직접 생성한다. `.zshrc`에서 자동으로 로드된다.

```bash
# ~/.zshrc.local (repo에 포함되지 않음)
export SOME_API_KEY="..."
```

## 패키지 목록 갱신

Homebrew에 새 패키지를 설치한 뒤 Brewfile을 업데이트:

```bash
brew bundle dump --describe --force --file=~/.dotfiles/Brewfile
```
