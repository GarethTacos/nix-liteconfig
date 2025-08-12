# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # for encryptions
  #boot.initrd.luks.devices."luks-524c03e3-a7a5-4e67-b29e-7efcdfcd452b".device = "/dev/disk/by-uuid/524c03e3-a7a5-4e67-b29e-7efcdfcd452b";
  networking.hostName = "holopockylab"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #overlay opts
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.holopocket = {
    isNormalUser = true;
    description = "holopocket";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.fish;
  };
  # for boobaDS
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  android-file-transfer
  furnace
  fortune
  #easyeffects - > no work
  jamesdsp
  # leave the android-tools here incase phon broken again and remove comment if u need
  android-tools 
  element-desktop
  cage
  librewolf
  git
  ncdu
  fzf
  mpv
  # games
  #superTuxKart
  #superTux
  #xonotic
  #wesnoth
  # binbows (still shit)
  # utube
  freetube
  # windows shit aint gonna run so yeah...
  transmission_4-qt
  #taisei
  wasistlos
  p7zip-rar
  fastfetch
  librewolf
  teams-for-linux
  gammastep
  libreoffice-fresh
  zip
  unzip
  ntfs3g
  pavucontrol
  brightnessctl
  wofi
  btop
  neovim
  grim
  slurp
  wl-clipboard
  mako
  kitty
  clipman
  #asciiquarium (rarely use so commented this)
  peaclock
  #steam # for infinite toes 2
  swayfx
  ungoogled-chromium
  # notes
  direnv
  joplin-desktop
  graalvmPackages.graalvm-ce
  yt-dlp
  speedcrunch
  # to test windows targeted CLI programs
  wineWowPackages.full
  audacity
  ];
  programs.fish.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.fail2ban.enable = true;
  #services.openssh = {
  #  enable = true;
  #  ports = [ 15433 ];
  #  settings = {
  #    PasswordAuthentication = true;
  #    KbdInteractiveAuthentication = false;
  #    PermitRootLogin = "no";
  #    AllowUsers = [ "holopocket" ];
  #  };
  #};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  # human error zone:
  # lanya
  # laggotron ultra services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  }; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # nix store storage optimisations:
  nix.settings.auto-optimise-store = true;
  nix.gc = {
   automatic = true;
   dates = "daily";
   options = "--delete-older-than 1d";
  };
  # save power and prevent PLD from toastering
  services.thermald.enable = true;
  services.auto-cpufreq  = {
   enable = true;
   settings = {
    battery = {
     governor = "powersave";
     turbo = "never";
    };
    charger = {
     governor = "performance";
     turbo = "auto";
    };
   };
  };
  # frosted flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # sway the shitden
   programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
   };
   #rt because yes
   security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 99; }
   ];
   # andwoid :D (disabled because no need currently)
   # and also root detection is screwing me up
   # stupid thing says i have magisk uds but i didnt install magisk???
   virtualisation.waydroid.enable = true;
# metal pipe audio
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  jack.enable = true;
};
# dont do lanya yet because save power but can make custom script to enable lanya
# nevermind gonna do lanya because yes
# nerd ahh fonts
fonts.packages = with pkgs; [
  nerd-fonts.mononoki
  mononoki
  noto-fonts-cjk-sans
  aegyptus
];
boot.kernel.sysctl = {
    "vm.swappiness" = 1; # when swapping to ssd, otherwise change to 1
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_background_ratio" = 20;
    "vm.dirty_ratio" = 50;
    # these are the zen-kernel tweaks to CFS defaults (mostly)
    "kernel.sched_latency_ns" = 4000000;
    # should be one-eighth of sched_latency (this ratio is not
    # configurable, apparently -- so while zen changes that to
    # one-tenth, we cannot):
    "kernel.sched_min_granularity_ns" = 500000;
    "kernel.sched_wakeup_granularity_ns" = 50000;
    "kernel.sched_migration_cost_ns" = 250000;
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "kernel.sched_nr_migrate" = 128;
  }; 
  # Let users put things in appropriately-weighted scopes
  systemd = {
    extraConfig = ''
      DefaultCPUAccounting=yes
      DefaultMemoryAccounting=yes
      DefaultIOAccounting=yes
    '';
    user.extraConfig = ''
      DefaultCPUAccounting=yes
      DefaultMemoryAccounting=yes
      DefaultIOAccounting=yes
    '';
    services."user@".serviceConfig.Delegate = true;
  };
  systemd.services.nix-daemon.serviceConfig = {
    CPUWeight = 20;
    IOWeight = 20;
  };
  # change krnl
  boot.kernelPackages = pkgs.linuxPackages_zen; 
  # change stuff
  # Pass F2FS GC options on initial mount via the kernel cmdline because no work on remount
  # only on first boot
  boot.kernelParams = [
    "elevator=kyber"
    "rootflags=atgc,gc_merge"
    # only when want to game 
    #"isolcpus=1,3"
   # Tell kernel to use cgroups_v2 exclusively
   "cgroup_no_v1=all"
   "systemd.unified_cgroup_hierarchy=yes"
   ];
   #xdg potal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # allow kun (disabled because swap no like me)
#  systemd.sleep.extraConfig = ''
#  AllowSuspend=yes
#  AllowHibernation=yes
#  AllowHybridSleep=no
#  AllowSuspendThenHibernate=no
#'';
hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  }; 
# mikrokod
hardware.cpu.intel.updateMicrocode = true;
# usb mount
services.udisks2.enable = true;
# stem
#programs.steam = {
#  enable = true;
#  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
#};
#swapfile because easier (also disabled because swap no like me)
# swapDevices = [ {
#    device = "/var/lib/swapfile";
#    size = 8*1024;
#  } ];
# boot
# Add kernel modules to be loaded at boot
boot.kernelModules = [
  "crc32"
  "f2fs"
  "zstd_compress"
  "kvm-intel"
];
# Define root filesystem with f2fs and compression options
fileSystems."/" = {
  device = "/dev/disk/by-uuid/dd19aa4e-c3d3-4e36-96ca-d15fad53d9bf";
  fsType = "f2fs";
  options = [
    "compress_algorithm=zstd:22"
    "compress_chksum"
    "compress_mode=fs"
  ];
};
# chinse
   i18n.inputMethod = {
     type = "fcitx5";
     enable = true;
     fcitx5.addons = with pkgs; [
       fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
       fcitx5-chinese-addons  # table input method support
       fcitx5-mozc # japanese stuff
     ];
     };
}
