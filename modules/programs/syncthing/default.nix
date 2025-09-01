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
          "macbookpro-docusign-2025" = {
            id = "VNBUOSV-NBA7BXM-FCQ2KWS-5YIJNTQ-ZXP2LI6-6HL5ESK-UZY7RRG-7BTW3AU";
          };
          "kubernetes-syncthing-mirror" = {
            id = "WWRWTXL-2QLS6J7-QNSA5MZ-XLLUS4R-TKBA754-GXYFAEF-33IO7G4-LH5FIAW";
          };
          "macbookpro-personal-2025" = {
            id = "YFRAWME-SEF4QKB-GGUK25Q-ABHMASU-HIYZTRX-G3H2AD7-237IM24-R6SZHQG";
          };
        };

        folders = {
          "org/personal" = {
            path = "~/org/personal";
            devices = [ "macstudio-personal-2023" "macbookpro-docusign-2025" "macbookpro-personal-2025" "kubernetes-syncthing-mirror" ];
            type = "sendreceive";
          };
          "notes/personal" = {
            path = "~/notes/personal";
            devices = [ "macstudio-personal-2023" "macbookpro-docusign-2025" "macbookpro-personal-2025" "kubernetes-syncthing-mirror" ];
            type = "sendreceive";
          };
          "notes/.notedown" = {
            path = "~/notes/.notedown";
            devices = [ "macstudio-personal-2023" "macbookpro-docusign-2025" "macbookpro-personal-2025" "kubernetes-syncthing-mirror" ];
            type = "sendreceive";
          };
        };
      };
    };
  };
}

