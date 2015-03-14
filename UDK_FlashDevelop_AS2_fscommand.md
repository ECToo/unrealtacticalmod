Work in progress.


# Information: #
> The fscommand("string") in actionscript. It almost the work the same for extremal call. But you can make it work in UDK kismet.


actionscript2.as
```
var button:MovieClip;//create some button...

button.onPress = function() {
   fscommand("fsbutton");
}
```

unreal editor:
```
Open UnrealKismet

It under:
New Event > GFx UI > FsCommand

Next part is make sure the load your movie. It to link your commands.
GFx Event_FSCommand
Moive:swf file location
FSCommand:fsbutton

To make sure it working. Under the Sequence Object.
Object Comment: Button press from as2!
Output Obj Comment To Screen:true

Note it will in the console output. When you press play. Press the '`'. It beside the 1 key. Left top of the keyboard.


```