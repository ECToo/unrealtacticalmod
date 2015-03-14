# Information: #
> There are two type of time. One is the game time and other is the World time. Game time is straight forward. If you needed the time of the game time.

AS2UDKTimeGFxHUD.uc
```
class AS2UDKTimeGFxHUD extends GFxMoviePlayer;

var UTGameReplicationInfo GRI;


//flash External call to this function
function click_over(){
  local PlayerController PC;
  //`log("click over");
  PC = GetPC();
  GRI = UTGameReplicationInfo(PC.WorldInfo.GRI);
  if ( GRI != None )
	{
	  `log("Remaining Time:" $ GRI.RemainingTime);

	}
}

```

Another one is the flash time. Real time clock. It an 24 hour clock.

main.as
```
import org.flashdevelop.utils.FlashConnect;
import flash.events.*;

class Main 
{
   public static function main(swfRoot:MovieClip):Void
   {
	   // entry point
		var app:Main = new Main();
   }
   
	public function Main() 
	{
		var _mc:MovieClip = _root.createEmptyMovieClip("mc", _root.getNextHighestDepth());
		
		var MCTimeClockTF:TextField = _mc.createTextField("MCTimeClockTF", _mc.getNextHighestDepth(),0,0,128,32);
		MCTimeClockTF.text = "0:0:0";
		
		
		var MCUDKTimeClockTF:TextField = _mc.createTextField("MCUDKTimeClockTF", _mc.getNextHighestDepth(),0,32,128,32);
		MCUDKTimeClockTF.text = "0:0:0";
		
		
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
			
			if (MCTimeClockTF != null) {
				var time:Date = new Date();
				
				MCTimeClockTF.text = time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds();
			}
			
			cursor._x = _root._xmouse;
			cursor._y = _root._ymouse;
		}
	}
	
}
```
Note it doesn't update variable for date class. It needed new variable to get the right time.


Note this is work in progress. Not yet how deal with this type of coding yet. I update once I learn more about it.