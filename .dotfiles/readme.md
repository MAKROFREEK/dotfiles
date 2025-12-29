DOTFILES MANAGEMENT VIA GIT BARE REPOSITORY

INITIAL SETUP Open your terminal and run the following commands to create the repository folder and initialize it as a bare repo.

	mkdir $HOME/.dotfiles git init --bare $HOME/.dotfiles

CREATE THE ALIAS Add the following line to your .bashrc or .zshrc file so you can interact with the repo easily.

	alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

After adding the line, reload your configuration: source ~/.bashrc (or source ~/.zshrc)

HIDE UNTRACKED FILES This is a crucial step. It ensures that when you run 'config status', you only see the files you have explicitly added, rather than every file in your home directory.

	config config --local status.showUntrackedFiles no

    TRACKING YOUR FIRST FILE Use the 'config' command just like you would use 'git'.

	config add .bashrc 
	config commit -m "Initial commit: add bashrc" 
	config remote add origin <your-git-repo-url> 
	config push -u origin main

    INSTALLING ON A NEW MACHINE When setting up a new computer, follow these steps:

A. Define the alias: alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
B. Clone the repository: git clone --separate-git-dir=$HOME/.dotfiles <your-repo-url> temp_dotfiles
C. Move the files to home: rsync --recursive --verbose --exclude '.git' temp_dotfiles/ $HOME/
D. Clean up and set local config: rm -rf temp_dotfiles config config --local status.showUntrackedFiles no
