{
  description = "A very basic flake";

  inputs =
    {
      nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
      flake-utils.url = "github:numtide/flake-utils";
    };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildInputs = with pkgs; [
          (texlive.combine {
            inherit (texlive)
              scheme-small

              # Add other LaTeX libraries (packages) here as needed, e.g:
              sourcesanspro
              moresize
              anyfontsize
              csquotes
              enumitem
              titlesec
              standalone
              currfile
              gincltex
              svn-prov
              adjustbox
              collectbox
              filemod
              blindtext
              ly1

              # build tools
              latexmk

              # dev tools
              chktex
              latexindent
              ;
          })
          glibcLocales
          nixpkgs-fmt
        ];
      in
      with pkgs;
      {
        devShells.default = pkgs.mkShell {
          shellHook = "echo Welcome to your nix flake powered shell environment with all your latex deps";
          packages = buildInputs ++ [ ghostscript ];
        };

        packages.default = stdenv.mkDerivation {
          inherit buildInputs;
          name = "resume";
          src = ./.;
          meta = with lib; {
            description = "My resume";
            license = licenses.gpl3;
            platforms = platforms.linux;
          };
        };
      }
    );
}
