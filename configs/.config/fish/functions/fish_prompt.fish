function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus

    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_hide_untrackedfiles 1
    set -g __fish_git_prompt_color_branch magenta --bold
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""
    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_invalidstate "✖"
    set -g __fish_git_prompt_char_cleanstate ""
    set -g __fish_git_prompt_char_stateseparator
    set -g __fish_git_prompt_color red
    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    set -g __fish_git_prompt_color_cleanstate green --bold

    set -l prefix_color
    if test $pipestatus = 0
       set prefix_color green
    else
       set prefix_color red
    end

    # PWD
    echo -n (set_color $prefix_color)"~> "(set_color -o cyan)(basename (prompt_pwd))(set_color normal)
    set_color normal

    printf '%s' (fish_vcs_prompt)
    echo -n ' '
end