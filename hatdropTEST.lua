-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Farhat-Quanysh/RobloxXploit_stuffs/refs/heads/main/hatdropTEST.lua"))()
-- credits to shownape
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local character = Player.Character or Player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
local shp = sethiddenproperty
local rep = replicatesignal

local allhats = {}
for _, v in pairs(character:GetChildren()) do
    if v:IsA("Accessory") then
        table.insert(allhats, v)
    end
end

local function updatestate(hat, state)
    local success, err = pcall(function()
        shp(hat, "BackendAccoutrementState", state)
    end)
    if not success then
        setscriptable(hat, "BackendAccoutrementState", true)
        hat.BackendAccoutrementState = state
    end
end

local function play(id, speed, prio, weight)
    speed = speed or 1
    prio = prio or 5
    weight = weight or 1
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(id)
    local track = humanoid:LoadAnimation(anim)
    track.Priority = prio
    track:Play()
    track:AdjustSpeed(speed)
    track:AdjustWeight(weight)
    track.TimePosition = 0.1
    return track
end

local function dropHats(selectedHats)
    selectedHats = selectedHats or allhats
    for _, hat in pairs(selectedHats) do
        updatestate(hat, 2)
    end
    local fph = workspace.FallenPartsDestroyHeight
    workspace.FallenPartsDestroyHeight = 0/0
    local dropcf = CFrame.new(hrp.Position.x, fph - 0.25, hrp.Position.z)
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        dropcf = dropcf * CFrame.Angles(math.rad(20), 0, 0)
        play(507767968, 1, 5, 1).TimePosition = 0.1
    else
        play(180436148, 1, 5, 1).TimePosition = 0.1
    end
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not hrp.Parent then
            connection:Disconnect()
            return
        end
        hrp.CFrame = dropcf
        hrp.Velocity = Vector3.new(0, 25, 0)
        hrp.RotVelocity = Vector3.new(0, 0, 0)
    end)
    task.wait(0.25)
    humanoid:ChangeState(15)
    torso.AncestryChanged:Wait()
    connection:Disconnect()
    for _, hat in pairs(selectedHats) do
        updatestate(hat, 4)
    end
    local dropped = false
    repeat
        local foundhandle = false
        for _, hat in pairs(selectedHats) do
            if hat:FindFirstChild("Handle") then
                foundhandle = true
                if hat.Handle.CanCollide then
                    dropped = true
                    break
                end
            end
        end
        if not foundhandle then
            break
        end
        task.wait()
    until not character.Parent or dropped
    workspace.FallenPartsDestroyHeight = fph
    if dropped then
        print("dropped")
    else
        print("failed to drop")
    end
end

local function permanentDeath()
    rep(Player.ConnectDiedSignalBackend)
    task.wait(Players.RespawnTime + .15)
    rep(Player.Kill)
end

-- Взлом SimulationRadius и Network Ownership
shp(Player, "ReplicationFocus", workspace)
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char then
        shp(Player, "SimulationRadius", math.huge)
        rep(Player.SimulationRadiusChanged, math.huge)
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                shp(v, "RootPriority", 1e9)
                shp(v, "PhysicsReplicationOwnership", 1)
                shp(v, "NetworkIsSleeping", false)
                rep(v.NetworkOwnerChanged, Player)
            end
        end
    end
end)

-- Запуск функций
dropHats()
permanentDeath()
