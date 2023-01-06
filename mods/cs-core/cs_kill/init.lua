
cs_kill = {
	var = {
		killed_players = {},
		alive_players = {},
	},
	null = {}, -- Not used var
	
	main_seconds = 10,
	
	 -- CoolDowns.
	
	cooldown1 = {}, -- Cooldown 1
	cooldown2 = {}, -- Cooldown 2
	cooldown3 = {}, -- Cooldown 3
	cooldown4 = {}, -- Cooldown 4
	cooldown5 = {}, -- Cooldown 5
}

for cs_coret, def in pairs(cs_kill.var) do -- Insert
	cs_kill.var[cs_coret] = {count = 0, counter = 0, terrorist = 0}
	table.insert(cs_kill.null, cs_coret) -- Null.
end
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	pname = hitter:get_player_name()
	victim = player:get_player_name()
	if (cs_core.ask_can_do_damage(pname) == false) then
		if not hud:exists(pname, "kill") then
			hud:add(pname, "kill", {
				hud_elem_type = "text",
				position = {x = 0.5, y = 0.5},
				offset = {x = 0, y = 45},
				alignment = {x = "center", y = "down"},
				text = "You can't damage others players!!",
				color = 0xFFC107,
			})
		else
			if hud:exists(pname, "kill") then
			hud:change(pname, "kill", {text = "You can't damage others players!!", color = 0xFFC107})
			end
		end
		
		function temporal()
			if hud:exists(pname, "kill") then
				hud:remove(pname, "kill")
			end
		end
		
		core.after(1.5, temporal)
	
	
	
	player:set_hp(player:get_hp() + damage)
	
	
	
	elseif (csgo.pot[pname] == csgo.pot[victim]) then
		if not hud:exists(pname, "kill") then
			hud:add(pname, "kill", {
				hud_elem_type = "text",
				position = {x = 0.5, y = 0.5},
				offset = {x = 0, y = 45},
				alignment = {x = "center", y = "down"},
				text = victim .. " its your teammate! ( ! )",
				color = 0xDC3545,
			})
		else
			if hud:exists(pname, "kill") then
				hud:change(pname, "kill", {text = victim .. " its your teammate! ( ! )", color = 0xDC3545})
			end
		
		end
	
	
		function temporal()
			if hud:exists(pname, "kill") then
				hud:remove(pname, "kill")
			end
		end
		
		
		core.after(1.5, temporal)
	--player:set_hp(player:get_hp() + damage) --[Friendly Shot enabled. So this is commented, uncomment to disable Friendly Shot.]
	end
	
	if (player:get_hp() > 0 and player:get_hp() - damage <= 0) then
	
	
		if (csgo.pot[pname] ~= csgo.pot[victim]) then
			local var5 = csgo.pot[victim]
			local var4 = csgo.pot[pname]
			
			cs_kill.var.killed_players[var5] = cs_kill.var.killed_players[var5] + 1
			cs_kill.var.alive_players[var5] = cs_kill.var.alive_players[var5] - 1
			
			local tovc = csgo.team[var5].count
			local tovc_TEMP = csgo.team[var5].count - 1
			local tokc_TEMP = csgo.team[var4].count - 1
			local tokc = csgo.team[var4].count
			
			if cs_kill.var.killed_players[var5] == tokc and cs_kill.var.killed_players[var4] == tovc_TEMP then
			mess = "The only one that killed the last enemy player, " .. pname
			cs_match.finished_match()
			annouce.winner(var4, mess) -- cs_annouce
			elseif cs_kill.var.killed_players[var5] == tovc and cs_kill.var.killed_players[var4] == 0 then
			mess = "Nobody in team " .. var4 .. " dint die in this round! WOW!"
			cs_match.finished_match()
			annouce.winner(var4, mess)
			elseif cs_kill.var.killed_players[var5] == tovc_TEMP and csgo.pot[pname] == csgo.pot[victim] then
			mess = "A player in " .. var5 .. " killed his all teammates..." -- LOL
			cs_match.finished_match()
			annouce.winner(var4, mess)
			end
			
			
			
			
			
			
		end
	
	
	end
end)