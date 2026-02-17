# zigdoc-nix

Nix flake for [zigdoc](https://github.com/rockorager/zigdoc) - a terminal documentation viewer for Zig standard library and imported modules.

## Usage

### Run directly

```bash
nix run github:uzaaft/zigdoc-nix
```

### Add to your flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zigdoc.url = "github:uzaaft/zigdoc-nix";
  };

  outputs = {
    nixpkgs,
    zigdoc,
    ...
  }: let
    system = "x86_64-linux"; # or aarch64-darwin, etc.
  in {
    devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      buildInputs = [zigdoc.packages.${system}.default];
    };
  };
}
```

### Use the overlay

```nix
overlays = [ zigdoc.overlays.default ];
# Then access via pkgs.zigdoc
```

### Add to devShell

```nix
devShells.default = pkgs.mkShell {
  buildInputs = [ zigdoc.packages.${system}.default ];
};
```
