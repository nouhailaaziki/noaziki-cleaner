# NOAZIKI // CLEANER

A simple Linux cleanup tool made for 42 / 1337 environments.

It cleans common user caches and temporary files to recover disk space without touching your projects.

## Features

* Shows available storage before cleaning
* Cleans user cache
* Cleans safe user-owned temporary files
* Cleans Python pip cache
* Cleans npm cache
* Cleans Yarn cache
* Cleans Maven repository cache
* Cleans Gradle cache
* Cleans Cargo cache when available
* Cleans Trash
* Shows available storage after cleaning
* Shows how much storage was freed
* Provides a global `nclean` command

## /goinfre Protection

**`/goinfre` is NEVER touched by this script.**

The cleaner only operates on explicitly defined cache and temporary directories.

Your projects and files outside those cleanup locations are not targeted.

## Requirements

Linux with:

* Bash
* `df`
* `find`
* `rm`

Optional tools such as `pip`, `npm`, `yarn`, and `cargo-cache` are only used when they are installed.

## Installation

Clone the repository:

```bash
git clone git@github.com:nouhailaaziki/noaziki-cleaner.git
cd noaziki-cleaner
```

Run the installer:

```bash
./install.sh
```

The installer:

* Installs the cleaner as `nclean`
* Creates `~/.local/bin` if needed
* Adds `~/.local/bin` to your shell PATH
* Supports Bash and Zsh

After installation, you can run the cleaner from anywhere:

```bash
nclean
```

If the current shell does not recognize `nclean`, restart your terminal or run:

```bash
source ~/.zshrc
```

For Bash:

```bash
source ~/.bashrc
```

## Manual Usage

You can also run the cleaner directly without installing the global command:

```bash
chmod +x cleaner.sh
./cleaner.sh
```

## Example

```text
-----------------------------------------------
        NOAZIKI // CLEANER v1.0
        42 / 1337 Linux Environment
-----------------------------------------------

[!] /goinfre is PROTECTED
    This script will NEVER clean /goinfre.

 -- Available Storage Before Cleaning : || 2.0G || --

 -- Cleaning ...

-----------------------------------------------
        CLEANUP COMPLETE
-----------------------------------------------

 -- Available Storage After Cleaning  : || 2.6G || --

 -- Storage Freed : || 600 MB || --

✓ NOAZIKI // CLEANER finished.
✓ /goinfre was not touched.
```

## Warning

Some caches may need to be downloaded again when you build projects.

For example, clearing Maven or Gradle caches can cause Java dependencies to be downloaded again.

Use the script when you actually need to recover disk space.

## Uninstall

To remove the global `nclean` command:

```bash
rm ~/.local/bin/nclean
```

If you also want to remove the PATH entry added by the installer, remove this line from your shell configuration:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

For Zsh:

```bash
nano ~/.zshrc
```

For Bash:

```bash
nano ~/.bashrc
```

## Author

**Nouhaila Aziki**

GitHub: https://github.com/nouhailaaziki
