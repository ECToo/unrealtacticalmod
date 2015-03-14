# Information: #
> This is work in progress testing out how the flash files will response. This section deal with text change and update script.


Main.as
```
import org.flashdevelop.utils.FlashConnect;
class Main
{   
   public var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
   
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:Main = new Main();
		//FlashConnect.trace("test");
   }
   
   public function Main()
   {       
	   var text:String;
	  var myformat:TextFormat = new TextFormat();
		myformat.color = 0x0000FF;
		myformat.size =12;
		myformat.align="center";				
		myformat.font = "visitor1";//ID Tag
	   
		var healthtx:TextField = _mc.createTextField("healthtx", 0, 0, 0, 100, 40);
		healthtx.text = "health";
		healthtx.setTextFormat(myformat);
		
		_root.onEnterFrame = function() { 
			//this will require udk update
			//to update the format text
			//if new text update the format
			if (text != healthtx.text ) {
				text = healthtx.text;
				healthtx.setTextFormat(myformat);//update format text if text has change.
			}
			//FlashConnect.trace("updateing...");
		}
		
   }
}
```

Required to add library font in swf file. This will update the font format. Note the UDK give error in font loading.

CustomFxHUD.us
```
class CustomFxHUD extends GFxMoviePlayer;

...

function Init(optional LocalPlayer LocPlay) {

	//Start and load the SWF Movie
	Start();
	Advance(0.f);

	//Set the cahce value so that it will get updated on the first Tick
	LastHealthpc = -1337;

	//Load the references with pointers to the movieClips and text fields in the .swf
	HealthTF = GetVariableObject("_root.mc.healthtx");//Get variable
	HealthTF.SetText("LOCATION");//textfield.text
}

```