#### **GER**:
## 111
**15.0.1 wird unterstützt**

* [**Aktualisiert**] SwitchBros_BasisPaket besteht jetzt aus:
    * Basis Paket
    * Daten Paket
    * ThemeApps Paket
    * LAN-Play Paket
* [**Aktualisiert**] BasisApps.txt (Root der SD-Karte) - Alle enthaltenen Apps und System-Module stehen mit ihrer Versionsnummer dort drin.
* [**Aktualisiert**] Batch Datei um SD-Karte automatisch einzurichten (sind statt einer jetzt zwei Dateien).
    * SwitchBros_NERD-O-MAT.bat:
      * Sehr umfangreich. Alles kann über das Hauptmenü eingestellt, individuell und zudem einzeln, installiert werden.
    * SwitchBros_NOOB-O-MAT.bat:
      * Geeignet für blutige Anfänger = SD-Karte in den PC stecken, bat Datei starten und zwei Fragen beantworten und sobald die batch sich geschlossen hat, SD-Karte wieder in die Switch und hekate starten.
* [**Aktualisiert**] [Atmosphere 1.4.1 + hbmenu 3.5.1 + hbl 2.4.3 ](https://github.com/Switch-Bros/SwitchBros-O-sphere)
    * Unterstützung für die Umleitung von Speicherständen ins emuNAND auf der SD-Karte hinhinzugefügt. Es kann aktiviert werden wenn folgende Zeile auskommentiert wird 'fsmitm_redirect_saves_to_sd'. Die Speicherstände werden dann automatisch in den 'atmosphere/saves' Ordner umgeleitet. Das erhöht die Möglichkeit diese beim verlassen des emuNAND's zu speichern. Die Option ist experimentell und zur Zeit deaktiviert.
    * Cheat-Schalter Einstellungen nach Neustart speichern (Cheats sind standardmäßig ebenfalls deaktiviert)
    * Änderungen in der Lüfterkontrolle, taken from 4IFIR
    * Telemetrie deaktiviert, was theoretisch den Schlaf-Modus optimieren sollte, taken from 4IFIR
    * [**Mehr Details zu den Änderungen in Atmosphere**](https://github.com/Atmosphere-NX/Atmosphere/releases)
* [**Aktualisiert**] [hekate 6.0.1 + Nyx 1.5.1](https://github.com/CTCaer/hekate) - L4T für Mariko Unterstützung
* [**Aktualisiert**] [DBI 480](https://github.com/rashevskyv/dbi/releases) - Bugs- und Rechtschreibfehler behoben, BMP Unterstützung, Größe externer USB Laufwerke anzeigen
* [**Aktualisiert**] [tinfoil](https://tinfoil.io/Download#download) - Standard Konfigurationen entfernt: Beim aktualisieren vom SwitchBros_BasisPaket, gehen die Einstellungen nicht verloren.
----