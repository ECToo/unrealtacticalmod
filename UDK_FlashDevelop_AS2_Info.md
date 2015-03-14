# Information: #
> I current working on the pages to be update much as possible. I try to get most in HUD design while work on other projects.

Note you need to learn action script 2. They little different from action script 3. They some time used non exist variable to assign variable form root path.

Example:
```

_root.myvar = 0;

_root// it the main path that unreal will see to link object or variables.

```



When coding HUD from FlashDevelop. The code may different a bit.


> From what I gather. The file have to have xml format correct to load into UDK scaleform HUD. Like image and font file. It deal with file convert to symbol that is the library added into the swf. Mean it the flash program the editor is similar to FlashDevelop library add to file.

# Content: #
  * [Actionscript 2 to UDK HUD](UDK_FlashDevelop_AS2_HUD.md)
  * [Basic Text Field](UDK_FlashDevelop_AS2_TextField.md)
  * [Basic Font Loading](UDK_FlashDevelop_AS2_FontLoading.md)
  * [Image Loading](UDK_FlashDevelop_AS2_ImageLoading.md)
  * [Variable Access](UDK_FlashDevelop_AS2_Variable_Access.md)
  * [External Call](UDK_FlashDevelop_AS2_External.md)
  * [fscommand](UDK_FlashDevelop_AS2_fscommand.md)
  * [Array String](UDK_FlashDevelop_AS2_ArrayString.md)



# Area in research: #
  * HUD
  * Actionscript2 (work in progress)
  * Actionscript3 (not yet seen the release yet)
  * Getting the variable from swf to unreal script and kismet.

## Pros: ##
  * Able to load image file.
  * Able to set and get array string from flash and unreal script.
  * Able to Load font.
  * Able to use External call to unreal script and ActionScript2.
  * Able to use fscommand(); from actionscript2 to unreal kismet triggers.

## Cons: ##
  * Flash Player 8 Version.
  * Used Actionscript 2
  * Can't get Sound working. Required more coding in unreal script to make it work.
  * Font error that deal with embed file.
  * You can not fully used scaleform since there are graphic user interface editor. Mean you have to create your own buttons, menus, etc.
  * You can't really use the classes in some area a limited.
  * You have to create a render and clear graphic.

### Notes: ###
  * Takes a while to find right coding and many other things.
  * Hate writing things down in the cons section. Waiting for actionscript3 if supported.

## Bug: ##
  * MovieClip.scrollRect is not working for some reason.



> For more information check the UDN page for scale form.




#### FAQS: ####
  * Q: How come my font is not show up, but show zero or square.
    * A: You need to add to library from FlashDevelop. By right clicking the font and there it will say Library. Next you need to assign a variable. Once the font color is blue go right click again. There you see an option. Uncheck in Advanced > Auto-Genrate ID attach Movie(). Name the variable correctly.

  * How can I get my variables?
    * Only in actionscript2 can get a available in _root.
```
Example: 
_root.myvar1 = 100;
_root.myvar2 = 5;

```_

```
var GFxObject RootMC;
	RootMC = GetVariableObject("_root");
        RootMC.GetFloat("myvar1");
        RootMC.GetFloat("myvar2");
```

  * Q: How come I can't my variables in kismet that return None.
  * A: There are two ways. One for kismset is this.
```
event bool Start(optional bool StartPaused = false){

Advance(0.f);//include this to get your variables.
return StartPaused;
}
```
  * Q: Where my path?
  * A: You path start at `_root`. Since actionscript2 is your `_root` path. To able to get any variables, functions and objects.

Example:

`var myvarable:int = 12;` This doesn't work when your coding only.

`_root.myvarable = 12;` This does work. Since it link to the `_root` path.