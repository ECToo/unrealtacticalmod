# Information: #
> Array string is quite simple to do. Note some functions need to work from GFxMoviePlayer class to able to get and set a variable from actionscript2 flash.


```
class AS2UDKArray
{   
   public var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:AS2UDKArray = new AS2UDKArray();

   }
   
   public function AS2UDKArray()
   {    
	   _root.flasharray = new Array();//assign array to the root to able to find in the path.
           _root.flasharray.push("hello world flash");
	   
		var cursor:MovieClip = _mc.createEmptyMovieClip("cursor", _mc.getNextHighestDepth());
		//create a sqaure object
		cursor.lineStyle(5, 0xff00ff, 100, true, "none", "round", "miter", _mc.getNextHighestDepth());
		cursor.beginFill(0xFF0000);
		cursor.moveTo(5, 5);
		cursor.lineTo(10, 5);
		cursor.lineTo(10, 10);
		cursor.lineTo(5, 10);
		cursor.lineTo(5, 5);
		cursor.endFill();
		
		_root.onEnterFrame = function() { 
			cursor._x = _root._xmouse;
			cursor._y = _root._ymouse;
		}
		
   }
}
```


CustomGFxHUD.uc
```
class CustomGFxHUD extends GFxMoviePlayer;

var GFxObject RootMC;
var GFxObject MC;

//...

event bool Start(optional bool StartPaused = false){
   super.Start(StartPaused);
   Advance(0.f);//make sure you addd this to init
   RootMC = GetVariableObject("_root");
   getarrayfromas2();

   return StartPaused;
}

function getarrayfromas2(){
  local int index;
  local array<string> unrealArray;
  //path is get from root with the variable for array string
  getVariableStringArray( "_root.flasharray", 0, unrealArray );
   for (index = 0; index < unrealArray.Length; ++index){
     `log("array string:" $ unrealArray[index]);
   }
}

function setarrayfromas2(){
  local int index;
  local array<string> unrealArray;
   for (index = 0; index < unrealArray.Length; ++index){
     `log("array string:" $ unrealArray[index]);
   }
  //path is set to root with the variable for array string
  SetVariableStringArray( "_root.flasharray", 0, unrealArray );
}
```


Post found here:
  * http://forums.epicgames.com/showthread.php?t=754717