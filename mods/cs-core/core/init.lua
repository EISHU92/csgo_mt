local modpath = core.get_modpath(minetest.get_current_modname())
-- Core 1 Dofiles

version = "V0.5.7-ALPHA"

--Cores
dofile(modpath.."/core3.lua") -- 3ND CORE --- Player Customise
dofile(modpath.."/core1.lua") -- Primary Core

--Core1 dofiles
dofile(modpath.."/cooldown.lua") -- CoolDown MINI-API
dofile(modpath.."/api.lua") -- API
dofile(modpath.."/l_j.lua") -- Leave/Join.
dofile(modpath.."/callbacks.lua") -- Callbacks

dofile(modpath.."/core2.lua") -- Secondary Core




dofile(modpath.."/alias.lua") -- Aliases


--MODS in core
dofile(modpath.."/cs_match/init.lua")
dofile(modpath.."/cs_timer/init.lua")