# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

PROJECT = dotfiles

SOURCE_DIR = .
TARGET_DIR = "${HOME}"
BACKUP_DIR = "${HOME}/backup"

.PHONY: default backup submodule

default:
	@echo "* Stowing ..."
	@stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME} \
	     git bash vim zsh

# update the submodules
submodule:
	@git submodule update --init --recursive

# remove files commonly found on a blank install
delete:
	@rm -fvr ${HOME}/.bashrc \
	         ${HOME}/.vimrc \
		 ${HOME}/.gitconfig \
		 ${HOME}/.zshrc \
		 ${HOME}/.oh-my-zsh

test:
	podman build .

