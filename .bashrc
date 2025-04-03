# Exit if not running interactively
case $- in
  *i*) ;;
    *) return;;
esac

# ──────────────────────────────────────────────
# Oh My Bash
# ──────────────────────────────────────────────
export OSH="$HOME/.oh-my-bash"
OSH_THEME="agnoster"

completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)

[ -s "$OSH/oh-my-bash.sh" ] && source "$OSH/oh-my-bash.sh"

# ──────────────────────────────────────────────
# Bash Completion
# ──────────────────────────────────────────────
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# ──────────────────────────────────────────────
# Optional Bash Features (safe enable)
# ──────────────────────────────────────────────
if [ -n "$BASH_VERSION" ]; then
  for opt in cdspell dirspell autocd; do
    shopt -s "$opt" 2>/dev/null || true
  done
fi

# ──────────────────────────────────────────────
# Starship Prompt (if installed)
# ──────────────────────────────────────────────
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# ──────────────────────────────────────────────
# fzf (fuzzy finder)
# ──────────────────────────────────────────────
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
fi

# ──────────────────────────────────────────────
# ble.sh (Autosuggestions + Syntax Highlighting)
# ──────────────────────────────────────────────
if [ -f ~/.local/share/blesh/ble.sh ]; then
  source ~/.local/share/blesh/ble.sh
  bleopt inputrc_mode=emacs  # ← disables Ctrl+J multiline mode
fi

# ──────────────────────────────────────────────
# Optional: Debug confirmation
# ──────────────────────────────────────────────
echo ">>> .bashrc loaded ✅"
