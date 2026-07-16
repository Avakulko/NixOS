{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.jujutsu = moduleWithSystem (
    {
      self',
      pkgs,
    }: {
      environment.systemPackages = [self'.packages.jujutsu pkgs.commitlint-rs pkgs.hunk];
    }
  );
  perSystem = {pkgs, ...}: {
    packages.jujutsu = inputs.wrapper-modules.wrappers.jujutsu.wrap {
      inherit pkgs;
      settings = {
        template-aliases = {
          "format_short_change_id(id)" = "id.shortest()";
        };
        user = {
          name = "Andrew";
          email = "45006345+Avakulko@users.noreply.github.com";
        };
      };
    };
  };
}
