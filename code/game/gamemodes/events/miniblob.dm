/proc/mini_blob_event()

	//writepanic("[__FILE__].[__LINE__] (no type)([usr ? usr.ckey : ""])  \\/proc/mini_blob_event() called tick#: [world.time]")

	var/turf/T = pick(blobstart)
	var/obj/effect/blob/core/bl = new /obj/effect/blob/core(T, 200)
	spawn(0)
		bl.Life()
		bl.Life()
		bl.Life()
	blobevent = 1
	spawn(0)
		dotheblobbaby()
	spawn(3000)
		blobevent = 0
	spawn(rand(1000, 2000)) //Delayed announcements to keep the crew on their toes.
		command_alert("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert")
		for(var/mob/M in player_list)
			if(!istype(M,/mob/new_player) && M.client)
				M << sound('sound/AI/outbreak5.ogg')

/proc/dotheblobbaby()
	//writepanic("[__FILE__].[__LINE__] (no type)([usr ? usr.ckey : ""])  \\/proc/dotheblobbaby() called tick#: [world.time]")
	if (blobevent)
		if(blob_cores.len)
			for(var/i = 1 to 5)
				sleep(-1)
				if(!blob_cores.len)	break
				var/obj/effect/blob/B = pick(blob_cores)
				if(B.z != 1)
					continue
				B.Life()
		spawn(30)
			dotheblobbaby()