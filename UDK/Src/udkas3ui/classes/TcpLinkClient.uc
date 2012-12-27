/*
 * An example usage of the TcpLink class
 *  
 * By Michiel 'elmuerte' Hendriks for Epic Games, Inc.
 *  
 * You are free to use this example as you see fit, as long as you 
 * properly attribute the origin. 
 */
 
class TcpLinkClient extends TcpLink;
 
var PlayerController PC; //reference to our player controller
var string TargetHost; //URL or P address of web server
var int TargetPort; //port you want to use for the link
var string path; //path to file you want to request
var string requesttext; //data we will send
var int score; //score the player controller will send us
var bool send; //to switch between sending and getting requests
 
event PostBeginPlay()
{
    super.PostBeginPlay();
	`log("INIT.. TCP... TEST...");
}
 
function ResolveMe() //removes having to send a host
{
    Resolve(targethost);
}
 
event Resolved( IpAddr Addr )
{
    // The hostname was resolved succefully
    `Log("[TcpLinkClient] "$TargetHost$" resolved to "$ IpAddrToString(Addr));
     
    // Make sure the correct remote port is set, resolving doesn't set
    // the port value of the IpAddr structure
    Addr.Port = TargetPort;
     
    //dont comment out this log because it rungs the function bindport
    `Log("[TcpLinkClient] Bound to port: "$ BindPort() );
    if (!Open(Addr))
    {
        //`Log("[TcpLinkClient] Open failed");
    }
}
 
event ResolveFailed()
{
    //`Log("[TcpLinkClient] Unable to resolve "$TargetHost);
    // You could retry resolving here if you have an alternative
    // remote host.
 
    //send failed message to scaleform UI
    //JunHud(JunPlayerController(PC).myHUD).JunMovie.CallSetHTML("Failed");
	`log("FAIL CONNECT");
}
 
event Opened()
{
    // A connection was established
    //`Log("[TcpLinkClient] event opened");
    //`Log("[TcpLinkClient] Sending simple HTTP query");
     
    //The HTTP GET request
    //char(13) and char(10) are carrage returns and new lines
    if(send == false)
    {
        SendText("GET /"$path$" HTTP/1.0");
        SendText(chr(13)$chr(10));
        SendText("Host: "$TargetHost);
        SendText(chr(13)$chr(10));
        SendText("Connection: Close");
        SendText(chr(13)$chr(10)$chr(13)$chr(10));
    }
    else if(send == true && score > 0)
    {       
        requesttext = "value="$score$"&submit=10987";
 
        SendText("POST /"$path$" HTTP/1.0"$chr(13)$chr(10));
        SendText("Host: "$TargetHost$chr(13)$chr(10));
        SendText("User-Agent: HTTPTool/1.0"$Chr(13)$Chr(10));
        SendText("Content-Type: application/x-www-form-urlencoded"$chr(13)$chr(10));
        //we use the length of our requesttext to tell the server
        //how long our content is
        SendText("Content-Length: "$len(requesttext)$Chr(13)$Chr(10));
        SendText(chr(13)$chr(10));
        SendText(requesttext);
        SendText(chr(13)$chr(10));
        SendText("Connection: Close");
        SendText(chr(13)$chr(10)$chr(13)$chr(10));
    }
         
    `Log("[TcpLinkClient] end HTTP query");
}
 
event Closed()
{
    // In this case the remote client should have automatically closed
    // the connection, because we requested it in the HTTP request.
    `Log("[TcpLinkClient] event closed");
     
    // After the connection was closed we could establish a new
    // connection using the same TcpLink instance.
}
 
event ReceivedText( string Text )
{   
    // receiving some text, note that the text includes line breaks
    `Log("[TcpLinkClient] ReceivedText:: "$Text);
     
    //we dont want the header info, so we split the string after two new lines
    Text = Split(Text, chr(13)$chr(10)$chr(13)$chr(10), true);
    `Log("[TcpLinkClient] SplitText:: " $Text);
     
    //First we will recieve data from the server via GET
    if (send == false)
    {
        //send data to our UI
        //JunHud(JunPlayerController(PC).myHUD).JunMovie.CallSetHTML(Text);
		`log(Text);
        send = true; //next time we resolve, we will send player score
    }
}
 
defaultproperties
{
    TargetHost="127.0.0.1"
    TargetPort=80 //default for HTTP
    path = "/submit"
    score = 0;
    send = false;
}