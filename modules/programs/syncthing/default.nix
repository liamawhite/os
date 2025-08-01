{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, pkgs, ... }: {
    services.syncthing = {
      enable = true;

      settings = {
        devices = {
          "macstudio-personal-2023" = {
            id = "BXLJQAD-JGO6OW4-Z5YXHZN-N33HASZ-LJBVBVR-XCJKVLX-PSWF3ZP-EU7XZAK";
          };
        };

        folders = {
          "org" = {
            path = "~/org/personal";
            devices = [ "macstudio-personal-2023" ];
            type = "sendreceive";
          };
        };
      };
    };
  };
}

