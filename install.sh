#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLEANER="$SCRIPT_DIR/cleaner.sh"
TARGET="$INSTALL_DIR/nclean"

echo
echo "-----------------------------------------------"
echo "        NOAZIKI // CLEANER INSTALLER"
echo "-----------------------------------------------"
echo

if [ ! -f "$CLEANER" ]; then
echo "[ERROR] cleaner.sh not found."
exit 1
fi

mkdir -p "$INSTALL_DIR"

chmod +x "$CLEANER"
ln -sf "$CLEANER" "$TARGET"

echo "[ OK ] Cleaner installed as: nclean"

# Add ~/.local/bin to PATH if needed

case ":$PATH:" in
*":$INSTALL_DIR:"*)
;;
*)
export PATH="$INSTALL_DIR:$PATH"
;;
esac

# Detect shell

SHELL_NAME="$(basename "$SHELL")"

if [ "$SHELL_NAME" = "zsh" ]; then
SHELL_CONFIG="$HOME/.zshrc"
elif [ "$SHELL_NAME" = "bash" ]; then
SHELL_CONFIG="$HOME/.bashrc"
else
SHELL_CONFIG=""
fi

# Add PATH permanently

if [ -n "$SHELL_CONFIG" ]; then
if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG" 2>/dev/null; then
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
echo "[ OK ] Added ~/.local/bin to $SHELL_NAME PATH"
fi
fi

echo
echo "-----------------------------------------------"
echo "        INSTALLATION COMPLETE"
echo "-----------------------------------------------"
echo
echo "You can now run:"
echo
echo "        nclean"
echo
echo "from anywhere."
echo

# Make nclean available in the current shell

if command -v "$TARGET" >/dev/null 2>&1; then
echo "[ OK ] nclean is ready."
else
echo "[!] Restart your terminal or run:"
echo
echo "    source $SHELL_CONFIG"
echo
fi
