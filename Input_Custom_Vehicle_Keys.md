# Information: #
Support:
  * UDK
  * UT3

This is the simple way to get your input working for your vehicle. Note your have to play with the input keys to get the desire effects.

CustomVehicle.uc
```

class CustomVehicle extends UTVehicle;

exec function testkey()
{
   `log('test key bind from vehicle');
}

```

UTInput.ini
```
[Engine.PlayerInput]
;...
Bindings=(Name="X",Command="testkey");I just added the key at the end of the key binds
```