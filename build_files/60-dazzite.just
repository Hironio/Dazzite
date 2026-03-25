# Configurazione post-installazione Dazzite
setup-dazzite:
    #!/usr/bin/bash
    echo "--- Configurazione Dazzite in corso ---"
    sudo systemctl enable --now cups libvirtd avahi-daemon
    sudo firewall-cmd --permanent --add-service=mdns --add-service=ipp
    sudo firewall-cmd --reload
    flatpak install -y flathub it.libreoffice.LibreOffice org.keepassxc.KeePassXC com.spotify.Client eu.betterbird.Betterbird org.torproject.torbrowser-launcher
