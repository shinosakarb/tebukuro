SESSION_NAME=tebukuro
tmux new-session -d -s $SESSION_NAME
tmux new-window -t $SESSION_NAME -n 'server'
tmux send-keys 'bundle; bin/rake db:migrate; bin/rails s' C-m
tmux split-window -h
tmux send-keys 'yarn; yarn start' C-m
tmux send-keys 'cd front; yarn; yarn start' C-m
tmux attach -t $SESSION_NAME
