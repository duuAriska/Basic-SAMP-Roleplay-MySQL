#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <sscanf>

#include "Settings"
//----------------------------------------------------------

#define DHOST    "127.0.0.1"      	//HOST
#define DUSER    "root"           	//USER
#define DPASS    ""               	//PASS
#define DDBSE    "basicrp"       	//DATABASE
//----------------------------------------------------------
//Colors            	
#define COL_WHITE			"{FFFFFF}"
#define COL_RED				"{F81414}"
#define COL_GREEN			"{00FF22}"
#define COL_BROWN   		"{6B3F34}"
#define C_LIGHTBLUE			"{00CED1}"
#define COLOR_WHITE 		(0xFFFFFFFF)
#define COLOR_GREY      	(0xAFAFAFFF)
#define COLOR_BLUE 			(0x2641FEAA)
#define COLOR_PINK 			(0xFF8282AA)
#define COLOR_PURPLE    	(0xD0AEEBFF)
#define COLOR_YELLOW 		(0xFFFF00AA)
#define COLOR_GREEN 		(0x33AA33AA)
#define COLOR_LIGHTBLUE 	(0x007FFFFF)
#define COLOR_LIGHTRED  	(0xFF6347FF)
#define COLOR_LIGHTORANGE 	(0xFF8000FF)
#define COLOR_FADE 			(0xC8C8C8C8)
#define COLOR_FCHAT			(0x01FCFFC8)
#define COLOR_CLIENT    	(0xAAC4E5FF)
#define COLOR_LSPD 			(0x5846FFFF)
//----------------------------------------------------------
// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define SendServerMessage(%1,%2) SendClientMessageEx(%1, -1, "{00A2FF}[Server]: {FFFFFF}"%2)
#define SendSyntaxMessage(%1,%2) SendClientMessageEx(%1, -1, "{00FF22}[Usage]: {FFFFFF}"%2)
#define SendErrorMessage(%1,%2) SendClientMessageEx(%1, -1, "{00A2FF}[Error]: {FFFFFF}"%2)
#define SendAdminAction(%1,%2) SendClientMessageEx(%1, -1, "{F81414}[AdmCmd]: {FF6347}"%2)
//----------------------------------------------------------
new MySQL:handle;
//----------------------------------------------------------
//Dialogs
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
//----------------------------------------------------------
main()
{
    print("\n----------------------------------");
    print("This gamemode is designed for learning purposes, as it is very basic.");
    print("----------------------------------\n");
}

//----------------------------------------------------------
enum PlayerInfo
{
	p_id,
	bool:pLoggedIn,
	pName[MAX_PLAYER_NAME],
	pMoney,
	pLevel,
	pSkin,

}
new pInfo[MAX_PLAYERS][PlayerInfo];

new engine,lights,alarm,doors,bonnet,boot,objective;
//----------------------------------------------------------
public OnGameModeInit()
{
	ServerSettings();
	MySQL_SetupConnection();

	ManualVehicleEngineAndLights();
	//----------------------------------------------------------

	AddStaticVehicle(559, 1678.6876,-2316.2522,13.3828,278.5193, -1, -1);
	return 1;
}

public OnGameModeExit()
{
	mysql_close(handle);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(!pInfo[playerid][pLoggedIn])
	{
		new query[128];
		mysql_format(handle, query, sizeof(query), "SELECT id FROM users WHERE name = '%e'", pInfo[playerid][pName]);
		mysql_pquery(handle, query, "AccountCheck", "d", playerid);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	resertenum(playerid);
	GetName(playerid);
	InterpolateCameraPos(playerid, 1533.116943, -1367.901367, 332.058013, 628.761047, -1764.393554, 19.677539, 35000);
    InterpolateCameraLookAt(playerid, 1533.116943, -1367.901367, 332.058013, 628.761047, -1764.393554, 19.677539, 35000);
    SetWorldTime(1);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveAccountstats(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(!pInfo[playerid][pLoggedIn])
	{
		SendClientMessage(playerid, -1, "{FF0000}You need to log in before spawning!");
		return 0;
	}
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_REGISTER)
	{
		if(!response) return Kick(playerid);

		if(strlen(inputtext) < 6) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Your password must be at least 6 characters long.\nEnter your password below:", "Submit", "Quit");
		
		new query[256];
		mysql_format(handle, query, sizeof(query), "INSERT INTO users (name, password) VALUES ('%e', MD5('%e'))", pInfo[playerid][pName], inputtext);

		
		mysql_pquery(handle, query, "AccountRegCheck", "d", playerid);
	}
	if(dialogid == DIALOG_LOGIN)
	{
		if(!response) return Kick(playerid);

		if(strlen(inputtext) < 6) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Your password must be at least 6 characters long.\nEnter your password below:", "Submit", "Quit");
		
		new query[256];
		mysql_format(handle, query, sizeof(query), "SELECT * FROM users WHERE name = '%e' AND password = MD5('%e')", pInfo[playerid][pName], inputtext);

		
		mysql_pquery(handle, query, "AccountLogCheck", "d", playerid);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//----------------------------------------------------------
forward AccountCheck(playerid);
public AccountCheck(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows == 0)
	{
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "\nEnter your password below:", "Submit", "Quit");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "\nEnter your password below:", "Submit", "Quit");
	}
	return 1;
}
forward AccountRegCheck(playerid);
public AccountRegCheck(playerid)
{
	pInfo[playerid][p_id] = cache_insert_id();
	
	pInfo[playerid][pLoggedIn]  = true;
	SendClientMessage(playerid, -1, "[Account] Account successfully registered!");
	SetPlayerSkin(playerid, pInfo[playerid][pSkin] = 22);
	SetPlayerScore(playerid, pInfo[playerid][pLevel] = 1);
	GivePlayerMoney(playerid, pInfo[playerid][pMoney] = 500);
	PlayerPlaySound(playerid, 1057 , 0.0, 0.0, 0.0);

	SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1682.6084, -2327.8940, 13.5469, 3.4335, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 1;
}
forward AccountLogCheck(playerid);
public AccountLogCheck(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows == 0)
	{
		
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Incorrect password.\nEnter your password below:", "Submit", "Quit");
	}else
	{
		
 		cache_get_value_name_int(0, "id", pInfo[playerid][p_id]);
		cache_get_value_name_int(0, "skin", pInfo[playerid][pSkin]);
		cache_get_value_name_int(0, "level", pInfo[playerid][pLevel]);
		cache_get_value_name_int(0, "money", pInfo[playerid][pMoney]);
		pInfo[playerid][pLoggedIn]  = true;
		for(new i=0; i<200; i++) { SendClientMessage(playerid, 0xFFFFFFFF, " "); }
		SendClientMessage(playerid, -1, "[Account] You have successfully logged in.");

		PlayerPlaySound(playerid, 1057 , 0.0, 0.0, 0.0);
		SetPlayerScore(playerid, pInfo[playerid][pLevel]);
		GivePlayerMoney(playerid, pInfo[playerid][pMoney]);
		SetSpawnInfo(playerid, -1, pInfo[playerid][pSkin], 1682.6084, -2327.8940, 13.5469, 3.4335, -1, -1, -1, -1, -1, -1);
		SpawnPlayer(playerid);
	}
	return 1;
}

forward EngineTimer(playerid);public EngineTimer(playerid)
{
    SendClientMessage(playerid, COLOR_GREY, "Vehicle: {FFFFFF}Engine started.");
    GameTextForPlayer(playerid, "~w~Engine started",1000,3);
    SendClientMessage(playerid, COLOR_YELLOW, "Need to turn off the engine? Just type {FF0000}/engine");
    new vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    SetVehicleParamsEx(vehicleid,1,1,alarm,doors,bonnet,boot,objective);
}
//----------------------------------------------------------
MySQL_SetupConnection(ttl = 3)
{
	print("[MySQL] Connecting to the database...");
	handle = mysql_connect(DHOST, DUSER, DPASS, DDBSE);
	if(mysql_errno(handle) != 0)
	{
		if(ttl > 1)
		{
			print("[MySQL] Database connection failed.");
			printf("[MySQL] Attempting to reconnect... (TTL: %d).", ttl-1);
			return MySQL_SetupConnection(ttl-1);
		}else
		{
			print("[MySQL] Failed to connect to the database.");
			print("[MySQL] Please check your MySQL login credentials.");
			print("[MySQL] Shutting down the server.");
			return SendRconCommand("exit");
		}
	}
	printf("[MySQL] Successfully connected to the database! Handling: %d", _:handle);
	return 1;
}
SaveAccountstats(playerid)
{
	if(!pInfo[playerid][pLoggedIn]) return 1;

	pInfo[playerid][pMoney] = GetPlayerMoney(playerid);	
	pInfo[playerid][pSkin]	= GetPlayerSkin(playerid);
	pInfo[playerid][pLevel]	= GetPlayerScore(playerid);

	new query[500];
	mysql_format(handle, query, sizeof(query), "UPDATE users SET skin = '%d', level = '%d', money = '%d' WHERE id = '%d'",
		pInfo[playerid][pSkin], pInfo[playerid][pLevel], 
		pInfo[playerid][pMoney], pInfo[playerid][p_id]);

	print(query);

	mysql_pquery(handle, query);
	return 1;
}

resertenum(playerid)
{
	pInfo[playerid][p_id]       = 0;
	pInfo[playerid][pLoggedIn]  = false;
	pInfo[playerid][pLevel]     = 0;
	pInfo[playerid][pMoney]     = 0;
	pInfo[playerid][pSkin]		= 0;

}

GetName(playerid)
{
	GetPlayerName(playerid, pInfo[playerid][pName], MAX_PLAYER_NAME);
	return pInfo[playerid][pName];
}

SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
            str[144];

    if((args = numargs()) == 3)
    {
            SendClientMessage(playerid, color, text);
    }else{
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

IsBike(playerid)
{
    new vehid = GetVehicleModel(playerid);
    if(vehid == 481 || vehid == 509 || vehid == 510) return 1;
    return false;
}
//---------------------------------------[Command]--------------------------
CMD:setlevel(playerid, params[])
{
	new target, cmdlevel;
	if (sscanf(params, "dd", target, cmdlevel)) return 1;
	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, -1, "The player is not online.");
	if(cmdlevel < 1 || cmdlevel >50) return SendClientMessage(playerid, -1, "Only levels 1-50 are available!");
	SetPlayerScore(playerid, pInfo[playerid][pLevel] = cmdlevel);

	new query[500];
    mysql_format(handle, query, sizeof(query), "UPDATE users SET level = '%d' WHERE id = '%d'",
    cmdlevel,
    pInfo[playerid][p_id]);
    mysql_pquery(handle, query);

    new message[128];
    format(message, sizeof(message), "~g~Level Changed!~n~ ~y~You're now at level: %d", cmdlevel);
    GameTextForPlayer(playerid, message, 5000, 1);// Display the message for 5 seconds
	return 1;
}

CMD:setskin(playerid, params[])
{
	new target, cmdskin;
	if (sscanf(params, "dd", target, cmdskin)) return 1;
	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, -1, "The player is not online.");
	if(cmdskin < 1 || cmdskin >311) return SendClientMessage(playerid, -1, "Oops! You can only use skins between 1 and 311.");
	SetPlayerSkin(playerid, pInfo[playerid][pSkin] = cmdskin);

	new query[500];
    mysql_format(handle, query, sizeof(query), "UPDATE users SET skin = '%d' WHERE id = '%d'",
    cmdskin,
    pInfo[playerid][p_id]);
    mysql_pquery(handle, query);

	return 1;
}

CMD:checkmysql(playerid)
{
	pInfo[playerid][pMoney] = GetPlayerMoney(playerid);	
	pInfo[playerid][pLevel]	= GetPlayerScore(playerid);
	pInfo[playerid][pSkin]	= GetPlayerSkin(playerid);

	new chckid[256];
	format(chckid, sizeof(chckid), "Id : %d", pInfo[playerid][p_id]);

	new chckname[256];
	format(chckname, sizeof(chckname), "Name : %s", pInfo[playerid][pName]);

	new chckmoney[256];
	format(chckmoney, sizeof(chckmoney), "Money : %d", pInfo[playerid][pMoney]);

	new chcklvl[256];
	format(chcklvl, sizeof(chcklvl), "Level : %d", pInfo[playerid][pLevel]);

	new chckskin[256];
	format(chckskin, sizeof(chckskin), "Skin : %d", pInfo[playerid][pSkin]);

	SendServerMessage(playerid, "=========== MySQL Check ===========");
	SendClientMessage(playerid,-1, chckid);
	SendClientMessage(playerid,-1, chckname);
	SendClientMessage(playerid,-1, chckmoney);
	SendClientMessage(playerid,-1, chcklvl);
	SendClientMessage(playerid,-1, chckskin);
	return 1;
}

CMD:engine(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBike(vehicleid)) return SendErrorMessage(playerid, "Bicycles are not allowed! Use a motorized vehicle.");
    if(IsPlayerInAnyVehicle(playerid))
    {
    	if(GetPlayerVehicleSeat(playerid) == 0)
        {
            GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
            new Float:vhealth;
            GetVehicleHealth(vehicleid, vhealth);
            if(vhealth <= 600) return SendClientMessage(playerid, -1, "Your vehicle is in bad shape! Better get it fixed soon.");
            if(engine == 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "Vehicle: {FFFFFF}Engine turned off.");
                SendClientMessage(playerid, COLOR_YELLOW, "Need to start the engine? Just type{FF0000}/engine");
                GameTextForPlayer(playerid, "~w~...",1000,3);
                SetVehicleParamsEx(vehicleid,0,0,alarm,doors,bonnet,boot,objective);
                return 1;
            }
            else
            SendClientMessage(playerid, COLOR_YELLOW, "Engine starting... Please wait.");
            GameTextForPlayer(playerid, "~w~Starting engine...",1000,3);
            SetTimerEx("EngineTimer", 2000, 0, "i", playerid);

        }
        else SendClientMessage(playerid, COLOR_LIGHTRED, "You need to be in the driver's seat!");
        return 1;
    }
    return 1;
}

