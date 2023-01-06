-- BY EISHU
main_hud = {
	terrorist = {},
	counter = {},


}
hud = mhud.init()
minetest.register_on_joinplayer(function(player)
if not hud:exists(player, "terrorist") then




if main_hud.terrorist.number then
hud:add(player, "terrorist", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.409, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_terrorists"..main_hud.terrorist.number..".png",
})
else
hud:add(player, "terrorist", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.409, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_terrorists.png",
})
end



end
if not hud:exists(player, "counter") then

if main_hud.counter.number then
hud:add(player, "counter", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.560, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_counters"..main_hud.counter.number..".png",
})
else
hud:add(player, "counter", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.560, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_counters.png",
})
end

end
end)
function main_hud.set_main_terrorist(number)
for _, player in pairs(core.get_connected_players()) do
hud = mhud.init()
if player then
if not hud:exists(player, "terrorist") then
hud:add(player, "terrorist", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.409, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_terrorists"..number..".png",
})
main_hud.terrorist.number = number
else



hud:change(player, "terrorist", {text = "cmh_terrorist.png"})
main_hud.terrorist.number = number




end
end
end
end

function main_hud.set_main_counter(number)
for _, player in pairs(core.get_connected_players()) do
hud = mhud.init()
if player then
if not hud:exists(player, "counter") then

hud:add(player, "counter", {
hud_elem_type = "image",
scale = {x = 1.5, y = 1.5},
position = {x = 0.560, y = 0},
offset = {x = 30, y = 100},
--size = {x = 2},
alignment = {x = 0, y = -1},
text = "cmh_counters"..number..".png",
})
main_hud.counter.number = number
else


hud:change(player, "counter", {text = "cmh_counter.png"})
main_hud.counter.number = number


end
end
end
end
