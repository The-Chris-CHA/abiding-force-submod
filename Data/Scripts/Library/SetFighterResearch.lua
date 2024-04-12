--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Jorritkarwehr
--*   @Date:                2018-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            SetFighterResearch.lua
--*   @Last modified by:    [TR]Jorritkarwehr
--*   @Last modified time:  2020-05-21T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("HeroFighterLibrary")

function Set_Fighter_Research(rtype)
	local levels = GlobalValue.Get("FIGHTER_RESEARCH")
	if levels == nil then
		levels = {}
	end
	for index, obj in pairs(levels) do
		if obj == rtype then
			return
		end
	end
	table.insert(levels, rtype)
	GlobalValue.Set("FIGHTER_RESEARCH", levels)
end

function Clear_Fighter_Research(rtype)
	local levels = GlobalValue.Get("FIGHTER_RESEARCH")
	if levels == nil then
		return
	end
	for index, obj in pairs(levels) do
		if obj == rtype then
			table.remove(levels, index)
			GlobalValue.Set("FIGHTER_RESEARCH", levels)
			return
		end
	end
end

function Get_Fighter_Research(rtype)
	local levels = GlobalValue.Get("FIGHTER_RESEARCH")
	if levels == nil then
		return false
	end
	for index, obj in pairs(levels) do
		if obj == rtype then
			return true
		end
	end
	return false
end

function Set_Fighter_Hero(hero, host)
	local heroes = GlobalValue.Get("HERO_FIGHTERS")
	local hosts = GlobalValue.Get("HERO_FIGHTER_HOSTS")
	if heroes == nil then
		heroes = {}
		hosts = {}
	end
	local set = false
	for index, obj in pairs(heroes) do
		if obj == hero then
			hosts[index] = host
			set = true
		end
	end
	if not set then
		table.insert(heroes, hero)
		table.insert(hosts, host)
	end
	GlobalValue.Set("HERO_FIGHTERS", heroes)
	GlobalValue.Set("HERO_FIGHTER_HOSTS", hosts)
end

function Clear_Fighter_Hero(hero)
	local heroes = GlobalValue.Get("HERO_FIGHTERS")
	local hosts = GlobalValue.Get("HERO_FIGHTER_HOSTS")
	if heroes == nil then
		return
	end
	for index, obj in pairs(heroes) do
		if obj == hero then
			table.remove(heroes, index)
			table.remove(hosts, index)
			GlobalValue.Set("HERO_FIGHTERS", heroes)
			GlobalValue.Set("HERO_FIGHTER_HOSTS", hosts)
			return
		end
	end
end

function Get_Fighter_Hero(hero)
	local heroes = GlobalValue.Get("HERO_FIGHTERS")
	local hosts = GlobalValue.Get("HERO_FIGHTER_HOSTS")
	if heroes == nil then
		return nil
	end
	for index, obj in pairs(heroes) do
		if obj == hero then
			return hosts[index]
		end
	end
	return nil
end

function Transfer_Fighter_Hero(host1, host2)
	local heroes = GlobalValue.Get("HERO_FIGHTERS")
	local hosts = GlobalValue.Get("HERO_FIGHTER_HOSTS")
	if heroes == nil then
		return
	end
	for index, obj in pairs(hosts) do
		if obj == host1 then
			hosts[index] = host2
		end
	end
	GlobalValue.Set("HERO_FIGHTER_HOSTS", hosts)
end

function Upgrade_Fighter_Hero(hero1, hero2)
	local heroes = GlobalValue.Get("HERO_FIGHTERS")
	if heroes == nil then
		return
	end
	for index, obj in pairs(heroes) do
		if obj == hero1 then
			heroes[index] = hero2
		end
	end
	GlobalValue.Set("HERO_FIGHTERS", heroes)
end

--Set a hero to a host if it exists
--Note that the lists are indexed by the assign dummy, not the squadron itself
--Target owner of nil will match any faction
--param keep_existing == true will keep target hero with current host if current host exists
function Set_To_First_Extant_Host(setter_object, target_owner, keep_existing)
	local hero_entry = Get_Hero_Entries(setter_object)
	
	if keep_existing then
		local current_host = Find_First_Object(Get_Fighter_Hero(hero_entry.Hero_Squadron))
		
		if TestValid(current_host) then
			local current_host_owner = current_host.Get_Owner()
			
			if current_host_owner == target_owner then
				return true
			end
		end
	end
	
	for option, alternates in pairs(hero_entry.Options) do
		for index, obj in pairs(alternates.Locations) do
			checkObject = Find_First_Object(obj)
			if TestValid(checkObject) then
				if target_owner == nil or checkObject.Get_Owner() == target_owner then
					Set_Fighter_Hero(hero_entry.Hero_Squadron,obj)
					return true
				end
			end
		end
	end
	return false
end
