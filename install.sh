#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD='\033[1m'

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLEANER="$SCRIPT_DIR/cleaner.sh"
TARGET="$INSTALL_DIR/nclean"

echo
echo -e "${GREEN}-----------------------------------------------${RESET}"
echo -e "${BOLD}        NOAZIKI // CLEANER INSTALLER${RESET}"
echo -e "${GREEN}-----------------------------------------------${RESET}"
echo

if [ ! -f "$CLEANER" ]; then
    echo -e "${RED}[ERROR] cleaner.sh not found.${RESET}"
    exit 1
fi

mkdir -p "$INSTALL_DIR"

chmod +x "$CLEANER"
ln -sf "$CLEANER" "$TARGET"

echo -e "${GREEN}[ OK ]${RESET} Cleaner installed as: ${CYAN}nclean${RESET}"

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
        echo -e "${GREEN}[ OK ]${RESET} Added ${CYAN}~/.local/bin${RESET} to ${CYAN}$SHELL_NAME${RESET} PATH"
    fi
fi

echo
echo -e "${GREEN}-----------------------------------------------${RESET}"
echo -e "${GREEN}${BOLD}        INSTALLATION COMPLETE${RESET}"
echo -e "${GREEN}-----------------------------------------------${RESET}"
echo
echo -e "${YELLOW}You can now run:${RESET}"
echo
echo -e "        ${CYAN}${BOLD}nclean${RESET}"
echo
echo -e "${YELLOW}from anywhere.${RESET}"
echo

# Make nclean available in the current shell

if command -v "$TARGET" >/dev/null 2>&1; then
    echo -e "${GREEN}[ OK ]${RESET} ${CYAN}nclean${RESET} is ready."
else
    echo -e "${YELLOW}[!]${RESET} Restart your terminal or run:"
    echo
    echo -e "    ${CYAN}source $SHELL_CONFIG${RESET}"
    echo
fi
