{inputs, ...}: {
  flake.nixosModules.kanata = {...}: {
    imports = [
      inputs.kanata-switcher.nixosModules.default
    ];
    users.users.andrew = {
      extraGroups = ["input"];
    };
    services = let
      tcpPort = 10000;
    in {
      kanata = {
        enable = true;

        keyboards.main = {
          port = tcpPort;
          extraDefCfg = "process-unmapped-keys yes";
          config =
            # kdl
            ''
              (defsrc
               caps
               a s d f
               j k l ;
              )

              (deflayer base
               @caps-mod
               _ _ _ _
               _ _ _ _
              )

              (deflayer home-row
               @caps-mod
               @a-mod @s-mod @d-mod @f-mod
               @j-mod @k-mod @l-mod @;-mod
              )

              (defvar
               tap-time 200
               hold-time 200
              )

              (defalias
               caps-mod (tap-hold-press $tap-time $hold-time esc lctl)

               a-mod (tap-hold $tap-time $hold-time a lalt)
               s-mod (tap-hold $tap-time $hold-time s lmet)
               d-mod (tap-hold $tap-time $hold-time d lctl)
               f-mod (tap-hold $tap-time $hold-time f lsft)

               j-mod (tap-hold $tap-time $hold-time j rsft)
               k-mod (tap-hold $tap-time $hold-time k rctl)
               l-mod (tap-hold $tap-time $hold-time l rmet)
               ;-mod (tap-hold $tap-time $hold-time ; ralt)
              )
            '';
        };
      };
      kanata-switcher = {
        enable = true;
        kanataPort = tcpPort;
        settings = [
          {default = "home-row";}
          {on_native_terminal = "home-row";}
          {
            class = "^steam_app";
            layer = "base";
          }
        ];
      };
    };
  };
}
