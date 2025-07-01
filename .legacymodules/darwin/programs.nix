{ config, pkgs, lib, user, email, ... }:

import ../shared/programs { inherit config pkgs lib user email; }
  //
{ }

