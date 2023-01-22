### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})‚Ä¶%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for nnexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

export PROMPT_EOL_MARK=""

########## hooks
DISABLE_AUTO_TITLE="true"
function precmd_set_tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}
autoload -Uz "add-zsh-hook"
add-zsh-hook "precmd" "precmd_set_tab_title"


########## bindkeys
bindkey -v
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

# bash like ctrl-d wrapper for IGNOREEOF
setopt ignoreeof
function bash-ctrl-d() {
  if [[ $CURSOR == 0 && -z $BUFFER ]]
  then
    [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
    if [[ "$LASTWIDGET" == "bash-ctrl-d" ]]
    then
      (( --__BASH_IGNORE_EOF <= 0 )) && exit
    else
      (( __BASH_IGNORE_EOF = IGNOREEOF ))
    fi
    echo "Use "exit" to leave the shell."
    zle send-break
  else
    zle delete-char-or-list
  fi
}
zle -N bash-ctrl-d
bindkey "^D" bash-ctrl-d


########## prezto
# https://github.com/sorin-ionescu/prezto/tree/master/modules
zinit snippet "PZT::modules/environment/init.zsh"
zinit snippet "PZT::modules/history/init.zsh"
setopt hist_ignore_space


########## completions
zinit ice wait lucid blockf
zinit light "zsh-users/zsh-completions"

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
## awscli
complete -C $(brew --prefix awscli)/bin/aws_completer aws
## gcloud
#zinit ice wait lucid \
#  as"completion" if'[[ -n "$commands[gcloud]" ]]'
#zinit snippet "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


########## autosuggestions
zinit ice wait lucid \
  atload'_zsh_autosuggest_start'
zinit light "zsh-users/zsh-autosuggestions"


########## highlight
zinit ice wait lucid \
  atinit"zpcompinit; zpcdreplay; bashcompinit"
zinit light "zdharma-continuum/fast-syntax-highlighting"


########## directory
zinit ice wait lucid \
  atclone"dircolors -b LS_COLORS > c.zsh" atpull"%atclone" \
  pick"c.zsh" \
  nocompile"!" \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light "trapd00r/LS_COLORS"


########## prompt
zinit ice \
  as"program" from"gh-r" \
  atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' atpull"%atclone" \
  src"init.zsh"
zinit light "starship/starship"


########## fuzzy finder
# install script of skim unsupported arm
#zinit ice wait lucid \
#  as"program" \
#  atclone"./install" atpull"%atclone" \
#  pick"bin/*" multisrc"shell/key-bindings.zsh" \
#  atload'export SKIM_DEFAULT_OPTIONS="--layout=reverse"'
#zinit load "lotabout/skim"

zinit ice wait lucid \
  as"program" \
  atclone"cargo build --release; mkdir -p bin; mv target/release/sk bin" atpull"%atclone" \
  pick"bin/*" multisrc"shell/{completion,key-bindings}.zsh" \
  atload'export SKIM_DEFAULT_OPTIONS="--layout=reverse"'
zinit light "lotabout/skim"


########## cd
# dead from zsh 5.9
# zinit ice wait lucid \
#   pick"init.sh" \
#   atload"ENHANCD_FILTER=sk:fzf:cd; export ENHANCD_FILTER"
# zinit light "b4b4r07/enhancd"

zinit ice wait lucid \
  as"program" \
  atclone"cargo build --release; mkdir -p bin; mv target/release/zoxide bin" atpull"%atclone" \
  pick"bin/*" \
  atload'eval "$(zoxide init zsh)"'
zinit light "ajeetdsouza/zoxide"

# https://blog.katio.net/page/zplugin

### End of Zinit's installer chunk
