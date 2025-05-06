# Dotfiles

This repository contains my dotfiles,
which were created specifically for Arch Linux.

![Screenshot](images/screenshot.png)

## Tools

| Tool              | Purpose           |
| ----------------- | ----------------- |
| Paru              | Aur helper        |
| AwesomeWM         | Window manager    |
| Kitty             | Terminal          |
| zsh               | Shell             |
| Powerlevel10k     | Zsh theme         |
| LazyVim           | Editor            |
| Rofi              | Launcher          |
| Pyenv             | Python Management |

## Deployment

1. Clone this repository to your home directory.
2. Install ansible.
3. Run ansible playbook via:

```bash
ansible-playbook ~/playbook.yml --ask-become-pass
```
