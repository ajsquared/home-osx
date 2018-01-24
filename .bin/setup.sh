#!/bin/bash

set -euo pipefail

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 'Installing TPM'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
