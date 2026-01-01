--=====================================================
-- MANHBAO-HOP by manhbao
-- Get Key + Server Hop + UI + Background
-- Delta Optimized
--=====================================================

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local lp = Players.LocalPlayer
local PlaceId = game.PlaceId
local BG_ID = "rbxassetid://96045391302700"

--=====================================================
-- GET KEY SYSTEM
--=====================================================
local KEY = "MANHBAO-KEY"
local KEY_TIME = 48 * 60 * 60
local SAVE_NAME = "MANHBAO_KEY.json"
local GETKEY_LINK = "https://link4m.com/6yGePO7"

local savedTime = 0
pcall(function()
    if isfile(SAVE_NAME) then
        savedTime = HttpService:JSONDecode(readfile(SAVE_NAME)).time or 0
    end
end)

if os.time() - savedTime > KEY_TIME then
    local g = Instance.new("ScreenGui", lp.PlayerGui)
    g.Name = "MANHBAO_GETKEY"
    g.ResetOnSpawn = false

    local f = Instance.new("Frame", g)
    f.Size = UDim2.new(0,360,0,240)
    f.Position = UDim2.new(0.5,-180,0.5,-120)
    f.BackgroundColor3 = Color3.fromRGB(20,20,20)
    f.BorderSizePixel = 0
    f.Active = true
    f.Draggable = true
    f.ZIndex = 5
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,14)

    -- Background GET KEY
    local bgKey = Instance.new("ImageLabel", f)
    bgKey.Size = UDim2.new(1,0,1,0)
    bgKey.Image = BG_ID
    bgKey.BackgroundTransparency = 1
    bgKey.ImageTransparency = 0.2
    bgKey.ScaleType = Enum.ScaleType.Crop
    bgKey.ZIndex = 1
    Instance.new("UICorner", bgKey).CornerRadius = UDim.new(0,14)

    local title = Instance.new("TextLabel", f)
    title.Size = UDim2.new(1,0,0,40)
    title.Text = "MANHBAO-HOP"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.ZIndex = 10

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0.8,0,0,36)
    box.Position = UDim2.new(0.1,0,0,70)
    box.PlaceholderText = "Nhập key"
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.BorderSizePixel = 0
    box.ZIndex = 10
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

    local function btn(text,y)
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(0.8,0,0,36)
        b.Position = UDim2.new(0.1,0,0,y)
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 14
        b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundColor3 = Color3.fromRGB(40,40,40)
        b.BorderSizePixel = 0
        b.ZIndex = 10
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
        return b
    end

    local getKey = btn("GET KEY (Copy Link)",120)
    local submit = btn("XÁC NHẬN KEY",170)

    getKey.MouseButton1Click:Connect(function()
        setclipboard(GETKEY_LINK)
    end)

    submit.MouseButton1Click:Connect(function()
        if box.Text == KEY then
            writefile(SAVE_NAME,HttpService:JSONEncode({time=os.time()}))
            g:Destroy()
        else
            box.Text = ""
            box.PlaceholderText = "Sai key!"
        end
    end)

    repeat task.wait() until not g.Parent
end

--=====================================================
-- MAIN UI
--=====================================================
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "MANHBAO_HOP"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,260)
main.Position = UDim2.new(0.5,-210,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 5
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- Background MENU
local bg = Instance.new("ImageLabel", main)
bg.Size = UDim2.new(1,0,1,0)
bg.Image = BG_ID
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.18
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 1
Instance.new("UICorner", bg).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "MANHBAO-HOP"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.ZIndex = 10

local sub = Instance.new("TextLabel", main)
sub.Size = UDim2.new(1,0,0,20)
sub.Position = UDim2.new(0,0,0,32)
sub.Text = "by manhbao"
sub.Font = Enum.Font.Gotham
sub.TextSize = 13
sub.TextColor3 = Color3.fromRGB(200,200,200)
sub.BackgroundTransparency = 1
sub.ZIndex = 10

local function createButton(text,y)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.8,0,0,40)
    b.Position = UDim2.new(0.1,0,0,y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.BorderSizePixel = 0
    b.ZIndex = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local hopLowPlayer = createButton("HOP SERVER ÍT NGƯỜI (1–2)", 90)
local hopLowPing   = createButton("HOP SERVER PING THẤP", 150)

-- Logo toggle menu
local toggle = Instance.new("ImageButton", gui)
toggle.Size = UDim2.new(0,45,0,45)
toggle.Position = UDim2.new(0,15,0.5,-22)
toggle.Image = BG_ID
toggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggle.BorderSizePixel = 0
toggle.ZIndex = 20
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

local open = true
toggle.MouseButton1Click:Connect(function()
    open = not open
    main.Visible = open
end)

--=====================================================
-- SERVER HOP LOGIC
--=====================================================
local function getServers()
    local servers = {}
    local cursor = ""
    repeat
        local url = "https://games.roblox.com/v1/games/"..PlaceId..
        "/servers/Public?sortOrder=Asc&limit=100"..(cursor~="" and "&cursor="..cursor or "")
        local data = HttpService:JSONDecode(game:HttpGet(url))
        for _,v in pairs(data.data) do
            table.insert(servers,v)
        end
        cursor = data.nextPageCursor
    until not cursor
    return servers
end

local function hop(mode)
    local servers = getServers()
    local best
    for _,s in pairs(servers) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            if mode=="lowplayer" and s.playing<=2 then
                best = s
                break
            elseif mode=="lowping" then
                if not best or (s.ping and s.ping < (best.ping or math.huge)) then
                    best = s
                end
            end
        end
    end
    if best then
        TeleportService:TeleportToPlaceInstance(PlaceId,best.id,lp)
    end
end

hopLowPlayer.MouseButton1Click:Connect(function()
    hop("lowplayer")
end)
hopLowPing.MouseButton1Click:Connect(function()
    hop("lowping")
end)
