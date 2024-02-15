# AI for command line.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"


# Cache for my theme.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# My Theme for my terminal + Custom terminal.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Version control, Highlighting and autosuggestions
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
)

# Path for my custom terminal.
source $ZSH/oh-my-zsh.sh

# Path for My Theme for my terminal.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh





[ -s "/Users/eveeify/.bun/_bun" ] && source "/Users/eveeify/.bun/_bun"

# Fast javascript runtime.
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Ruby version manager lets me change my ruby version.
export PATH="$PATH:$HOME/.rvm/bin"


# History manager lets me see previous history.
eval "$(atuin init zsh)"

# Java Version Manager lets me change my java version.
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# Dockerize things into virtual machines.
export PATH=$PATH:~/.docker/bin.

# Export all paths
export PATH=$PATH:/usr/local/bin/

alias ls='lsd --long'


# Neofetch Images
export MAGICK_HOME="$HOME/ImageMagick-7.1.1"

# AI for the commandline.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

