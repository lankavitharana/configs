# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/rajith/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# custom installed plugins by rajith - fzf, zsh-nvm)
plugins=(git history-substring-search fzf zsh-nvm)

source $ZSH/oh-my-zsh.sh

# Vi mode - rajith 
bindkey -v

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Below code snippet is to notify when a job is finished - rajith
preexec () {
    # Note the date when the command started, in unix time.
    CMD_START_DATE=$(date +%s)
    # Store the command that we're running.
    CMD_NAME=$1
}
precmd () {
    EXIT_STATUS=$?
    if [[ $CMD_NAME == "vim"* ]]; then
	return;
    fi
    # Proceed only if we've ran a command in the current shell.
    if ! [[ -z $CMD_START_DATE ]]; then
        # Note current date in unix time
        CMD_END_DATE=$(date +%s)
        # Store the difference between the last command start date vs. current date.
        CMD_ELAPSED_TIME=$(($CMD_END_DATE - $CMD_START_DATE))
        # Store an arbitrary threshold, in seconds.
        CMD_NOTIFY_THRESHOLD=20

        if [[ $CMD_ELAPSED_TIME -gt $CMD_NOTIFY_THRESHOLD ]]; then
            # Beep or visual bell if the elapsed time (in seconds) is greater than threshold
	    if [ "$EXIT_STATUS" -eq "0" ]; then
		    (zenity --info --title="Job Success !!!!" --icon-name=info --text="The job \"$CMD_NAME\" has finished. \n\nExit code - $EXIT_STATUS" --timeout=5 --width=300 &>/dev/null &)
		    SOUND_FILE="/usr/share/sounds/ubuntu/notifications/Positive.ogg"
	    else
		    (zenity --error --title="Job Failed !!!!" --icon-name=error --text="The job \"$CMD_NAME\" has finished. \n\nExit code - $EXIT_STATUS" --timeout=5 --width=300 &>/dev/null &)
		    SOUND_FILE="/usr/share/sounds/ubuntu/notifications/Mallet.ogg"
	    fi
            print -n '\a'
            # Send a notification
            # notify-send "$JOB_HEADER" "The job \"$CMD_NAME\" has finished. Exit status - $EXIT_STATUS" --icon "$ICON_PATH" 
	    # Playing a success or failure sound
	    (paplay $SOUND_FILE &>/dev/null &)
        fi

    	unset CMD_START_DATE
    fi
}


# Custom aliases - rajith 
# To enable disable touchpad 
touchpad() {
	if [ -z "$1" ]; then 
		echo "Invalid input, provide '1' to 'Enable' and '0' to 'Disable'";
		return;
	fi
	if [ "$1" != "1" ] && [ "$1" != "0" ]; then 
		echo "Invalid input, provide '1' to 'Enable' and '0' to 'Disable'";
		return;
	fi
	touchId=( $(xinput list | grep TouchPad | awk '{print $6}' | awk -F '=' '{print $2}') )
	deviceDetails=( $(xinput list | grep TouchPad) )
	xinput set-prop $touchId "Device Enabled" $1
	echo "Setting 'Device Enabled' property of defice id - $touchId, with value - $1"
	echo "Device - $deviceDetails"
}

# Set fzf installation directory path
export FZF_BASE="$HOME/.fzf"

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"



