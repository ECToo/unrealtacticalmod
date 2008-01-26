/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 *
 * Example to show how to replace the mid game menu
 */

class CustomGamePanel extends UTTabPage;

event bool ActivatePage( int PlayerIndex, bool bActivate, optional bool bTakeFocus=true )
{
	`log("[CustomGamePanel] - Our Page is Active");
	return Super.ActivatePage(PlayerIndex, bActivate, bTakeFocus);
}
