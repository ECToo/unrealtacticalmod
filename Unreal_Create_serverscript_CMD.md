Is there a way to control my dedicated server when I am connected to it as a player?
- Yes. In order to do this you must have specified an Admin password in the command line that loads the dedicated server.
```
To use, open a console (F10 or TAB) while in-game and use the following commands:

* AdminLogin <password> - logs you in as an admin
* AdminLogout <password> - logs you out of admin mode
* AdminRestartMap - restarts the current map
* AdminChangeMap <MapName> - loads a different map (gametype will change too, depending on map)
* Admin addbots <#> - adds # bots
* Admin killbots - removes all bots
* AdminPlayerList - shows PlayerID of players
* Adminkick <playername> - kicks player from current game
* Adminkickban <playername> - kicks player from current game and bans player from reconnecting (bans are stored in .ini file for later editing)
* AdminForceVoiceMute <playername> - blocks a player from sending voip to others
* AdminForceVoiceUnMute <playername> - allows a player to resume sending voip to others
* AdminForceTextMute <playername> - blocks a player from sending text to others
* AdminForceTextUnMute <playername> - allows a player to resume sending text to others
* AdminPublishMapList - overrides the server's map list for the current game type with the one on the client that used the command
* Admin DemoRec <name> - begin recording server-side demo of current map (demos are stored in \UTGame\Demos\)
```

Quick Easy Setup From Scripts:
```
http://www.kitah.org/ut3/ut3clgen.php
http://www.m3nt0r.de/ut3/startupgen.html
http://darkweb.nl/tools/ut3cmd/
http://commandgen.mfdclan.com/
```

http://udn.epicgames.com/Three/UT3Servers.html


http://utforums.epicgames.com/showthread.php?t=578745

http://utforums.epicgames.com/showthread.php?t=586810 This is from FAQS