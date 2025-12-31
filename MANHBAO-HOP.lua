-- MANHBAO-HOP by manhbao
-- Delta Optimized | Blox Fruits

if not game:IsLoaded() then game.Loaded:Wait() end

-- Save file
if writefile and not isfile("manhbao-hop.lua") then
    writefile("manhbao-hop.lua","-- MANHBAO-HOP by manhbao")
end

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Config
local LOGO_ID = "rbxassetid://96045391302700"
local CORRECT_KEY = "MANHBAO-KEY"
local KEY_TIME = 48 * 60 * 60
local KEY_FILE = "MANHBAO_KEY.json"
local GET_KEY_LINK = "https://link4m.com/6yGePO7"

--========================
-- KEY SYSTEM
--========================
local function sign(key,time,uid)
    local s = 0
    for i = 1, #key do s += key:byte(i) end
    return tostring(s + time + uid)
end

local function saveKey()
    local t = os.time()
    writefile(KEY_FILE, HttpService:JSONEncode({
        key = CORRECT_KEY,
        time = t,
        uid = LocalPlayer.UserId,
        sig = sign(CORRECT_KEY,t,LocalPlayer.UserId)
    }))
end

local function checkKey()
    if isfile(KEY_FILE) then
        local d = HttpService:JSONDecode(readfile(KEY_FILE))
        if d.uid ~= LocalPlayer.UserId then return false end
        if d.sig ~= sign(d.key,d.time,d.uid) then return false end
        if os.time() - d.time <= KEY_TIME and d.key == CORRECT_KEY then
            return true
        end
    end
    return false
end

--========================
-- KEY UI
--========================
if not checkKey() then
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local f = Instance.new("Frame", sg)
    f.Size = UDim2.fromScale(0.32,0.32)
    f.Position = UDim2.fromScale(0.34,0.34)
    f.BackgroundColor3 = Color3.fromRGB(20,20,20)
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,0,0.22,0)
    t.Text = "MANHBAO-HOP\nby manhbao"
    t.TextScaled = true
    t.Font = Enum.Font.GothamBold
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.new(1,1,1)

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0.8,0,0.18,0)
    box.Position = UDim2.new(0.1,0,0.38,0)
    box.PlaceholderText = "Nhập key..."

    local status = Instance.new("TextLabel", f)
    status.Size = UDim2.new(1,0,0.12,0)
    status.Position = UDim2.new(0,0,0.58,0)
    status.TextScaled = true
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.fromRGB(255,120,120)

    local get = Instance.new("TextButton", f)
    get.Size = UDim2.new(0.4,0,0.16,0)
    get.Position = UDim2.new(0.1,0,0.75,0)
    get.Text = "GET KEY"

    local ok = Instance.new("TextButton", f)
    ok.Size = UDim2.new(0.4,0,0.16,0)
    ok.Position = UDim2.new(0.5,0,0.75,0)
    ok.Text = "XÁC NHẬN"

    get.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(GET_KEY_LINK) end
        status.Text = "📋 Đã copy link get key"
    end)

    ok.MouseButton1Click:Connect(function()
        if box.Text == CORRECT_KEY then
            saveKey()
            sg:Destroy()
        else
            status.Text = "❌ Key sai"
        end
    end)

    repeat task.wait() until checkKey()
end

--========================
-- HOP EFFECT
--========================
local function hop()
    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 25

    local gui = Instance.new("ScreenGui", game.CoreGui)

    local logo = Instance.new("ImageLabel", gui)
    logo.Size = UDim2.fromScale(0.22,0.22)
    logo.Position = UDim2.fromScale(0.5,0.45)
    logo.AnchorPoint = Vector2.new(0.5,0.5)
    logo.Image = LOGO_ID
    logo.BackgroundTransparency = 1

    local txt = Instance.new("TextLabel", gui)
    txt.Size = UDim2.fromScale(1,0.18)
    txt.Position = UDim2.fromScale(0,0.62)
    txt.Text = "HOP SEVER...\nMANHBAO-HOP\nby manhbao"
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1,1,1)

    task.spawn(function()
        while gui.Parent do
            TweenService:Create(logo,TweenInfo.new(1,Enum.EasingStyle.Linear),
                {Rotation = logo.Rotation + 360}):Play()
            task.wait(1)
        end
    end)

    task.wait(1.2)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

--========================
-- REDZ STYLE UI (1 TAB)
--========================
local ui = Instance.new("ScreenGui", game.CoreGui)

local toggle = Instance.new("ImageButton", ui)
toggle.Size = UDim2.fromOffset(46,46)
toggle.Position = UDim2.fromScale(0.02,0.45)
toggle.Image = LOGO_ID
toggle.BackgroundTransparency = 1

local main = Instance.new("Frame", ui)
main.Size = UDim2.fromScale(0.38,0.48)
main.Position = UDim2.fromScale(0.31,0.26)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0.14,0)
title.Text = "MANHBAO-HOP | SEVER"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

local body = Instance.new("Frame", main)
body.Size = UDim2.new(1,0,0.8,0)
body.Position = UDim2.new(0,0,0.18,0)
body.BackgroundTransparency = 1

local function btn(text,y)
    local b = Instance.new("TextButton", body)
    b.Size = UDim2.new(0.8,0,0.22,0)
    b.Position = UDim2.new(0.1,0,y,0)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local b1 = btn("HOP SEVER ÍT NGƯỜI",0.15)
b1.MouseButton1Click:Connect(hop)

local b2 = btn("HOP SEVER PING THẤP",0.5)
b2.MouseButton1Click:Connect(hop)
