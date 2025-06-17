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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

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
    # SSH is weird
    # pkgs.openssh
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
    pkgs.wl-clipboard
    pkgs.rclone
    pkgs.micromamba
    pkgs.hadolint
    # pkgs.fluxcd
    pkgs.awscli2
    pkgs.rye
    pkgs.jujutsu
    pkgs.lazyjj
    pkgs.terraform
    pkgs.difftastic
    pkgs.openstackclient
    pkgs.skopeo
    pkgs.uv
    # zig does not properly work like this
    # pkgs.zig
    pkgs.krew
    pkgs.mkcert
    pkgs.telepresence2
    # Operator sdk clashes with other versions installed locally per project
    # pkgs.operator-sdk
    pkgs.typescript-language-server
    pkgs.sops
    pkgs.pack
    pkgs.typst
    pkgs.k6
    pkgs.marp-cli
    pkgs.opentofu
    pkgs.terraform-ls
    pkgs.packer
    # (pkgs.vagrant.overrideAttrs (oldAttrs: {
    #   withLibvirt = false;
    # }))
    pkgs.snyk
    pkgs.shellcheck
    pkgs.goreleaser
    pkgs.dive
    pkgs.golangci-lint

    # gs is an existing executable for ghost-script, I want the executable to be called git-spice
    (pkgs.git-spice.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + "\nmv $out/bin/gs $out/bin/git-spice";
    }))

    ## Fonts 
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.victor-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.meld
    pkgs.azure-cli
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
      merge = {
        tool = "meld";
        algorithm = "histogram";
      };
      "mergetool \"meld\"" = {
        cmd = "meld \"$LOCAL\" \"$BASE\" \"$REMOTE\" --output \"$MERGED\"";
      };
      mergetool = {
        prompt=false;
        keepBackup = false;
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
      tlp = "telepresence";
    };
    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    focusEvents = true;
    extraConfig = ''
      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'

      # Window navigation (w/o requiring leader)
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Pane navigation when splitting a single window
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Enable 265 colors
      # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-a-256-colour-terminal
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ",*:RGB"

      # Tmux navigator
      set -g @plugin 'christoomey/vim-tmux-navigator'

      set -g @plugin 'catppuccin/tmux#v2.1.3'
      set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style 'rounded'
      set -g @catppuccin_window_number_position 'right'
      set -g @catppuccin_status_background "#000000"
      set -g @catppuccin_window_status 'no'
      set -g @catppuccin_window_text '#W'
      set -g @catppuccin_window_current_fill 'number'
      set -g @catppuccin_window_current_text '#W'
      set -g @catppuccin_window_current_color '#{E:@thm_surface_2}'
      set -g @catppuccin_status_module_text_bg '#{E:@thm_mantle}'

      # start index at 1
      set -g base-index 1
      set -g pane-base-index 1

      # renumber when window is closed
      set -g renumber-window on

      # Resurrect and coninuum
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '10'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'

      run '~/.config/tmux/plugins/tpm/tpm'

      # Setup status line
      set -g allow-rename off
      set -g status-position top
      set -g status-interval 5
      set -g status-left-length 100
      set -g status-right-length 100
      set -gF status-right "#{@catppuccin_status_directory}"
      set -agF status-right '#{@catppuccin_status_session} '
      set -g status-left ""
    '';
  };

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
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

  # Could not get this to show up in app menu when pressing super in ubuntu
  # xdg.desktopEntries = {
  #   wezterm = {
  #     name="WezTerm";
  #     comment="Wez's Terminal Emulator";
  #     # keywords=["shell" "prompt" "command" "commandline" "cmd"];
  #     icon=./icons/wezterm.png;
  #     # startupWMClass="org.wezfurlong.wezterm";
  #     # tryExec="wezterm";
  #     exec="wezterm start --cwd .";
  #     type="Application";
  #     categories=["System" "TerminalEmulator" "Utility"];
  #     terminal=false;
  #   };
  # };

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
    ".config/ghostty".source = ./ghostty;
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
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/zig"
    "$HOME/.krew/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
