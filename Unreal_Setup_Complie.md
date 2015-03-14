# where package to be complie for .uc: #

dir = ~\My Documents\My Games\Unreal Tournament 3\UTGame\Src\

# where the execute .u: #

dir = ~\My Documents\My Games\Unreal Tournament 3\UTGame\Unpublished\CookedPC\Script

# where are the work files start: #

dir = ~\My Documents\My Games\Unreal Tournament 3\UTGame\Unpublished\CookedPC

# clean\_u.bat #
dir = ~\My Documents\My Games\Unreal Tournament 3\UTGame\Unpublished\CookedPC\Script
```
@echo off
del *.u
```


# UTEditor.ini #
dir = ~\My Documents\My Games\Unreal Tournament 3\UTGame\Config
```
...
[ModPackages]
ModPackagesInPath=..\UTGame\Src
ModOutputDir=..\UTGame\Unpublished\CookedPC\Script
ModPackages=nameofpackage
...
```



# make.bat #
dir = C:\Program Files\Unreal Tournament 3\Binaries
```
@echo off
UT3 make -useunpublished
```

# if your making a Mutator add on #
go to "My Documents\My Games\Unreal Tournament 3\UTGame\Config"
your ini **.in -> "packagename".ini**


### FAQS: ###
> Q: How come I can't compile again?
> A: Once you compile your first time and second time. It need to be delete.