function venv
    set -f entries

    if test "$VENV_DIR"
        for venv_item in (command ls $VENV_DIR)
            set -af entries "$venv_item,$VENV_DIR$venv_item/bin/activate.fish"
        end
    end

    for local_venvs in (fd -a -p -u --exact-depth 3 '/bin/activate.fish$')
        if test -n $initial_query
            set -f initial_query current
        end

        set -af entries "$(basename (string trim -r -c "/bin/activate.fish" $local_venvs)) (from current directory),$local_venvs"
    end

    if test (count $entries) -eq 0
        echo "Found no vnev entries in vnevn dir or local dir, Please set your venv dir using `set -Ux VENV_DIR <VENV_DIR_PATH>`"
        return 1
    end

    set -l result (printf %s\n $entries | fzf --delimiter=',' --with-nth={1} --accept-nth={2} --query "$initial_query")

    if test $status -eq 0
        source $result
    end
end
