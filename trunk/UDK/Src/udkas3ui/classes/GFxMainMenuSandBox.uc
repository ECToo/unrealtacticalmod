/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 * This is just a test build for testing how to deal with interacting the something...
 *
 * This is for testing out the menu. For quick access.
 *
 * 
 */

class GFxMainMenuSandBox extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;

var GFxMainMenuUI MainMenu;
var GFxMenuSinglePlayer MenuSinglePlayer;
var GFxMenuServerList MenuMultiPlayers;
var GFxMenuOptions MenuOptions;
var GFxMenuCredits MenuCredits;
var GFxMenuExit MenuExit;
var String menuname;

/** Structure which defines a unique menu view to be loaded. */
struct ViewInfo
{
	/** Unique string. */
	var name ViewName;

    /** SWF content to be loaded. */
    var string SWFName;

    /** Dependant views that should be loaded if this view is displayed. */
    var array<name> DependantViews;
};

/** Array of all menu views to be loaded, defined in DefaultUI.ini. */
var config array<ViewInfo>			ViewData;

/** 
 *  Shadow of the AS view stack. Necessary to update ( View.OnTopMostView(false) ) views that
 *  alreday exist on the stack. 
 */
var array<GFxUDKFrontEnd_View>		ViewStack;

/**
 * An array of names of views which have been attachMovie()'d and loadMovie()'d. Views
 * are loaded based on their DependantViews array, defined in Default.ini.
 */
var array<name>						LoadedViews;

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{    
	local bool bResult;
	bResult = false;
	`log( "=========================================================================================");
	`log( "GFxUDKFrontEnd::WidgetInit: " @ WidgetName @ " : " @ WidgetPath @ " : " @ Widget ,,'DevUI');  
	
	
    return bResult;
}


function Init( optional LocalPlayer LocPlay )
{
    `log("init menu ui");
    //Start();
    
    RootMC = GetVariableObject("root");
    
    Super.Init( LocPlay );
	
	Advance(0.0f);
    MenuSinglePlayer = new class'GFxMenuSinglePlayer';
	MenuSinglePlayer.init(LocPlay);
	MenuSinglePlayer.MainMenu = self;
	
	MenuMultiPlayers = new class'GFxMenuServerList';
	MenuMultiPlayers.init(LocPlay);
	MenuMultiPlayers.MainMenu = self;
	
	MenuCredits = new class'GFxMenuCredits';
	MenuCredits.init(LocPlay);
	MenuCredits.MainMenu = self;
	
	MenuOptions = new class'GFxMenuOptions';
	MenuOptions.init(LocPlay);
	MenuOptions.MainMenu = self;

}

function BtnClose(){
    `log("close");
     ClosePlayer();
}

function BtnBack(GFxObject EventObject, int PlayerIndex){
    `log("back function...");
     ClosePlayer();
}

//close UI
function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI   
}

function BtnMenuSelect(string _menuname){
    menuname = _menuname;
	`log("NAME" @ menuname);
}

function BtnNext(){
    if(menuname == "singleplayer"){
        `log("found menu");
		if(MenuSinglePlayer !=none){
			ClosePlayer();
			MenuSinglePlayer.init();
			MenuSinglePlayer.Start();
			`log("found menu opeing single menu");
			
		}else{
			`log("found error menu!");
			MenuSinglePlayer = new class'GFxMenuSinglePlayer';
			MenuSinglePlayer.init();
			MenuSinglePlayer.MainMenu = self;
			MenuSinglePlayer.Start();
			ClosePlayer();
		}
    }
	
	if(menuname == "multipleplayer"){
        //`log("found exit");
		if(MenuMultiPlayers !=none){
			ClosePlayer();
			MenuMultiPlayers.Start();
			
		}else{
			ClosePlayer();
			MenuMultiPlayers = new class'GFxMenuServerList';
			MenuMultiPlayers.MainMenu = self;
			MenuMultiPlayers.init();
			MenuMultiPlayers.Start();
		}
    }
	
	
	if(menuname == "options"){
        //`log("found exit");
		if(MenuOptions !=none){
			MenuOptions.Start();
			ClosePlayer();
		}else{
			MenuOptions = new class'GFxMenuOptions';
			MenuOptions.MainMenu = self;
			MenuOptions.init();
			MenuOptions.Start();
			ClosePlayer();
		}
    }
	
	if(menuname == "credits"){
        //`log("found exit");
		if(MenuCredits !=none){
			MenuCredits.Start();
			ClosePlayer();
		}else{
			MenuCredits = new class'GFxMenuCredits';
			MenuCredits.MainMenu = self;
			MenuCredits.init();
			MenuCredits.Start();
			ClosePlayer();
		}
    }
	
	if(menuname == "exit"){
        //`log("found exit");
		if(MenuExit !=none){
			MenuExit.Start();
			ClosePlayer();
		}else{
			MenuExit = new class'GFxMenuExit';
			MenuExit.MainMenu = self;
			MenuExit.init();
			MenuExit.Start();
			ClosePlayer();
		}
    }
}

//call to AddMenuList function
function AddMenuList(string _mn,string _id,string _info){//works
    local array<ASValue> args;
    local ASValue asval;

    asval.Type = AS_String;
    asval.s = _mn;
    args[0] = asval;
    
    asval.Type = AS_String;
    asval.s = _id;
    args[1] = asval;
    
    asval.Type = AS_String;
    asval.s = _info;
    args[2] = asval;

    GetVariableObject("root").Invoke("AddMenuList", args);
    `log("Invoke args...");
}

function ClearMenuList(){
    ActionScriptVoid("root.ClearMenuList");
}

function WidgetInit(string WidgetName, string WidgetPath, GFxObject Widget)//works
{    
    switch(WidgetName)
    {                 
        case ("myAS3Button"):
            MyAS3Button = Widget;
            SetWidgetPathBinding(MyAS3Button, name(WidgetPath));
            `log("found...");
            break;
        case ("myAS3Button2"):
            break;
        default:
            break;
    }
}

/** 
 * Activates, updates, and pushes a view on the stack if it is allowed.
 * This method is called when a view is created by name using PushViewByName().
 */
function ConfigureTargetView(GFxUDKFrontEnd_View TargetView)
{
    if( IsViewAllowed( TargetView ) )
    {
        // LoadDependantViews( TargetView.ViewName );
        // Disable the current top most view's controls to prevent focus from escaping during the transition.
		if (ViewStack.Length > 0)
		{
			ViewStack[ViewStack.Length - 1].DisableSubComponents(true);
		}
        
        TargetView.OnViewActivated();
        TargetView.OnTopMostView( true );

        ViewStack.AddItem( TargetView );
        PushView( TargetView );      
    }    
}


/** Check whether target view is appropriate to add to the view stack. */
function bool IsViewAllowed(GFxUDKFrontEnd_View TargetView)
{
    local byte i;	
    local name TargetViewName;

    // Check to see that we weren't passed a null view.
    if ( TargetView == none )
    {
		`log( "GFxUDKFrontEnd:: TargetView is null. Unable to push view onto stack." ,,'DevUI');         
        return false;
    }

    // Check to see if the view is already loaded on the view stack using the view name. 
    TargetViewName = TargetView.ViewName;
    for ( i = 0; i < ViewStack.Length; i++ )
    {
        if (ViewStack[i].ViewName == TargetViewName)
        {
			`log( "GFxFrontEnd:: TargetView is already on the stack." ,,'DevUI');             
            return false;
        }
    }

    return true;
}

/** Pushes a view onto MenuManager.as view stack. */
function PushView(coerce GFxUDKFrontEnd_View targetView) 
{     
    ActionScriptVoid("pushStandardView"); 
}

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    MovieInfo=SwfMovie'udkas3hui.UDKMainMenuUI2'
	bCaptureInput=true
	TimingMode=TM_Real
	bDisplayWithHudOff=TRUE
}

