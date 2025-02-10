# Freds Dotfiles 2025
# the full BSD 2-Clause License can be found in the LICENSE file

# this docker file is used for testing the stow command
# run $ podman build . 

FROM fedora:latest

WORKDIR /dotfiles
COPY . .
RUN dnf -y install make stow
RUN make delete && make
RUN ls -lA ${HOME}