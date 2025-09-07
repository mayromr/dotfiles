function change_tmux_session
    if test "$TMUX"
        set -l all_sessions (tmux list-sessions | sed -E 's/:.*$//')
        set -l current_session (tmux display-message -p '#S')

        string match -v $current_session $all_sessions | fzf --reverse | xargs tmux switch-client -t
    else
        echo "Cannot change tmux session outside of TMUX"
    end
end
