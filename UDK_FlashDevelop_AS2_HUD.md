# Support: #
  * ActionScript 2

# Information: #
> When working with actionscript2 that is current working for UDK. I be using the FlashDevelop. It will be quite hard, since I work with Action Script 3. That I will try to get it working. UDK can read swf file.

But the file of the swf and other files like images need to be in the correct location to be able to load into UDK. It will be convert into unreal packages.

Here one of the simple example for writing main file and loaded into the game.

Main.as
```
class Main
{   
   // create a global MovieClip
   var _mc = _root.createEmptyMovieClip("mc", 1);
   
   public static function main(swfRoot:MovieClip):Void
   {
		var app:Main = new Main();
   }
   
   public function Main()
   {       
		// entry point
		_mc.createTextField("hw", 0, 0, 0, 100, 40);
		_mc.hw.text = "Hello, world!";
   }
}
```
Note the font can't be read. It read as digit zero.

Note I just started it. It a work in progress.

For more information:
Links:
  * http://forums.epicgames.com/showthread.php?p=27276051