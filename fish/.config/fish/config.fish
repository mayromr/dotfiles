# Stolen from Folke repo :)
if status is-interactive
    # Commands to run in interactive sessions can go here

    # Cursor styles
    set -gx fish_vi_force_cursor 1
    set -gx fish_cursor_default block
    set -gx fish_cursor_insert line blink
    set -gx fish_cursor_visual block
    set -gx fish_cursor_replace_one underscore

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
end
