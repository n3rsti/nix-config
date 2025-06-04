{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.rstudio-copilot;

  copilotSetupScript = pkgs.writeShellScriptBin "setup-rstudio-copilot" ''
    #!/usr/bin/env bash
    set -e

    echo "Setting up GitHub Copilot for RStudio..."
    
    # Create required directories
    mkdir -p ~/.config/rstudio/copilot/node_modules
    mkdir -p ~/.vscode
    
    # Install GitHub Copilot CLI if not already installed
    if ! command -v github-copilot-cli &> /dev/null; then
      echo "Installing GitHub Copilot CLI..."
      npm install -g @github/copilot-cli
    fi
    
    # Check if VSCode is installed
    if ! command -v code &> /dev/null; then
      echo "Error: Visual Studio Code is not installed. Please install it first."
      exit 1
    fi
    
    # Check if GitHub Copilot extension is installed in VSCode
    if [ ! -d ~/.vscode/extensions/github.copilot-* ]; then
      echo "Installing GitHub Copilot extension for VSCode..."
      code --install-extension GitHub.copilot
    fi
    
    # Create symlinks to VSCode extension for RStudio to use
    copilot_ext_path=$(find ~/.vscode/extensions -name "github.copilot-*" -type d | head -n 1)
    if [ -n "$copilot_ext_path" ]; then
      echo "Found GitHub Copilot extension at $copilot_ext_path"
      # Create symlink to agent binary
      mkdir -p ~/.config/rstudio/copilot/bin
      if [ -f "$copilot_ext_path/dist/agent.js" ]; then
        ln -sf "$copilot_ext_path/dist/agent.js" ~/.config/rstudio/copilot/bin/
        echo "Linked agent.js to ~/.config/rstudio/copilot/bin/"
      else
        echo "Error: agent.js not found in $copilot_ext_path/dist/"
        exit 1
      fi
      
      # Create symlinks to node_modules
      if [ -d "$copilot_ext_path/node_modules" ]; then
        for module in "$copilot_ext_path/node_modules/"*; do
          module_name=$(basename "$module")
          ln -sf "$module" ~/.config/rstudio/copilot/node_modules/
        done
        echo "Linked node_modules to ~/.config/rstudio/copilot/node_modules/"
      else
        echo "Error: node_modules not found in $copilot_ext_path"
        exit 1
      fi
    else
      echo "Error: GitHub Copilot extension not found in ~/.vscode/extensions/"
      exit 1
    fi
    
    echo "Setup complete! GitHub Copilot should now work with RStudio."
    echo "Make sure to authorize Copilot in VSCode first before using it in RStudio."
  '';
in {
  options.programs.rstudio-copilot = {
    enable = mkEnableOption "Enable GitHub Copilot for RStudio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      copilotSetupScript
      vscode
      nodejs
      git
      nodePackages.npm
    ];
    
    # Set required environment variables
    environment.sessionVariables = {
      # GitHub Copilot paths
      GITHUB_COPILOT_PATH = "$HOME/.vscode/extensions/github.copilot-*";
      NODE_PATH = "$HOME/.config/rstudio/copilot/node_modules";
    };

    # Open necessary ports for GitHub Copilot
    networking.firewall.allowedTCPPorts = [ 9000 9999 ];
  };
}