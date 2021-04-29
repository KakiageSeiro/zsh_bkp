#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

#lsコマンドの色を変更
export LSCOLORS=gxfxcxdxbxegedabagacad

#rbenv設定
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuta/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuta/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuta/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuta/google-cloud-sdk/completion.zsh.inc'; fi

# エイリアス
alias dc=docker-compose
alias ll=ll
alias l=ll
function ll() {
    ls -la -G;
    pwd | printf "\033[36m$(CAT)\033[m\n";
}
function l() {
    ls -l -G;
    pwd | printf "\033[36m$(CAT)\033[m\n";
}
# lsの色分け
export LSCOLORS=Cxfxcxdxbxegedabagacad



export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

#/Users/yuta/go/binにパスを通す
export PATH="$HOME/./go/bin:$PATH"

#PROMPT='(｢･ω･)｢'
#PROMPT='(∩＾ω＾)⊃━☆゜.*・。'
#PROMPT='⊂⌒~⊃｡Д｡)⊃'
#PROMPT='(っ ˘ω˘ ).。o'
#PROMPT='(　 ﾟДﾟ)⊃'
#PROMPT='( ﾟДﾟ)｡oＯ'
#PROMPT='( ﾟДﾟ).｡oＯ('
#PROMPT='( ﾟДﾟ).｡oＯ（'
#PROMPT='( ˘⊖˘) 。o（ '
PROMPT='( ﾟДﾟ) 。o（ '

#sudo したときのプロンプト
export SUDO_PROMPT="[sudo] さっさとパスワード入れなさいよ、このバカ犬！ > "

# git のカラー表示
git config --global color.ui auto

# ヒストリ (履歴) を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# [TAB] でパス名の補完候補を表示したあと、
# 続けて [TAB] を押すと候補からパス名を選択できるようになる
# 候補を選ぶには [TAB] か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

