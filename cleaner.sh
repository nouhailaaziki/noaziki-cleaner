#!/bin/bash

# ============================================================
#                    NOAZIKI // CLEANER
#                 42 / 1337 Linux Environment
#
#             /goinfre is NEVER touched.
# ============================================================

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'
BOLD='\033[1m'

# ------------------------------------------------------------
# Storage functions
# ------------------------------------------------------------

get_available() {
    df -h "$HOME" | awk 'NR==2 {print $4}'
}

get_available_kb() {
    df -Pk "$HOME" | awk 'NR==2 {print $4}'
}

# ------------------------------------------------------------
# Safe cleanup function
# ------------------------------------------------------------

clean_dir() {
    DIR="$1"

    if [ -d "$DIR" ]; then
        find "$DIR" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} + 2>/dev/null
    fi
}

# ------------------------------------------------------------
# Header
# ------------------------------------------------------------

clear

echo
echo -e "${GREEN}"
echo "███╗   ██╗ ██████╗  █████╗ ███████╗██╗██╗  ██╗██╗"
echo "████╗  ██║██╔═══██╗██╔══██╗╚══███╔╝██║██║ ██╔╝██║"
echo "██╔██╗ ██║██║   ██║███████║  ███╔╝ ██║█████╔╝ ██║"
echo "██║╚██╗██║██║   ██║██╔══██║ ███╔╝  ██║██╔═██╗ ██║"
echo "██║ ╚████║╚██████╔╝██║  ██║███████╗██║██║  ██╗██║"
echo "╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚═╝"
echo
echo " ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗ "
echo "██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗"
echo "██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝"
echo "██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗"
echo "╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║"
echo " ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝"
echo -e "${RESET}"

echo -e "${GREEN}-----------------------------------------------${RESET}"
echo -e "${BOLD}        NOAZIKI // CLEANER v1.0${RESET}"
echo -e "        42 / 1337 Linux Environment"
echo -e "${GREEN}-----------------------------------------------${RESET}"

echo
echo -e "${YELLOW}[!] /goinfre is PROTECTED${RESET}"
echo -e "    This script will NEVER clean /goinfre."
echo

# ------------------------------------------------------------
# Storage BEFORE
# ------------------------------------------------------------

BEFORE=$(get_available)
BEFORE_KB=$(get_available_kb)

echo -e "${YELLOW} -- Available Storage Before Cleaning : || ${BEFORE} || --${RESET}"

echo
echo -e "${RED} -- Cleaning ...${RESET}"
echo

# ------------------------------------------------------------
# User cache
# ------------------------------------------------------------

clean_dir "$HOME/.cache"

# ------------------------------------------------------------
# Temporary files
# Only files belonging to the current user
# ------------------------------------------------------------

if [ -d "/tmp" ]; then
    find /tmp \
        -mindepth 1 \
        -maxdepth 1 \
        -user "$(id -u)" \
        -exec rm -rf -- {} + 2>/dev/null
fi

# ------------------------------------------------------------
# Python cache
# ------------------------------------------------------------

if command -v pip3 >/dev/null 2>&1; then
    pip3 cache purge >/dev/null 2>&1
fi

if command -v pip >/dev/null 2>&1; then
    pip cache purge >/dev/null 2>&1
fi

# ------------------------------------------------------------
# NPM cache
# ------------------------------------------------------------

if command -v npm >/dev/null 2>&1; then
    npm cache clean --force >/dev/null 2>&1
fi

# ------------------------------------------------------------
# Yarn cache
# ------------------------------------------------------------

if command -v yarn >/dev/null 2>&1; then
    yarn cache clean >/dev/null 2>&1
fi

# ------------------------------------------------------------
# Maven cache
# ------------------------------------------------------------

if [ -d "$HOME/.m2/repository" ]; then
    clean_dir "$HOME/.m2/repository"
fi

# ------------------------------------------------------------
# Gradle cache
# ------------------------------------------------------------

if [ -d "$HOME/.gradle/caches" ]; then
    clean_dir "$HOME/.gradle/caches"
fi

# ------------------------------------------------------------
# Cargo cache
# ------------------------------------------------------------

if command -v cargo-cache >/dev/null 2>&1; then
    cargo cache --autoclean >/dev/null 2>&1
fi

# ------------------------------------------------------------
# Trash
# ------------------------------------------------------------

if [ -d "$HOME/.local/share/Trash/files" ]; then
    clean_dir "$HOME/.local/share/Trash/files"
fi

if [ -d "$HOME/.local/share/Trash/info" ]; then
    clean_dir "$HOME/.local/share/Trash/info"
fi

# ------------------------------------------------------------
# Storage AFTER
# ------------------------------------------------------------

AFTER=$(get_available)
AFTER_KB=$(get_available_kb)

# Calculate space gained
GAIN=$((AFTER_KB - BEFORE_KB))

if [ "$GAIN" -gt 0 ]; then
    GAIN_MB=$((GAIN / 1024))
else
    GAIN_MB=0
fi

# ------------------------------------------------------------
# Result
# ------------------------------------------------------------

echo
echo -e "${GREEN}-----------------------------------------------${RESET}"
echo -e "${GREEN}${BOLD}        CLEANUP COMPLETE${RESET}"
echo -e "${GREEN}-----------------------------------------------${RESET}"

echo
echo -e "${YELLOW} -- Available Storage After Cleaning  : || ${AFTER} || --${RESET}"

echo
echo -e "${GREEN} -- Storage Freed : || ${GAIN_MB} MB || --${RESET}"

echo
echo -e "${GREEN}✓ NOAZIKI // CLEANER finished.${RESET}"
echo -e "${CYAN}✓ /goinfre was not touched.${RESET}"
echo
