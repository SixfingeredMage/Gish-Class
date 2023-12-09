---@diagnostic disable: undefined-global

local function TryGetResource(entityGuid, resourceGuid)
    local entity = Ext.Entity.Get(entityGuid)
    _P("Entity found.\n")
    if entity then
      local resource = entity.ActionResources.Resources[resourceGuid]
        if resource then
            return resource["1"].Amount
        end
    end
    return 0
end

function PsionicEnergyDieSize(guid)
    local success, base = pcall(TryGetResource, guid, "69657fb8-c730-400e-abf8-3f4c91d9051c")
    _P("Output from TryGetResource: " .. base .. "\n")
    return success and base or 0
end

-- function Osi.GetActionResourceValuePersonal(player, resourceName, resourceLevel) end

--- function Osi.CombatEnded(combatGuid) end 
--- Use later for losing rage

---@param character GUIDSTRING
---@param status string
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(character, status, _, _)
    if status == "SM_PSIONIC_ENERGY_DIE_CHECKER_IGNORE_RESTING" and Osi.IsPlayer(character) == 1 then
        local psionic_energy_die_size = math.floor(PsionicEnergyDieSize(character))
        local becauseSEIsDumb = "SM_PsionicEnergyDie" .. psionic_energy_die_size
         for i = 0, 6 do
            local passive = string.format("SM_PsionicEnergyDie%d", i)
            if HasPassive(character, passive) == 1 then
                RemovePassive(character, passive)
            end
        end
        _P(passive)
        _P(becauseSEIsDumb)
        _P(character .. " " .. psionic_energy_die_size)
        Osi.AddPassive(character, becauseSEIsDumb)
    end
end) 

--Ext.Osiris.RegisterListener("EnteredTrigger", 2, "before", function (character, _)
	--if	Osi.HasPassive(character,"SM_BarbarianRage") == 1 and Osi.IsPlayer(character) == 1 then
    --local current_rage = math.floor(RageMeter(character))
   -- local becauseSEIsDumb = "ENRAGED" .. current_rage
	--	  Osi.AddPassive(character, becauseSEIsDumb)
    --end
--end)

--@param item CHARACTER
--@param resourceName string

---@param ratingOwner CHARACTER
---@param ActionResource GUIDSTRING
---@param NewActionResourceAmount integer
--function Osi.ActionResourcesChanged(Character, ActionResource, NewActionResourceAmount) end

--ext.NewEvent("(ActionResourcesChanged,)")


--WatchedVariables = {
--    a = 5,
 --   b = 22,
--}
--WatchedVariables_cache = {}
--for k,v in pairs(WatchedVariables) do
--    WatchedVariables_cache[k] = v
--end

--function OnFrame()
 --   print("NEXT FRAME! (possibly 1 second later or something)")
 --   for k,v in pairs(WatchedVariables) do
  --      local v_old = WatchedVariables_cache[k]
  --      if v ~= v_old then
            -- this is the "callback"
   --         print(tostring(k).." changed from "..tostring(v_old).." to "..tostring(v))

    --        WatchedVariables_cache[k] = v
   --     end
 --    end
 --end

 --function SomeFunctionThatOperatesSomeTime()
  --   print("about to change a, brother!")
   --  WatchedVariables.a = -7
   --  print("a is changed")
 --end