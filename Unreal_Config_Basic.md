# Support: #
  * UT3
  * UDK

# Introduction #
> For those who are new at this read the lines. You should understand some part of the code. I will put some comments as well to make sure you understand how it works. There are native function that can be use to get the config. Note this is build from scrape. Meaning the code may different on how you build, but the basic area there.

This is the main class. This is use to test if the config is loaded into the map. You just need to place in the map to work it.


This section give you the file config to loaded in the unreal script. Since there are built in native function to help load .ini file.

MechaActor.uc
```
class MechaActor extends Actor
	placeable;
	
var class<MyClass> StorageClass;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	`log("init....MechaActor");
	LoadMyClasses();
}

function LoadMyClasses()
{
	local array<MyClass> MyClasses;
	local array<string> Names;
	local int i,idx;

	GetPerObjectConfigSections(StorageClass, Names);//get the list that matches class'MyClass' and add to the array
	`log("mecha actor");
	`log("config list");
	for (i = 0; i < Names.length; i++){
		`log("Full Name:" $ Names[i]);//name of the class, class type name
		//need to remove the class type to get just the name of it
		idx = InStr(Names[i], " ");
		if (idx != INDEX_NONE){
			Names[i] = left(Names[i], idx);
		}
		`log("Class Name:" $ Names[i]);//name of the class
		MyClasses[MyClasses.length] = new(None, Names[i]) StorageClass;//add the class to the array class
		`log(MyClasses[MyClasses.length - 1].Name);//Name of the Class
		`log(MyClasses[MyClasses.length - 1].var1);//class var
	}
}

defaultproperties
{
	//need to add a display in the editor to see it
	Begin Object Class=SpriteComponent Name=Sprite
		Sprite=Texture2D'EditorResources.S_Trigger'
		HiddenGame=False
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
	End Object
	Components.Add(Sprite)
	StorageClass=class'MyClass'
}
```


MyClass.uc

```
class MyClass extends Object
      PerObjectConfig 
      config(Mecha);//This is your ini config Mecha > UTMecha.ini
 
// config variables and logic
var config string var1;

defaultproperties
{

}
```

UTMecha.ini
```
[ThisIsMyName MyClass]
var1="hello0"

[ThisIsMyName2 MyClass]
var1="hello1"

[ThisIsMyName3 MyClass]
var1="hello2"

[MechHeadTest MechPartObject]
;note this will not show since it doesn't match the class
```


**Work in Progress. Still learning it.**