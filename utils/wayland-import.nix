# Select a compositor and a portal group, returning a Home Manager module.
# `portal` omits the `-portal.nix` suffix used by portal group files.
{ compositor, portal }:

import (../common/home/wayland-compositor + "/${compositor}") {
  portal = import (../common/home/wayland-portals + "/${portal}-portal.nix");
}
