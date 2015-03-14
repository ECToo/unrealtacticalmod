# Require: #
  * UDK
  * FlashDevelop
  * Flex SDK
  * Actionscript 2

# Setup: #
> The way to setup image file and able to load into the UDK. Create your actionscript2 project in FlashDevelop program.

# Code: #
> Here the simple file on how to load the image to unreal but you need few things before you can export your file to swf and import to UDK.

Main.as
```
class Main 
{
	var _mc:MovieClip = _root.createEmptyMovieClip("mc", 1);
	
	public static function main(swfRoot:MovieClip):Void 
	{
		// entry point
		var app:Main= new Main();
	}
	
	public function Main() 
	{
		_mc.attachMovie("libaray.imagepng.png","sybmolimage", _mc.getNextHighestDepth());
	}
	
}
```

```
project+
-bin (folder)
-+AS2UDKImage.swf
-libaray (folder)
-+imagepng.png
-src (folder)
-+Main.as
```
> This what I have set up by default. Right click on the file image. Select Add to Library.
Then edit the file to:
```
_mc.attachMovie("[here file id]","sybmolimage", _mc.getNextHighestDepth());
```
> If you don't know your file id. Right click on the image file. Select Insert to Document file. By default. libaray.imagepng.png. Since I create a folder and then the file full name and ext.

Then you press test movie. It should work.

You can change the variable "libaray.imagepng.png" to "imagepng". But the variable has to right naming. The naming the correctly for UDK naming file right way.

Link video:
  * http://adf.ly/DiGo


For more information check the epic form in scale form.
  * http://forums.epicgames.com/forumdisplay.php?f=392