# Workstation

This is the repo housing my dotfiles and ansible playbook for setting up a workstation.

## (Arch) Install Guide

_**Do not use this as is. Clone and modify to suit your needs**_

1. Download and boot an [arch linux iso](https://archlinux.org/download/)
2. Use [archinstall](https://github.com/archlinux/archinstall) with the config in this repo:
	
	```shell
	archinstall --config https://github.com/jonnobrow/workstation/blob/main/archinstall.json
	```

	This will carry out a basic install, adding only key packages for the rest of this guide.

3. Reboot and login as root
4. Initialize [Chezmoi](https://www.chezmoi.io/)
	
	```shell
	BOOTSTRAP=true chezmoi init https://github.com/jonnobrow/workstation.git
	```

5. Switch to the chezmoi directory, then the playbook directory.
	
	```shell
	chezmoi cd
	cd bootstrap
	```

6. Run the ansible playbook. (See the [README](./bootstrap/README.md) for details)
7. Reboot and login as user (default: `jb`)
8. _jonnobrow specific_ Login to Nextcloud using Solokey
9. _jonnobrow specific_ Setup sync for passwords and re-run chezmoi init without `BOOTSTRAP` set
	- Should sync to `~/dirs/doc/keepass/keepass.kdbx`

## (MacOS) Install Guide

1. [Disable System Integrity Protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)
