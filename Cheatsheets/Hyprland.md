**Hyprland Configuration Cheatsheet**
=====================================

### Main Modifier
----------------

* `$mainMod` is set to `Super` (or `meta` or `windows` key)

### Assign Apps
----------------

* `$note` = `obsidian`
* `$term` = `kitty tmux`
* `$editor` = `nvim`
* `$file` = `dolphin`
* `$browser` = `firefox`

### Bindings
------------

#### Window/Session Actions
-------------------------

* `$mainMod`, `Q`: Close focused window
* `Alt`, `F4`: Close focused window
* `$mainMod`, `Delete`: Kill hyprland session
* `$mainMod`, `W`: Toggle window between focus and float
* `$mainMod`, `G`: Toggle window between focus and group
* `Alt`, `Return`: Toggle window between focus and fullscreen
* `$mainMod`, `L`: Launch lock screen
* `$mainMod` + `Shift`, `F`: Toggle pin on focused window
* `$mainMod`, `Backspace`: Launch logout menu
* `Ctrl` + `Alt`, `W`: Toggle waybar

#### Application Shortcuts
-------------------------

* `$mainMod`, `T`: Launch terminal emulator
* `$mainMod`, `E`: Launch file manager
* `$mainMod`, `C`: Launch text editor
* `$mainMod`, `F`: Launch web browser
* `Ctrl` + `Shift`, `Escape`: Launch system monitor (htop/btop or fallback to top)
* `$mainMod`, `N`: Launch note taking app

#### Rofi Menus
--------------

* `$mainMod`, `Return`: Launch application launcher
* `$mainMod`, `Tab`: Launch window switcher
* `$mainMod` + `Shift`, `E`: Launch file explorer

### Audio Control
----------------

* `, F10`: Toggle audio mute
* `, F11`: Decrease volume
* `, F12`: Increase volume
* `, XF86AudioMute`: Toggle audio mute
* `, XF86AudioMicMute`: Toggle microphone mute
* `, XF86AudioLowerVolume`: Decrease volume
* `, XF86AudioRaiseVolume`: Increase volume

### Bar
-----

* `$mainMod`, `B`: Toggle hide/show waybar
* `$mainMod` + `Ctrl`, `B`: Launch Waybar Styles Menu
* `$mainMod` + `Alt`, `B`: Launch Waybar Layout Menu

### Media Control
----------------

* `, XF86AudioPlay`: Toggle between media play and pause
* `, XF86AudioPause`: Toggle between media play and pause
* `, XF86AudioNext`: Media next
* `, XF86AudioPrev`: Media previous

### Brightness Control
-------------------

* `, XF86MonBrightnessUp`: Increase brightness
* `, XF86MonBrightnessDown`: Decrease brightness

### Move between Grouped Windows
-------------------------------

* `$mainMod` + `Ctrl`, `H`: Move to previous window in group
* `$mainMod` + `Ctrl`, `L`: Move to next window in group

### Screenshot/Screencapture
-------------------------

* `$mainMod`, `P`: Partial screenshot capture
* `$mainMod` + `Ctrl`, `P`: Partial screenshot capture (frozen screen)
* `$mainMod` + `Alt`, `P`: Monitor screenshot capture
* `, Print`: All monitors screenshot capture

### Custom Scripts
------------------

* `$mainMod` + `Alt`, `G`: Disable hypr effects for gamemode
* `$mainMod` + `Alt`, `Right`: Next wallpaper
* `$mainMod` + `Alt`, `Left`: Previous wallpaper
* `$mainMod` + `Alt`, `Up`: Next waybar mode
* `$mainMod` + `Alt`, `Down`: Previous waybar mode
* `$mainMod` + `Shift`, `R`: Launch wallbash mode select menu
* `$mainMod` + `Shift`, `T`: Launch theme select menu
* `$mainMod` + `Shift`, `A`: Launch select menu
* `$mainMod` + `Shift`, `W`: Launch wallpaper select menu
* `$mainMod`, `V`: Launch clipboard
* `$mainMod`, `K`: Switch keyboard layout

### Move/Change Window Focus
---------------------------

* `$mainMod`, `Left`: Move focus to left
* `$mainMod`, `Right`: Move focus to right
* `$mainMod`, `Up`: Move focus up
* `$mainMod`, `Down`: Move focus down
* `Alt`, `Tab`: Move focus to next window

Here is the continuation of the Markdown cheatsheet:

### Switch Workspaces
-------------------

* `$mainMod`, `1`-`10`: Switch to workspace 1-10
* `$mainMod` + `Ctrl`, `Right`/`Left`: Switch to next/previous workspace
* `$mainMod` + `Ctrl` + `Down`: Move to first empty workspace

### Resize Windows
-----------------

* `$mainMod` + `Shift`, `Right`/`Left`: Resize window to the right/left by 30 pixels
* `$mainMod` + `Shift`, `Up`/`Down`: Resize window up/down by 30 pixels

### Move Focused Window
----------------------

* `$mainMod` + `Shift`, `1`-`10`: Move focused window to workspace 1-10
* `$mainMod` + `Ctrl` + `Alt`, `Right`/`Left`: Move focused window to next/previous workspace
* `$mainMod` + `Shift` + `Ctrl`, `Left`/`Right`/`Up`/`Down`: Move focused window left/right/up/down

### Move/Resize Focused Window with Mouse
----------------------------------------

* `$mainMod`, `mouse:272`: Move window with mouse
* `$mainMod`, `mouse:273`: Resize window with mouse
* `$mainMod`, `Z`: Move window with mouse
* `$mainMod`, `X`: Resize window with mouse

### Special Workspace (Scratchpad)
--------------------------------

* `$mainMod` + `Alt`, `S`: Move to special workspace (scratchpad)
* `$mainMod`, `S`: Toggle special workspace

### Toggle Focused Window Split
-------------------------------

* `$mainMod`, `J`: Toggle focused window split

### Move Focused Window to Workspace Silently
--------------------------------------------

* `$mainMod` + `Alt`, `1`-`10`: Move focused window to workspace 1-10 silently