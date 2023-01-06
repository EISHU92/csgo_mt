-- Only API and Menu

cs_core.main_seconds = 10
csgo = {}
csgo = {
	team = { -- All modes need a variable "inf" registered with a value "true" for valid team.
		counter = {}, -- Counter Terrorist Forces
		terrorist = {}, -- Terrorist Forces
		spectator = {}, -- When a player die. Turns into a spectator
	},
	ctl = {}, -- Current team list
	op = {}, -- Online Players, DEF_L1:::=If a player are in those three teams {c,t,s}
	pt = {}, -- Player team
	pot = {}, -- Name of team in a player ENV
	teams = {}, -- DEF:::={inf=nil}
	online = {},

}
csgo.usrTlimit = 10
cs = {}
function cs.s_t(name)
player_api.set_textures(name, "red.png")
end
function cs.s_c(name)
player_api.set_textures(name, "blue.png")
end


for team, def in pairs(csgo.team) do -- Insert
	csgo.team[team] = {count = 0, players = {}, inf = true}
	table.insert(csgo.ctl, team)
end

function csgo.send_message(message, team, player) -- Send a message to every player in the specified team.
	if (csgo.team[team].inf == true) then -- Verify team before continue.
		for aplayer, def in pairs(csgo.team[team].players) do
			if (player) then
				core.chat_send_player(aplayer, "[" .. player .. "] " .. message)
			else
				core.chat_send_player(aplayer, message)
			end
		end
	end
end

function csgo.spectator(player, reason) -- Called when he are died or directly turns into a spectator from menu
	local ttt = "spectator"
	playerr = minetest.get_player_by_name(player)
	csgo.op[player] = nil -- Disable him
	csgo.pt[player] = nil -- Disable him
	csgo.online[player] = true
	if csgo.pot[player] == "terrorist" then -- BUG FIX #1
		local tea = "terrorist"
		csgo.team[tea].count = csgo.team[tea].count - 1
		main_hud.set_main_terrorist(csgo.team[tea].count)
	else
		local tea = "counter"
		csgo.team[tea].count = csgo.team[tea].count - 1
		main_hud.set_main_counter(csgo.team[tea].count)
	end


	csgo.pot[player] = ttt

	csgo.team[ttt].count = csgo.team[ttt].count + 1
	cs_core.can_do_damage(player, "no") -- Cant put damage to playing players
	csgo.team[ttt].players[player] = true -- Put that plater in spectator-mode team. DEF:::={inf="L48", search="spectator"}
	if (reason) then
	csgo.send_message(player .. " " .. reason, ttt) -- No building auto-reasons by machine!
	end
	if cs_death.team.spectator.pos then
		poss = cs_death.team.spectator.pos
		playerr:setpos(poss)
		else
		core.log("error", "By-Core: No position for spectators found!")
	
	end
end
--print(csgo.usrTlimit)
function csgo.terrorist(player)
local ttt = "terrorist"
	if (not csgo.op[player] == true ) then
		if csgo.pot[player] == "spectator" then
		csgo.spectator(player, "joined spectators, reason: Teams Limit has reached")
		else
			playerr = minetest.get_player_by_name(player)
			
			csgo.op[player] = true
			csgo.pt[player] = true
			csgo.online[player] = true
			csgo.pot[player] = "terrorist"
			csgo.team[ttt].count = csgo.team[ttt].count + 1
			
			main_hud.set_main_terrorist(csgo.team[ttt].count)
			
			player_core.upgrade_to_mode(player, "terrorist.b3d")
			
			
			for _, player in pairs(core.get_connected_players()) do
			if player and hud:exists(player, "timerrrr") then

			function TEMP_151()
			if hud:exists(player, "timerrrr") then
			hud:remove(player, "timerrrr")
			end
			end

			core.after(1, TEMP_151)

			end
			end
				
			
			cs_core.can_do_damage(player, "yes") -- Can do damage to every player
			csgo.team[ttt].players[player] = true -- Put that plater in terrorist team. DEF:::={inf="L22", search="terrorist"}
			
			cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
			
			csgo.send_message(player .. " Joins the Terrorist forces", ttt)
			if terrorists_spawn() then
			poss = terrorists_spawn()
			playerr:setpos(poss)
			else
			minetest.log("error", "By-Core: No position for terrorists found!")
			end
		end

	end
end

function csgo.counter(player)
	if (not csgo.op[player] == true) then
	if csgo.pot[player] == "spectator" then
	csgo.spectator(player, "joined spectators, reason: Teams Limit has reached")
	else
		playerr = minetest.get_player_by_name(player)
		local ttt = "counter"
		csgo.op[player] = true
		csgo.pt[player] = true
		csgo.online[player] = true
		csgo.pot[player] = "counter"
		
		csgo.team[ttt].count = csgo.team[ttt].count + 1
		
		main_hud.set_main_counter(csgo.team[ttt].count)
		
		player_core.upgrade_to_mode(player, "counter.b3d")
		
		
		for _, player in pairs(core.get_connected_players()) do
		if player and hud:exists(player, "timerrrr") then

		function TEMP_151()
		if hud:exists(player, "timerrrr") then
		hud:remove(player, "timerrrr")
		end
		end
		
		core.after(1, TEMP_151)

		end
		end
		
		
		cs_core.can_do_damage(player, "yes") -- Can do damage to every player.
		csgo.team[ttt].players[player] = true -- Put that plater in counter team. DEF:::={inf="L48", search="counter"}
		
		cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
		
		--core.chat_send_player(player, "E2") -- debug
		csgo.send_message(player .. " Joins the Counter-Terrorist forces", ttt)
		if counters_spawn() then
		poss = counters_spawn()
		playerr:setpos(poss)
		else
		core.log("error", "By-Core: No position for counters found!")
		end
	end
	end
end



function preparenow(messa)
if (messa) then
cs_core.message = messa
else
cs_core.message = "Select Fast!! in 10 seconds this menu closes and theres no back!"
end
end
function csgo.main(name)
    local minute = cs_core.main_seconds
    local formspec = {
        "formspec_version[6]" ..
	"size[17,11]" ..
	"box[0,1.1;18.4,11;#fc0000]" ..
	"box[0,0;17.5,1.1;#ff4400]" ..
	"label[0.3,0.5;Counter Strike Like]" ..
	"label[13.9,0.5;Version: 0.1-BETA]" ..
	 "button[0,1.1;6.2,7.6;counterr;Counters Terrorists\n Bots: " .. minetest.formspec_escape(csgo.team.counter.count) .."\n Players: " .. minetest.formspec_escape(csgo.team.counter.count) .. " ]" ..
	 "button[10.8,1.1;6.2,7.6;terrorist;Terrorists\n Bots: " .. minetest.formspec_escape(csgo.team.terrorist.count) .."\n Players: " .. minetest.formspec_escape(csgo.team.terrorist.count) .. " ]"  ..
	"label[4.3,10.4; " .. minetest.formspec_escape(cs_core.message) .."]" ..
	"label[0.7,9; Theres a limit of players in every team\n Terrorists Limit: 10\n Counters Limit: 10\n]" ..
	"button[7,1.3;3,5.6;spect;Spectator]" 
    }
    
    

    return table.concat(formspec, "")
end

function empty() end







function regdie() 

for player in pairs(minetest.get_connected_players()) do
if player then
			player:set_hp(20)
end
end
end

call.register_on_end_match(function()
regdie()

end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "core:main" then
        return
    end
		
	if fields.terrorist then
        local pname = player:get_player_name()
        if not csgo.team.terrorist.count == 10 then
        var = "no teams had to join. Because teams limit reached"
        csgo.spectator(pname, var)
        else
        csgo.terrorist(pname) 
        end
        core.close_formspec(pname, "core:main")
    	
    end
    
    if fields.counterr then
        local pname = player:get_player_name()
        if not csgo.team.counter.count == 10 then
        var = "no teams had to join. Because teams limit reached"
        csgo.spectator(pname, var)
        else
        
        csgo.counter(pname)
        end
        core.close_formspec(pname, "core:main")
    end
    
    
    if fields.spect then
        local pname = player:get_player_name()
        local var = "will be a spectator, reason: no died but required from main menu."
        csgo.spectator(pname, var)
        core.close_formspec(pname, "core:main")
    end
end)



function temp(name)
    minetest.show_formspec(name, "core:main", csgo.main(name))
end
minetest.register_chatcommand("t", {
    func = function(name, param)
    	local team = csgo.pot[name]
    	if team == "counter" then
        csgo.send_message(minetest.colorize("#3491FF", "** " .. param .. " **"), team, name)
        elseif team == "terrorist" then
        csgo.send_message(minetest.colorize("#FFA900", "** " .. param .. " **"), team, name)
        elseif team == "spectator" then
        csgo.send_message(minetest.colorize("#00C200", "** " .. param .. " **"), team, name)
        end
        
    end,
})
--[[
minetest.register_chatcommand("gameee", {
    func = function(name)



    	temp(name)

        
    end,
})
]]

function terminate(var, pname) -- This has a players act

if (csgo.team.terrorist.count > csgo.team.counter.count) then
csgo.counter(pname)
end
if (csgo.team.counter.count > csgo.team.terrorist.count) then
csgo.terrorist(pname)
end
if (csgo.team.counter.count == csgo.usrTlimit and csgo.team.terrorist.count == csgo.usrTlimit) then
csgo.spectator(pname)
end
if (csgo.team.counter.count == 0 and csgo.team.terrorist.count == 0 or csgo.team.terrorist.count == csgo.team.counter.count) then
	if var == 1 then
	csgo.counter(pname)
	end
	if var == 2 then
	csgo.terrorist(pname)
	end
end

end








function doit()

term_var = math.random(1, 2)
terminate(term_var, name)
core.close_formspec(name, "core:main")

end



minetest.register_on_joinplayer(function(playerrrr)
	
	playerrrr:set_hp(20)
	
	if not map_edit then
	name = playerrrr:get_player_name()
    	preparenow()
    	core.after(1, function()
    	if csgo.team.terrorist.count == csgo.usrTlimit and csgo.team.counter.count == csgo.usrTlimit then
    	preparenow("Unavailable teams. Limit reached. Spectator Is available.\n Trying to enter in there while the limit reached will convert into a spectator")
    	end
    	 minetest.show_formspec(name, "core:main", csgo.main(name))
    	end)
    	
    	
    	minetest.register_on_player_receive_fields(function(player, formname, fields)
    	if formname == "core:main" and player == playerrrr then
        return
        else
        minetest.after(10, doit)
    	end
    	
    	end)
    	minetest.after(10, doit) -- hehe, here must be an error but its solved a long time ago in top of this file
	end

end)


function csgo.show_menu(player)
	player:set_hp(20)
	
	
	name = player:get_player_name()
    	preparenow()
    	core.after(1, function()
    	if csgo.team.terrorist.count == csgo.usrTlimit and csgo.team.counter.count == csgo.usrTlimit then
    	preparenow("Unavailable teams. Limit reached. Spectator Is available.\n Trying to enter in there while the limit reached will convert into a spectator")
    	end
    	 minetest.show_formspec(name, "core:main", csgo.main(name))
    	end)
    	
    	
    	minetest.register_on_player_receive_fields(function(player, formname, fields)
    	if formname == "core:main" and player == player then
        return
        else
        minetest.after(10, doit)
    	end
    	
    	end)
    	minetest.after(10, doit) -- hehe, here must be an error but its solved a long time ago in top of this file
end


