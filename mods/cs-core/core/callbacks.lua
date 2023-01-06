cb = {
    registered_on_new_match = {},
    registered_on_end_match = {},
    registered_on_join_team = {},
    registered_on_end_time = {},
}
call = {}
--Register on new match
function call.register_on_new_match(func)
	table.insert(cb.registered_on_new_match, func)
end
--Register on end match
function call.register_on_end_match(func)
	table.insert(cb.registered_on_end_match, func)
end
--Register when a player join teams
function call.register_on_player_join_team(func)
	table.insert(cb.registered_on_join_team, func)
end
--Register on end time
function call.register_on_end_time(func)
	table.insert(cb.registered_on_end_time, func)
end
