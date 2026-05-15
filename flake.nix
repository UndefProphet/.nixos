# D o  N o t  E d i t o  O r  I  K i l l o  B i l l u !
{
  description = "Potato";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      ref = "master";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
    };
    fuzzy-search-yazi = {
      url = "github:onelocked/fuzzy-search.yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    glide-browser = {
      url = "github:glide-browser/glide.nix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };
    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      type = "github";
      owner = "myume";
      repo = "niri-flake";
      ref = "blur";
    };
    nix-index-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      type = "github";
      owner = "FlameFlag";
      repo = "nixcord";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-credentials = {
      url = "git+ssh://git@github.com/UndefProphet/.nixos.credentials";
      flake = false;
    };
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    nixvim.url = "github:nix-community/nixvim";
    sops-nix = {
      type = "github";
      owner = "Mic92";
      repo = "sops-nix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      type = "github";
      owner = "Gerg-L";
      repo = "spicetify-nix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      type = "github";
      owner = "nix-community";
      repo = "stylix";
      ref = "master";
    };
  };
}
