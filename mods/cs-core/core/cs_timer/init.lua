--
-- Timer For CS:GO Like was made by -EISHU-
-- v0.1 (First Release)
--

ctimer = {} -- CS_TIMER must be called but this i want hehe
temporal0x3281 = nil
local modpathh = core.get_modpath(minetest.get_current_modname())
dofile(modpathh.."/cs_timer/timer.conf")

minetest.register_on_joinplayer(function(player)
timehud = player:hud_add({
  hud_elem_type = "text",
  name = "hud_timer",
  scale = {x = 1.5, y = 1.5},
  position = {x = 0.485, y = 0.05},
  offset = {x = 30, y = 100},
  size = {x = 2},
  alignment = {x = 0, y = -1},
  text = "***D:HH:MM:SS***",
  number = 0xCECECE,
})
end)

function ctimer.disp_time(time) -- 0.0
  local days = math.floor(time/86400)
  local remaining = time % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  if (hours < 10) then
    hours = "0" .. tostring(hours)
  end
  if (minutes < 10) then
    minutes = "0" .. tostring(minutes)
  end
  if (seconds < 10) then
    seconds = "0" .. tostring(seconds)
  end
  answer = tostring(days)..':'..hours..':'..minutes..':'..seconds
  return answer
end

function ctimer.reset()
run = true
local time = default_timer
-- Undeclare values...
ctimer.commence = nil -- Line 49, function that need to be nil every round that commence, later its declared again SOLVED: Number multiplier
local temporal0x3281 = nil -- Clock colors
end

function ctimer.set_timer(timer) -- timer can be optional
if timer then
default_timer = timer
else
default_timer = de_timer
end
temporal0x3281 = nil
run = true
local time = default_timer
--minetest.register_globalstep(function(dtime) -- Has too much errors
function ctimer.commence()
if not map_edit then
	time = time - DEFAULT_TIME -- Reverse action
	--print(time)
    if time == 0 then
        run = false
        annouce.winner("No winner", "Timed out has reached")
        core.after(5, cs_match.finished_match)
    end
	if time == 60 then
		coloring = 0xFF9D86
		temporal0x3281 = true
	elseif (not temporal0x3281) then
		coloring = 0xCECECE
	end
    if run then 
	--time_next = math.floor(time)
	
	timerare = ctimer.disp_time(time)
	
  for _, player in pairs(core.get_connected_players()) do
	
    if player then
  
      
        
      
        
      player:hud_change(timehud, "text", timerare)
  
  
      
  
        
      
  
      
        --hud:remove(player, "timerrrr") -- no.
    end
    
    end
	
	
	
    end
if type(ctimer.commence) == "function" then
core.after(1, ctimer.commence)
--time = time - DEFAULT_TIME -- Reverse action
--core.after(5, function() minetest.chat_send_all(minetest.colorize(coloring, timerare))  end)

end
end
end
if type(ctimer.commence) == "function" then
--  time = time - DEFAULT_TIME -- Reverse action
core.after(1, ctimer.commence)
end



end

























