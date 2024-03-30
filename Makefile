all: install config

.PHONY: install config unconfig secure zsh rust 
install: zsh rust

zsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

secure:
	ACCOUNT=client-a op inject -i secure-templates/git-profile.conf.tpl -o git/.config/git/profiles/git-client-a.conf
	ACCOUNT=personal op inject -i secure-templates/git-profile.conf.tpl -o git/.config/git/profiles/git-personal.conf
	ACCOUNT=personal op inject -i secure-templates/hosts.json.tpl -o github/.config/github-copilot/hosts.json

config: secure
	stow --verbose --target=$$HOME --restow */

unconfig:
	stow --verbose --target=$$HOME --delete */


