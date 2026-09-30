# helix.nvim

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Neovim](https://img.shields.io/badge/Neovim-0.7+-green.svg?logo=neovim)](https://neovim.io)

**helix.nvim** brings the modern, selection-first modal editing workflow and keybindings inspired by the [Helix editor](https://helix-editor.com/) to Neovim.

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

### Core Actions (Normal Mode)

| Key | Helix Action | Neovim Equivalent | Description |
|:---:|:---|:---|:---|
| `c` | Change | `vc` | Select current character and enter insert mode |
| `d` | Delete | `vd` | Delete current character/selection |
| `x` | Select Line | `V` | Select the current line (or expand selection by lines) |
| `y` | Yank | `vy` | Yank current character/selection |

### Navigation & Selections (`full = true`)

#### Basic Movement
- `h`, `j`, `k`, `l` — Move cursor (clears current visual selection before moving).
- `H`, `J`, `K`, `L` — **Extend** selection left, down, up, or right.

#### Word Motions
- `w`, `e`, `b` — Move to and select next word start, word end, or previous word start.
- `W`, `E`, `B` — **Extend** selection to next word start, word end, or previous word start.
- `<A-w>`, `<A-e>`, `<A-b>` — WORD (whitespace-delimited) variants: select / extend.

#### Character Search
- `f<char>` — Find `<char>` forward (creates selection to character).
- `t<char>` — Till `<char>` forward (creates selection up to character).
- `F<char>`, `T<char>` — **Extend** selection forward to / till `<char>`.
- `<A-f><char>`, `<A-t><char>` — Find / till backward (extends selection).

#### Line & Buffer Navigation
- `<A-h>`, `<A-l>` — Select from cursor to start (`0`) or end (`$`) of line.
- `gh`, `gl` — Go to start or end of line (exits visual selection first).
- `Gh`, `Gl` — **Extend** selection to start or end of line.
- `gg`, `ge` — Go to buffer start or buffer end.
- `Gg`, `Ge` — **Extend** selection to buffer start or buffer end.
- `gj`, `gk` — Jump to buffer bottom or buffer top.
- `Gj`, `Gk` — **Extend** selection to buffer bottom or buffer top.
- `gt`, `gc`, `gb` — Go to top, center, or bottom of screen view.
- `Gt`, `Gc`, `Gb` — **Extend** selection to top, center, or bottom of screen view.

#### Manipulation & Paste
- `<A-j>` — Join lines (`J`).
- `<A-;>` — Flip selection cursor (move cursor to the other end of the selection).
- `p`, `P` — Paste (in Visual mode, pastes at the corresponding end of selection).
- `R` — In Normal mode: replace character with clipboard; in Visual mode: replace entire selection with clipboard.
- `o`, `O` — Open newline below / above.
- `<A-o>`, `<A-O>` — Add newline below / above without moving cursor / disturbing selection.

#### Text Objects
- `<A-i><obj>` — Select *inside* text object (e.g. `<A-i>w` for inner word, `<A-i>"` for inside quotes).
- `<A-a><obj>` — Select *around* text object (e.g. `<A-a>w` around word).

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

## 🛠️ Local Development

A development runner script is provided in `./dev`:

```bash
./dev/dev.sh [file]
```

This launches a clean, isolated Neovim instance with `helix.nvim` loaded from the local repository.

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
