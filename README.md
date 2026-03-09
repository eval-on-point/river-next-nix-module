# NixOS module for River 0.4.0 (AKA `river-next`)
River development has undergone drastic changes, with new design principles, compared to 0.3.x and prior. It doesn't yet have an official release. However, it is in a state that runs well. Still, given the frequent changes, it's not something that would find a place in Nixpkgs yet. One can only find `river-classic` (0.3.x) in the repo.

Rather than wait for the release, I wanted to build it locally now, to try out the changes. Plus, given how the compositor works, a dozen or so of window managers would need to be packaged to actually run something in `river-next`. This repository does exactly that: it builds the new River package, along with all supported window managers (see below) and a NixOS module. 

## Contents
This repo has/will contain the following:
- [x] River 0.4.0 (from main branch)
- [x] Builds for window managers as listed [upstream](https://codeberg.org/river/wiki/src/branch/main/pages/wm-list.md): 
  - [x]  beansprout - a DWM-style tiling window manager with built-in wallpaper and a clock/bar, with configuration in Kdl
  - [x] Canoe - Stacking window manager with classic look and feel, written in Rust
  - [x]  kuskokwim - A tiling window manager with composable keybindings and first-class support for process management, written in Python
  - [x]  kwm - DWM-like dynamic tilling window manager with scrollable-tiling support, includes a simple status bar, written in Zig
  - [x]  machi - Minimalist window manager with cascading windows, horizontal panels and vertical workspaces
  - [x]  mousetrap - Minimal stumpwm/ratpoison-like window manager, using modern c++
  - [x]  orilla - Dynamic tiling window manager inspired by XMonad, written in Rust
  - [x]  pwm - Tiling window manager with SSD titlebars and Python API
  - [ ]  reka - An Emacs-based WM for river (similar to EXWM)
  - [x]  rhine - Tiling window manager with a bsp layout, some Hyprland IPC for bars and ambitions of modularity
  - [x]  rijan - Small dynamic tiling window manager in 600 lines of Janet
  - [x]  rill - A minimalist scrolling window manager with simple animation, written in Zig
  - [x]  rrwm - Tiling window manager with a cosmic/bspwm layout, written in Rust
  - [x]  tarazed - Non-tiling window manager focusing on a powerful and distraction-free desktop experience
  - [x]  zrwm - Dynamic tiling window manager configured using a CLI tool
 - [x] River 0.4.0 module: `programs.river-next`
    - See available options [here](https://github.com/dmkhitaryan/river-next-nix-module/wiki/List-of-Module-Options)
      
## Importing
To install the module, you can do the following (npins-install):
+ Run `npins add --name "river-next" github dmkhitaryan river-next-nix-module -b main`
+ Add `river-next = sources.river-next;` in a `let` statement in your configuration (or don't!).
+ Import the module either by adding `"${river-next}/river-module.nix"` or `(import river-next).nixosModule` in your `imports`. 

## Goals
1. ~~Finish writing derivations for the window managers listed above.~~
2. ~~Write a module for River, along with options for enabling supported window managers.~~ 
3. Version control beyond manually running update scripts.

## Notes
Please note that all the packages here are pulling changes against their respective main branches. For window managers in particular, some are further along in development than others. Therefore, the risk of experiencing a breaking change may vary, **but it is always non-zero**!

Furthermore, it is highly recommended for users with multi-monitor setups to to configure outputs via tools like `kanshi`. This is because not all window managers support output management on their own, which will lead to incorrectly positioned windows or even crashes altogether.



