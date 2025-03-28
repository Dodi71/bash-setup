#!/bin/bash
set -e

echo "🍎 Detected macOS - starting setup..."

# Install Homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "📦 Installing required packages via Homebrew..."
brew install bash git curl bash-completion starship

# Get the full path to Homebrew's bash
BREW_BASH=$(brew --prefix)/bin/bash

echo "🛠 Setting Bash as the default shell: $BREW_BASH"
if ! grep -q "$BREW_BASH" /etc/shells; then
  echo "$BREW_BASH" | sudo tee -a /etc/shells
fi
chsh -s "$BREW_BASH"

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

echo "📁 Installing .bash_profile..."

# Backup existing .bash_profile if it exists
if [ -f ~/.bash_profile ]; then
    echo "🔁 Backing up existing .bash_profile to ~/.bash_profile.backup"
    cp ~/.bash_profile ~/.bash_profile.backup
fi

# Use .bashrc as the content and link it to .bash_profile
cp .bashrc ~/.bash_profile
echo "✅ .bash_profile installed successfully"

echo "🔄 Reloading shell..."
exec "$BREW_BASH"
