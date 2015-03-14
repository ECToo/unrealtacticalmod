## Information: ##
> The way to create an variable is quite simple. Manage to get it working and digging around the some posts for how flash variable are access. Since ActionScript 2, that you can get any with it. On how variable are used. To define a var to number or string. Work in progress.

```
class Main
{   
   // create a global MovieClip
   var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:Main = new Main();
   }
   
   public function Main()
   {       
                
		// entry point
		_root.MyFlashN = 100;//create a variable
   }
}
```

CustomGFxHUD.uc
```

class CustomGFxHUD extends GFxMoviePlayer;
...
var float myNumber;
var GFxObject RootMC;
...

function Init(optional LocalPlayer LocPlay) {

//Start and load the SWF Movie
	Start();
	Advance(0.f);//this init or get variable from movie clip
       	RootMC = GetVariableObject("_root");
       	
	`log("######################### ");
	`log("#############" @ RootMC.GetFloat("MyFlashN"));
        myNumber = RootMC.GetFloat("MyFlashN");
...

}
```

To get it run in kismet is this line of code.
```
event bool Start(optional bool StartPaused = false){
      super.Start(StartPaused);
      Advance(0.f);//make sure you add this to init variable when it start looking for your variables.
      RootMC = GetVariableObject("_root");
      if(RootMC == None){
       `log("None Root");
      }else{
        `log("Root found");
      }
    `log("_root  ############## SET");
     myNumber = RootMC.GetFloat("MyFlashN");
     `log("##### MyNumber: "@myNumber);
   return StartPaused;
}
```





The code is partly for Player HUD( Head Up Display).

Note it not fully coded. I still working how to get some code working.