/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 *
 * Example to show how to replace the mid game menu
 * ut3 ctf-strident?game=MidGameMenuMod.XCTFGame -log -useunpublished
 */

class DFGame_Content extends DFGame;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	//log("[DFGame] - Initialized and running");
}


defaultproperties
{
        //HUDType=class'UTGame.UTOnslaughtHUD'
        //show game content ingame HUD
	HUDType=class'UTGame.UTCTFHUD'
	//TranslocatorClass=class'UTWeap_Translocator_Content'
	//AnnouncerMessageClass=class'UTCTFMessage'
 	//TeamScoreMessageClass=class'UTGameContent.UTTeamScoreMessage'
	MidGameMenuTemplate=UTUIScene_MidGameMenu'TMod_GameMenuMod.Menus.MidGameMenu'
	//DefaultMapPrefixes(6)=(Prefix="UTCIN",GameType="UTGame.UTCinematicGame")
}
