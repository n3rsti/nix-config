{ self, ... }:
{
  flake.homeModules.application-suite = {
    imports = [
      self.homeModules.browsers
      self.homeModules.communication
      self.homeModules.documents
      self.homeModules.maker
      self.homeModules.media
      self.homeModules.productivity
    ];
  };
}
