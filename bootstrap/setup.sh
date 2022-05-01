#!/bin/bash
export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"

if command -v ansible-playbook >/dev/null; then
	echo "Ansible installed, skipping..."
else
	sudo pip3 install --upgrade pip
	pip3 install ansible
fi

dotfiles_path="$HOME/.local/share/chezmoi"
if [[ -d "$dotfiles_path" ]]; then
	(
		cd "$dotfiles_path"
		git pull
	)
else
	git clone https://github.com/jonnobrow/workstation "$dotfiles_path"
fi

cd "${dotfiles_path}/bootstrap"
ansible-playbook main.yml --limit jbmbp
