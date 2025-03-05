#!/bin/bash -e

# Get the canonical path of the directory containing this file
dotfiles="$(cd "$(dirname "${0}")"; pwd)"

# For dotfiles internal links (hook is called per directory)
hookexec=.hook-on-link
while IFS= read -r -d '' path; do
    set +e
    (cd "$path" && [ -x $hookexec ] && ./$hookexec)
    set -e
done < <(find "$dotfiles" -maxdepth 1 -type d ! -name '.*' -print0)

# Apps that meet XDG Base Directory Specification
xdg_apps=('nvim' 'alacritty')

# Create symlinks to files/directories in dotfiles root directory
for i in "$dotfiles"/*; do
    filename="${i##*/}"
    # if filename does not indicate this shell file
    if [[ "$filename" != "$(basename "${0}")" ]]; then
        dest="$HOME/.$filename"
        # if the destination exists and is an actual file, rename it for backup
        [[ -e "$dest" ]] && [[ ! -L "$dest" ]] && mv "$dest" "$HOME/$filename.bak"

        # prevent files from being linked according to conditions
        ### if the filename simply matches a pattern
        [[ "$filename" = "README.md" ]] && continue
        [[ "$filename" = "vrapperrc" ]] && continue
        ### despite X config files, if no X server is running
        [[ -z "${filename%%X*}" ]] && [[ -z "$DISPLAY" ]] && continue
        ### if the filename indicates an XDG-based app
        for app in "${xdg_apps[@]}"; do
            [[ "$filename" = "$app" ]] && continue 2
        done

        # create a symlink without follwing an existing symbolic link
        (set -x; ln -fns "$i" "$dest")
    fi
done

# For apps that meet XDG Base Directory Specification
for app in "${xdg_apps[@]}"; do
    dir="$HOME/.config/$app"
    if [[ -e "$dir" ]]; then
        if [[ -L "$dir" ]]; then
            rm "$dir"
        else
            mv "$dir" "$dir.bak"
        fi
    fi
    mkdir -p "${dir%/*}"
    (set -x; ln -fns "$dotfiles/$app" "$dir")
done

exit 0
