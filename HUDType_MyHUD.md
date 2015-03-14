# Game Class #

This will list or show how many classes that is in game that is parent of Navigation class.
```
local UTObjective UTNode;
`log(' COUNT CLASSES  ');
ForEach WorldInfo.AllNavigationPoints(class'UTObjective', UTNode){
        //UTNode.Function();
        //UTNode.Heath;
        `log("Number of class that matches and sub classes");
}
```


Player HUD
```
function DrawLivingHud()
{
	super.DrawLivingHud();
	Canvas.DrawColor = WhiteColor;
	Canvas.SetPos(35,260);
	Canvas.DrawText("Hello World");
}
```


```
simulated function Timer()
{
   Super.Timer();
   //`log('hud timer');//this tick every sec
}
```

# Mutator Class #
  * one yet