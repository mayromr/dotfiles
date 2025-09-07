function dev
    if test "$DEV_DIR"
        cd "$DEV_DIR/$(command ls /Users/mayrom.rabinovich/dev | fzf)"
    else
        echo "Please set your dev dir using `set -Ux DEV_DIR <DEV_DIR_PATH>`"
    end
end
