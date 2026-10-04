# helix.nvim

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Neovim](https://img.shields.io/badge/Neovim-0.7+-green.svg?logo=neovim)](https://neovim.io)

**helix.nvim** brings the modern, selection-first modal editing workflow and keybindings inspired by the [Helix editor](https://helix-editor.com/) to Neovim.

> [!WARNING]
> **Under Active Development**: This project is in an early development stage and has **not been released yet**. Features, APIs, and keybindings are experimental, actively evolving, and subject to breaking changes.

> [!NOTE]
> **Open Source Attribution**: `helix.nvim` is a fork of [`kak.nvim`](https://github.com/mirlge/kak.nvim) by [mirge](https://github.com/mirlge). This project builds on `kak.nvim`'s foundation and is evolving towards full Helix editor integration and keybinding parity in Neovim under the [GNU General Public License v3.0](LICENSE).

---

## 💡 The Helix Philosophy: Selection → Action

In standard Vim / Neovim, editing follows an **Action → Motion** pattern (e.g., `dw` to delete a word, `ci"` to change inside quotes). You commit to an operation before visually confirming the target.

Helix inverts this model to **Selection → Action**:
1. **Select** the text first (e.g., `w` to select a word, `x` to select a line).
2. Inspect the highlighted selection.
3. Apply the **action** (e.g., `d` to delete, `c` to change, `y` to yank).

This interactive paradigm provides immediate visual feedback, minimizes editing mistakes, and makes complex manipulations intuitive.

---

## ⚡ Prerequisites

- **Neovim** >= 0.7.0
- *(Optional)* [which-key.nvim](https://github.com/folke/which-key.nvim) for interactive keybinding popups and text object discovery.

---

## 📦 Installation

### [💤 lazy.nvim](https://github.com/folke/lazy.nvim) (Recommended)

```lua
{
  "VyTrg/helix.nvim",
  event = "VeryLazy", -- load after other plugins to avoid conflicts
  opts = {
    -- configuration options (see below)
  },
}
```

With `which-key.nvim` integration:

```lua
{
  "VyTrg/helix.nvim",
  dependencies = { "folke/which-key.nvim" },
  event = "VeryLazy",
  opts = {
    which_key_integration = true,
  },
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({
  "VyTrg/helix.nvim",
  config = function()
    require("helix").setup({
      -- your configuration here
    })
  end,
})
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'VyTrg/helix.nvim'
" In your init.lua / config:
lua require("helix").setup()
```

---

## ⚙️ Setup & Configuration

Calling `setup()` is optional if you use `lazy.nvim` with `opts = {}`. Otherwise, invoke it in your configuration:

```lua
require("helix").setup({
  -- Default configuration:
  full = true,                  -- Enable full Helix keybind suite (if false, only remaps c, d, x, y)
  which_key_integration = true, -- Enable which-key text objects and goto integration

  experimental = {
    rebind_visual_aiAI = false, -- If true, rebinds Visual mode [aiAI] to insert/append at selection boundaries
  },
})
```

---

## ⌨️ Keybindings Reference

| Key        | Description | Mode           |
| :--------- | :---------- | :------------- |
| `c`        | Select current character and enter insert mode (`vc`) | normal |
| `d`        | Delete current character or visual selection (`vd`) | normal |
| `x`        | Select current line / expand selection linewise (`V`) | normal, visual |
| `y`        | Yank current character or visual selection (`vy`) | normal |
| `h`        | Move cursor left (clears visual selection) | normal, visual |
| `j`        | Move cursor down (clears visual selection) | normal, visual |
| `k`        | Move cursor up (clears visual selection) | normal, visual |
| `l`        | Move cursor right (clears visual selection) | normal, visual |
| `H`        | Extend selection left | normal, visual |
| `J`        | Extend selection down | normal, visual |
| `K`        | Extend selection up | normal, visual |
| `L`        | Extend selection right | normal, visual |
| `w`        | Move to next word start (creates selection) | normal, visual |
| `e`        | Move to next word end (creates selection) | normal, visual |
| `b`        | Move to previous word start (creates selection) | normal, visual |
| `W`        | Extend selection to next word start | normal, visual |
| `E`        | Extend selection to next word end | normal, visual |
| `B`        | Extend selection to previous word start | normal, visual |
| `<A-w>`    | Move to next WORD (whitespace-delimited) start (creates selection) | normal, visual |
| `<A-e>`    | Move to next WORD end (creates selection) | normal, visual |
| `<A-b>`    | Move to previous WORD start (creates selection) | normal, visual |
| `f`        | Find character forward (creates selection to character) | normal, visual |
| `t`        | Till character forward (creates selection up to character) | normal, visual |
| `F`        | Extend selection forward to character | normal, visual |
| `T`        | Extend selection forward till character | normal, visual |
| `<A-f>`    | Find character backward (extends selection) | normal, visual |
| `<A-t>`    | Till character backward (extends selection) | normal, visual |
| `<A-h>`    | Select from cursor to start of line (`0`) | normal, visual |
| `<A-l>`    | Select from cursor to end of line (`$`) | normal, visual |
| `gh`       | Go to start of line (`0`, clears visual selection) | normal, visual |
| `gl`       | Go to end of line (`$`, clears visual selection) | normal, visual |
| `Gh`       | Extend selection to start of line (`0`) | normal, visual |
| `Gl`       | Extend selection to end of line (`$`) | normal, visual |
| `gg`       | Go to buffer start (clears visual selection) | normal, visual |
| `ge`       | Go to buffer end (clears visual selection) | normal, visual |
| `Gg`       | Extend selection to buffer start | normal, visual |
| `Ge`       | Extend selection to buffer end | normal, visual |
| `gj`       | Jump to buffer bottom / last line (clears visual selection) | normal, visual |
| `gk`       | Jump to buffer top / first line (clears visual selection) | normal, visual |
| `Gj`       | Extend selection to buffer bottom / last line | normal, visual |
| `Gk`       | Extend selection to buffer top / first line | normal, visual |
| `gt`       | Go to top of screen view (`H`, clears visual selection) | normal, visual |
| `gc`       | Go to center of screen view (`M`, clears visual selection) | normal, visual |
| `gb`       | Go to bottom of screen view (`L`, clears visual selection) | normal, visual |
| `Gt`       | Extend selection to top of screen view (`H`) | normal, visual |
| `Gc`       | Extend selection to center of screen view (`M`) | normal, visual |
| `Gb`       | Extend selection to bottom of screen view (`L`) | normal, visual |
| `G`        | Goto extend prefix / Which-Key menu | normal, visual |
| `%`        | Select entire buffer (`ggVG`) | normal, visual |
| `<C-c>`    | Toggle comment on current line (`gcc`) or selection (`gc`) | normal, visual |
| `<A-j>`    | Join lines (`J`) | normal, visual |
| `<A-;>`    | Flip selection cursor to opposite end of selection | visual |
| `p`        | Paste after cursor / at selection end | visual |
| `P`        | Paste before cursor / at selection start | visual |
| `R`        | Replace character or selection with clipboard content | normal, visual |
| `o`        | Open newline below and move to selection end | visual |
| `O`        | Open newline above and move to selection start | visual |
| `<A-o>`    | Add newline below without moving cursor or selection | normal, visual |
| `<A-O>`    | Add newline above without moving cursor or selection | normal, visual |
| `<A-i>`    | Select inside text object (prompt for object) | normal, visual |
| `<A-a>`    | Select around text object (prompt for object) | normal, visual |
| `i'`       | Select inside single quotes | visual, operator-pending |
| `a'`       | Select around single quotes | visual, operator-pending |

---

## 🗺️ Roadmap towards Full Helix Integration

`helix.nvim` aims to bring complete Helix modal editing capabilities to Neovim:

- [x] Helix selection-first primitives (`c`, `d`, `x`, `y`)
- [x] Helix movement and extension keys (`[HJKL]`, `[WEB]`, `[FT]`)
- [x] Goto navigation (`g` and `G` extend family)
- [x] Which-key integration for text objects and goto motions
- [ ] Match mode (`m` / `M`) integration (matching brackets, surrounding pairs)
- [ ] View mode (`z` / `Z`) integration (scroll center, top, bottom)
- [ ] Multi-cursor / multi-selection workflows (Helix `s`, `S`, `C`, `alt-s`)
- [ ] Treesitter-based selection expansion (`[` and `]` family)

---

## 🛠️ Local Development (LazyVim / lazy.nvim)

To test and develop `helix.nvim` locally in your Neovim / LazyVim setup, point your plugin specification directly to the local directory:

```lua
-- ~/.config/nvim/lua/plugins/helix.lua
return {
  "VyTrg/helix.nvim",
  dir = "~/Documents/helix.nvim",
  dependencies = { "folke/which-key.nvim" },
  event = "VeryLazy",
  opts = {
    full = true,
    which_key_integration = true,
  },
}
```

---

## 🤝 Contributing

Contributions, bug reports, and suggestions are welcome!
- For major architectural changes or keymap additions, please open an issue first to discuss the design.
- Pull requests should adhere to existing Lua formatting conventions.

---

## 📜 License & Acknowledgments

This project is licensed under the **GNU General Public License v3.0** — see the [LICENSE](LICENSE) file for details.

### Acknowledgments

- **[kak.nvim](https://github.com/mirlge/kak.nvim)**: Original project by [mirge](https://github.com/mirlge) / [mirlge](https://codeberg.org/mirge/kak.nvim), from which `helix.nvim` was forked.
- **[Helix Editor](https://helix-editor.com/)**: For the inspiring modal editor design and selection-first paradigm.
