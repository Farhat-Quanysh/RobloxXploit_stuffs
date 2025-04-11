local uis = game:GetService("UserInputService")
local keycode = game:GetService("KeyboardService")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://17714027660" -- Replace with your actual animation ID
local animationTrack = animator:LoadAnimation(animation)

local forceField = Instance.new("ForceField")

local soundAnim = script.SpawnSound

local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(2)

local targetTransparency = 1

local glow = Instance.new("Highlight")

glow.FillColor = Color3.fromRGB(255, 255, 255)
glow.FillTransparency = 0.5
glow.OutlineTransparency = 0.5
glow.Parent = character
glow.Adornee = character

local tween = TweenService:Create(glow, tweenInfo, {FillTransparency = targetTransparency})
local tween1 = TweenService:Create(glow, tweenInfo, {OutlineTransparency = targetTransparency})

animationTrack.Looped = false

local function playAnimationLoop()
	task.wait(0.1) -- The seconds that animation starts when you spawn
	animationTrack:Play()
	soundAnim:Play()
	
	--When player press one of this keys ff disappear (ik this is a shetty way to do this, but im kinda bussy :p)
	--Here is a "F" KeyCode, if you want this script for some different game that's not BG, yk what to do 🗣
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.Touch then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.W then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.A then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.S then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.D then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.F then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)
	
	uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.Space then
			animationTrack:Stop()
			forceField:Destroy()
			glow:Destroy()
			soundAnim:Stop()
		end
	end)

	task.wait(1) -- This is for Highlight fade if you want you want a more ff effect change this (and ff countdown too)
	tween:Play()
	tween1:Play()
end --for an example, i have ff cooldown on 3 and its sincronized with that "task.wait(1)" but if you want to change it idc.

-- Start anim when... every you respawn obviously :v
playAnimationLoop()
--rbxassetid://17714603545 spawn sound
