# Information #
> The basis way to get the input text. Is quite simple. Here the code. Note you need a font to make the HUD work with unreal engine. Else it will give square letter.

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
		var myformat:TextFormat = new TextFormat();
		myformat.color = 0x0000FF;
		myformat.size =12;
		//myformat.align="center";				
		myformat.font = "";//ID Tag
		
		var _mc:MovieClip = _root.createEmptyMovieClip("mc", _root.getNextHighestDepth());
		
		var MCTimeClockTF:TextField = _mc.createTextField("MCTimeClockTF", _mc.getNextHighestDepth(),0,0,128,32);
		MCTimeClockTF.text = "0:0:0";
		MCTimeClockTF.restrict = "A-Z 0-9";
		MCTimeClockTF.type = "input";
		MCTimeClockTF.setTextFormat(myformat);
		
		//mouse cursor
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
			//if (MCTimeClockTF != null) {
				//MCTimeClockTF.setTextFormat(myformat);
			//}
			
			cursor._x = _root._xmouse;
			cursor._y = _root._ymouse;
		}
	}
	
}
```

When dealing with read time you need to update the format. But it depend if is needed to be format.

You need to make sure the `Textfield.type = "input"` like `MCTimeClockTF.type = "input";`. Also you can restrict letters or symbols.