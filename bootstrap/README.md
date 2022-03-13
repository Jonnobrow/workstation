# Bootstrap

This is an ansible playbook designed to install an opinionated arch linux workstation setup.

## Use it

```bash
ansible-galaxy install -r requirements.yml
ansible-playbook -K -i inventory main.yml -e password="Your5uper5ecurePa*s"
```

## Features
- [ ] Base
	- [x] Arch Linux Defaults (Timezone, Keyboard Layout etc...)
	- [x] Autologin
	- [x] Nobeep
	- [x] Paru
	- [ ] Browser (Firefox)
	- [ ] Foot (Terminal)
	- [ ] Network Configuration
	- [ ] Utils (faq, fd, ripgrep, bat ...)
- [ ] Development
	- [ ] Neovim
	- [ ] Go
	- [ ] Python
	- [ ] JavaScript
	- [ ] Docker
	- [ ] Terraform
	- [ ] Language Servers
	- [ ] Git
- [ ] Sway
	- [ ] Install Sway, Swayidle, Swaylock, Waybar
	- [ ] [wlsunset](https://sr.ht/~kennylevinsen/wlsunset/)
