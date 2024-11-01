{ pkgs, pkgs-stable, system, ... }:

{
  home.packages = with pkgs; builtins.filter (pkg: pkg != null) [
    btop
    docker-credential-helpers
    eza
    fd
    flux
    k9s
    kitty
    kubectl
    just
    lazydocker
    lazygit
    neofetch
    nodejs_22 # for Github Copilot
    nerdfonts
    raycast
    ripgrep
    rsync
    (if system != "aarch64-linux" then slack else null)
    (if system != "aarch64-li pnux" then spotify else null)
    spicetify-cli
    tmux
    tree
    vim
    vivid
    xclip
    (if system != "aarch64-linux" then zoom-us else null)
    yazi
    zoxide
    zsh
  ] ++ (with pkgs-stable; [
    obsidian
  ]);
}