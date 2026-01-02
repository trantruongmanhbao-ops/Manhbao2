--================================
-- File: FLYGUI-MANHBAO.lua
-- Author: manhbao
-- Version: Full Fix | Delta Supported
--================================

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- PLAYER
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

--================ GUI ROOT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FLYGUI-MANHBAO"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--================ INTRO =================
local introLogo = Instance.new("TextLabel", gui)
introLogo.Size = UDim2.new(0,70,0,70)
introLogo.Position = UDim2.new(0.5,-35,0.4,0)
introLogo.Text = "✈"
introLogo.TextSize = 40
introLogo.BackgroundColor3 = Color3.fromRGB(25,25,25)
introLogo.TextColor3 = Color3.new(1,1,1)
introLogo.TextTransparency = 1
introLogo.BackgroundTransparency = 1
introLogo.BorderSizePixel = 0
Instance.new("UICorner", introLogo).CornerRadius = UDim.new(1,0)

local introText = Instance.new("TextLabel", gui)
introText.Size = UDim2.new(0,320,0,40)
introText.Position = UDim2.new(0.5,-160,0.4,80)
introText.BackgroundTransparency = 1
introText.Text = "FLYGUI - MANHBAO"
introText.Font = Enum.Font.GothamBold
introText.TextSize = 24
introText.TextColor3 = Color3.new(1,1,1)
introText.TextTransparency = 1

--================ LOGO (MINIMIZED) =================
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0,200)
logo.Text = "✈"
logo.TextSize = 26
logo.BackgroundColor3 = Color3.fromRGB(25,25,25)
logo.TextColor3 = Color3.new(1,1,1)
logo.BorderSizePixel = 0
logo.Visible = false
logo.Active = true
logo.Draggable = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

--================ MENU =================
local normalSize = UDim2.new(0,280,0,260)
local maxSize = UDim2.new(0,420,0,340)

local frame = Instance.new("Frame", gui)
frame.Size = normalSize
frame.Position = UDim2.new(0,80,0,200)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- BACKGROUND
local bg = Instance.new("ImageLabel", frame)
bg.Size = UDim2.new(1,0,1,0)
bg.Image = "rbxassetid://96045391302700"
bg.BackgroundTransparency = 1
bg.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", bg).CornerRadius = UDim.new(0,16)

local overlay = Instance.new("Frame", frame)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0
Instance.new("UICorner", overlay).CornerRadius = UDim.new(0,16)

--================ TITLE =================
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,-90,0,40)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "FLYGUI - MANHBAO"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1,1,1)

local function windowBtn(txt, x)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(0,30,0,30)
	b.Position = UDim2.new(1,x,0,5)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.BackgroundColor3 = Color3.fromRGB(50,50,50)
	b.TextColor3 = Color3.new(1,1,1)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b)
	return b
end

local minBtn = windowBtn("-", -90)
local maxBtn = windowBtn("□", -55)
local closeBtn = windowBtn("X", -20)

--================ CONTENT =================
local fpsLabel = Instance.new("TextLabel", frame)
fpsLabel.Size = UDim2.new(1,-20,0,25)
fpsLabel.Position = UDim2.new(0,10,0,45)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 14
fpsLabel.TextColor3 = Color3.fromRGB(0,255,0)
fpsLabel.Text = "FPS : 0"

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(1,-20,0,40)
flyBtn.Position = UDim2.new(0,10,0,75)
flyBtn.Text = "FLY : OFF"
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 16
flyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.BorderSizePixel = 0
Instance.new("UICorner", flyBtn)

local speed = 60
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1,-20,0,25)
speedLabel.Position = UDim2.new(0,10,0,125)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.Text = "Speed : "..speed.."  [ / ]"

--================ WINDOW LOGIC =================
local maximized = false

minBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	logo.Visible = true
end)

logo.MouseButton1Click:Connect(function()
	frame.Visible = true
	logo.Visible = false
end)

maxBtn.MouseButton1Click:Connect(function()
	maximized = not maximized
	TweenService:Create(frame, TweenInfo.new(0.25), {
		Size = maximized and maxSize or normalSize
	}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--================ INTRO PLAY =================
TweenService:Create(introLogo, TweenInfo.new(0.5), {
	TextTransparency = 0,
	BackgroundTransparency = 0
}):Play()
task.wait(1)
TweenService:Create(introText, TweenInfo.new(0.5), {
	TextTransparency = 0
}):Play()
task.wait(1)
introLogo:Destroy()
introText:Destroy()
frame.Visible = true

--================ FPS =================
local frames, last = 0, tick()
RunService.RenderStepped:Connect(function()
	frames += 1
	if tick() - last >= 1 then
		fpsLabel.Text = "FPS : "..frames
		frames = 0
		last = tick()
	end
end)

--================ REAL FLY =================
local flying = false
local bgf, bv
local move = {F=0,B=0,L=0,R=0,U=0,D=0}

local function startFly()
	bgf = Instance.new("BodyGyro", hrp)
	bgf.P = 9e4
	bgf.MaxTorque = Vector3.new(9e9,9e9,9e9)

	bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)

	humanoid.PlatformStand = true
end

local function stopFly()
	if bgf then bgf:Destroy() end
	if bv then bv:Destroy() end
	humanoid.PlatformStand = false
end

RunService.RenderStepped:Connect(function()
	if flying and bv then
		local cam = workspace.CurrentCamera
		local dir =
			(cam.CFrame.LookVector * (move.F - move.B)) +
			(cam.CFrame.RightVector * (move.R - move.L)) +
			(Vector3.new(0,1,0) * (move.U - move.D))

		if dir.Magnitude > 0 then
			bv.Velocity = dir.Unit * speed
		else
			bv.Velocity = Vector3.zero
		end
		bgf.CFrame = cam.CFrame
	end
end)

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "FLY : ON" or "FLY : OFF"
	if flying then startFly() else stopFly() end
end)

--================ INPUT =================
UIS.InputBegan:Connect(function(i,g)
	if g then return end
	if i.KeyCode == Enum.KeyCode.W then move.F=1 end
	if i.KeyCode == Enum.KeyCode.S then move.B=1 end
	if i.KeyCode == Enum.KeyCode.A then move.L=1 end
	if i.KeyCode == Enum.KeyCode.D then move.R=1 end
	if i.KeyCode == Enum.KeyCode.Space then move.U=1 end
	if i.KeyCode == Enum.KeyCode.LeftControl then move.D=1 end

	if i.KeyCode == Enum.KeyCode.LeftBracket then
		speed = math.max(10, speed-10)
	end
	if i.KeyCode == Enum.KeyCode.RightBracket then
		speed += 10
	end
	speedLabel.Text = "Speed : "..speed.."  [ / ]"
end)

UIS.InputEnded:Connect(function(i)
	if i.KeyCode == Enum.KeyCode.W then move.F=0 end
	if i.KeyCode == Enum.KeyCode.S then move.B=0 end
	if i.KeyCode == Enum.KeyCode.A then move.L=0 end
	if i.KeyCode == Enum.KeyCode.D then move.R=0 end
	if i.KeyCode == Enum.KeyCode.Space then move.U=0 end
	if i.KeyCode == Enum.KeyCode.LeftControl then move.D=0 end
end)
