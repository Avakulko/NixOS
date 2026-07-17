{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.myMachineConfiguration = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.niri
      self.nixosModules.networking
      self.nixosModules.kanata
      self.nixosModules.nix
      self.nixosModules.nautilus
      self.nixosModules.jujutsu
      self.nixosModules.kitty
      self.nixosModules.neovim

      inputs.dms.nixosModules.greeter
      inputs.dms.nixosModules.dank-material-shell
    ];
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "myMachine"; # Define your hostname.
    # Set your time zone.
    time.timeZone = "Asia/Yekaterinburg";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver = {
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
    };

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    # services.pulseaudio.enable = true;
    # OR
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.andrew = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user
        "networkmanager"
      ];
      # packages = with pkgs; [
      #   tree
      # ];
    };

    programs = {
      # neovim = {
      #   enable = true;
      #   defaultEditor = true;
      #   package = self.packages."${pkgs.stdenv.hostPlatform.system}".neovim;
      # };
      television = {
        enable = true;
        enableBashIntegration = true;
      };
      firefox.enable = true;
      git.enable = true;
      dank-material-shell = {
        enableCalendarEvents = false; # BUG
        enable = true;
        systemd = {
          enable = true;
          restartIfChanged = true;
        };
        greeter = {
          compositor = {
            name = "niri";
          };
          enable = true;
        };
      };
      yazi.enable = true;
      starship.enable = true;
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      comma

      # LLM
      pi-coding-agent
      herdr
      openshell

      sioyek # BUG: run as QT_QPA_PLATFORM=xcb sioyek. Mb configuring niri would help?

      # for programs.television
      fd
      ripgrep
      bat

      yq

      btop
      fastfetch # TODO: fastfetch show on shell startup, check fastfetchMinimal
      outfieldr # tldr client
      wget
      stow
      zellij
      xwayland-satellite # for niri
      telegram-desktop
      vesktop
      tela-circle-icon-theme
    ];
    fonts.packages = with pkgs; [
      noto-fonts
    ];
    hardware.bluetooth.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics = {
      enable = true;
      enable32Bit = true; # Steam and 32-bit OpenGL/Vulkan apps
    };

    hardware.nvidia = {
      open = false;

      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      nvidiaSettings = false;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
    };
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
