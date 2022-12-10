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
#include blade\_common;

// ==========================
// ### Personal Best Times
savePBtime()
{
	map = getdvar("mapname");
	guid = getsubstr(self getguid(), 11, 19);

	path = "cloud/"+map+"/pb_"+guid+".txt";
	if(!FS_TestFile(path))
	{
		create_file = FS_FOpen(path,"write");
		FS_FClose(create_file);
	}

	wait .05;

	time = self.pers["time"];
	file = FS_FOpen(path,"write");
	FS_WriteLine(file,time);

	wait .05;
	FS_FClose(file);

	self setclientdvar("uidr_pb_time", time/1000);
}

loadPBtime()
{
	map = getdvar("mapname");
	guid = getsubstr(self getguid(), 11, 19);

	path = "cloud/"+map+"/pb_"+guid+".txt";
	if(FS_TestFile(path))
	{
		info = cloud_read(path);
		time = int(info[0]);

		wait .05;

		self.pers["time"] = time;
		self setclientdvar("uidr_pb_time", time/1000);
	}
	else 
	{
		self.pers["time"] = 99999999;
		self setclientdvar("uidr_pb_time", "0:00.00");
	}
}

// ==========================
// ### Time Records
saveTimeRecords()
{
	map = getdvar("mapname");

	path = "cloud/"+map+"/maprecords.txt";
	if(!FS_TestFile(path))
	{
		create_file = FS_FOpen(path,"write");
		FS_FClose(create_file);
	}

	wait .05;

	records = [];
	write = [];

	for(i=0; i<5; i++)
	{
		records[i] = level.playerTimes[i]["name"]+";"+level.playerTimes[i]["time"]+";"+level.playerTimes[i]["guid"];
		write[i] = records[i];

		wait .05;
	}

	file = FS_FOpen(path,"write");
	for(i=0;i<write.size;i++)
	{
		FS_WriteLine(file,write[i]);
		wait .05;
	}
	FS_FClose(file);
}

loadTimeRecords()
{
	map = getdvar("mapname");

	path = "cloud/"+map+"/maprecords.txt";
	if(FS_TestFile(path))
	{
		info = cloud_read(path);

		for(i=0; i<5; i++)
		{
			tokens = strtok(info[i],";");
			level.playerTimes[i]["name"] = tokens[0];
			level.playerTimes[i]["time"] = int(tokens[1]);
			level.playerTimes[i]["guid"] = tokens[2];
		}
	}
}

// ==========================
// ### Most Valueable Player
saveMvpHolder()
{
	map = getdvar("mapname");

	path = "cloud/"+map+"/mvp.txt";
	if(!FS_TestFile(path))
	{
		create_file = FS_FOpen(path,"write");
		FS_FClose(create_file);
	}

	wait .05;

	mvp = level.bestScores[0]["player"]+";"+level.bestScores[0]["guid"]+";"+level.bestScores[0]["value1"]+";"+level.bestScores[0]["value2"]+";"+level.bestScores[0]["model"];
	file = FS_FOpen(path,"write");
	FS_WriteLine(file,mvp);

	wait .05;
	FS_FClose(file);
}

loadMvpHolder()
{
	map = getdvar("mapname");

	path = "cloud/"+map+"/mvp.txt";
	if(FS_TestFile(path))
	{
		info = cloud_read(path);
		tokens = strtok(info[0],";");
		
		level.bestScores[0]["player"] = tokens[0];
		level.bestScores[0]["guid"] = tokens[1];
		level.bestScores[0]["value1"] = int(tokens[2]);
		level.bestScores[0]["value2"] = int(tokens[3]);
		level.bestscores[0]["model"] = tokens[4];
	}
}