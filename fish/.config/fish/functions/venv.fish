function venv
    if test "$VENV_DIR"
        set -l selected_venv (command ls $VENV_DIR | fzf)
        if test -n "$status"
            source "$VENV_DIR$selected_venv/bin/activate.fish"
        end
    else
        echo "Please set your venv dir using `set -Ux VENV_DIR <VENV_DIR_PATH>`"
    end
end
