{
  stdenv,
  fetchFromSourcehut,
  wayland,
  pkg-config,
  wayland-scanner,
  wayland-protocols,
  libxkbcommon,
  lib,
  git,
}:
let
  exampleConfig = ./init;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zrwm";
  version = "unstable-2026-03-22";

  src = fetchFromSourcehut {
    owner = "~zuki";
    repo = "zrwm";
    rev = "d36851012c15b81498900dfd68d6fc56cf828699";
    hash = "sha256-q0iOCaCWMaMWRQOTXRpo/SAPBQB0Nf+EdK+aapwP4+w=";
  };

  nativeBuildInputs = [
    wayland-scanner
    pkg-config
    git
  ];
  buildInputs = [
    wayland
    libxkbcommon
    wayland-protocols
  ];

  buildPhase = ''
    cc nob.c -o nob
    ./nob
  '';

  installPhase = ''
    install -Dm755 zrwm $out/bin/zrwm
    install -Dm755 zrwm-msg $out/bin/zrwm-msg
    install -Dm755 ${exampleConfig} $out/examples/init
  '';

  postPatch = ''
    substituteInPlace ipc.h \
      --replace \
        'init_file = malloc(sizeof(char) * (home_len + zrwm_init_text_len));' \
        'init_file = malloc(sizeof(char) * (home_len + zrwm_init_text_len + 1));'
  '';

  meta = {
    homepage = "https://git.sr.ht/~zuki/zrwm";
    description = "dwl-inspired window manager for river";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      dmkhitaryan
    ];
    platforms = lib.platforms.linux;
  };
})
