--By EISHU
central = {}
cs_buying = {}
local modpath = core.get_modpath(minetest.get_current_modname())


--Banks

minetest.register_on_joinplayer(function(player)
local playerare={name=player:get_player_name()}
bank.place_values(playerare.name)
money = playerv.money
end)


function central.preparee(pname)
bank.place_values(pname)
money = playerv.money
end





function central.load(pname, formname, formspec)
bank.place_values(pname)
money = playerv.money
minetest.show_formspec(pname, formname, formspec)
end

--Dofiles...
dofile(modpath.."/pistol.lua")
dofile(modpath.."/ammo.lua")
dofile(modpath.."/shotguns.lua")


--Disable and change to normal when maked successfully.




function central.main(name)
    local moneyr = money
    local formspec = {
        "formspec_version[6]" ..
	"size[10.2,11]" ..
	"box[0,0;6.2,1;#00bfff]" ..
	"box[6.2,0;5.2,1;#00cc00]" ..
	"button[0.2,1.3;3,1.6;rifle;Rifles]" ..
	"button[3.2,1.3;3,1.6;pistol;Pistols]" ..
	"button[0.2,2.9;3,1.6;grenade;Grenades]" ..
	"button[0.2,6.1;3,1.6;sniper;Snipers]" ..
	"button[0.2,4.5;3,1.6;armor;Armors]" ..
	"button[3.2,2.9;3,1.6;shotgun;Shotguns]" ..
	"button[3.2,4.5;3,1.6;smg;Smgs]" ..
	"button[3.2,6.1;3,1.6;ammo;Ammunations]" ..
	"list[current_player;main;0.2,8.5;8,2;0]" ..
	"label[4.4,8.1;Inventory]" ..
	"label[2.3,0.5;Shop & Menu]" ..
	"label[6.3,0.5;Total Money:]" ..
	"label[8.7,0.5;  " .. moneyr .. "]" ..
	"box[6.5,1.3;3.4,1.4;#800000]" ..
	"button[6.7,1.6;3,0.8;exit;Exit from the game]" ..
	"button_exit[6.7,6.1;3,1.6;eee;Exit (ESC)]"
    }

    return table.concat(formspec, "")
end


function central.show_to(name)
    minetest.show_formspec(name, "central:shop", central.main(name))
end

minetest.register_chatcommand("game", {
    func = function(name)
    	central.preparee(name)
        central.show_to(name)
    end,
})



minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "" then
        return
    end
    
    local playerr = player:get_player_name()
    bank.place_values(playerr)
	money = playerv.money
		
	if fields.ammo then
        local pname = player:get_player_name()
        minetest.show_formspec(pname, "central:ammo", central.ammo(name)) -- Load Ammo shopping
    	
    end
    
    if fields.pistol then
        local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:pistol", central.pistol(name)) -- Load Pistols shopping
    end
    if fields.shotgun then
    local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:shotgun", central.shotgun(name)) -- Load Pistols shopping
    end
    
    if fields.exit then
        local pname = player:get_player_name()
        minetest.kick_player(pname, "Exiting of the game.....")
    end
end)

if not map_edit then
minetest.register_on_joinplayer(function(player)


player:set_inventory_formspec(central.main(player))


end)
end


if not map_edit then



function central.fmain(name)
local formspec = {
	"formspec_version[6]" ..
	"size[0,0]" 
	}
return table.concat(formspec, "")
end

function cs_buying.enable_shopping(player)
if player then
	
	player:set_inventory_formspec(central.main(player))
	
	else
		for _, player in pairs(core.get_connected_players()) do
		--local playerr = core.get_player_by_name(player)
		player:set_inventory_formspec(central.main(player))
		end
	end
end

function cs_buying.disable_shopping(player)
	if player then
	
	player:set_inventory_formspec(central.fmain(player))
	
	else
		for _, player in pairs(core.get_connected_players()) do
		--local playerr = core.get_player_by_name(player)
		player:set_inventory_formspec(central.fmain(player))
		end
	end
end





end