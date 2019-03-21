# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/rsuarez/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  git-flow
  zsh-syntax-highlighting
  zsh-autosuggestions
  docker
  battery
  newline 
  history 
  node 
  npm 
  kubectl
  zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nano ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/etc/profile.d/autojump.sh
source /usr/local/share/antigen/antigen.zsh

alias j8_cgcof="export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_172`; java -version"
alias j8_eng="export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_131`; java -version"
alias stopweblogic='~/workspaces/Tools/servers/weblogic/user_projects/domains/enagas_orion/bin/stopWebLogic.sh'
alias proxy_eci='export ALL_PROXY=proxycorp.geci:8080'
alias proxy_sopra='export ALL_PROXY=alca.proxy.corp.sopra:8080'
alias sin_proxy="unset ALL_PROXY; unset HTTP_PROXY; unset HTTPS_PROXY;"
alias eci_git='git config --global user.name "FRANCISCO JAVIER LOZANO BLANCO"; git config --global user.email "ECI@localhost.com"; git config --global http.proxy http://T0000104:12345678@proxycorp.geci:8080; proxy_eci'
alias sopra_git='git config --global user.name "SUAREZ REDONDO Rafael"; git config --global user.email "rafael.saurez@soprasteria.com"; git config --global --unset http.proxy'
alias mvn_cgcof='ln -s -f ~/.m2/settings.cfgcof.cdk.xml ~/.m2/settings.xml'
alias mvn_eci='ln -Fs ~/.m2/settings.eci.xml ~/.m2/settings.xml'
alias mvn_sopra='ln -s -f ~/.m2/settings.sopra.xml ~/.m2/settings.xml'
alias mvn_orig='ln -Fs ~/.m2/settings.orig.xml ~/.m2/settings.xml'


#alias docker
alias dkps="docker ps"
alias dkst="docker stats"
alias dkpsa="docker ps -a"
alias dkimgs="docker images"
alias dkcpup="docker-compose up -d"
alias dkcpdown="docker-compose down"
alias dkcpstart="docker-compose start"
alias dkcpstop="docker-compose stop"

export USER_MEM_ARGS="-Xmx1024m"
export ORACLE_HOME=/Users/rsuarez/Oracle/Middleware/Oracle_Home
export PATH="/usr/local/sbin:$PATH"


#Get the weather information from https://www.apixu.com/
#Just create a free account to have an API key
#Download jq do convert json
zsh_weather(){

  local weather=$(curl -x "http://alca.proxy.corp.sopra:8080" -s -m 1 "https://api.apixu.com/v1/current.json?key=c5787f79ee184e258de125308182210&q=Madrid")
  #local weather=$(curl -s -m 1 "https://api.apixu.com/v1/current.json?key=c5787f79ee184e258de125308182210&q=Madrid")

  local temp=$(echo $weather | jq .current.temp_c)
  local condition=$(echo $weather | jq .current.condition.text)

  #Default value
  local color='%F{green}'
  local symbol="\uf2c7"

  if [[ $condition == *"rain"* ]] ;
  then symbol="\uf043" ; color='%F{blue}'
  fi

  if [[ $condition == *"cloudy"* || $condition == *"Overcast"* ]] ;
  then symbol="\uf0c2" ; color='%F{grey}';
  fi

  if [[ $condition == *"Clear"* ]] ;
  then symbol="\uf186" ; color='%F{grey}';
  fi

  if [[ $condition == *"Sunny"* ]] ;
  then symbol="\uf185" ; color='%F{yellow}';
  fi

  echo -n "%{$color%}$temp \u2103  $symbol"
}


# Powerlevel9k
# General config
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%K{black}%F{black} `zsh_weather` %f%k%F{black}%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2570 > "
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_OS_ICON='\uf302'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(battery user dir dir_writable todo vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time ram)

POWERLEVEL9K_TIME_FOREGROUND='black'
POWERLEVEL9K_TIME_BACKGROUND='blue'
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"

POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='magenta'

POWERLEVEL9K_TODO_FOREGROUND='black'
POWERLEVEL9K_TODO_BACKGROUND='blue'

POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='cyan'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='magenta'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'

POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='green'

POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='cyan'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='green'

POWERLEVEL9K_USER_ICON="\uF415" # 
POWERLEVEL9K_ROOT_ICON="#"
POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=..
POWERLEVEL9K_STATUS_CROSS=true



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/rsuarez/.sdkman"
[[ -s "/Users/rsuarez/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/rsuarez/.sdkman/bin/sdkman-init.sh"
