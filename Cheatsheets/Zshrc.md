Here is the Cheatsheet for my alias in my .zshrc




**Helpful Aliases**

| Alias                         | Description                                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------------------------- |
| `cp`                          | Run `cp` with the `-i` option                                                                       |
| `mv`                          | Run `mv` with the `-i` option                                                                       |
| `rm`                          | Run `rm` with the `-i` option                                                                       |
| `mkdir`                       | Run `mkdir` with the `-p` option                                                                    |
| `ps`                          | Run `ps` with the `auxf` option                                                                     |
| `ping`                        | Run `ping` with the `-c 10` option                                                                  |
| `less`                        | Run `less` with the `-R` option                                                                     |
| `cls`                         | Clear the terminal screen                                                                           |
| `apt-get`                     | Run `apt-get` with sudo privileges                                                                  |
| `multitail`                   | Run `multitail` with the `--no-repeat` and `-c` options                                             |
| `freshclam`                   | Run `freshclam` with sudo privileges                                                                |
| `vi`                          | Run `nvim` instead of `vi`                                                                          |
| `svi`                         | Run `sudo vi` instead of `vi`                                                                       |
| `vis`                         | Run `nvim` with the `+set si` option                                                                |
| `grep`                        | Run `grep` with the `--color` option                                                                |
| `sgrep`                       | Run `grep` with the `--color` option and search recursively                                         |
| `pacman-update`               | Run `pacman-mirrors` with the `--geoip` option                                                      |
|                               |                                                                                                     |
| `h`                           | Run `history`                                                                                       |
| `open`                        | Open the current directory with Dolphin                                                             |
| `pl`                          | List installed packages using the AUR helper                                                        |
| `pa`                          | List available packages using the AUR helper                                                        |
| `pc`                          | Remove unused cache using the AUR helper                                                            |
| `po`                          | Remove unused packages using the AUR helper                                                         |
| `vc`                          | Open the current directory in the GUI code editor                                                   |
| `rm`                          | Run `rm` with the `-i` option                                                                       |
| `cp`                          | Run `cp` with the `-i` option                                                                       |
| `mv`                          | Run `mv` with the `-i` option                                                                       |
| `lf`                          | Run `eza` with the `--color=always` and `--long` options, and filter out directories                |
| `lh`                          | Run `eza` with the `--color=always` and `--long` options, and group directories                     |
| `ls`                          | Run `eza` with the `--color=always` and `--long` options, and sort by size                          |
| `code`                        | Run the GUI code editor                                                                             |
| `ping`                        | Run `ping` with the `-c 5` option                                                                   |
| `reload`                      | Reload the .zshrc file                                                                              |
| `HEAD`                        | Run `curl` with the `-I` option                                                                     |
| `v`                           | Run `fd` with the `--type f` and `--hidden` options, and open the results in `nvim`                 |
| `gitpush`                     | Run `git push` with the current commit message                                                      |
| `gitupdate`                   | Run `git update` and add the SSH key                                                                |
| `gp`                          | Run `git push` with the current commit message                                                      |
| `gu`                          | Run `git update` and add the SSH key                                                                |
| `mkdircd`                     | Create a new directory and change into it                                                           |
| `battery`                     | Run `upower` to get the battery percentage                                                          |
| `mkcd`                        | Create a new directory and change into it                                                           |
| `..`, `...`, `.3`, `.4`, `.5` | Change into the parent directory or go up several levels                                            |
| `mkdir`                       | Create a new directory with the `-p` option                                                         |
| `rmd`                         | Run `rm` with the `--recursive`, `--force`, and `--verbose` options                                 |
| `gti`                         | Run `git` instead of `gti`                                                                          |
| `tmux`                        | Run `tmux` with the `new-session` option                                                            |
| `countfiles`                  | Count the number of files, links, and directories in the current directory                          |
| `checkcommand`                | Check if a command is aliased, a file, or a built-in command                                        |
| `diskspace`                   | Run `du` with the `-S` and `--max-depth=1` options, and sort by size                                |
| `folders`                     | Run `du` with the `-h` and `--max-depth=1` options, and group directories                           |
| `folderssort`                 | Run `find` with the `--max-depth=1` and `--type d` options, and sort by size                        |
| `tree`                        | Run `tree` with the `-CAhF` and `--dirsfirst` options                                               |
| `treed`                       | Run `tree` with the `-CAFd` option                                                                  |
| `mountedinfo`                 | Run `df` with the `-hT` option                                                                      |
| `openports`                   | Run `netstat` with the `-nape` and `--inet` options                                                 |
| `logs`                        | Run `find` with the `--type f` and `--exec` options, and print the results                          |
| `docker-clean`                | Run `docker` with the `container prune`, `image prune`, `network prune`, and `volume prune` options |
| `whatsmyip`                   | Run `whatsmyip` with the internal and external IP lookup options                                    |
| `ftext`                       | Run `grep` with the `-i`, `-I`, `-H`, `-r`, and `-n` options, and print the results                 |
| `h`                           | Run `history`                                                                                       |
| `open`                        | Open the current directory with Dolphin                                                             |


**Functions**

| Function | Description |
| --- | --- |
| `cpp` | Copy a file and display a progress bar |
| `cpg` | Copy a file and go to the destination directory |
| `mvg` | Move a file and go to the destination directory |
| `mkdirg` | Create a directory and go to it |
| `ex` | Extract a file archive (e.g. tar, zip, rar) |




