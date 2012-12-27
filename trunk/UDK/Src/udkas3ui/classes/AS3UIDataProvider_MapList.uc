/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class AS3UIDataProvider_MapList extends UDKUIResourceDataProvider
	config(AS3UI)
	PerObjectConfig;
	
/** Unique ID for maps. */
var config int	  MapId;

/** Actual map name to load */
var config string MapName;

/** String describing how many players the map is good for. */
var config localized string NumPlayers;

/** Localized description of the map */
var config localized string Description;

/** Markup text used to display the preview image for the map. */
var config string PreviewImageMarkup;

defaultproperties
{
	//bSearchAllInis=true
}