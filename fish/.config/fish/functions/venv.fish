function venv
    if test "$VENV_DIR"
        source "$VENV_DIR$(command ls $VENV_DIR | fzf)/bin/activate"
    else
        echo "Please set your venv dir using `set -Ux VENV_DIR <VENV_DIR_PATH>`"
    end
end
