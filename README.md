# Dotfiles Repository
This repository contains my personal dotfiles, managed using GNU Stow. It includes configurations for Neovim, Zsh, and associated tools. The setup is primarily tested on Fedora Linux but should work on other Unix-like systems with minimal modifications.

## Prerequisites
Before setting up these dotfiles, ensure you have installed and configured the following tools according to your system's requirements and best practices:

### Core Requirements
- Git
- GNU Stow
- Zsh
- Neovim
- Python 3 with pip and venv support

### Shell and Development Tools
- zinit (Zsh plugin manager)
- Powerlevel10k (Zsh theme)
- fzf (fuzzy finder)
- zoxide (smart directory jumper)
- pyenv (Python version manager)
- asdf (version manager)

### Additional Tools Referenced in Configurations
- ripgrep
- fd-find
- Node.js and npm (for Neovim plugins)

## Repository Structure
```
dotfiles
├── nvim/                  # Neovim configuration
│   └── .config/nvim/     
├── nvim-python/          # Python virtual environment for Neovim
│   └── .local/virtualenv/nvim/
│       └── requirements.txt
├── zsh/                  # Zsh configuration
│   └── .zshrc
└── README.md
```

## Installation
Once all prerequisites are installed and configured, follow these steps to set up the dotfiles:

1. Clone the repository:
   ```bash
   git clone git@github.com:siddgodev/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Set up the Python virtual environment for Neovim:
   ```bash
   # Create virtual environment
   mkdir -p ~/.local/virtualenvs
   python3 -m venv ~/.local/virtualenvs/nvim
   
   # Install Python dependencies
   source ~/.local/virtualenvs/nvim/bin/activate
   pip install -r nvim-python/.local/virtualenv/nvim/requirements.txt
   deactivate
   ```

3. Deploy configurations using GNU Stow:
   ```bash
   # Deploy Zsh configuration
   stow zsh
   
   # Deploy Neovim configuration
   stow nvim
   ```

4. Start a new shell session for changes to take effect.

## Configuration Details
### Zsh Configuration
The Zsh configuration assumes you have installed and configured zinit and other referenced tools. It provides:
- Integration with Powerlevel10k theme
- Plugin management through zinit
- Custom aliases and key bindings
- Tool integrations for development workflows

### Neovim Configuration
The Neovim setup includes:
- Dedicated Python virtual environment for Neovim plugins
- Support for Ansible development
- Configuration managed through init.lua
- Custom keybindings and settings

## Maintaining the Repository
### Python Dependencies
The Python virtual environment is not tracked in version control. To update dependencies:

```bash
source ~/.local/virtualenvs/nvim/bin/activate
# Add whatever packages you want then:
pip freeze > ~/.dotfiles/nvim-python/.local/virtualenv/nvim/requirements.txt
deactivate
```

### Configuration Updates
When you edit any configuration file (like ~/.zshrc or files in ~/.config/nvim), the changes are automatically reflected in your dotfiles repository because these files are symbolic links to the repository files.

You only need to run stow again when you:
1. Add new configuration files to the repository
2. Remove configuration files from the repository
3. Move files around within the repository structure

In these cases, update the symbolic links with:
```bash
cd ~/.dotfiles
# Restow affected packages
stow -R zsh  # for zsh changes
stow -R nvim # for neovim changes
```

## Troubleshooting
If you encounter conflicts when stowing configurations:

1. Check for existing configuration files:
   ```bash
   # For Zsh
   ls -la ~/.zshrc
   # For Neovim
   ls -la ~/.config/nvim
   ```

2. Back up and remove any existing configurations before stowing:
   ```bash
   # Example for Zsh
   mv ~/.zshrc ~/.zshrc.backup
   # Example for Neovim
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

3. Try stowing again after removing conflicts.

## License
This repository is licensed under the MIT License - see the LICENSE file for details.
