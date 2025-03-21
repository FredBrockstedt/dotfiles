# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

PROJECT = dotfiles

SOURCE_DIR = .
TARGET_DIR = "${HOME}"
BACKUP_DIR = "${HOME}/backup"

.PHONY: default backup submodule

default: submodule
	@echo "* Stowing ..."
	@stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME} \
	     git bash vim zsh tmux
	@stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME}/.config \
	     config

# update the submodules
submodule:
	@git submodule add --force 'https://github.com/ohmyzsh/ohmyzsh.git' zsh/dot-oh-my-zsh 
	@git submodule update --init --recursive

# remove files commonly found on a blank install
delete:
	@rm -fvr ${HOME}/.bashrc \
	         ${HOME}/.vimrc \
		 ${HOME}/.gitconfig \
		 ${HOME}/.tmux.conf \
		 ${HOME}/.zshrc \
		 ${HOME}/.config/mpv/mpv.conf \
		 ${HOME}/.oh-my-zsh \
		 ${HOME}/oh-my-zsh

test:
	podman build .

