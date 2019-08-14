local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

DefineClass.mrudat_LongRangeMining = {}

DefineClass.mrudat_LongRangeMining_RegolithExtractor = {
  __parents = { "mrudat_LongRangeMining" }
}

function BuildingDepositExploiterComponent:Getexploitation_radius()
  local dome = self.parent_dome or GetDomeAtPoint(self:GetPos())
  if not dome then return self:GetDefaultPropertyValue('exploitation_radius') end
  return dome:GetOutsideWorkplacesDist()
end

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
