# NixOS Configuration

This repository contains my NixOS and Home Manager configuration for multiple machines, including:

- PC workstation
- Laptop
- WSL
- Server

The setup includes reusable modules that can be imported to configure hosts quickly and consistently. To prioritize stability, most packages are sourced from the stable `nixpkgs` channel.

In addition, the configuration uses the `determinate-nix` channels. These are derived from the upstream `nixpkgs` channels and include extra features such as [nixpkgs-cooldown](https://determinate.systems/blog/nixpkgs-cooldown), which helps improve supply-chain security.


> [!NOTE]
> Most of my dotfile configurations are already integrated into this repository. The rest can be found in my [dotfiles](https://github.com/n3rsti/dotfiles) repository.

## Screenshots

### Noctalia Shell Configuration

![Noctalia shell configuration](./assets/20260706_204418.png)

![Noctalia shell configuration](./assets/20260706_204502.png)

### Waybar Configuration

![Desktop showcase with Waybar](./assets/desktop.png)

## Details

### General Overview

This repository manages the configuration for multiple NixOS-based systems using a modular structure. It provides ready-to-import modules and reusable profiles to simplify setup across different machines.

### Host Configurations

All personal devices use **Tailscale** for secure connectivity.

#### PC

Main workstation configured for:

- Development
- Local and remote gaming
- Remote builds for other machines

#### Laptop

Shares most of its configuration with the **PC**. It is configured for:

- Updates built remotely by the PC
- Comfortable usage without additional peripherals

#### Server

Configured as a 24/7 base for device integration and self-hosted services, including:

- Remote storage with **Nextcloud**
- Movie and series streaming with the **Arr stack** and **Jellyfin**
- Minecraft server hosting with [nix-minecraft](https://github.com/Infinidoge/nix-minecraft)
- Document organization with **Paperless**
- Image storage with **Immich**
- Backups with **borgbackup**
- Build caching with **Github Actions** and **Attic** for ultra fast rebuilds even on slower machines
- Network-wide and remote Ad Blocking with **Pi-hole**
- Dashboard with **Glance**

## Repository Structure

- `flake.nix`: Entry point defining all system configurations
- `modules/`: Reusable modules
  - `features/`: Ready-to-import modules, each implementing one specific part of the system
  - `flake/`: Additional flake configuration
  - `homes/`: Home Manager and dotfiles integration
  - `hosts/`: Main host configurations
  - `profiles/`: Reusable bundles of modules, such as the `workstation` profile for the **PC** and **laptop**
  - `users/`: User definitions

## Methodology

To keep the configuration modular and maintainable across multiple hosts, this repository follows the [dendritic pattern](https://github.com/mightyiam/dendritic).

This means that each module should be a [flake-parts](https://flake.parts/) module that implements a single feature.

## Usage

### Setting Up a New Host

1. Clone the repository.

> [!TIP]
> Use `nix-shell -p git nh` if `git` and `nh` are not available.

2. Create a new host under `modules/hosts/`.

3. Generate the hardware configuration:

   ```sh
   make generate-hardware-config
   ```

4. Import the selected modules, profiles, and `hardware-configuration.nix`.

5. Rebuild the system:

   ```sh
   nh os switch -H hostname
   ```

   Example:

   ```sh
   nh os switch -H pc
   ```

6. If you have the same hostname and configuration name, you can continue to just use:

   ```sh
   nh os switch
   ```

