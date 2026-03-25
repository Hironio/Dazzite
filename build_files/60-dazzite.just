# --- SEZIONE DAZZITE POST-INSTALL ---

[group('Dazzite')]
setup-dazzite:
    #!/usr/bin/bash
    echo "--- Configurazione Dazzite in corso ---"
    # 1. Abilitazione servizi
    sudo systemctl enable --now cups libvirtd avahi-daemon
    # 2. Firewall Brother
    sudo firewall-cmd --permanent --add-service=mdns --add-service=ipp
    sudo firewall-cmd --reload
    # 3. Sincronizzazione Flathub e Installazione
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org
    flatpak update --appstream
    echo "--- Installazione Applicazioni Flatpak ---"
    flatpak install -y flathub \
        org.libreoffice.LibreOffice \
        org.keepassxc.KeePassXC \
        com.spotify.Client \
        eu.betterbird.Betterbird \
        org.torproject.torbrowser-launcher
    # 4. Forzare localizzazione Italiana per LibreOffice
    echo "--- Configurazione Lingua Italiana ---"
    flatpak config --user --set languages "it;en"
    flatpak update -y
