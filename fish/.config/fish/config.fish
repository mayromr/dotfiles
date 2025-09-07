if status is-interactive
    # Commands to run in interactive sessions can go here

    # Path
    set -x fish_user_paths
    fish_add_path ~/.cargo/bin

    set -gx EDITOR (which nvim)
    set -gx VISUAL $EDITOR
    set -gx SUDO_EDITOR $EDITOR

    # Exports
    set -x MANPAGER "nvim +Man!"

    alias ls="eza --color=always --icons --group-directories-first"
    alias la 'eza --color=always --icons --group-directories-first --all'
    alias ll 'eza --color=always --icons --group-directories-first --all --long'
    abbr l ll

    # Editor
    abbr vim nvim
    abbr vi nvim
    abbr v nvim

    starship init fish | source
    pyenv init - fish | source
end
