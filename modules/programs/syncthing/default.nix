{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, pkgs, ... }: {
    services.syncthing = {
      enable = true;

      settings = {
        devices = {
          "macstudio-personal-2023" = {
            id = "Y6NSC7H-7ISVMIQ-MG6CA4Z-TIXVGBU-CPCRHHN-EAKVOKC-RVWTF45-ZIEANQ7";
          };
          "macbookpro-personal-2018" = {
            id = "OIDLC3D-EX3JH4E-FKEE2X5-YKGVYM4-7QLPPJQ-6ELD5T6-2GQB473-N6CRSAA";
          };
        };

        folders = {
          "org/personal" = {
            path = "~/org/personal";
            devices = [ "macstudio-personal-2023" "macbookpro-personal-2018" ];
            type = "sendreceive";
          };
        };
      };
    };
  };
}

