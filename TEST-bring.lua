-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Farhat-Quanysh/RobloxXploit_stuffs/refs/heads/main/TEST-bring.lua"))()
local uis = game:GetService("UserInputService")
local cg = game:GetService("CoreGui")
local p = game:GetService("Players")
local lp = p.LocalPlayer

local sgui = Instance.new("ScreenGui", cg)
sgui.Name = "Bring by Farhat"

local f = Instance.new("Frame", sgui)
f.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
f.Size = UDim2.new(0, 200, 0, 120)
f.Position = UDim2.new(0.5, -100, 0.5, -60)
f.Active = true
f.Draggable = true

local tb = Instance.new("TextBox", f)
tb.Size = UDim2.new(1, -10, 0, 30)
tb.Position = UDim2.new(0, 5, 0, 5)
tb.PlaceholderText = "USERNAME \ DISPLAYNAME"
tb.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
tb.TextColor3 = Color3.new(1,1,1)
tb.ClearTextOnFocus = false
tb.Text = ""

local fire = Instance.new("TextButton", f)
fire.Size = UDim2.new(0.5, -7, 0, 30)
fire.Position = UDim2.new(0, 5, 1, -35)
fire.BackgroundColor3 = Color3.new(0, 0.6, 0)
fire.Text = "Fire"
fire.TextColor3 = Color3.new(1,1,1)

local closee = Instance.new("TextButton", f)
closee.Size = UDim2.new(0.5, -7, 0, 30)
closee.Position = UDim2.new(0.5, 2, 1, -35)
closee.BackgroundColor3 = Color3.new(0.6, 0, 0)
closee.Text = "X"
closee.TextColor3 = Color3.new(1,1,1)

fire.MouseButton1Click:Connect(function()
    local t = tb.Text
    for _,plr in next, p:GetPlayers() do
        if plr ~= lp and plr.Character and (plr.Name:lower():find(t:lower()) or plr.DisplayName:lower():find(t:lower())) then
            for _,v in next, plr.Character:GetChildren() do
                if v:IsA("Accessory") and v:FindFirstChild("Handle") then
                    local s = v:FindFirstChildWhichIsA("BackendAccoutrementState", true)
                    if s then
                        sethiddenproperty(s, "State", 0)
                        -- временно отключено:
                        -- if v:FindFirstChild("ServerEquipAccoutrement") then
                        --     replicatesignal(v.ServerEquipAccoutrement)
                        -- end
                        task.wait(.1)
                        sethiddenproperty(s, "State", 2)
                    end
                end
            end
        end
    end
end)

closee.MouseButton1Click:Connect(function()
    sgui:Destroy()
end)
