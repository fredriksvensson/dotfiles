#!/usr/bin/env bash

function ubuntu {
	echo Detected Ubuntu...

	sudo apt-get install -y curl

	echo 1password PPA...
	curl -sS https://downloads.1password.com/linux/keys/1password.asc |
		sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
		sudo tee /etc/apt/sources.list.d/1password.list

	sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
		sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	curl -sS https://downloads.1password.com/linux/keys/1password.asc |
		sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

	echo Installing packages...
	sudo apt-get update && xargs sudo apt-get -y install <Brewfile

	echo Installing lazygit...
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin

	rm -rf lazygit
	rm -rf lazygit.tar.gz
}

function osx {
	echo Detected OSX...

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew tap homebrew/cask
	brew bundle install
	brew install lazygit
}

case $(uname -s) in
Linux)
	if [[ $(grep -Po '^NAME="\K\w+' /etc/os-release) == "Ubuntu" ]]; then
		ubuntu
	fi
	;;

Darwin) osx ;;
*) echo other ;;
esac
