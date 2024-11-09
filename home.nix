{ inputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tolevski";
  home.homeDirectory = "/home/tolevski";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Example of how you can add an overlay
  # NOTE: This is not needed because the same effect can be achieved by what I did below
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     git-spice = prev.git-spice.overrideAttrs (oldAttrs: {
  #       postInstall = lib.optionalString (pkgs.stdenv.buildPlatform.canExecute pkgs.stdenv.hostPlatform) ''
  #         mv $out/bin/gs $out/bin/git-spice
  #         installShellCompletion --cmd git-spice \
  #           --bash <($out/bin/git-spice shell completion bash) \
  #           --zsh <($out/bin/git-spice shell completion zsh) \
  #           --fish <($out/bin/git-spice shell completion fish)
  #       '';
  #     });
  #   })
  # ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fzf
    pkgs.zip
    pkgs.unzip
    pkgs.kubectl
    pkgs.jq
    pkgs.yq-go
    pkgs.tree
    pkgs.nix-output-monitor
    pkgs.htop
    pkgs.lsof
    pkgs.openssh
    pkgs.gnumake
    pkgs.ripgrep
    pkgs.nodejs_22
    pkgs.go
    pkgs.rustup
    pkgs.lua54Packages.luarocks
    pkgs.fd
    pkgs.kind
    pkgs.kubectx
    pkgs.devcontainer
    pkgs.lazydocker
    pkgs.lua5_1
    pkgs.tree-sitter
    pkgs.pipx
    pkgs.kubernetes-helm
    pkgs.eza

    # gs is an existing executable for ghost-script, I want the executable to be called git-spice
    (pkgs.git-spice.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + "\nmv $out/bin/gs $out/bin/git-spice";
    }))

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    (pkgs.nerdfonts.override { fonts = [ "VictorMono" "JetBrainsMono" ]; })

    # inputs.self.packages.x86_64-linux.poetry-polylith-plugin
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git = {
    enable = true;
    userName = "Tasko Olevski";
    userEmail = "olevski90@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      rerere = {
        enabled = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      append = true;
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = ["$terminfo[kcud1]"];
      searchUpKey = ["$terminfo[kcuu1]"];
    };
    shellAliases = {
      # Default aliases in Ubuntu
      egrep="egrep --color=auto";
      fgrep="fgrep --color=auto";
      grep="grep --color=auto";
      l="ls -CF";
      la="ls -A";
      ll="ls -alF";
      ls="ls --color=auto";
      # I dont want to type kubectl all the time
      k = "kubectl";
      dcb = "devcontainer build --workspace-folder $(git rev-parse --show-toplevel)";
      dcu = "devcontainer up --workspace-folder $(git rev-parse --show-toplevel)";
      dce = "devcontainer exec --workspace-folder $(git rev-parse --show-toplevel)";
      gspc = "git-spice";
    };
    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    sensibleOnTop = true;
    mouse = true;
    extraConfig = ''
      # put the status bar on top
      set-option -g status-position top
      # window navigation (w/o requiring leader)
      bind -n S-Left previous-window
      bind -n S-Right next-window
      # pane navigation when splitting a single window
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          # Enable 265 colors
          # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-a-256-colour-terminal
          set -g default-terminal "tmux-256color"
          set -as terminal-overrides ",*:RGB"
          # Catpuccin Config 3
          set -g @catppuccin_status_background "#000000"
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_status_modules_right "directory session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
      { plugin = tmuxPlugins.vim-tmux-navigator; }
    ];
  };

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.poetry = {
    enable = true;
    # package =  pkgs.poetry.withPlugins(ps: with ps; [ (pkgs.callPackage ./poetry-plugins/poetry-polylith-plugin.nix { }) ]);
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  programs.k9s = {
    enable = true;
    skins = {
      catppuccin-mocha = ./k9s/catppuccin-mocha.yaml;
    };
    settings = {
      k9s = {
        ui = {
          skin = "catppuccin-mocha";
        };
      };
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      pane_frames = false;
    };
  };

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/nvim/lua".source = ./nvim/lua;
    ".config/nvim/after".source = ./nvim/after;
    ".config/starship.toml".source = ./starship/starship.toml;
    ".config/kitty".source = ./kitty;
    ".config/wezterm".source = ./wezterm;
    ".config/lazygit".source = ./lazygit;
    ".config/lazydocker".source = ./lazydocker;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tolevski/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
