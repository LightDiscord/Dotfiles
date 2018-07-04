{ ... }:

let
  configuration = ''
    # i3status configuration file.
    # see "man i3status" for documentation.

    # It is important that this file is edited as UTF-8.
    # The following line should contain a sharp s:
    # ß
    # If the above line is not correctly displayed, fix your editor first!

    general {
            colors = true
            interval = 5
    }

    # order += "ipv6"
    order += "disk /"
    order += "run_watch DHCP"
    order += "path_exists VPN"
    order += "wireless wlan0"
    order += "ethernet eth0"
    order += "battery 0"
    order += "load"
    order += "tztime local"

    wireless wlan0 {
            format_up = "W: (%quality at %essid) %ip"
            format_down = "W: down"
    }

    ethernet eth0 {
            # if you use %speed, i3status requires root privileges
            format_up = "E: %ip (%speed)"
            format_down = "E: down"
    }

    battery 0 {
            format = "%status %percentage %remaining"
    }

    run_watch DHCP {
            pidfile = "/var/run/dhclient*.pid"
    }

    path_exists VPN {
            path = "/var/run/systemd/units/invocation:openvpn-ProtonVPN.service"
    }

    tztime local {
            format = "%Y-%m-%d %H:%M:%S"
    }

    load {
            format = "%1min"
    }

    disk "/" {
            format = "%avail"
    }
  '';
in {
  home.file.".config/i3status/config".text = configuration;
}
