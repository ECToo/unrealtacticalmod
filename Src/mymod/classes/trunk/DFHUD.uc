/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class DFHUD extends UTUIScene_Hud;

simulated function PostBeginPlay()
{
//	GetPowerCores();

	Super.PostBeginPlay();
	SetTimer(1.0, True);
}

defaultproperties
{
	//bShowDirectional=true
	//bShowFragCount=false
	//ScoreboardSceneTemplate=Scoreboard_CTF'UI_Scenes_Scoreboards.sbCTF'
        //ScoreboardSceneTemplate=UTUIScene_TeamScoreboard'UI_Scenes_Scoreboards.sbTeamDM'
	//MapPosition=(X=0.99,Y=0.01)
}