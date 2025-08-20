mkdir -p ~/.config/nvim
rsync --delete --archive --exclude .git ./ ~/.config/nvim
