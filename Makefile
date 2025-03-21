# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

PROJECT = dotfiles

SOURCE_DIR = .
TARGET_DIR = "${HOME}"

define my_stow
	@echo "* Stowing $@..."
	@stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME} \
	     "$@"
endef

.PHONY: default config git bash vim tmux emacs zsh zsh_submodule 

# this is what is run when you call make
default: git bash emacs vim tmux config

# actually mpv.conf
config:
	stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME}/.config \
	     config

# individual programs
git bash vim tmux: 
	$(call my_stow)

# Z-Shell mostly used on Macintosh systems
zsh: update_submodules
	$(call mystow)

emacs: update_submodules
	$(call my_stow)	
	(cd emacs/dot-emacs.d/extensions/avy && git checkout 0.5.0)

update_submodules:
	@git submodule update --init --recursive

add_submodules:
	@git submodule add --force 'https://github.com/ohmyzsh/ohmyzsh.git' zsh/dot-oh-my-zsh 
	@git submodule add --force 'https://github.com/abo-abo/avy.git' emacs/dot-emacs.d/extensions/avy
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

