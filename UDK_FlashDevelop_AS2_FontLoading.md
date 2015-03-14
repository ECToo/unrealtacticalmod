# Require: #
  * UDK
  * FlashDevelop
  * Flex SDK
  * Actionscript 2

# Setup: #
> The way it setup to get the UDK read the image file and package to upk file. Create your actionscript2 project in FlashDevelop program.

# Code: #
> Here the simple file on how to load the image to unreal but you need few things before you can export your file to swf and import to UDK.

MainUDKTextFormat.as
```
class MainUDKTextFormat
{   
   var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:MainUDKTextFormat = new MainUDKTextFormat();
		FlashConnect.trace("test");
   }
   
   public function MainUDKTextFormat()
   {       
	  
	   var myformat:TextFormat = new TextFormat();
		myformat.color = 0x0000FF;
		myformat.size =12;
		myformat.align="center";				
		myformat.font = "library.visitor1.ttf";//ID Tag
		  
		var hw:TextField = _mc.createTextField("hw", 0, 0, 0, 100, 40);
		hw.text = "Hello, world!";
		hw.setTextFormat(myformat);
   }
}

```

```
project+
-bin (folder)
-+AS2UDKImage.swf
-libaray (folder)
-+visitor1.ttf
-src (folder)
-+Main.as
```
> This what I have set up by default. Right click on the font file. Select Add to Library. You font id is base on your file path and the backslash is convert into dots.

But for unreal engine.

Video Link:
  * http://adf.ly/DiGI

For more information check the epic form in scale form.
  * http://forums.epicgames.com/forumdisplay.php?f=392

NOTE:
  * **Font loading is not working for FlashDevelop when player custom HUD error**
  * It work in kismet stuff.
  * There are pros and cons in how to setup the code.