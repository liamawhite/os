{
  checks.verifyNixPath = false; # Turn off NIX_PATH warnings now that we're using flakes
  stateVersion = 5;
  primaryUser = "liam";

  defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      "com.apple.swipescrolldirection" = true;

      # 120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;

      # 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 15;

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 10.0;
      show-recents = false;
      launchanim = false;
      orientation = "bottom";
      tilesize = 48;
      mru-spaces = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    CustomUserPreferences = {
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
      };
      # Avoid creating .DS_Store files on network or USB volumes
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screensaver" = {
        # Require password immediately after sleep or screen saver begins
        askForPassword = 1;
        askForPasswordDelay = 0;
      };
      "com.apple.speech.recognition.AppleSpeechRecognition.prefs" = {
        # Set dictation shortcut to double-tap Control key
        DictationIMShortcutType = 2;
      };
    };
  };

  keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # activationScripts.preUserActivation.text = ''
  #   if ! xcode-select --version 2>/dev/null; then
  #     xcode-select --install
  #   fi
  #   if ! /opt/homebrew/bin/brew --version 2>/dev/null; then
  #     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  #   fi
  # '';
  #
  # # Avoid a logout/login cycle
  # activationScripts.postUserActivation.text = ''
  #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  # '';
}
