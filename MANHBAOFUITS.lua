-- MANHBAOFRUITS-HUB
-- Auto Pick All Fruits | ESP FIX | Safe Store | Auto Hop | Thank You Text
-- FULL FIX VERSION

------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
repeat task.wait() until Player.Character
local Character = Player.Character
local HRP = Character:WaitForChild("HumanoidRootPart")
local Backpack = Player:WaitForChild("Backpack")

------------------------------------------------
-- ANTI AFK
------------------------------------------------
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

------------------------------------------------
-- SAFE STORE FRUIT
------------------------------------------------
local function SafeStoreFruit(fruitName)
    for i = 1,5 do
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", fruitName)
        end)
        task.wait(0.6)
        if not Backpack:FindFirstChild(fruitName) then
            return true
        end
    end
    return false
end

------------------------------------------------
-- CHECK STORAGE HAS FRUIT
------------------------------------------------
local function StorageHasFruit()
    local inv = ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
    for _,v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            return true
        end
    end
    return false
end

------------------------------------------------
-- ESP FRUIT (FIXED)
------------------------------------------------
local function AddFruitESP(tool)
    if not tool:IsA("Tool") then return end
    local handle = tool:FindFirstChild("Handle")
    if not handle then return end
    if handle:FindFirstChild("MANHBAO_ESP") then return end

    local bill = Instance.new("BillboardGui")
    bill.Name = "MANHBAO_ESP"
    bill.Adornee = handle
    bill.Size = UDim2.new(0,140,0,40)
    bill.AlwaysOnTop = true
    bill.StudsOffset = Vector3.new(0,2.5,0)
    bill.Parent = handle

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.Text = tool.Name
    txt.TextColor3 = Color3.fromRGB(0,170,255)
    txt.TextStrokeTransparency = 0
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.Parent = bill

    local hl = Instance.new("Highlight")
    hl.Name = "MANHBAO_ESP"
    hl.Adornee = tool
    hl.FillColor = Color3.fromRGB(0,170,255)
    hl.OutlineColor = Color3.fromRGB(255,255,255)
    hl.Parent = tool
end

------------------------------------------------
-- SERVER HOP
------------------------------------------------
local visited = {}
local function ServerHop()
    local servers = HttpService:JSONDecode(
        game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")
    )
    for _,v in pairs(servers.data) do
        if not visited[v.id] and v.playing < v.maxPlayers then
            visited[v.id] = true
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Player)
            break
        end
    end
end

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MANHBAOFRUITS-HUB"

local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0.05,0,0.4,0)
logo.Image = "rbxassetid://117706072543025"
logo.BackgroundTransparency = 1
logo.Active = true
logo.Draggable = true

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,270,0,210)
menu.Position = UDim2.new(0.35,0,0.3,0)
menu.Visible = false
menu.Active = true
menu.Draggable = true

local bg = Instance.new("ImageLabel", menu)
bg.Size = UDim2.new(1,0,1,0)
bg.Image = "rbxassetid://117706072543025"
bg.BackgroundTransparency = 1
bg.ScaleType = Enum.ScaleType.Crop

local overlay = Instance.new("Frame", menu)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency = 0.35

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1,0,0,35)
title.Text = "MANHBAOFRUITS-HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

local toggle = Instance.new("TextButton", menu)
toggle.Size = UDim2.new(0.8,0,0,45)
toggle.Position = UDim2.new(0.1,0,0.45,0)
toggle.Text = "AUTO FRUIT: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(180,0,0)
toggle.TextColor3 = Color3.new(1,1,1)

logo.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

------------------------------------------------
-- THANK YOU TEXT
------------------------------------------------
local thankGui = Instance.new("Frame", gui)
thankGui.Size = UDim2.new(0.4,0,0.18,0)
thankGui.Position = UDim2.new(0.3,0,0.15,0)
thankGui.BackgroundTransparency = 1
thankGui.Visible = false

local viText = Instance.new("TextLabel", thankGui)
viText.Size = UDim2.new(1,0,0.5,0)
viText.BackgroundTransparency = 1
viText.Text = "Cáº¢M Æ N ÄÃƒ Sá»¬ Dá»¤NG"
viText.TextColor3 = Color3.fromRGB(0,170,255)
viText.TextScaled = true
viText.TextTransparency = 1

local enText = Instance.new("TextLabel", thankGui)
enText.Size = UDim2.new(1,0,0.5,0)
enText.Position = UDim2.new(0,0,0.5,0)
enText.BackgroundTransparency = 1
enText.Text = "THANK YOU FOR USING"
enText.TextColor3 = Color3.fromRGB(0,170,255)
enText.TextScaled = true
enText.TextTransparency = 1

local function ShowThankYou()
    thankGui.Visible = true
    TweenService:Create(viText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    TweenService:Create(enText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    task.wait(2)
    TweenService:Create(viText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(enText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    task.wait(0.7)
    thankGui.Visible = false
end

------------------------------------------------
-- TOGGLE
------------------------------------------------
local AutoFarm = false
toggle.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    toggle.Text = AutoFarm and "AUTO FRUIT: ON" or "AUTO FRUIT: OFF"
    toggle.BackgroundColor3 = AutoFarm and Color3.fromRGB(0,180,0) or Color3.fromRGB(180,0,0)
    if AutoFarm then
        ShowThankYou()
    end
end)

------------------------------------------------
-- MAIN LOOP
------------------------------------------------
task.spawn(function()
    while task.wait(2) do
        if AutoFarm then

            if StorageHasFruit() then
                ServerHop()
                task.wait(6)
                continue
            end

            local fruitName = nil
            for _,v in pairs(Workspace:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Handle") then
                    AddFruitESP(v)
                    HRP.CFrame = v.Handle.CFrame
                    task.wait(0.3)
                    firetouchinterest(HRP, v.Handle, 0)
                    firetouchinterest(HRP, v.Handle, 1)
                    fruitName = v.Name
                    break
                end
            end

            if fruitName then
                repeat task.wait() until Backpack:FindFirstChild(fruitName)
                if SafeStoreFruit(fruitName) then
                    ServerHop()
                end
            else
                ServerHop()
            end

            task.wait(6)
        end
    end
end)

