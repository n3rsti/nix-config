{
  flake.homeModules.kubernetes = { pkgs, ... }: {
    home.packages = with pkgs; [
      kind
      kubectl
      kubernetes-helm
      minikube
    ];
  };
}
