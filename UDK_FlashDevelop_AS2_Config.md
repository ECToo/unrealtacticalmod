# Information: #
> This is work in progress. I haven't work on more detail approach to way to work well in the configure yet.

# Setup: #
  * Right click on your AS2 project.
  * Click on properties.
  * Under Output > Test Movie : Select > Run Custom Command...

  * Select the Build Tab.
  * In the Post-Build Command Line:
```
//OutputDir = is the path the file location save in for swf.
//OutputName = file name for the swf.
Drive:\UDK\UDK-XXXX-XX\Binaries\GFx\FxMediaPlayer $(OutputDir)\$(OutputName)
```

> Once that done it will run in GFx movie player. To change to screen size in the Output Tab. Dimensions.