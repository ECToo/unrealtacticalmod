Information: There are three way to building the UIScene. One you can create UIScene with pure kismet. Kismet has many lesson about make them work by doing some search engine. Two Create unreal script and design the layout in UIScene. Three Use Kismet and unreal script to make them work together.

```
class CustomSceneMenu extends UTUIScene;
```

This will look for all class that is current in the map that matches it. This will find your class that is extend from Navigation class.
```
    local UTMBuildingNode UTMNode;//
    local WorldInfo WI;
    WI = GetWorldInfo();
    
    ForEach WI.AllNavigationPoints(class'UTMBuildingNode', UTMNode)//find matching class
    {
            if(UTMNode.Name ==  buildingnodename){//if the building matches the name do this
                            //UTMNode.function();
            }
    }
```