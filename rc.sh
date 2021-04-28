if [ -n "$ZSH_VERSION" ]; then
    source ./antigen.zsh

    # Load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # Bundles
    antigen bundle git
    antigen bundle buonomo/yarn-completion

    # Syntax highlighting bundle.
    antigen bundle zsh-users/zsh-syntax-highlighting

    # Load the theme.
    antigen theme robbyrussell

    # Tell Antigen that you're done.
    antigen apply
fi
