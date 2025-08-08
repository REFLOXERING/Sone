local function downloadFile(path, link)
    if not isfile(path) then
        print("Downloading: "..path)
        local content = game:HttpGet(link)
        writefile(path, content)
    end
end
local function morph()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local char = LocalPlayer.Character

    local NewCharacter = game:GetObjects(getcustomasset("HAXORwithepicsword.rbxm"))[1]

    for _, v in pairs(NewCharacter:GetChildren()) do
        if v:IsA("Part") then
            local targetPart = char:FindFirstChild(v.Name)
            if targetPart then
                v.Anchored = false
                v.Massless = true
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
                v.Parent = targetPart
                local motor = Instance.new("Motor6D")
                motor.Part0 = targetPart
                motor.Part1 = v
                motor.C0 = CFrame.new()
                motor.C1 = CFrame.new()
                motor.Name = "MorphMotor" .. v.Name
                motor.Parent = targetPart
            end
        end
    end
    task.spawn(function()
        local a = RunService.RenderStepped:Connect(function()
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("Part") then
                    v.Transparency = 1
                end
            end
        end)
        repeat task.wait() until char:FindFirstChildOfClass("Humanoid").Health <= 0
        a:Disconnect()
    end)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Accessory") or v.Name == "face" then
            v:Destroy()
        end
    end
end
if not isfile("HAXORwithepicsword.rbxm") then
    downloadFile("HAXORwithepicsword.rbxm", "https://github.com/kittysufferseveryday/iddkkk/raw/refs/heads/main/HAXORwithepicsword.rbxm")
end
morph()