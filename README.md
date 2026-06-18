# Dotfiles
System configuration for my machines using the [Dendritic pattern][Dendritic] — a structured way to organise NixOS/nix configurations as reusable modules that anyone can adopt.

# Features

* A devshell with handy hooks to keep your config orgnised,
* A formatter set under the flake makes it easy as one command `nix fmt` to format the codebase,
* Flake Templates such as language specific environments 
* Module option Helpers template that offers module Helpers such as (nixvim, nix-darwin, nixos, nixpkgs, etc..) available such as an easy `nix flake init -t github:eveeifyeve/dotfiles#module-option-helpers`
* A good configuration examples


### Supported Platforms

| Platform | Status |
|---|---|
| NixOS | ✅ Supported |
| Home-Manager | ⚠️ Partially Supported (missing install docs) |
| Hjem | ❌ Not supported at all (simply due to missing module support/maturity) |
| nix-darwin (macOS) | ✅ Supported |
| nix-on-droid | 🚧 In progress |
| nix-bsd | 🟠 (Highly expermential & not tested) |
| nix-windows | ❌ (Will work on it once nix-windows exists) |
| System-Manager | 🟠 (Highly expermential, not tested & missing module support) |
Need support for another platform? [Open a GitHub issue][issues] if one doesn't already exist (don't open a new issue if one exists, just 👍 if you think it's important).

---

# Helper Installing Commands

* Darwin:
```bash
sudo nix run --extra-experimental-features "nix-command flakes" nixpkgs#git -- clone https://github.com/eveeifyeve/dotfiles /etc/nixos
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake /etc/nixos
```

* NixOS (Manual):
```
nix run --extra-experimental-features "nix-command flakes" nixpkgs#git -- clone https://github.com/eveeifyeve/dotfiles /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#<your-hostname>
```
---

# Rebuilding

This repo uses [nh][nh], a friendly wrapper around `nixos-rebuild`, `darwin-rebuild`, and `home-manager`. It gives cleaner output and handles common tasks automatically.
[See the nh documentation for available commands →][nhBuild]

---

# Updating

Keeping your system up to date is a two-step process: update the lock file, then rebuild.

### Step 1 — Update inputs (choose one)

**a. Manually** — run the following to update all flake inputs and commit it:
```bash
nix flake update
git add flake.lock && git commit -m "chore: update flake inputs"
```

**b. Automatically** — use [Renovate][renovate] or [Dependabot][dependabot] to open pull requests for input updates, then merge them.

### Step 2 — Deploy

- **NixOS / Darwin:** Your system will pick up the changes on the next rebuild (or automatically if you use the deployment service comin).
- **Home-Manager:** You need to manually trigger a rebuild — [see the rebuild section above](#nixos--home-manager--darwin).

<!-- Links -->
[NixDownload]: https://nixos.org/download
[nh]: https://github.com/nix-community/nh
[Dendritic]: https://github.com/mightyiam/dendritic
[nhBuild]: https://github.com/nix-community/nh#platform-specific-subcommands
[renovate]: https://github.com/renovatebot/renovate
[dependabot]: https://github.com/dependabot/dependabot-core
[issues]: https://github.com/eveeifyeve/dotfiles/issues
[flake-file]: https://github.com/denful/flake-file
