if [ -n "$ZSH_VERSION" ]; then
    # noop
    ZSH_DISABLE_COMPFIX=true

    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

        autoload -Uz compinit
        compinit
    fi
fi
