{
  description = "GStreamer development shell";

  inputs = {
    nix-overlays.url = "github:nix-ocaml/nix-overlays";
    nixpkgs.follows = "nix-overlays/nixpkgs";
  };

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              bison
              flex
              gettext
              glib
              indent
              meson
              ninja
              pkg-config
              python3
            ];
          };
        }
      );
    };
}
