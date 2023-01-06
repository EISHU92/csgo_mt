cs_match = {
	registered_matches = {},
	available_matches = {},
}

-- *C* CORE
ccore = { -- New table for a bug fix
	teams = {
	terrorist = {},
	counter = {},
	},
}

for cteam, _ in pairs(ccore.teams) do
	ccore.teams[cteam] = {players = {}, count = 0}
end


cs_match.default_matches = 15
function cs_match.register_matches(number)
if number then
cs_match.registered_matches = number
cs_match.available_matches = number
else
cs_match.registered_matches = cs_match.default_matches
cs_match.available_matches = cs_match.default_matches
end
end



function remove_hsa()
for _, player in pairs(core.get_connected_players()) do
if player and hud:exists(player, "temp000x1") then
hud:remove(player, "temp000x1")

end
end
end



function cs_match.finished_match()
	if cs_match.available_matches == 0 then
		for i = 1, #cb.registered_on_end_match do
			cb.registered_on_end_match[i]()
		end
		function finishedmatch() return true end
		print("[CORE] Starting new matches. New map... Registering some values...")
		cs_map.new_match()
		cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		
		
		
		for _, player in pairs(core.get_connected_players()) do
		if player and not hud:exists(player, "temp000x1") then
			playeree = player:get_player_name()
			core.chat_send_player(playeree, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
			hud:add(player, "temp000x1", {
			hud_elem_type = "text",
			--texture = "",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.800, y = 0.10},
			offset = {x = 30, y = 100},
			size = {x = 1.5},
			alignment = {x = 0, y = -1},
			text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
			color = 0xFF9D00,
			})
		if hud:exists(player, "timerrrr") then
		hud:remove(player, "timerrrr")
		end
		player:get_inventory():set_list("main", {})
		
		playerr = player:get_player_name()
		if (csgo.online[playerr]) then
		print("DEBUGN1")
		he_team = csgo.pot[playerr]
		csgo.op[playerr] = nil
		csgo.pt[playerr] = nil
		csgo.online[playerr] = nil
		csgo.pot[playerr] = nil
		hud:remove(playerr)
		csgo.team[he_team].count = csgo.team[he_team].count - 1
		if he_team == "terrorist" then
		main_hud.set_main_terrorist(csgo.team[he_team].count)
		end
		if he_team == "counter" then
		main_hud.set_main_counter(csgo.team[he_team].count)
		end
		csgo.team[he_team].players[playerr] = nil
		end	
		
		
		
		
		
		
		
		
		csgo.show_menu(player)
		
		
		
		
		end
		end
		
		
		
		
		if not map_edit then
		cs_buying.enable_shopping()
		core.after(1, ctimer.reset)
		core.after(20, cs_buying.disable_shopping)
		core.after(20, remove_hsa)
		core.after(20, ctimer.set_timer)
	
		core.after(3, function()
		function finishedmatch() return false end
		end)
		
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		end
		startednewmatch =  true
	
	end
	if cs_match.available_matches < 1  then
		cs_match.available_matches = cs_match.available_matches - 1
		for i = 1, #cb.registered_on_end_match do
			cb.registered_on_end_match[i]()
		end
		function finishedmatch() return true end
		print("[CORE] Normal match commenced, available: " .. cs_match.available_matches)
		--cs_map.new_match()
		--cs_death.register_spawn("all", spectators_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		for _, player in pairs(core.get_connected_players()) do
		if player and not hud:exists(player, "temp000x1") then
			playeree = player:get_player_name()
			core.chat_send_player(playeree, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
			hud:add(player, "temp000x1", {
			hud_elem_type = "text",
			--texture = "",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.800, y = 0.10},
			offset = {x = 30, y = 100},
			size = {x = 1.5},
			alignment = {x = 0, y = -1},
			text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
			color = 0xFF9D00,
			})
			player:get_inventory():set_list("main", {})
			if hud:exists(player, "timerrrr") then
				hud:remove(player, "timerrrr")
			end

			core.after(3, function()
			function finishedmatch() return false end
			end)

			if (csgo.pot[playeree] == "terrorist") then
				print("debug___")
				if terrorists_spawn() then
					poss = terrorists_spawn()
					player:setpos(poss)
				else
					minetest.log("error", "By-Core: No position for terrorists found!")
				end
			
			elseif csgo.pot[playeree] == "counter" then
				
				print("debug__2_")
				if counters_spawn() then
					poss = counters_spawn()
					player:setpos(poss)
				else
					core.log("error", "By-Core: No position for counters found!")
				end
			elseif csgo.pot[playeree] == "spectator" then
				print("debug__3_")
			end
		end
		end
		if not map_edit then
		cs_buying.enable_shopping()
		core.after(1, ctimer.reset)
		core.after(20, cs_buying.disable_shopping)
		core.after(20, ctimer.set_timer)
		core.after(20, remove_hsa)
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		end
	end

end
function cs_match.start_matches()
		print("[CORE] Starting {Maps, Values, Registers} for the server")

		cs_map.new_match()
		cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		
		if not map_edit then
		if not alreadyVAR then
		minetest.register_on_joinplayer(function(player)
		csgo.show_menu(player)
		if player and not hud:exists(player, "temp000x15") then
			playeree = player:get_player_name()
			player:get_inventory():set_list("main", {})
			core.chat_send_player(playeree, "You joined on a continued match, matches remaining: " .. cs_match.available_matches)
			minetest.chat_send_player(playeree, "Be Fast!! shop your arms before time reach!\nYou Had ".. minetest.colorize("#FF8282", "20")  .." Seconds to shop.")
		cs_buying.enable_shopping(player)
		
		core.after(35, cs_buying.disable_shopping, player)
		
		
		end
		end)
		ctimer.reset()
		core.after(35, ctimer.set_timer)
		function finishedmatch() return false end
		alreadyVAR = true
		end
		end
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		core.after(20, remove_hsa)


end
local function empty() end
minetest.register_on_dieplayer(function(player)
core.after(2, function(player)
	player:set_hp(20)
	
end, player)
if finishedmatch() then
empty()
else
local pname = player:get_player_name()
core.register_on_respawnplayer(function(obj1) -- Fixed Bug #2
	local pname = obj1:get_player_name()
	core.after(1, csgo.spectator, pname)
end)
--print(pname) -- DEBUG

if csgo.pot[pname] then -- Regret that player to his team (TABLE)
	local top = csgo.pot[pname]
	ccore.teams[top].players[pname] = true
	ccore.teams[top].count = ccore.teams[top].count + 1
end

csgo.send_message(pname .. " will be a spectator. because he died. ", "spectator")
player:set_armor_groups({immortal = 1})
minetest.set_player_privs(pname, {fly=true, fast=true, noclip=true, teleport=true}) -- Teleport Is a feature
end
end)

call.register_on_new_match(function()
for e1, aplayer in pairs(minetest.get_connected_players()) do
	if aplayer then
		if ccore.teams.terrorist.players[aplayer] == true then
			aplayert = "terrorist"
			if csgo.team.terrorist.count == 10 then
				print("[CORE] Can't put player "..aplayer.." in terrorist team, Why: team is full")
			else
				csgo.terrorist(aplayer)
			end
		end
		if ccore.teams.counter.players[aplayer] == true then
			aplayert = "terrorist"
			if csgo.team.counter.count == 10 then
			print("[CORE] Can't put player "..aplayer.." in counter team, Why: team is full")
			else
			csgo.counter(aplayer)
			end
		end
		
	
	
	end	
end
end)

minetest.register_on_leaveplayer(function(player)
local playern = player:get_player_name()
for teamn in pairs(ccore.teams) do
if ccore.teams[teamn].players[playern] == true then
	ccore.teams[teamn].players[playern] = nil
	ccore.teams[teamn].count = ccore.teams[teamn].count - 1
end
end
end)



















