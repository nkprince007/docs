{
  description = "A very basic flake";

  inputs =
    {
      nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
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
            ;
        })
        glibcLocales
        ghostscript
      ];
    in
    with pkgs;
    {
      devShells.${system}.default = pkgs.mkShell {
        shellHook = "echo Welcome to your nix flake powered shell environment with all your latex deps";
        packages = buildInputs;
      };

      packages.${system}.default = stdenv.mkDerivation {
        inherit buildInputs;

        name = "resume";

        src = ./.;

        meta = with lib; {
          description = "My resume";
          license = licenses.gpl3;
          platforms = platforms.linux;
        };
      };
    };
}
