# A Basic Stable IDE config for Neovim

> Why does this repo exist?

I'm simply deeply tired of configurations that breaks once and again and again for the main languages I use. 
NeoVim ecosystem is evolving incredibly flast, at the cost of introducing breaking changes almost every step of the way. 
There are NeoVim API changes, core plugins changing (eg: Plug, Pathogen, Packer, now Lazy...)
This project exists because I want to keep configuration as sipmle as possible with the features I use.

```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/jimyx17/nvim-cfg.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** First time you will get an error just ignore them and press enter, it will say nvim-ts-context-commentstring is not installed but that is fine just close and reopen nvim and everything should be fine  

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

This configuration uses Mason and an autocmd to install and configure any LSP server needed.
Once a file is opened or a new buffer is read, it triggers Mason installer to download and boot
the LSP and the client.

Care because by default it downloads and install ALL known LSP servers from Mason for the filetype detected.
If there is any good reason to avoid installing it, configure the skipped_filetypes and skipped_servers.

### Plugins

All plugins used by this configuration can be found in [here](https://github.com/jimyx17/nvim-cfg/blob/master/lua/user/plugins.lua)

### Keybindings

These are the keybindings that work for me. Love them or change them.

The `<leader>` key is set to ` `

#### tabs, buffers and windows

`<leader>wv` -> split current buffer vertically
`<leader>ws` -> split current buffer horizontally
`<leader>wc` -> close current window
`<leader>wo` -> close all other windows.

`<C-h>` -> move cursor to left window
`<C-j>` -> move cursor to down window
`<C-k>` -> move cursor to up window
`<C-l>` -> move cursor to right window

`<C-Up>`    -> resize window horizontally reducing size
`<C-Down>`  -> resize window horizontally increasing size
`<C-Left>`  -> resize window vertically reducing size
`<C-Right>` -> resize window vertically increasing size

`L` -> open next buffer
`H` -> open prev buffer
`X` -> close open buffer

`<A-o>` -> open new tab. 
`<A-l>` -> open next tab
`<A-h>` -> open prev tab
`<A-x>` -> close current tab

#### file explorer
`<leader>et` -> toggle file explorer
`<leader>ee` -> focus on file explorer

#### git
`<leader>gg` -> open lazygit. for this to work lazygit must be installed in the system

#### comment
`<leader>cc` -> toggle comment status of the current line or block

#### LSP
`<leader>lf` -> format current buffer with available LSP servers

`K` -> show hover
`gr` -> goto reference
`gd` -> goto definition
`gD` -> goto declaration
`gI` -> goto implementation
`gs` -> show signature help
`ge` -> go to next issue in the diagnostics results
`gE` -> go to prev issue in the diagnostics results
`gl` -> open float window with the output of the issue under the current line

#### Terminal

`<C-t>`       -> open a new terminal in a float window
`<leader>to`  -> open a new terminal
`<leader>tt`  -> toggle opened terminals

`<esc>`       -> exit terminal mode to normal mode
`<esc><esc>`  -> exit terminal and close window
`<esc>2`      -> open a side terminal
`<esc>3`      -> open a third side terminal
`<esc>c`      -> escape and close terminals (it's pretty much the same as <esc><esc>) 
`<C-h>`       -> move to the terminal on the left
`<C-l>`       -> move to the terminal on the right

#### Theme

By default, when NVIM loads, it changes the theme based on the time of the day.

`<leader><leader>` -> change theme

---
