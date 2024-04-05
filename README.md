# Tmux YouTube Music Plugin

Tmux plugin that shows the current music status for YouTube Music

(OSX + Google Chrome only)
> An .applescript will be run to check Google Chrome for a tab where YouTube Music is being played.

#### Enable appleScript to execute Javascript
This plugin uses applescript to execute javascript in google chrome.
> ( in Google Chrome ) turn it on by, from the menu bar, go to View > Developer > Allow JavaScript from Apple Events.

Note: it's also possible to install YouTube Music as Browser app.

Introduces the following new status variables:

* `#{track}`

![Screenshot](https://github.com/kdssoftware/tmux-youtube-music/assets/10829524/cc2bee71-c3dd-468d-893d-ae259b2734b3)
TODOs:
Add a `#{status}` based on any sound being played or not.


### Usage

The following interpolations are made available for your statusline:

* `#{track}` - Will show a 'pause' icon if nothing is found, else the info will be shown

Here's the example in `.tmux.conf`:

```
set -g status-right "♫ #{track}"
```

### Screenshots

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'kdssoftware/tmux-youtube-music'

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/kdssoftware/tmux-youtube-music ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/music.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf
