# Dotfiles Repository

This repository contains my personal dotfiles, managed using GNU Stow. It includes configurations for Neovim, Zsh, and associated tools. The setup is primarily tested on Fedora Linux but should work on other Unix-like systems with minimal modifications.

## Prerequisites

Before setting up these dotfiles, ensure you have the following base packages installed:

```bash
# Core dependencies
sudo dnf install git stow python3-pip neovim zsh curl

# Additional tools used in configurations
sudo dnf install fzf ripgrep fd-find
```

## Installation

### 1. Clone the Repository

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

### 2. Shell Setup (Zsh)

First, let's set up Zsh and its dependencies:

```bash
# Make Zsh your default shell
chsh -s $(which zsh)

# Install zinit (plugin manager)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zinit/powerlevel10k
```

### 3. Development Tools

Install various development tools referenced in the Zsh configuration:

```bash
# Install asdf version manager
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

# Install pyenv
curl https://pyenv.run | bash

# Install zoxide (smart directory jumper)
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install Node.js and npm (for Neovim plugins)
sudo dnf install nodejs npm
```

### 4. Neovim Python Environment

Set up the Python virtual environment for Neovim:

```bash
# Create virtual environment directory
mkdir -p ~/.local/virtualenvs

# Create and activate virtual environment
python3 -m venv ~/.local/virtualenvs/nvim
source ~/.local/virtualenvs/nvim/bin/activate

# Install Python dependencies
pip install -r ~/.dotfiles/nvim-python/.local/virtualenv/nvim/requirements.txt

# Deactivate when done
deactivate
```

### 5. Deploy Dotfiles

Use GNU Stow to create the symbolic links:

```bash
cd ~/.dotfiles

# Deploy Zsh configuration
stow zsh

# Deploy Neovim configuration
stow nvim
```

### 6. Final Setup

After deploying the configurations:

1. Start a new Zsh session
2. The first run will initialize Powerlevel10k configuration
3. Zinit will automatically install configured plugins
4. Launch Neovim - it will automatically install configured plugins

## Configuration Details

### Zsh Configuration

The Zsh configuration includes:
- Powerlevel10k theme for enhanced prompt
- Syntax highlighting and autosuggestions
- Integration with fzf for fuzzy finding
- Various Oh-My-Zsh plugins for git, kubectl, and more
- Custom aliases and key bindings
- Integration with asdf and pyenv for version management

### Neovim Configuration

The Neovim setup includes:
- Dedicated Python virtual environment for Neovim plugins
- Support for Ansible development
- Various plugins managed through lazy.nvim
- Custom keybindings and settings

## Maintaining the Repository

### Virtual Environment

The Python virtual environment is not tracked in version control. If you update the Python dependencies:

```bash
source ~/.local/virtualenvs/nvim/bin/activate
pip freeze > ~/.dotfiles/nvim-python/.local/virtualenv/nvim/requirements.txt
deactivate
```

### Updating Configurations

After making changes to any configurations:

```bash
cd ~/.dotfiles
# Restow affected packages
stow -R zsh  # for zsh changes
stow -R nvim # for neovim changes
```

## Troubleshooting

### Common Issues

1. **Stow conflicts**: If you get conflicts when stowing, ensure the target files don't already exist:
   ```bash
   # Remove existing config
   rm ~/.zshrc  # for zsh
   rm -rf ~/.config/nvim  # for neovim
   ```

2. **Python environment issues**: If Neovim complains about Python support:
   ```bash
   # Verify virtual environment
   ls ~/.local/virtualenvs/nvim/bin/python
   # Reinstall if necessary following step 4 above
   ```

3. **Plugin installation failures**: If Neovim plugins fail to install:
   ```bash
   # Remove plugin cache
   rm -rf ~/.local/share/nvim
   # Restart Neovim
   ```

## License

This repository is licensed under the MIT License - see the LICENSE file for details.
