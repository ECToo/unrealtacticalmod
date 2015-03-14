# Information: #
Support:
  * UDK
  * UT3


This is the simple way to get your input working for your vehicle. Note your have to play with the input keys to get the desire effects.

CustomVehicle.uc
```

class CustomWeapon extends UTWeapon;

exec function Reload()
{
   `log('reload action');
}

```

UTInput.ini
```
[Engine.PlayerInput]
;...
Bindings=(Name="R",Command="Reload");I just added the key at the end of the key binds
```