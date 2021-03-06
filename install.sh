#!/bin/bash
	GITADDR=git@github.com
	GITUSER=$(git config --global --get user.name | cat)

promptName() {
	read -rp 'Project name: ' NAME
}

cloneStater() {
	git clone $GITADDR:$GITUSER/epsilon-naught.git "$NAME" && cd "$NAME" || exit
}

setupGit() {
	rm -rfv .git

	read -p 'Do you want to set up a remote Git repository? (Y/n) ' -n 1 -r
	echo
	if [[ ! "$REPLY" =~ ^[Yy]$ ]]
	then
		return 0
	fi

	read -rp 'Enter the remote upstream repository: ' REPO
	echo "$REPO"

	git init && git remote add origin "$GITADDR:$GITUSER/$REPO" && git remote -v
}

installDependencies() {
	yarn install && bower install
}

promptName
cloneStater
setupGit
installDependencies

printf '\n\033[32mCompleted!\033[0m\n'
