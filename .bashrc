case $- in
  *i*) ;;
    *) return;;
esac

export OSH='/home/oliste/.oh-my-bash'

OSH_THEME="brainy"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS='[dd.mm.yyyy]'


OMB_USE_SUDO=true

# OMB completions
completions=(
  git
  ssh
)

# OMB aliases
aliases=(
  general
)

# OMB plugins
plugins=(
  git
  bashmarks
)

source "$OSH"/oh-my-bash.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
