{
  description = "zigdoc - terminal documentation viewer for Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        zigdoc = pkgs.stdenv.mkDerivation {
          pname = "zigdoc";
          version = "0-unstable-2026-02-02";

          src = pkgs.fetchFromGitHub {
            owner = "rockorager";
            repo = "zigdoc";
            rev = "c685d9a518d8dcc46a26a863d3443c60a8e3c111";
            hash = "sha256-mVqci0MPu2JTs2LutiB/aKiKSKqZY1rvUSWlwUa98mk=";
          };

          nativeBuildInputs = [pkgs.zig.hook];

          dontUseZigCheck = true;

          meta = {
            description = "Terminal documentation viewer for Zig standard library and imported modules";
            homepage = "https://github.com/rockorager/zigdoc";
            license = pkgs.lib.licenses.mit;
            maintainers = [];
            mainProgram = "zigdoc";
          };
        };

        default = self.packages.${system}.zigdoc;
      }
    );

    overlays.default = final: prev: {
      zigdoc = self.packages.${prev.system}.zigdoc;
    };
  };
}
