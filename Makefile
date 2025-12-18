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

.PHONY: default config git bash vim tmux emacs zsh zsh_submodule clean

# Help Message
#   see: https://stackoverflow.com/questions/35730218/how-to-automatically-generate-a-makefile-help-command
#
# Display help information
help:
	@echo "Usage: make <target>"
	@echo ""
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t
	@echo ""

# Apply the default configuration
default: git bash emacs vim tmux config

# Stow anything placed in the .config folder of your homedirectory
config:
	stow --verbose \
	     --restow \
	     --dotfiles \
	     --target ${HOME}/.config \
	     config

# Configure the respective application
git bash vim tmux: 
	$(call my_stow)

# Z-Shell mostly used on Macintosh systems
zsh: update_submodules
	$(call mystow)

emacs: update_submodules
	$(call my_stow)	

update_submodules:
	@git submodule update --init --recursive

add_submodules:
	@git submodule add --force 'https://github.com/ohmyzsh/ohmyzsh.git' zsh/dot-oh-my-zsh 
	@git submodule update --init --recursive

# Preinstall software on a MacOS system
#
# requirements:
#   - homebrew (package management system)
#     https://brew.sh/
#   - Brewfile 
#
# Install MacOS software
macos:
	@echo "* Installing software with homebrew..."
	@#brew bundle check
	@brew bundle install

# Remove files commonly found on a blank install
delete:
	@rm -fvr ${HOME}/.bashrc \
	         ${HOME}/.vimrc \
		 ${HOME}/.gitconfig \
		 ${HOME}/.tmux.conf \
		 ${HOME}/.zshrc \
		 ${HOME}/.config/mpv/mpv.conf \
		 ${HOME}/.oh-my-zsh \
		 ${HOME}/oh-my-zsh

# Test the dotfiles configuration in a container check the file Dockerfile on what system is used
test:
	time podman build .

# Clean up old podman images
clean:
	podman images prune
