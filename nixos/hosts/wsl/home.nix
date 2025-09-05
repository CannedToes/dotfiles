{
  pkgs,
  username,
  nix-index-database,
  nixvim,
  ...
}: let
  unstable-packages = with pkgs.unstable ; [
    # tools
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    fx
    git
    git-crypt
    htop
    btop
    jq
    killall
    mosh
    procs
    ripgrep
    sd
    tmux
    tree
    unzip
    vim
    wget
    zip
  ];
  stable-packages = with pkgs; [
    # key tools
    gh
    just

    # core languages
    rustup
    gcc
    go
    zig

    # rust stuff
    cargo-cache
    cargo-expand

    # treesitter
    tree-sitter

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix

    # fun stuff
    sl
    lolcat
    cowsay
    wezterm
  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
    nixvim.homeModules.nixvim
  ];

  home.stateVersion = "25.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";
  };

  home.packages = 
    stable-packages
    ++ unstable-packages
    ++ [
	
    ];

  programs = {
    home-manager.enable = true;
    nix-index = {
	enable = true;
	enableFishIntegration = true;
    };
    nix-index-database.comma.enable = true;

    nixvim = {
	enable = true;

	colorschemes.gruvbox.enable = true;
	plugins = {
		# cosmetic
		transparent.enable = true;
		lualine.enable = true;
		smear-cursor.enable = true;
		neoscroll.enable = true;

		# language specific
		rustaceanvim.enable = true;
		crates.enable = true;
		
		# lsp/dap
		lsp = {
		    enable = true;
		    servers = {
		    	nil_ls.enable = true;
			lua_ls.enable = true;
		    };
		};
		dap.enable = true;
		dap-ui.enable = true;

		# niceties
		wezterm.enable = true;
		vim-suda.enable = true;
		cmp = {
		    enable = true;
		    autoEnableSources = true;
		};
		treesitter = {
		    enable = true;
		    settings = {
		    	highlight.enable = true;
		     };
		};
	};
    };
    starship = {
    	enable = true;
	enableFishIntegration = true;
	enableTransience = true;
	settings = {
	    aws.disabled = true;
	    gcloud.disabled = true;
	    kubernetes.disabled = false;
	};
    };
    fzf = {
    	enable = true;
	enableFishIntegration = true;
    };
    zoxide = {
    	enable = true;
	enableFishIntegration = true;
	options = ["--cmd cd"];
    };
    eza = {
    	enable = true;
	icons = "auto";
	enableFishIntegration = true;
	extraOptions = [
	    "-l"
	    "--no-permissions"
	];
    };
    broot = {
    	enable = true;
	enableFishIntegration = true;
    };
    direnv = {
    	enable = true;
	nix-direnv.enable = true;
    };

    git = {
      enable = true;
      package = pkgs.unstable.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "mylesglanville@gmail.com";
      userName = "CannedToes";
      extraConfig = {
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_add_path --append /mnt/c/Users/Myles/scoop/apps/win32yank/0.1.1
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

        set -U fish_greeting
      '';
      functions = {
        refresh = "source $HOME/.config/fish/config.fish";
        take = ''mkdir -p -- "$1" && cd -- "$1"'';
        ttake = "cd $(mktemp -d)";
        show_path = "echo $PATH | tr ' ' '\n'";
        posix-source = ''
          for i in (cat $argv)
            set arr (echo $i |tr = \n)
            set -gx $arr[1] $arr[2]
          end
        '';
      };
      shellAbbrs =
        {
          gc = "nix-collect-garbage --delete-old";
	  rbld = "sudo nixos-rebuild switch --flake ~/Config";
        }
        # navigation shortcuts
        // {
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
        }
        # git shortcuts
        // {
          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";
          gsp = "git stash push -m";
          gsa = "git stash apply stash^{/";
          gsl = "git stash list";
        };
      shellAliases = {
        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
        explorer = "/mnt/c/Windows/explorer.exe";
      };
      plugins = [
        {
          inherit (pkgs.fishPlugins.autopair) src;
          name = "autopair";
        }
        {
          inherit (pkgs.fishPlugins.done) src;
          name = "done";
        }
        {
          inherit (pkgs.fishPlugins.sponge) src;
          name = "sponge";
        }
	{
	  inherit (pkgs.fishPlugins.gruvbox) src;
	  name = "gruvbox";
	}
      ];
    };
  };
}
