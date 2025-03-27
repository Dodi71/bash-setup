#!/bin/bash
set -e

echo "📦 Installing required packages..."
apt update -y && apt install -y curl git bash bash-completion

echo "🚀 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "🎨 Installing Oh My Bash..."
git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash

echo "🧠 Installing ble.sh..."
wget https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz
tar -xf ble-0.4.0-devel3.tar.xz
mkdir -p ~/.local/share/blesh
mv ble-0.4.0-devel3/* ~/.local/share/blesh/
rm -rf ble-0.4.0-devel3 ble-0.4.0-devel3.tar.xz

echo "📁 Copying .bashrc to home directory..."
cp .bashrc ~/.bashrc

echo "🔄 Reloading shell configuration..."
source ~/.bashrc

echo "✅ Installation complete! Enjoy your new Bash environment 🎉"
