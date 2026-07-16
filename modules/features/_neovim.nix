{inputs, ...}: {
  flake.nixosModules.neovim = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nvf.nixosModules.default];
    programs.nvf = {
      enable = true;
      defaultEditor = true;
      settings = {
        vim = {
          keymaps = [
            # Smooth navigation inside wrapped lines
            {
              mode = "n";
              key = "k";
              action = "v:count == 0 ? 'gk' : 'k'";
              noremap = true;
              expr = true;
              silent = true;
            }
            {
              mode = "n";
              key = "j";
              action = "v:count == 0 ? 'gj' : 'j'";
              noremap = true;
              expr = true;
              silent = true;
            }
            # Join lines
            {
              mode = "n";
              key = "J";
              action = "mzJ`z";
            }
            # Clear highlights on search when pressing <Esc> in normal mode
            {
              mode = "n";
              key = "<Esc>";
              action = "<cmd>nohlsearch<CR>";
            }
            {
              mode = ["n" "i" "x"];
              key = "<C-S>";
              action = "<Esc><Cmd>silent! update | redraw<CR>";
              desc = "Save and go to Normal mode";
            }
            # Move line(s) up/down
            {
              mode = "n";
              key = "<C-S-k>";
              action = ":m -2<CR>==";
            }
            {
              mode = "n";
              key = "<C-S-j>";
              action = ":m +1<CR>==";
            }
            {
              mode = "v";
              key = "<C-S-k>";
              action = ":m '<-2<CR>gv=gv";
            }
            {
              mode = "v";
              key = "<C-S-j>";
              action = ":m '>+1<CR>gv=gv";
            }

            # Window navigation
            {
              mode = "n";
              key = "<C-k>";
              action = "<C-W><Up>";
            }
            {
              mode = "n";
              key = "<C-j>";
              action = "<C-W><Down>";
            }
            {
              mode = "n";
              key = "<C-h>";
              action = "<C-W><Left>";
            }
            {
              mode = "n";
              key = "<C-l>";
              action = "<C-W><Right>";
            }
          ];
          formatter.conform-nvim.setupOpts.formatters_by_ft = {
            "_" = ["trim_whitespace"];
          };
          theme = {
            enable = true;
            name = "catppuccin";
            style = "auto";
          };
          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };
          undoFile.enable = true;
          options = {
            # General
            mouse = "a";
            switchbuf = "usetab"; # Use already opened buffers when switching
            undolevels = 10000;
            langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz";

            # UI
            colorcolumn = "+1"; # Draw colored line if vim.o.textwidth is set
            cursorline = true;
            scrolloff = 999;
            sidescrolloff = 5;
            list = true;
            fillchars = {
              eob = " ";
              fold = " ";
              foldopen = "";
              foldsep = " ";
              foldinner = " ";
              foldclose = "";
            };
            listchars = {
              tab = "▏ ";
              trail = "·";
              extends = "»";
              precedes = "«";
              nbsp = "␣";
            };
            ruler = false;
            showmode = false;
            shortmess = "CFOSWaco";
            splitkeep = "screen";
            winborder = "rounded";

            # Folding
            foldlevel = 99;
            foldcolumn = "auto";

            # Editing
            smartindent = true;
            tabstop = 2;
            shiftwidth = 0; # Follows tabstop
            shiftround = true;
            expandtab = true;
            formatoptions = "rqnl1j";
            formatlistpat = "^\s*[0-9\-\+\*]\+[\.\)]*\s\+";
            ignorecase = true;
            smartcase = true;
            incsearch = true;
            spelloptions = "camel";
            virtualedit = "block";
            iskeyword = "@,48-57,_,192-255,-"; # Treat dash as `word` textobject part

            # Built-in completion
            infercase = true;
            complete = ".,w,b,kspell";
            completeopt = "menuone,noselect,fuzzy,nosort";

            # Wrapping
            wrap = false; # Don't visually wrap lines (toggle with \w)
            # BUG: screenline,number cannot be set in nvf
            # cursorlineopt = "screenline,number"; # Show cursor line per screen line
            cursorlineopt = "both";
            breakindent = true; # Indent wrapped lines to match line start
            breakindentopt = "list:-1"; # Add padding for lists (if 'wrap' is set)
            linebreak = true; # Wrap lines at 'breakat' (if 'wrap' is set)
            showbreak = "↪ "; # "|" Visually mark wrapped lines
          };
          diagnostics = {
            enable = true;
            config = {
              severity_sort = true;
              # -- Show signs on top of any other sign, but only for warnings and errors
              signs = {
                priority = 9999;
                severity = {
                  min = "WARN";
                  max = "ERROR";
                };
              };

              # -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
              underline = true;
              virtual_text = {
                current_line = true;
                severity =
                  lib.generators.mkLuaInline
                  #lua
                  ''{ min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR }'';
              };
            };
          };
          filetree.neo-tree.enable = true;
          session.nvim-session-manager.enable = true;
          treesitter = {
            enable = true;
            fold = true;
            grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
          };
          autocomplete.blink-cmp.enable = true;
          binds = {
            whichKey.enable = true;
            # hardtime-nvim.enable = true;
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            inlayHints.enable = true;
            servers.nixd = {
              settings.nixd = {
                nixpkgs = {
                  expr = "import (builtins.getFlake \"/home/andrew/myNixOS\").inputs.nixpkgs { }";
                };
                options = {
                  nixos = {expr = "(builtins.getFlake \"/home/andrew/myNixOS\").nixosConfigurations.myMachine.options";};
                  flake-parts-debug = {expr = "(builtins.getFlake \"/home/andrew/myNixOS\").debug.options";};
                  flake-parts-currentSystem = {expr = "(builtins.getFlake \"/home/andrew/myNixOS\").currentSystem.options";};
                };
              };
            };
            # servers.nil = {};
          };
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            nix = {
              enable = true;
              lsp.servers = [
                "nixd"
                # "nil"
              ];
            };
          };
          statusline.lualine.enable = true;
          ui = {
            nvim-ufo = {
              enable = true;
              setupOpts = {
                provider_selector =
                  lib.generators.mkLuaInline
                  #lua
                  ''function(bufnr, filetype, buftype) return {'treesitter', 'indent'} end'';
              };
            };
            ui2.enable = true;
            breadcrumbs.enable = true;
          };
        };
      };
    };
  };
}
