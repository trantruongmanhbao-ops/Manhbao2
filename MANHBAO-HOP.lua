
--========================
-- MANHBAO-HOP by manhbao
-- Delta Optimized
--========================

if not game:IsLoaded() then game.Loaded:Wait() end

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Config
local PLACE_ID = game.PlaceId
local SAVE_FILE = "MANHBAO_KEY.json"
local CORRECT_KEY = "MANHBAO-KEY"
local KEY_DURATION = 48 * 60 * 60
local GET_KEY_LINK = "https://link4m.com/6yGePO7"
local LOGO_ID = "rbxassetid://96045391302700"

--========================
-- KEY SYSTEM
--========================
local function makeSignature(key, time, uid)
    local raw = key .. time .. uid
    local sum = 0
    for i = 1, #raw do
        sum += string.byte(raw, i)
    end
    return tostring(sum)
end

local function saveKey()
    if writefile then
        local now = os.time()
        local data = {
            key = CORRECT_KEY,
            time = now,
            uid = LocalPlayer.UserId,
            sig = makeSignature(CORRECT_KEY, now, LocalPlayer.UserId)
        }
        writefile(SAVE_FILE, HttpService:JSONEncode(data))
    end
end

local function getKeyStatus()
    if isfile and isfile(SAVE_FILE) then
        local data = HttpService:JSONDecode(readfile(SAVE_FILE))
        if data.uid ~= LocalPlayer.UserId then return "invalid" end
        if data.sig ~= makeSignature(data.key, data.time, data.uid) then return "invalid" end
        if data.key == CORRECT_KEY then
            if os.time() - data.time <= KEY_DURATION then
                return "valid"
            else
                return "expired"
            end
        end
    end
    return "none"
end

--========================
-- KEY GUI
--========================
local keyStatus = getKeyStatus()
if keyStatus ~= "valid" then
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "MANHBAO_KEY_GUI"

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.fromScale(0.3,0.3)
    frame.Position = UDim2.fromScale(0.35,0.35)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0.25,0)
    title.Text = "MANHBAO-HOP"
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.TextScaled = true

    local sub = Instance.new("TextLabel", frame)
    sub.Size = UDim2.new(1,0,0.15,0)
    sub.Position = UDim2.new(0,0,0.22,0)
    sub.Text = "by manhbao"
    sub.TextColor3 = Color3.fromRGB(200,200,200)
    sub.BackgroundTransparency = 1
    sub.TextScaled = true

    local box = Instance.new("TextBox", frame)
    box.PlaceholderText = "Nhập key..."
    box.Size = UDim2.new(0.8,0,0.18,0)
    box.Position = UDim2.new(0.1,0,0.45,0)
    box.Text = ""

    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1,0,0.15,0)
    status.Position = UDim2.new(0,0,0.65,0)
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.fromRGB(255,120,120)
    status.TextScaled = true

    if keyStatus == "expired" then
        status.Text = "🔒 Key đã hết hạn, vui lòng get key lại!"
    elseif keyStatus == "invalid" then
        status.Text = "⚠️ File key không hợp lệ!"
    end

    local getKey = Instance.new("TextButton", frame)
    getKey.Text = "GET KEY"
    getKey.Size = UDim2.new(0.4,0,0.15,0)
    getKey.Position = UDim2.new(0.1,0,0.82,0)

    local submit = Instance.new("TextButton", frame)
    submit.Text = "XÁC NHẬN"
    submit.Size = UDim2.new(0.4,0,0.15,0)
    submit.Position = UDim2.new(0.5,0,0.82,0)

    getKey.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(GET_KEY_LINK) end
        status.Text = "📋 Đã copy link get key"
    end)

    submit.MouseButton1Click:Connect(function()
        if box.Text == CORRECT_KEY then
            saveKey()
            sg:Destroy()
        else
            status.Text = "❌ Key sai!"
        end
    end)

    repeat task.wait() until getKeyStatus() == "valid"
end

--========================
-- MAIN GUI
--========================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MANHBAO_MAIN"

-- Toggle logo
local toggle = Instance.new("ImageButton", gui)
toggle.Size = UDim2.fromOffset(45,45)
toggle.Position = UDim2.fromScale(0.02,0.4)
toggle.Image = LOGO_ID
toggle.BackgroundTransparency = 1

-- Main frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.35,0.45)
main.Position = UDim2.fromScale(0.325,0.275)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Visible = true
main.Active = true
main.Draggable = true

toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Title
local t = Instance.new("TextLabel", main)
t.Size = UDim2.new(1,0,0.15,0)
t.Text = "MANHBAO-HOP"
t.TextScaled = true
t.BackgroundTransparency = 1
t.TextColor3 = Color3.new(1,1,1)

local s = Instance.new("TextLabel", main)
s.Size = UDim2.new(1,0,0.08,0)
s.Position = UDim2.new(0,0,0.13,0)
s.Text = "by manhbao"
s.TextScaled = true
s.BackgroundTransparency = 1
s.TextColor3 = Color3.fromRGB(180,180,180)

--========================
-- SERVER TAB
--========================
local function hopServer(lowPing)
    -- Effect
    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 24

    local overlay = Instance.new("ScreenGui", game.CoreGui)
    local img = Instance.new("ImageLabel", overlay)
    img.Size = UDim2.fromScale(0.25,0.25)
    img.Position = UDim2.fromScale(0.375,0.35)
    img.Image = LOGO_ID
    img.BackgroundTransparency = 1

    local txt = Instance.new("TextLabel", overlay)
    txt.Size = UDim2.fromScale(1,0.1)
    txt.Position = UDim2.fromScale(0,0.6)
    txt.Text = "MANHBAO-HOP\nby manhbao"
    txt.TextScaled = true
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1,1,1)

    task.wait(1)
    TeleportService:Teleport(PLACE_ID, LocalPlayer)
end

local btn1 = Instance.new("TextButton", main)
btn1.Size = UDim2.new(0.8,0,0.18,0)
btn1.Position = UDim2.new(0.1,0,0.35,0)
btn1.Text = "HOP SERVER ÍT NGƯỜI"

btn1.MouseButton1Click:Connect(function()
    hopServer(false)
end)

local btn2 = Instance.new("TextButton", main)
btn2.Size = UDim2.new(0.8,0,0.18,0)
btn2.Position = UDim2.new(0.1,0,0.6,0)
btn2.Text = "HOP SERVER PING THẤP"

btn2.MouseButton1Click:Connect(function()
    hopServer(true)
end)
