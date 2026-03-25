# Configurazione post-installazione specifica per Dazzite
setup-dazzite:
    #!/usr/bin/bash
    echo "--- Inizializzazione Dazzite ---"
    
    echo "Abilitazione servizi hardware..."
    sudo systemctl enable --now cups libvirtd avahi-daemon
    
    echo "Configurazione Firewall per Brother MFC..."
    sudo firewall-cmd --permanent --add-service=mdns --add-service=ipp
    sudo firewall-cmd --reload
    
    echo "Installazione pacchetti Flatpak (Produttività e Utility)..."
    flatpak install -y flathub \
        it.libreoffice.LibreOffice \
        org.keepassxc.KeePassXC \
        com.spotify.Client \
        eu.betterbird.Betterbird \
        org.torproject.torbrowser-launcher
    
    echo "Configurazione completata con successo!"
