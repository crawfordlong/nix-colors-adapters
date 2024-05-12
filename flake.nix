{
  description = "";

  inputs = { nix-colors.url = "github:misterio77/nix-colors"; };

  outputs = { self, nix-colors }:
    let nixColorsAdaptersLib = import ./lib.nix; in {
      _module.args.nixColorsAdaptersLib = nixColorsAdaptersLib;
      homeManagerModules.default = import ./adapters;
      lib = nixColorsAdaptersLib;
    };
}
