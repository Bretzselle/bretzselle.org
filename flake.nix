{
  description = "Bretz'selle website development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby_3_3;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            ruby
            pkgs.bundler
            pkgs.pkg-config
            pkgs.libxml2
            pkgs.libxslt
            pkgs.zlib
            pkgs.openssl
          ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
            pkgs.libiconv
            pkgs.darwin.apple_sdk.frameworks.CoreFoundation
            pkgs.darwin.apple_sdk.frameworks.Security
          ];

          shellHook = ''
            export BUNDLE_PATH="$PWD/vendor/bundle"
            export PATH="$PWD/vendor/bundle/bin:$PATH"

            # Point nokogiri and other native gems at nix-provided libs
            export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:${pkgs.libxslt.dev}/lib/pkgconfig:${pkgs.zlib.dev}/lib/pkgconfig"
            export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

            echo "Ruby $(ruby --version | cut -d' ' -f2)"
            if [ ! -d vendor/bundle ]; then
              echo "Run 'bundle install' to install gem dependencies."
            fi
          '';
        };
      }
    );
}
