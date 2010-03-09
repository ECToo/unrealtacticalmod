class MechaActor extends Actor
	placeable;
	
var class<MyClass> StorageClass;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	//`log("init....MechaActor");
	LoadMyClasses();
}

function LoadMyClasses()
{
	local array<MyClass> MyClasses;
	local array<string> Names;
	local int i,idx;

	GetPerObjectConfigSections(StorageClass, Names);//get the list that matches class'MyClass' and add to the array
	//`log("mecha actor");
	//`log("config list");
	for (i = 0; i < Names.length; i++){
		//`log("Full Name:" $ Names[i]);//name of the class, class type name
		//need to remove the class type to get just the name of it
		idx = InStr(Names[i], " ");
		if (idx != INDEX_NONE){
			Names[i] = left(Names[i], idx);
		}
		//`log("Class Name:" $ Names[i]);//name of the class
		MyClasses[MyClasses.length] = new(None, Names[i]) StorageClass;//add the class to the array class
		//`log(MyClasses[MyClasses.length - 1].Name);//Name of the Class
		//`log(MyClasses[MyClasses.length - 1].var1);//class var
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