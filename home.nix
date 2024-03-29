{ config, pkgs, ... }:

{
	home.username = "mark";
	home.homeDirectory = "/home/mark";

	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.

	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = [
		# # Adds the 'hello' command to your environment. It prints a friendly
		# # "Hello, world!" when run.
		# pkgs.hello

		# # It is sometimes useful to fine-tune packages, for example, by applying
		# # overrides. You can do that directly here, just don't forget the
		# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
		# # fonts?
		# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

		# # You can also create simple shell scripts directly inside your
		# # configuration. For example, this adds a command 'my-hello' to your
		# # environment:
		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
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

	home.sessionVariables = {
		EDITOR = "hx";
	};

	programs.home-manager.enable = true;
	programs.git.enable = true;
	programs.helix.enable = true;

	programs = {
		nushell = {
			enable = true;
			configFile.source = ./config.nu;
		};
		lf = {
			enable = true;
			commands = {
				editor-open = ''$$EDITOR $f'';
				mkdir = ''
					''${{
						printf "Directory Name: "
						read DIR
						mkdir $DIR
					}}
					'';
			};
			keybindings = {
				c = "mkdir";
				ee = "editor-open";
			};
		};
		vscode = {
			enable = true;
			extensions = [
				pkgs.vscode-extensions.bbenoist.nix
				pkgs.vscode-extensions.thenuprojectcontributors.vscode-nushell-lang
			];
		};
	};

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};
}
