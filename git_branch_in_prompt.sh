echo "Sourcing git branch in prompt..."

if [ -n "$ZSH_VERSION" ]; then
    # noop
elif [ -n "$BASH_VERSION" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        c_reset='\[\e[0m\]'
        c_user='\[\e[1;34m\]'
        c_path='\[\e[0;32m\]'
        c_git_clean='\[\e[0;36m\]'
        c_git_dirty='\[\e[0;35m\]'
    else
        c_reset=
        c_user=
        c_path=
        c_git_clean=
        c_git_dirty=
    fi

    git_prompt ()
    {
        if ! git rev-parse --git-dir > /dev/null 2>&1; then
            return 0
        fi

        git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

        if git diff --quiet 2>/dev/null >&2; then
            git_color="$c_git_clean"
        else
            git_color="$c_git_dirty"
        fi

        echo " [$git_color$git_branch${c_reset}]"
    }

    #PROMPT_COMMAND='PS1="${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}$(git_prompt)\$ "'
    PROMPT_COMMAND='PS1="${c_path}\w${c_reset}$(git_prompt)\$ "'
else
   # noop
fi