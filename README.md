# Starship Config

A [Starship](https://starship.rs/) prompt configuration.

## Features

- **Time display** - Shows current time (24h, UTC+1),
- **Battery indicator** - With red-to-green gradient,
- **Sudo session detection** - Based on cached sudo credentials,
  - `$` (green) - No active sudo session,
  - `#` (yellow) - Sudo credentials cached.
- **Git integration** - Branch name and detailed status indicators:
  <pre>
  - conflicted - 'X'                               (red bold),  
  - staged     - 'S'                               (green bold),  
  - modified   - '+'                               (green bold),  
  - renamed    - '~'                               (white bold),  
  - deleted    - '-'                               (red bold),  
  - untracked  - '?'                               (white bold),  
  - stashed    - '∆'                               (white),  
  - ahead      - '↑${count}'                       (yellow bold),  
  - behind     - '↓${count}'                       (red bold),
  - diverged   - '¦${ahead_count}/${behind_count}' (red).
  </pre>

- **Regular Bash features** - Displays active venv, color-coded username, hostname, directory etc...

## Installation

### Prerequisites

- [Starship](https://starship.rs/),
- `python3`,
- A `starship`-compatible shell.

### Quick Install

```bash
git clone git@github.com:YknotTYD/StarshipConfig.git
cd StarshipConfig
sh starship-config-install.sh
```

### Manual Install

```bash
# Generate the full config yourself (not recommended)
./starship_toml_gen.py > ~/.config/starship.toml
```
