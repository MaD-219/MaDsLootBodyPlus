# MaDsLootBodyPlus

[![WoW Version](https://img.shields.io/badge/WoW-12.1.0%20(Midnight)-blue.svg)](https://worldofwarcraft.blizzard.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**MaDsLootBodyPlus** is a lightweight quality-of-life World of Warcraft addon designed to automate repetitive prompts during group content, raids, and dungeon runs.

---

## ✨ Features

- 🔄 **Auto-Accept Resurrections**: Automatically accepts combat and non-combat resurrections after a **10-second delay**, ensuring you don't revive prematurely into hazards.
- 🚪 **Auto-Accept Summons**: Automatically accepts incoming group summons after a **10-second delay**.
- 🎲 **Auto-Pass Loot**: Instantly passes on all group loot rolls (ideal for carries, alt runs, or designated loot sessions).
- 🛡️ **Session-Based Safety (Opt-In)**: The addon **always loads in a disabled state** on login and UI reloads. It will never run unintentionally—you must explicitly enable it when you want it active.
- 🖥️ **Interactive Control Panel**: A draggable, minimalist status window to toggle features independently.
- ⌨️ **Slash Commands**: Quick command-line toggles for macros or fast access.

---

## 💻 Commands

| Command | Action |
|---|---|
| `/lb` | Opens or closes the MaDsLootBodyPlus control panel. |
| `/lb enable` | Enables all automation features (Auto-Accept + Auto-Pass). |
| `/lb disable` | Disables all automation features. |

---

## 📦 Installation

### Manual Installation
1. Go to the [Releases](https://github.com/MaD-219/MaDsLootBodyPlus/releases) page on GitHub.
2. Download the latest `MaDsLootBodyPlus.zip`.
3. Extract the `MaDsLootBodyPlus` folder into your World of Warcraft AddOns directory:
   - **Retail**: `World of Warcraft\_retail_\Interface\AddOns\`
4. Verify the folder structure matches:
   ```text
   World of Warcraft\_retail_\Interface\AddOns\MaDsLootBodyPlus\MaDsLootBodyPlus.toc
   ```
5. Log into the game (or type `/reload` if already logged in) and type `/lb` to open the control panel.

---

## 🔒 Safety & Blizzard API Compliance

- **Protected Functions Respected**: The addon strictly uses Blizzard's public API functions (`AcceptResurrect`, `C_SummonInfo.ConfirmSummon`, `RollOnLoot`). It does not automate spell casting or actions restricted to hardware events.
- **No Accidental Actions**: Because settings default to disabled upon every session load, you will never leave auto-pass or auto-accept active by accident across game sessions.

---

## 🛠️ Development & Compatibility

- **Target Client**: World of Warcraft Patch 12.1.0 (*Midnight*)
- **Interface Version**: `120100`

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
