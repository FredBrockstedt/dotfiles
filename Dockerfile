# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

# this docker file is used for testing the stow command
# run $ podman build . 

FROM fedora:latest

WORKDIR /dotfiles
COPY . .
RUN dnf -y install make stow git emacs-nox vim bash-completion tree
RUN mkdir -p ~/.config
RUN make delete
RUN make
RUN make emacs \
    && emacs --batch --eval "(load-file \"~/.emacs\")"
RUN make vim \
    && vim -c "q"
RUN tree -a /root