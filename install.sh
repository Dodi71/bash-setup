#!/bin/bash
set -e

echo "📦 Installing required packages..."
apt update -y && apt install -y curl git bash bash-completion fonts-powerline

echo "🛠 Setting Bash as the default shell..."
chsh -s /bin/bash "$(whoami)"

echo "🚀 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "🎨 Installing Oh My Bash..."
if [ -d ~/.oh-my-bash ]; then
    echo "⚠️  Removing existing ~/.oh-my-bash"
    rm -rf ~/.oh-my-bash
fi
git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash

echo "🧠 Installing ble.sh..."
if [ -d ~/.local/share/blesh ]; then
    echo "⚠️  Removing existing ~/.local/share/blesh"
    rm -rf ~/.local/share/blesh
fi
wget https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz
tar -xf ble-0.4.0-devel3.tar.xz
mkdir -p ~/.local/share/blesh
mv ble-0.4.0-devel3/* ~/.local/share/blesh/
rm -rf ble-0.4.0-devel3 ble-0.4.0-devel3.tar.xz

echo "📁 Installing .bashrc..."

# Backup existing .bashrc if it exists
if [ -f ~/.bashrc ]; then
    echo "🔁 Backing up existing .bashrc to ~/.bashrc.backup"
    cp ~/.bashrc ~/.bashrc.backup
fi

# Copy new .bashrc
cp .bashrc ~/.bashrc
echo "✅ .bashrc installed successfully"

echo "🧹 Cleaning up extracted folder if needed..."
cd ..
rm -rf bash-complete-setup

echo "🔄 Reloading shell configuration..."
exec bash
