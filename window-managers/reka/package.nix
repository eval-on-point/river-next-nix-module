{
  lib,
  rustPlatform,
  fetchFromCodeberg,
  pkg-config,
  wayland-scanner,
  wayland,
  libxkbcommon,
  wayland-protocols,
  emacsPackages,
  fetchurl,
}: # Packaging approach adopted from https://codeberg.org/tazjin/reka/src/branch/canon/default.nix

let
  reka = rustPlatform.buildRustPackage {
    pname = "reka-lib";
    version = "unstable-2026-03-22";

    src = fetchFromCodeberg {
      owner = "tazjin";
      repo = "reka";
      rev = "c8ef1c0cc3c8de6101e04d40b44f377829c52b1e";
      hash = "sha256-aIKBSu+sodhSQ7PrbqZ6V63ndTBuspDLd/VBN52Zn6c=";
    };

    cargoHash = "sha256-h5FTiU6zR0+w0KVnrjjaeQkSXOuCrQOXbZinJMLrNiY=";

    nativeBuildInputs = [
      pkg-config
      wayland-scanner
    ];

    buildInputs = [
      wayland
      libxkbcommon
      wayland-protocols
    ];

    postInstall = ''
      mkdir -p $out/share/emacs/site-lisp
      ln -s $out/lib/libreka.so $out/share/emacs/site-lisp/libreka.so
    '';
  };
in
emacsPackages.trivialBuild {
  pname = "reka";
  version = "unstable-2026-03-16";
  src = fetchurl {
    url = "https://codeberg.org/tazjin/reka/raw/branch/canon/lisp/reka.el";
    hash = "sha256-1VqU2aLrO13rIVksM4guDdOVfC4CEdZkotleTyBApoc=";
  };
  packageRequires = [ reka ];

  passthru.reka-lib = reka;

  meta = {
    homepage = "https://code.tvl.fyi/about/tools/emacs-pkgs/reka";
    description = "Emacs-based window manager for river";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      dmkhitaryan
    ];
    platforms = lib.platforms.linux;
  };
}
