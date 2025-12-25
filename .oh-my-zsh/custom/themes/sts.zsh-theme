# ~/.oh-my-zsh/custom/themes/stefan.zsh-theme

# Catppuccin Macchiato palette
local color_peach='#f5a97f'
local color_sapphire='#7dc4e4'
local color_blue='#8aadf4'
local color_green='#a6da95'
local color_mauve='#c6a0f6'
local color_yellow='#eed49f'
local color_red='#ed8796'
local color_base='#24273a'

# Semantic color assignments
local user_color=$color_sapphire
local host_color=$color_base
local dir_color=$color_base
local git_color=$color_base
local bg_user=$color_peach
local bg_dir=$color_blue
local bg_git=$color_mauve  # Changed to mauve

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{$color_red}●%f"      # Red dot for uncommitted changes
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{$color_green}✓%f"    # Green checkmark for clean
ZSH_THEME_GIT_PROMPT_ADDED=" %F{$color_green}+%f"    # Staged files
ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{$color_yellow}!%f" # Modified files
ZSH_THEME_GIT_PROMPT_DELETED=" %F{$color_red}-%f"    # Deleted files
ZSH_THEME_GIT_PROMPT_RENAMED=" %F{$color_blue}→%f"   # Renamed files
ZSH_THEME_GIT_PROMPT_UNMERGED=" %F{$color_red}═%f"   # Unmerged files
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{$color_yellow}?%f" # Untracked files
ZSH_THEME_GIT_PROMPT_AHEAD=" ↑"                       # Commits ahead
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"                      # Commits behind
ZSH_THEME_GIT_PROMPT_DIVERGED=" ↕"                    # Diverged from remote
ZSH_THEME_GIT_PROMPT_STASHED=" ⚑"                     # Stashed changes


PROMPT='%K{$bg_user} %F{$user_color}%n%f %F{$host_color}[ %m ]%f %k%K{$bg_dir} %F{$dir_color}%~%f %k%K{$bg_git}%F{$git_color}$(git_prompt_info)$(git_prompt_status)%f %k
$ '
