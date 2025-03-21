# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

PROJECT = dotfiles

SOURCE_DIR = .
TARGET_DIR = "${HOME}"
BACKUP_DIR = "${HOME}/backup"

define my_stow
	@echo "* Stowing $@..."
	@stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME} \
	     "$@"
endef

.PHONY: default zsh zsh_submodule backup config git bash vim tmux

default: git bash vim tmux config

config:
	stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME}/.config \
	     config

git: 
	$(call my_stow)

bash:
	$(call my_stow)

vim: 
	$(call my_stow)

tmux:
	$(call my_stow)	

# Z-Shell mostly used on Macintosh systems
zsh: zsh_submodule
	$(call mystow)

# update the submodules
zsh_submodule:
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

