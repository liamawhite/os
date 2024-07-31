{ homebrew-core, homebrew-cask, homebrew-bundle, homebrew-pulumi, homebrew-dagger, ... }:

{
    nix-homebrew = {
        enable = true;
        user = "liam";
        taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
            "homebrew/homebrew-bundle" = homebrew-bundle;
            "pulumi/tap" = homebrew-pulumi;
            "dagger/tap" = homebrew-dagger;
        };
        mutableTaps = true; # Setting this to false caused too much pain
        autoMigrate = true;
    };

}