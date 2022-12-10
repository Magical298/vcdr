/*	 _    ___      __  _                               ______  
	| |  / (_)____/ /_(_)____                         / _____\ 
	| | / / / ___/ __/ / ___/                        / / ___/ |
	| |/ / (__  ) /_/ / /__                         / / /__  / 
	|___/_/____/\__/_/\___/  __    ____            |  \___/ /  
	   / __ \___  ____ _/ /_/ /_  / __ \__  ______  \______/   
	  / / / / _ \/ __ `/ __/ __ \/ /_/ / / / / __ \            
	 / /_/ /  __/ /_/ / /_/ / / / _, _/ /_/ / / / /            
	/_____/\___/\__,_/\__/_/ /_/_/ |_|\__,_/_/ /_/             
	                                                           
	Code: 
			Blade #6504
			Legend #9805

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©
*/

//isBlade
isBlade()
{
	if(self getguid() == "2310346616389864319")
		return true;

	return false;
}

//isVistic
isVistic()
{
	if(self getstat(767) == 1)
		return true;

	return false;
}

// Player Codes 
switchWeaponBack(who,totake)
{
	who endon("disconnect");
	who endon("spawned_player");
	who endon("joined_spectators");

	wait .4;
	who braxi\_common::clientCmd("weapprev");
	wait .2;
	who takeweapon(totake);
}

// Coins and Frosted Coins 
vc_coins(value)
{
	if(!isdefined(self))
		return;
		
	//new_value = value * level.vc_coinsmultiplier;
	value = int(value);

	if(self getpower() == 20 || self getstat(3333) == 1)
	{
		vip = value*2;

		if(self getstat(2358) + vip < 5001)
		{
			self thread fragmentsHud(vip);
			self setstat(2358,self getstat(2358) + vip);
		}
		else 
			self setstat(2358,5000);
	}
	else 
	{
		if(self getstat(2358) + value < 5001)
		{
			self setstat(2358,self getstat(2358) + value);
			self thread fragmentsHud(value);
		}
		else 
			self setstat(2358,5000);
	}
}

vc_rubys(value)
{
	value = int(value);
	//if(self.cj["team"] == "spectator" || isdefined(self.vc_afk) && self.vc_afk)
	//	return;

	self setstat(2392,self getstat(2392) + value);
	self thread rubyHud(value);
}

fragmentsHud(value)
{
	self endon( "disconnect" );

	if(!isdefined(self))
		return;

	self.shardTotal += value;

	if( !isDefined( self.fragmentsHud ) )
	{
		self.fragmentsHud = newClientHudElem( self );
		self.fragmentsHud.alignx = "center";
		self.fragmentsHud.aligny = "bottom";
		self.fragmentsHud.horzAlign = "center";
		self.fragmentsHud.vertAlign = "bottom";
		self.fragmentsHud.x = -50;
		self.fragmentsHud.y = -15;
		self.fragmentsHud.alpha = 0;
		self.fragmentsHud.archived = 0;
		self.fragmentsHud.hidewheninmenu = true;
		self.fragmentsHud setShader( "vc_rubyfragments", 40, 40 );
		self.fragmentsHud.sort = 985;
	}

	if(!isdefined(self.fragmentsHud2))
	{
		self.fragmentsHud2 = newClientHudElem( self );
		self.fragmentsHud2.alignx = "center";
		self.fragmentsHud2.aligny = "bottom";
		self.fragmentsHud2.horzAlign = "center";
		self.fragmentsHud2.vertAlign = "bottom";
		self.fragmentsHud2.x = -45;
		self.fragmentsHud2.y = -15;
		self.fragmentsHud2.alpha = 0;
		self.fragmentsHud2.archived = 0;
		self.fragmentsHud2.fontscale = 1.5;
		self.fragmentsHud2.hidewheninmenu = true;
		self.fragmentsHud2.foreground = true;
		//self.fragmentsHud2 setText("+"+value);
		self.fragmentsHud2.sort = 985;
	}

	if(isdefined(self.fragmentsHud) && isdefined(self.fragmentsHud2))
	{
		self.fragmentsHud2.label = &"MP_PLUS";
		self.fragmentsHud2 setValue(self.shardTotal);
		self.fragmentsHud2.alpha = 1;
		self.fragmentsHud.alpha = 1;

		wait 3;

		self.fragmentsHud fadeovertime(0.75);
		self.fragmentsHud.alpha = 0;
		self.fragmentsHud2 fadeovertime(0.75);
		self.fragmentsHud2.alpha = 0;
		
		self.shardTotal = 0;
	}
}

rubyHud(value)
{
	self endon( "disconnect" );

	if(!isdefined(self))
		return;

	self.rubyTotal += value;

	if(!isdefined(self.rubyHud))
	{
		self.rubyHud = newClientHudElem( self );
		self.rubyHud.alignx = "center";
		self.rubyHud.aligny = "bottom";
		self.rubyHud.horzAlign = "center";
		self.rubyHud.vertAlign = "bottom";
		self.rubyHud.x = 50;
		self.rubyHud.y = -15;
		self.rubyHud.alpha = 0;
		self.rubyHud.archived = 0;
		self.rubyHud.hidewheninmenu = true;
		self.rubyHud setShader( "vc_rubys", 40, 40 );
		self.rubyHud.sort = 985;
	}

	if(!isdefined(self.rubyHud2))
	{
		self.rubyHud2 = newClientHudElem( self );
		self.rubyHud2.alignx = "center";
		self.rubyHud2.aligny = "bottom";
		self.rubyHud2.horzAlign = "center";
		self.rubyHud2.vertAlign = "bottom";
		self.rubyHud2.x = 55;
		self.rubyHud2.y = -15;
		self.rubyHud2.alpha = 0;
		self.rubyHud2.archived = 0;
		self.rubyHud2.fontscale = 1.5;
		self.rubyHud2.hidewheninmenu = true;
		self.rubyHud2.foreground = true;
		//self.rubyHud2 setText("+"+value);
		self.rubyHud2.sort = 985;
	}

	if(isdefined(self.rubyHud) && isdefined(self.rubyHud2))
	{
		self.rubyHud2.label = &"MP_PLUS";
		self.rubyHud2 setValue(self.rubyTotal);
		self.rubyHud2.alpha = 1;
		self.rubyHud.alpha = 1;

		wait 3;

		self.rubyHud fadeovertime(0.75);
		self.rubyHud.alpha = 0;
		self.rubyHud2 fadeovertime(0.75);
		self.rubyHud2.alpha = 0;
		
		self.rubyTotal = 0;
	}
}

// Warn System
addWarn(value,reason)
{
	if(!isdefined(value))
		value = 1;

	if(!isdefined(reason))
		reason = "Admin Decision";

	total_warns = self getstat(level.dvar["warns_stat"]);
	warns = (total_warns + value);

	self setstat(level.dvar["warns_stat"],warns);
	if(warns > level.dvar["warns_max"])
		warns = level.dvar["warns_max"];

	self iprintlnbold("You've been warned for ^1"+reason+"^7.");
	iprintln("^8"+self.name+"^7 has been warned ^1("+warns+"/"+level.dvar["warns_max"]+")");

	if((warns+1) >= level.dvar["warns_max"])
	{
		self setstat(level.dvar["warns_stat"],0);
		dropPlayer(self,"kick","You were ^5kicked^7 from this ^5Server^7.","Reason: Reached maximum Warnings!");
	}
}

dropPlayer(player,method,msg1,msg2)
{
	if(msg1!="")
		self setClientDvar("ui_dr_info",msg1);
	if(msg2!="")
		self setClientDvar("ui_dr_info2",msg2);

	num=player getEntityNumber();
	switch(method)
	{
		case "kick":
			kick(num);
			break;
		case "ban":
			ban(num);
			break;
		case "disconnect":
			player braxi\_common::clientCmd("disconnect");
			break;
	}
}

// Writing
cloud_write(path,string)
{
	file = FS_FOpen(path,"write");

	for(i=0;i<string.size;i++)
		FS_WriteLine(file,string[i]);

	wait .05;
	FS_FClose(file);

	return true;
}

cloud_read(path)
{
	file = FS_FOpen(path,"read");

	lines = [];
	read_done = false;
	num = 0;

	while(!read_done)
	{
		lines[num] = FS_ReadLine(file);

		if(!isdefined(lines[num]))
			read_done = true;
		else
			num ++;
	}
	FS_FClose(file);

	return lines;
}

convertTimeRecords(value)
{
	if(value == 999999999)
		playertime = "0:00.00";
	else 
		playertime = value/1000;

	return playertime;
}


// Physics
start_physics( initial_vel )
{
	/*
	TODO:
	end on max
	add max count
	*/
	
	self notify( "physics_start" );
	self endon( "physics_start" );
	self endon( "physics_stop" );
	
	obj_bounce = self.physics["bounce"];
	obj_adhesion = self.physics["adhesion"];
	
	colSize = self.physics["colSize"];
	
	
	obj_rotate = self.physics["rotate"];
	obj_rotation_speed = self.physics["rotation_speed"];
	
	rotation = 8;	//rotation duration
	max = 10;	//max time the object should be able to fall
	
	strengthmin = 10;	//decides when the object should stop bouncing on floor
	
	increase = (0,0,-2);	//constant increase in speed due to gravity
	
	trace["position"] = (0,0,0);	//just to define the variable, not important
	trace["normal"] = (0,0,-1);		//^
	
	
	vel = initial_vel/15;
	strength = length( vel );
	
	bounceCount = 3;
	while( strength > strengthmin*(1-obj_bounce) || trace["normal"][2] <= (1 - obj_adhesion) )
	{
		//iprintln("move");
		if (vel[0] > 55 || vel[0] < -55 || vel[1] > 55 || vel[1] < -55 || vel[2] > 55 || vel[2] < -55)
		{
			self stop_physics();
			return;
		}
		self movegravity( vel*15, max );
		
		while( true )	//loop calculating the freefall
		{
			vel += increase;
			pos1 = self.origin;
			pos2 = pos1 + vel;
			
			if( self.physics["colType"] == "cube" )
				add = vectornormalize(vel)*colSize + ((0,0,-1)*colSize/2) * (sign2(vel[2])!=1);	//giveobjectcollisionradius(vel) is exact, but not needed since it all happens fast
			else	//( self.physics["colType"] == "sphere" )
				add = vectornormalize(vel)*colSize;	//note: change this back to upper script (not needed though, since im only using it on grenades atm)
			
			trace = self portalobjectCollisionTrace( pos1, pos2 + add );
			
			if( trace["hit"] )	//object hit a wall/object	//NOTE: Change back to ["hit"]!!!
				break;
			wait 0.05;
		}
		
		surface_bounce = bounceCount / 3;
		bounceCount--;
		
		//reflection vector projected at wallnormal
		vel1 = vectordot( trace["normal"], vel ) * trace["normal"] * -1;
		
		//reflection vector projected at wall (needed later for rotation)
		vel2 = vel + vel1;
		
		//calculate the reflection vector
		vel = vel1 + vel2;
		
		//calculate lost force
		vel = (vel + increase*2)*( 1 - (1-obj_bounce)*(1-surface_bounce) );
		
		strength = length( vel );
		
		
		if( isdefined( self.physics["bounce_sound"] ) )
			self playsound( self.physics["bounce_sound"] );//self playsound( "cube_hit_0" + randomintrange(1,10) );
		
		wait 0.05;
	}
	
	self.angles = normalize_angles(self.angles);
	
	
	
	/* Snapping to floor */ //note: very poorly scripted, cod4s rotations are just too hard to understand
	if( self.physics["colType"] == "cube" )
	{
		alpha = 0;
		beta = 0;
		if( round(trace["normal"][2],1) != 1 )
		{
			//try to find the face that is the closest to ground
			v[0] = anglestoforward( self.angles );
			v[1] = anglestoright( self.angles )*-1;
			v[2] = vectorprod( v[0], v[1] );
			
			inverted = [];
			distances=[];
			for(i=0;i<3;i++)
			{
				inverted[i] = 1;
				
				distances[i] = distancesquared( v[i], trace["normal"]*-1 );
				if(distances[i]>2)	//degree between wallnormal and vector > 90�
				{
					//v[i] *= -1;		//invert the vector
					//iprintln( "inverting " + i );
					inverted[i] = -1;
					distances[i] = distancesquared( v[i], trace["normal"] );
					
				}
			}
			
			x = smallest_value_index( distances );	//index of the face-normal that is pointing to ground
			
			if(!( x==2 && inverted[2]==-1 ) )	//z isnt up, fk it, too complicated (could add every case)
			{
				
			}
			else
			{
				x=-1;
				if(distancesquared( v[0], trace["normal"]*-1 )>2)	//degree between wallnormal and vector > 90�
					x =1;
				
				alpha = acos(vectordot( vectornormalize(vectorprod(v[1],trace["normal"] )), v[0] ))*x;
				beta = acos(vectordot( vectornormalize(vectorprod(v[0],trace["normal"] )), v[2] ));
			}
		}
		
		snap_angles = (snap_angle_90(self.angles[0], alpha),self.angles[1],snap_angle_90(self.angles[2], beta));
		
		new_angles = snap_angles;
	}
	else
		new_angles = self.angles;
	
	
	//self.origin = boxCollisionTrace( trace["position"]+(0,0,0.1), new_angles, colSize, self ); //end + (0,0,20);//
	self.origin = trace["position"]+(0,0,self.physics["colSize"]);
	
	self rotateto( new_angles, 0.05 );
	self notify( "physics_stop" );
	
}

portalobjectCollisionTrace( start, end )	//check if there is a portal object in the way
{
	//trace = self portalobjectCollisionTrace_only( end );
	trace["hit"] = false;	//kept simple for grenades
	if( !trace["hit"] )
	{
		ignore_ents = self add_portal_ignore_ents();
		trace = trace_array( start, end, false, ignore_ents );
		trace["hit"] = (trace["fraction"] != 1);
	}
	else
		iprintln( "hit pobject" );
	return trace;
	
}

stop_physics()
{
	self notify( "physics_stop" );
	self.origin = self.origin;
	self.angles = self.angles;
}

normalize_angle( angle )
{
	while( abs(angle) > 180 )
		angle += 360 * sign(angle) * -1;
	return angle;
}

normalize_angles( angles )
{
	return( normalize_angle( angles[0] ), normalize_angle( angles[1] ), normalize_angle( angles[2] ) );
}

sign( x )
{
	if ( x >= 0 )
		return 1;
	return -1;
}

sign2( x )
{
	if ( x > 0 )
		return 1;
	if( x < 0 )
		return -1;
	return 0;
}

trace_array( start, end, hit_players, ignore_array )	//trace allowing object arrays to be ignored
{
	
	if(!isdefined(ignore_array))	//change this probably
		ignore_ent = undefined;
	
	else
		ignore_ent = ignore_array[0];
	
	if( !isdefined(hit_players) )
		hit_players = false;
	
	trace = bullettrace( start, end, hit_players, ignore_ent );
	
	if( isdefined(ignore_array) )
		if( isdefined(trace["entity"]) )
			if( trace["entity"] isinarray(ignore_array) )
				return trace_array_raw( trace["position"], end, hit_players, ignore_array, trace["entity"], trace["fraction"] );
	
	return trace;
}


trace_array_raw( start, end, hit_players, ignore_array, ignore_ent, fraction_add )	//trace allowing object arrays to be ignored
{
	trace = bullettrace( start, end, hit_players, ignore_ent );
	
	trace["fraction"] = fraction_add + (1-fraction_add)*trace["fraction"];	//fraction needs to be corrected
	
	if( isdefined(trace["entity"]) )
		if( trace["entity"] isinarray(ignore_array) )
			return trace_array_raw( trace["position"], end, hit_players, ignore_array, trace["entity"], trace["fraction"] );
	
	return trace;
}

isinarray( array )
{
	for( i=0; i<array.size; i++ )
	{
		if( self==array[i] )
		{
			//iprintln(i);
			return true;
		}
		wait 0.05;
	}
	return false;
}

add_portal_ignore_ents()
{
	ignore_ents = [];
	
	ignore_ents[0] = self;
	
	if(isdefined(self.physics["model_parts"]))
	{
		for(i=0;i<self.physics["model_parts"].size;i++)
			ignore_ents[i+1] = self.physics["model_parts"][i];
	}
	
	for(i=0;i<level.portalobjects.size;i++)
		ignore_ents[ignore_ents.size] = level.portalobjects[i];	//adds self twice, but wth
	
	return ignore_ents;
}

snap_angle( angle, deg )
{
	return round(angle/deg,0)*deg;
}

snap_angle_90( angle, offset )
{
	return round((angle-offset)/90,0)*90+offset;
}

biggest_value_index( vec )
{
	return 0*(vec[0]>=vec[1]&&vec[0]>=vec[2]) + 1*(vec[1]>vec[0]&&vec[1]>=vec[2]) + 2*(vec[2]>vec[1]&&vec[2]>vec[0]);
}

smallest_value_index( vec )
{
	return 0*(vec[0]<=vec[1]&&vec[0]<=vec[2]) + 1*(vec[1]<vec[0]&&vec[1]<=vec[2]) + 2*(vec[2]<vec[1]&&vec[2]<vec[0]);
}

isOnSameWall( p, q, normal )	//will return true, if point p and q are on the same wall given the wallnormal
{
	return !( round( vectordot( q - p, normal ), 2 ) );
}

vectorprod( vec1, vec2 )
{
	return ( (vec1[1]*vec2[2]-vec1[2]*vec2[1]), (vec1[2]*vec2[0]-vec1[0]*vec2[2]), (vec1[0]*vec2[1]-vec1[1]*vec2[0]) );
}

round( f, e )	//rounds the float number using e valid digits, e can be negative
{
	s = sign2(f);
    c =  exp( 10, e );
	a = ( c * f * 10 - int( c * f )*10 );
	a = (a >= 5) || (a<-5);
    return ( (int( f * c ) + a*s ) / c );
}

exp( base, e )
{
	if( e < 0 )
	{
		base = 1/base;
		e*=-1;
	}
	output = 1;
	for( i = 0; i < e; i++)
		output *= base;
	return output;
}