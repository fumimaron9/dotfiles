### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk


# bashcompinit
autoload bashcompinit
bashcompinit


########## bindkey
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


########## prezto
# https://github.com/sorin-ionescu/prezto/tree/master/modules
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/history/init.zsh


########## completions
zinit ice wait"0" blockf
zinit light zsh-users/zsh-completions

# completion menu select
zstyle ':completion:*:default' menu select=2

# match both upper and lower characters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


########## autosuggestions
zinit ice wait"0" atload"_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions


########## highlight
zinit ice wait"0" atinit"zpcompinit; zpcdreplay; bashcompinit" lucid
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light trapd00r/zsh-syntax-highlighting-filetypes


########## LS_COLORS
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zinit load trapd00r/LS_COLORS


########## prompt
# https://starship.rs/guide/
eval "$(starship init zsh)"


########## fzf
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'
#export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history



#zstyle ':prezto:*:*' color 'yes'
#
## https://github.com/sorin-ionescu/prezto/tree/master/modules
#zinit snippet PZT::modules/environment/init.zsh
#zinit snippet PZT::modules/history/init.zsh
#
#AGKOZAK_MULTILINE=0
#AGKOZAK_LEFT_PROMPT_ONLY=1
#AGKOZAK_PROMPT_DIRTRIM=0
#AGKOZAK_USER_HOST_DISPLAY=0
#AGKOZAK_PROMPT_DIRTRIM=1
#zinit load agkozak/agkozak-zsh-prompt
#
## https://github.com/whi-tw/.zshrc/blob/f0a5d3e77ec657e7c2f4bebc61b94ea4e32340a2/70-zplugin-loading-plugins.zsh
#zinit light zdharma/z-p-submods
#
#
#
#
#
#zinit ice wait'0' atload'_zsh_autosuggest_start' lucid
#zinit light zsh-users/zsh-autosuggestions
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
#
#
#
#
#
## zsh
#zinit ice wait"0" blockf lucid
#zinit light zsh-users/zsh-completions
#
## docker
#zinit ice as"completion" if'[[ -n "$commands[docker]" ]]'
#zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
#
## pamac
#zinit ice as"completion" if'[[ -n "$commands[pamac]" ]]'
#zinit snippet 'https://aur.archlinux.org/cgit/aur.git/plain/_pamac?h=pamac-zsh-completions'
#
## Syntax Highlighting (should always be at the end)
#zinit ice wait"0" atinit"zpcompinit; zpcdreplay; bashcompinit" lucid
#zinit light zdharma/fast-syntax-highlighting
