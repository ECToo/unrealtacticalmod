## Information: ##
> When scripting in both languages make sure the name of the function and the string matches. By using the external calls.

I found the post about.
  * http://utforums.epicgames.com/showthread.php?t=756148
  * http://forums.epicgames.com/showthread.php?t=756460

### Actionscript2 to UDK ###
Here is an example of the external call for actionscript2 to unrealscript.

AS2UDKExternal.as
```
import flash.external.ExternalInterface;
import org.flashdevelop.utils.FlashConnect;
import scripts.*;

class AS2UDKExternal
{   
   public var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:AS2UDKExternal = new AS2UDKExternal();
   }
   
   public function AS2UDKExternal()
   {    
	   
	   var box:MovieClip = _mc.createEmptyMovieClip("box", _mc.getNextHighestDepth());
		
		//create a sqaure object
		box.lineStyle(5, 0xeeeeee, 100, true, "none", "round", "miter", _mc.getNextHighestDepth());
		box.beginFill(0xeeeeee);
		box.moveTo(5, 5);
		box.lineTo(10, 5);
		box.lineTo(10, 10);
		box.lineTo(5, 10);
		box.lineTo(5, 5);
		box.endFill();
		
		box.onRollOver = function() {
			ExternalInterface.call("click_over");
			updateAfterEvent();			
		}
		
		box.onRollOut = function() {
			ExternalInterface.call("click_out");
			updateAfterEvent();			
		}
		
		box.onPress = function() {
			ExternalInterface.call("click_press");
			updateAfterEvent();			
		}
	   
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

...

function click_over(){
  `log("click over");
}

function click_out(){
  `log("click out");
}

function click_press(){
  `log("click press");
}

DefaultProperties
{
//MovieInfo=SwfMovie'pacakge.filename.swf'
bIgnoreMouseInput = false
bDisplayWithHudOff = false
bEnableGammaCorrection = false
bPauseGameWhileActive = false
bCaptureInput = false
}
```

I tested the in kismet that seem to work when linking the HUD package.


### UDK to Actionscript2 ###

unrealscript
```
class ... extends GFxMoviePlayer;
...

function MyUnrealFunction(String tag_name){
   `log("actionscript...");
   ActionScriptVoid("_root.SetInfo");//path of the function that should match actionscript.
}

```

Actionscript 2
```
_root.SetInfo = function (Info_Tag:String ){
   FlashConnect.trace("trigger:" + Info_Tag);
}
```

This will pass the unreal script to actionscript2 function.

MyUnrealFunction("hello world");

Note you need make sure you assign a path to `_root` and create a variable or a function from it. To able to execute a script.

Example:

Actionscript2
```
_root.myfunction = function(){

}

_root.myfunction2 = function(tag_name:String){

}
```


unreal script
```
function MyUnrealFunction(){
   `log("actionscript...");
   ActionScriptVoid("_root.myfunction");
}

function MyUnrealFunction2(String tag_name){
   `log("actionscript...");
   ActionScriptVoid("_root.myfunction2");

}
```