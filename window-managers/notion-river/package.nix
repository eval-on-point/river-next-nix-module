{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wayland-scanner,
  wayland,
  libxkbcommon,
  cairo,
  pango,
}:
rustPlatform.buildRustPackage {
  pname = "notion-river";
  version = "unstable-2026-03-21";

  src = fetchFromGitHub {
    owner = "Marenz";
    repo = "notion-river";
    rev = "a72ecbf55c07d780d3386a9ca3a4baa2bcb7315c";
    hash = "sha256-V9V6ksPaiJ5qc9Urftbu8fLRDye59VLn+tH3p8u+9Y0=";
  };

  cargoHash = "sha256-FZS49RAXgOHYIG2xWinNuJFfMFduHkNo7bGk9aD1Weo=";

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    wayland
    libxkbcommon
    cairo
    pango
  ];

  postInstall = ''
    cp -r $src/config-examples/ $out
  '';

  meta = {
    homepage = "https://github.com/Marenz/notion-river";
    description = "Notion/Ion3-style static tiling window manager for the River Wayland compositor";
    longDescription = ''
      notion-river is a static tiling window manager for the River Wayland compositor. Inspired by Notionwm (previously Ion3).
      As a result, unlike other tiling window managers, notion-river uses persistent frames. User has to explicitly split/unsplit layout.
      Additionally supporting floating mode, has waybar integration, and more.
    '';
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      dmkhitaryan
    ];
    platforms = lib.platforms.linux;
  };
}
