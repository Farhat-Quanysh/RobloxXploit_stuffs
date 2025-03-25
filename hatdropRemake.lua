-- credits: GEE CEE, ShownApe. 

local fph = workspace.FallenPartsDestroyHeight
local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")

local function updatestate(hat, state)
    if sethiddenproperty then
        sethiddenproperty(hat, "BackendAccoutrementState", state)
    elseif setscriptable then
        setscriptable(hat, "BackendAccoutrementState", true)
        hat.BackendAccoutrementState = state
    else
        local success = pcall(function()
            hat.BackendAccoutrementState = state
        end)
        if not success then
            error("❌ Sorry executor dont sethiddenproperty!")
        end
    end
end

local allhats = {}
for _, v in pairs(character:GetChildren()) do
    if v:IsA("Accessory") then
        table.insert(allhats, v)
    end
end

local hatPositions = {}
for _, hat in pairs(allhats) do
    local handle = hat:FindFirstChild("Handle")
    if handle then
        hatPositions[hat] = handle.CFrame 
    end
end

--fph 0/0 NaN
workspace.FallenPartsDestroyHeight = 0/0 

local locks = {}
for _, hat in pairs(allhats) do
    table.insert(locks, hat.Changed:Connect(function(p)
        if p == "BackendAccoutrementState" then
            updatestate(hat, 0)
        end
    end))
    updatestate(hat, 2)
end

local function play(id, speed, prio, weight)
    local Anim = Instance.new("Animation")
    Anim.AnimationId = "https"..tostring(math.random(1000000,9999999)).."="..tostring(id)
    local track = humanoid:LoadAnimation(Anim)
    track.Priority = prio
    track:Play()
    track:AdjustSpeed(speed)
    track:AdjustWeight(weight)
    return track
end

--animation ids
local r6fall = 180436148
local r15fall = 507767968

local dropcf = CFrame.new(hrp.Position.X, fph - 0.25, hrp.Position.Z)

if humanoid.RigType == Enum.HumanoidRigType.R15 then
    dropcf = dropcf * CFrame.Angles(math.rad(20), 0, 0)
    humanoid:ChangeState(16)
    play(r15fall, 1, 5, 1).TimePosition = 0.1
else
    play(r6fall, 1, 5, 1).TimePosition = 0.1
end

game:GetService("RunService").RenderStepped:Connect(function()
    if hrp.Parent then
        hrp.CFrame = dropcf
        hrp.Velocity = Vector3.new(0, 25, 0) 
        hrp.RotVelocity = Vector3.new(0, 0, 0)
    end
end)

task.wait(0.25)
humanoid:ChangeState(15)

torso.AncestryChanged:Wait()

for _, lock in pairs(locks) do
    lock:Disconnect()
end

for _, hat in pairs(allhats) do
    updatestate(hat, 4)
end

task.wait(0.5) 
for _, hat in pairs(allhats) do
    local handle = hat:FindFirstChild("Handle")
    if handle and hatPositions[hat] then
        handle.CFrame = hatPositions[hat] 
        handle.Velocity = Vector3.new(0, 0, 0) 
    end
end

local function hasDropped(hats)
    for _, hat in pairs(hats) do
        local handle = hat:FindFirstChild("Handle")
        if handle then
            if handle.Parent == nil or handle.Position.Y < (fph + 5) then
                return true
            end
        end
    end
    return false
end

repeat
    task.wait(0.1)
until plr.Character ~= character or hasDropped(allhats)

--[[spammy shits
if hasDropped(allhats) then
    print("✅ dropped!")
else
    print("❌ not dropped")
end
--]]
task.wait(2) 
if humanoid.Parent then
    for _, hat in pairs(allhats) do
        if hat.Parent ~= character then
            humanoid:AddAccessory(hat) 
        end
    end
end

-- task.wait(5)
workspace.FallenPartsDestroyHeight = -100 --fph

--its for permadeath 
--[[
local getMetamethodFromErrorStack=function(userdata,f,test)
	local ret=nil
	local xpcall=xpcall
	
	xpcall(f,function()
		ret=debug.info(2,"f")
	end,userdata,nil,0)
	if (type(ret)~="function") or not test(ret) then
		return f
	end
	return ret
end

local insSet=getMetamethodFromErrorStack(game,function(a,b,c) a[b]=c end,function(f) local a=i("Folder") local b=rs() f(a,"Name",b) return a.Name==b end)
local insGet=getMetamethodFromErrorStack(game,function(a,b) return a[b] end,function(f) local a=i("Folder") local b=rs() a.Name=b return f(a,"Name")==b end)

local cdsb=insGet(lp,"ConnectDiedSignalBackend")
--]]
