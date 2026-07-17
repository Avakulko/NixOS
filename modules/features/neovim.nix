{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.neovim = moduleWithSystem ({self', ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = self'.packages.neovim;
    };
  });
  perSystem = {pkgs, ...}: {
    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

      # settings.config_directory = /home/andrew/.dotfiles/nvim/.config/nvim; # or lib.generators.mkLuaInline "vim.fn.stdpath('config')";

      specs.general = with pkgs.vimPlugins; [
        # plugins which are loaded at startup ...
        blink-cmp
        conform-nvim
        fidget-nvim
        flash-nvim
        friendly-snippets
        fzf-lua
        iron-nvim
        luasnip
        mini-ai
        mini-cursorword
        mini-pairs
        mini-pick
        mini-splitjoin
        mini-statusline
        mini-surround
        mini-sessions
        # molten-nvim
        # # nvim
        nvim-lspconfig
        nvim-treesitter
        # nvim-treesitter-context # TODO: needs configuring window color
        nvim-treesitter-textobjects
        nvim-web-devicons
        oil-nvim
        otter-nvim
        plenary-nvim
        quarto-nvim
        render-markdown-nvim
        snacks-nvim
        todo-comments-nvim
        trouble-nvim
        typst-preview-nvim
        which-key-nvim
        # yarepl-nvim
        nvim-treesitter.withAllGrammars
      ];
      specs.lazy = {
        lazy = true;
        data = with pkgs.vimPlugins; [
          # plugins which are not loaded until you vim.cmd.packadd them ...
        ];
      };
      info = {
        values = "for lua";
        which = "will be placed in the generated info plugin for access";
      };
      runtimePkgs = with pkgs; [
        # lsps, formatters, etc...
        wl-clipboard

        nixd
        alejandra

        lua-language-server
        stylua

        vscode-json-languageserver
        prettier
      ];

      # set this to true
      # settings.dont_link = true;
      # and make sure these dont share values:
      # binName = "nnvim";
      # settings.aliases = [];
    };
  };
}
