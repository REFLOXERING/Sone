local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Settings
local unitOwner = "HermannNCorp" -- or "LocalPlayer"
local renameTo = "Sigma Dick Eraser 2000🥀💔" -- change this to the desired name

-- Determine unit path
local unit = workspace.Units:FindFirstChild(unitOwner == "LocalPlayer" and LocalPlayer.Name or unitOwner)
if not unit then return end

local mimicry = unit:FindFirstChild("Mimicry")
if not mimicry then return end

-- Set transparency of everything under Mimicry.Mimicry
local mimicModel = mimicry:FindFirstChild("Mimicry")
if mimicModel then
	for _, obj in ipairs(mimicModel:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Transparency = 1
		end
	end
end

-- Delete everything under Mimicry.mimicvfx
local mimicvfx = mimicry:FindFirstChild("mimicvfx")
if mimicvfx then
	for _, obj in ipairs(mimicvfx:GetChildren()) do
		obj:Destroy()
	end
end

-- Set all values under Abilities.AbilityNum#1.DownSlamAttack.CustomDamage to math.huge
local ability = mimicry:FindFirstChild("Abilities")
if ability then
	local ability1 = ability:FindFirstChild("AbilityNum#1")
	if ability1 then
		local downSlam = ability1:FindFirstChild("DownSlamAttack")
		if downSlam then
			local customDamage = downSlam:FindFirstChild("CustomDamage")
			if customDamage then
				for _, obj in ipairs(customDamage:GetDescendants()) do
					if obj:IsA("NumberValue") then
						obj.Value = math.huge
					end
				end
			end
		end
	end
end

-- Set all values under SettingValues to math.huge and set DamageType to "Pale"
local settings = mimicry:FindFirstChild("SettingValues")
if settings then
	for _, obj in ipairs(settings:GetDescendants()) do
		if obj:IsA("NumberValue") then
			obj.Value = math.huge
		end
	end

local settings2 = mimicry:FindFirstChild("HealOnDamage")
if settings2 then
	for _, obj in ipairs(settings2:GetDescendants()) do
		if obj:IsA("NumberValue") then
			obj.Value = math.huge
		end
	end

	local damageType = settings:FindFirstChild("DamageType")
	if damageType and damageType:IsA("StringValue") then
		damageType.Value = "Pale"
	end
end

-- Set AttackSpeed to 2
local charStats = unit:FindFirstChild("CharStats")
if charStats then
	local attackSpeed = charStats:FindFirstChild("AttackSpeed")
	if attackSpeed and attackSpeed:IsA("NumberValue") then
		attackSpeed.Value = 2
	end
end

-- Rename Mimicry to user-defined name
if renameTo ~= "" then
	mimicry.Name = renameTo
end
end