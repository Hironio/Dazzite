# --- SEZIONE DAZZITE POST-INSTALL ---

[group('Dazzite')]
setup-dazzite:
    #!/usr/bin/bash
    echo "--- Abilitazione Hardware e Virtualizzazione ---"
    sudo systemctl enable --now cups libvirtd avahi-daemon
    sudo firewall-cmd --permanent --add-service=mdns --add-service=ipp
    sudo firewall-cmd --reload
    
    echo "--- Sincronizzazione Catalogo App ---"
    # Aggiorna solo l'indice, senza aggiungere repo che ci sono già
    flatpak update --appstream
    
    echo "--- Installazione Applicazioni ---"
    # Installiamo a livello di sistema (default su Bazzite)
    flatpak install -y flathub \
        org.libreoffice.LibreOffice \
        org.keepassxc.KeePassXC \
        com.spotify.Client \
        eu.betterbird.Betterbird \
        org.torproject.torbrowser-launcher
    
    echo "--- Localizzazione Italiana ---"
    flatpak config --set languages "it;en"
    flatpak update -y
