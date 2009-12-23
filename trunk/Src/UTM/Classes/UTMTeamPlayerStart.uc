class UTMTeamPlayerStart extends UTTeamPlayerStart;


defaultproperties
{
     /*
     Begin Object NAME=Sprite
		HiddenGame=false
     End Object
     */
     Begin Object Class=SpriteComponent Name=SpriteTeam
		Sprite=Texture2D'UTMEditor.pawntool'
		HiddenGame=False
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
	End Object
	
	Components.Add(SpriteTeam)
 bHidden=FALSE
 bStatic=false
 bNoDelete=false
}