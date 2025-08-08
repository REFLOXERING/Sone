local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function DownloadPenisModel()
    if not isfile("Purity.rbxm") then
        local content = "https://github.com/REFLOXERING/refloshering/raw/refs/heads/main/Purity.rbxm"
        writefile("Purity.rbxm", content)
    end
    return getcustomasset("Purity.rbxm")
end

local function ApplyPenis()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local torso = character:WaitForChild("Torso")

    if character:FindFirstChild("SGWings") then
        character.SGWings:Destroy()
    end

    local wingFolder = Instance.new("Folder")
    wingFolder.Name = "SGWings"
    wingFolder.Parent = character

     local purityModel = game:GetObjects(getcustomasset("Purity.rbxm"))[1]
    purityModel.Parent = wingFolder

    local part1 = purityModel:GetChildren()[1]  -- Left wing
    local part2 = purityModel:GetChildren()[2]  -- Center ring
    local part3 = purityModel:GetChildren()[3]  -- Right wing

    RunService.RenderStepped:Connect(function()
    if not character or not character.Parent then return end

    local i = tick() * 40  -- mimic frame count for trigonometric timing
    part1.CFrame = torso.CFrame * CFrame.new(-4, 0, 2) * CFrame.Angles(
        math.rad(90),
        math.rad(180),
        math.rad(111 + math.sin(i / 35) * 6)
    )

    part3.CFrame = torso.CFrame * CFrame.new(4, 0, 2) * CFrame.Angles(
        -math.rad(90),
        -math.rad(200),
        math.rad(-69 + math.cos(i / 35) * 6)
    )

    part2.CFrame = torso.CFrame * CFrame.new(0, 1, 1) * CFrame.Angles(0, math.rad(90), 0)
end)
end

ApplyPenis()
getgenv().Time = 0.2

-- Accessories
getgenv().Torso     = {92612229754579, 16551810512}
getgenv().RightArm  = {72355464523562}
getgenv().LeftArm   = {123388097994457}
getgenv().RightLeg  = {128214963592293}
getgenv().LeftLeg   = {81279399931975}

-- Hair Mesh Configuration
getgenv().HairMeshes = {
    {MeshId = "rbxassetid://122420182381471", Offset = Vector3.new(0, -1.18, 0.28)}, -- Special higher hair
    {MeshId = "rbxassetid://124616337236968", Offset = Vector3.new(0, -0.19, 0.28)},
    {MeshId = "rbxassetid://83881065971318", Offset = Vector3.new(0, -0.19, 0.28)},
    {MeshId = "rbxassetid://130779357951282", Offset = Vector3.new(0, -0.19, 0.28)},
}
getgenv().HairTextureId = "rbxassetid://8896881350"
getgenv().HairScale = Vector3.new(0.95, 0.95, 0.95)

-- Leg Accessories Offset for pants alignment
getgenv().LegOffset = CFrame.new(0, -0.15, 0) -- <-- Change this for pants fine-tune per leg


local function weldParts(part0, part1, c0, c1)
    local weld = Instance.new("Weld")
    weld.Part0 = part0
    weld.Part1 = part1
    weld.C0 = c0 or CFrame.new()
    weld.C1 = c1 or CFrame.new()
    weld.Parent = part0
    return weld
end

local function findAttachment(rootPart, name)
    for _, desc in ipairs(rootPart:GetDescendants()) do
        if desc:IsA("Attachment") and desc.Name == name then
            return desc
        end
    end
end

local function addAccessoryToCharacter(accessoryId, parentPart, offsetCFrame)
    local accessory = game:GetObjects("rbxassetid://" .. accessoryId)[1]
    if not accessory then return end

    accessory.Parent = workspace
    local handle = accessory:FindFirstChild("Handle")
    if handle then
        handle.CanCollide = false
        local accAttach = handle:FindFirstChildOfClass("Attachment")
        local parentAttach = accAttach and findAttachment(parentPart, accAttach.Name)
        if parentAttach then
            local c0 = parentAttach.CFrame * (offsetCFrame or CFrame.new())
            weldParts(parentPart, handle, c0, accAttach.CFrame)
        else
            local ap = accessory:FindFirstChild("AttachmentPoint")
            local fallbackC0 = (offsetCFrame or CFrame.new()) * CFrame.new(0, 0.5, 0)
            if ap then
                weldParts(parentPart, handle, fallbackC0, ap.CFrame)
            else
                weldParts(parentPart, handle, fallbackC0, CFrame.new())
            end
        end
    end
    accessory.Parent = game.Players.LocalPlayer.Character
end

local function addHairMeshes(character)
    local head = character:FindFirstChild("Head")
    if not head then return end

    for _, hair in ipairs(getgenv().HairMeshes) do
        local part = Instance.new("Part")
        part.Name = "CustomHair"
        part.Size = Vector3.new(1, 1, 1)
        part.Anchored = false
        part.CanCollide = false
        part.Transparency = 0
        part.Color = Color3.new(0, 0, 0)
        part.Parent = character

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = hair.MeshId
        mesh.TextureId = getgenv().HairTextureId
        mesh.Scale = getgenv().HairScale
        mesh.Parent = part

        local attachment = head:FindFirstChild("HairAttachment") or head:FindFirstChild("HatAttachment")
        if attachment then
            weldParts(head, part, attachment.CFrame * CFrame.new(hair.Offset), CFrame.new())
        else
            weldParts(head, part, CFrame.new(0, 0.5, 0) * CFrame.new(hair.Offset), CFrame.new())
        end
    end
end

local function loadAccessories(character)

   -- Torso
    local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
    if torso then
        for _, id in ipairs(getgenv().Torso) do
            addAccessoryToCharacter(id, torso)
        end
    end

    -- Right Arm
    local rArm = character:FindFirstChild("RightUpperArm") or character:FindFirstChild("Right Arm")
    if rArm then
        for _, id in ipairs(getgenv().RightArm) do
            addAccessoryToCharacter(id, rArm)
        end
    end

    -- Left Arm
    local lArm = character:FindFirstChild("LeftUpperArm") or character:FindFirstChild("Left Arm")
    if lArm then
        for _, id in ipairs(getgenv().LeftArm) do
            addAccessoryToCharacter(id, lArm)
        end
    end

    -- Right Leg (pants layering)
    local rLeg = character:FindFirstChild("RightUpperLeg") or character:FindFirstChild("Right Leg")
    if rLeg then
        for _, id in ipairs(getgenv().RightLeg) do
            addAccessoryToCharacter(id, rLeg, getgenv().LegOffset)
        end
    end

    -- Left Leg (pants layering)
    local lLeg = character:FindFirstChild("LeftUpperLeg") or character:FindFirstChild("Left Leg")
    if lLeg then
        for _, id in ipairs(getgenv().LeftLeg) do
            addAccessoryToCharacter(id, lLeg, getgenv().LegOffset)
        end
    end
end

local function loadClothing()
    local char = game.Players.LocalPlayer.Character
    pcall(function() char.Pants:Destroy() end)
    pcall(function() char.Shirt:Destroy() end)

    local pants = Instance.new("Pants")
    pants.Parent = char
    pants.PantsTemplate = 'rbxassetid://6139818848'
    pants.Name = 'Pants'

    local shirt = Instance.new("Shirt")
    shirt.Parent = char
    shirt.ShirtTemplate = 'rbxassetid://10879148718'
    shirt.Name = 'Shirt'
end

local function changeFace(character)
    local head = character:FindFirstChild("Head")
    if head then
        local oldFace = head:FindFirstChildWhichIsA("Decal")
        if oldFace then
            oldFace:Destroy()
        end

        local newFace = Instance.new("Decal")
        newFace.Name = "face"
        newFace.Texture = "rbxassetid://78728386579541"
        newFace.Face = Enum.NormalId.Front
        newFace.Parent = head
    end
end

local layeredTShirtPositionOffset = Vector3.new(0, 0, 0) -- Adjust Position (X, Y, Z)
local layeredTShirtRotationOffset = Vector3.new(0, 0, math.rad(120)) -- Rotate 120 degrees around Z axis

local function addLayeredTShirt(character)
    local torso = character:FindFirstChild("Torso")
    if not torso then return end

    local accessory = Instance.new("Accessory")
    accessory.Name = "LayeredTShirt"

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.Transparency = 1
    handle.Anchored = false
    handle.CanCollide = false
    handle.Parent = accessory

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://103966884300378"
    mesh.TextureId = "rbxassetid://17733296405"
    mesh.Scale = Vector3.new(1.1, 1.1, 1.1)  -- Slightly smaller to prevent clipping
    mesh.Parent = handle

    local weld = Instance.new("Weld")
    weld.Part0 = torso
    weld.Part1 = handle
    weld.C0 = CFrame.new(layeredTShirtPositionOffset) * CFrame.Angles(layeredTShirtRotationOffset.X, layeredTShirtRotationOffset.Y, layeredTShirtRotationOffset.Z)
    weld.Parent = handle

    accessory.Parent = character
end

local function setSkinColor(character, color)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "Handle" then
            if part.Name ~= "Head" or not part:FindFirstChildOfClass("Decal") then
                part.Color = color
                part.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end

local function onCharacterAdded(character)
    if character:GetAttribute("ChangesApplied") then
        return
    end

    character:SetAttribute("ChangesApplied", true)

    task.wait(getgenv().Time)

    loadAccessories(character)
    loadClothing()
    addLayeredTShirt(character)
    setSkinColor(character, Color3.new(1, 1, 1))
end

local function onCharacterDied()
    local character = game.Players.LocalPlayer.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            lastDeathPosition = root.Position
        end
    end
end

-- Character Respawn Handling
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").Died:Connect(onCharacterDied)
    onCharacterAdded(char)
end)

if game.Players.LocalPlayer.Character then
    local char = game.Players.LocalPlayer.Character
    char:WaitForChild("Humanoid").Died:Connect(onCharacterDied)
    onCharacterAdded(char)

end
