_: {
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  services.gnome.gcr-ssh-agent.enable = false;
}
