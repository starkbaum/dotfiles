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
local color_yellow='#df8e1d' # Added for high-contrast host visibility
local local_teal='#179299'  # High-contrast Git branch visibility

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX="  "                     # Git branch icon with spacing
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

# Clean minimal prompt with user, maroon host, folder and git icons
PROMPT='%F{$color_yellow} %n%f %F{$color_peach}  %m%f %F{$color_blue}  %~%f%F{$local_teal}$(git_prompt_info)%f%F{$color_base}$(git_prompt_status)%f
$ '

