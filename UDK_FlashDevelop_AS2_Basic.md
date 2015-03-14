# Information: #
> To get basic idea on how create your movie clip it quite easy.

```
_root //this your main root or like main parent of your unreal path to make it read.
```

To create a movie clip. Is some thing like this.

```
var _mc:MovieClip  = _root.createEmptyMovieClip("mc", _root.getNextHighestDepth());
```

To understand this line of code. We first create a variable from root. That for unreal able to read our objects.

```
_root.mc//that we create from it.
```

The next part is the Depth that deal with the visible draw. It deal with draw order. Okay next we create a text field.

```

var MC_Refresh_TF:TextField = _mc.createTextField('MC_Refresh_TF', _mc.getNextHighestDepth(), 0, 0, 128, 32);
MC_Refresh_TF._x = 128;
MC_Refresh_TF.text = "Refresh";
MC_Refresh_TF.selectable = false;
MC_Refresh_TF.setTextFormat(myformat);
```

That how you create your text field. How come the name it same but different. First your string id will match the objects name path. It deal with layers.It like GIMP layer to show visible layer order. And the depth in not `_root.getNextHighestDepth` because we are create mc so mc is the current parent of our visible part of the draw.

```
_root.mc.MC_Refresh_TF 
```

String id

```
_mc.createTextField('stringid', _mc.getNextHighestDepth(), 0, 0, 128, 32);

```




I am not good at explaining things. >.<;