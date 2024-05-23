# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tahmhd/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd.mm.yyyy"

plugins=(git colorize brew macos zsh-syntax-highlighting zsh-autosuggestions zsh-nvm)

source $ZSH/oh-my-zsh.sh

#source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.toolbox/bin:$PATH

alias wake="wakeonlan -i 192.168.0.255 -p 9 C8:1F:66:14:80:65"
alias cloudui='python3 ~/.config/dcv-cdd.py connect dev-dsk-tahmhd-2a-68ee6ae5.us-west-2.amazon.com'
alias bb='brazil-build; afplay /System/Library/Sounds/Funk.aiff'
alias bbr='brazil-recursive-cmd --allPackages brazil-build; afplay /System/Library/Sounds/Funk.aiff'

export DEVELOPER_ACCOUNT_ID="Tahmhd"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home

# Add tunnel script
#source ~/.ssh/tunnel_script

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
export PATH="$PATH:$HOME/.spicetify"

PATH="/Users/tahmhd/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/tahmhd/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/tahmhd/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/tahmhd/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/tahmhd/perl5"; export PERL_MM_OPT;

export PATH="/Applications/Fortify/Fortify_SCA_and_Apps_21.2.2/bin:$PATH"
#eval "$(starship init zsh)"

export PATH="/Applications/Fortify/Fortify_SCA_and_Apps_22.1.0/bin:$PATH"

export PATH="/Applications/Fortify/Fortify_SCA_and_Apps_22.1.0/bin:$PATH"

eval $(thefuck --alias)
