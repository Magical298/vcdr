// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__

/*
	 _   ________   ___  __        __   
 	| | / / ___( ) / _ )/ /__ ____/ /__ 
 	| |/ / /__ |/ / _  / / _ `/ _  / -_)
 	|___/\___/   /____/_/\_,_/\_,_/\__/ 

	Plugin by VC' Blade ©
	Version: 1.0
	Website: vistic-clan.com
*/

init( modVersion )
{
        if(!isdefined(vers))
	        wait 0.1;

        for(;;)
        {
                level waittill("player_spawn",who);

                if(who getpower() == 80 || who getpower() == 100)
                        who thread _adminPickup();
        }
}
_adminPickup()
{
   self endon("disconnect");
 
        while(1)
        {        
                while(!self fragButtonPressed())
                {
                        wait 0.05;
                }
               
                start = self getEye();
                end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 999999);
                trace = bulletTrace(start, end, true, self);
                dist = distance(start, trace["position"]);
 
                ent = trace["entity"];
 
                if(isDefined(ent) && ent.classname == "player")
                {
                        if(isPlayer(ent))
                                ent iPrintLnBold("^1You've been picked up by the admin ^3" + self.name + "^1!");
 
                        self IPrintLn("You've picked up ^5" + ent.name + "^7!");
 
                        linker = spawn("script_origin", trace["position"]);
                        ent linkto(linker);
 
                        while(self fragButtonPressed())
                        {
                                wait 0.05;
                        }
 
                        while(!self fragButtonPressed() && isDefined(ent))
                        {
                                start = self getEye();
                                end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), dist);
                                trace = bulletTrace(start, end, false, ent);
                                dist = distance(start, trace["position"]);
 
                                if(self useButtonPressed() && !self adsButtonPressed())
                                        dist -= 15;
                                else if(self useButtonPressed() && self adsButtonPressed())
                                        dist += 15;
 
                                end = start + maps\mp\_utility::vector_Scale(anglestoforward(self getPlayerAngles()), dist);
                                trace = bulletTrace(start, end, false, ent);
                                linker.origin = trace["position"];
 
                                wait 0.05;
                        }
     
                        if(isDefined(ent))
                        {
                                ent unlink();
                                       
                                if(isPlayer(ent))
                                        ent iPrintLnBold("^1You've been dropped by the admin ^3" + self.name + "^1!");
 
                                self IPrintLn("You've dropped ^5" + ent.name + "^7!");
                        }
 
                        linker delete();
                }
 
                while(self fragButtonPressed())
                {
                        wait 0.05;
                }
        }
}