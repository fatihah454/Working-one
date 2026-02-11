-- Oceanic Hub Modernized Specification
-- Language: English
-- Theme: Oceanic Blue Dark

repeat task.wait() until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Oceanic Theme Configuration
local OceanicTheme = {
    SchemeColor = Color3.fromRGB(0, 120, 215), -- Classic Blue
    Background = Color3.fromRGB(15, 20, 25),   -- Deep Oceanic Dark
    Header = Color3.fromRGB(20, 30, 40),       -- Nautical Slate
    TextColor = Color3.fromRGB(255, 255, 255), -- White
    ElementColor = Color3.fromRGB(25, 35, 45)  -- Modern Blue-Gray
}

-- Cache Variables
local SavedBicho1 = "Waiting..."
local SavedBicho2 = "Waiting..."
local RemainingSeconds = 0
local LastTick = 0

-- Secret Registry
local SecretsList = {
    = "500K/s", ["Graipuss Medussi"] = "1M/s",
    = "4M/s", = "325K/s", ["Garama and Madundung"] = "50M/s",
    = "2.2M/s", = "150M", ["La Grande Combinasion"] = "10M/s",
    = "3.5M/s", ["Arcadopus"] = "5M/s", ["Los Combinasionas"] = "2B", 
    = "700K/s", = "250M/s", = "250M/s", 
    = "FREE", = "30M/s", ["La Cucaracha"] = "475K/s"
}

-- Utility Functions
local function GetSecretTime()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find("High Tier") or v.Text:find("Spawning") or v.Name == "Timer") then
            local timeMatch = v.Text:match("%d+:%d+") or v.Text:match("%d+m%s*%d+s")
            if timeMatch then return timeMatch end
        end
    end
    return "00:00"
end

-- Create Window with Modern Sidebar UI
local Window = Library.CreateLib("oceanic hub", OceanicTheme)

-- TAB: CUPID
local TabCupid = Window:NewTab("💘Cupid")
local SectionCupid = TabCupid:NewSection("Cupid Machine Monitoring")

SectionCupid:NewButton("📊 Open Cupid Monitor", "Auto-tracks machine names and time", function()
    if game:GetService("CoreGui"):FindFirstChild("OceanicCupidPopup") then return end
    
    local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
    sg.Name = "OceanicCupidPopup"
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 220, 0, 130)
    frame.Position = UDim2.new(0.5, -110, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
    frame.Active, frame.Draggable = true, true -- Requirement: Draggable
    Instance.new("UICorner", frame)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 120, 215)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "OPEN MACHINE ONCE"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Font = Enum.Font.GothamBold
    title.BackgroundTransparency = 1

    local b1 = Instance.new("TextLabel", frame)
    b1.Size = UDim2.new(0.9, 0, 0, 30)
    b1.Position = UDim2.new(0.05, 0, 0.35, 0)
    b1.Text = "Slot 1:???"
    b1.BackgroundColor3 = Color3.fromRGB(25, 35, 45)
    b1.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b1)

    local b2 = Instance.new("TextLabel", frame)
    b2.Size = UDim2.new(0.9, 0, 0, 30)
    b2.Position = UDim2.new(0.05, 0, 0.65, 0)
    b2.Text = "Slot 2:???"
    b2.BackgroundColor3 = Color3.fromRGB(25, 35, 45)
    b2.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b2)

    task.spawn(function()
        while sg.Parent do
            pcall(function()
                local mGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("CupidsMachine", true)
                if mGui and mGui:FindFirstChild("CupidsMachine") and mGui.CupidsMachine.Visible then
                    local left = mGui.CupidsMachine:FindFirstChild("Left")
                    local right = mGui.CupidsMachine:FindFirstChild("Right")
                    local tObj = mGui.CupidsMachine:FindFirstChild("Title")
                    
                    if left and right and tObj then
                        local lTxt = left:FindFirstChild("BrainrotLabel", true)
                        local rTxt = right:FindFirstChild("BrainrotLabel", true)
                        if lTxt and rTxt then
                            SavedBicho1, SavedBicho2 = lTxt.Text, rTxt.Text
                            local m = tObj.Text:match("(%d+)m") or 0
                            local s = tObj.Text:match("(%d+)s") or 0
                            RemainingSeconds = (tonumber(m) * 60) + tonumber(s)
                            LastTick = tick()
                        end
                    end
                end
                
                if LastTick > 0 then
                    local cur = RemainingSeconds - (tick() - LastTick)
                    title.Text = cur > 0 and string.format("EXCHANGES IN: %02dm %02ds", math.floor(cur/60), math.floor(cur%60)) or "TIME EXPIRED!"
                    title.TextColor3 = cur > 0 and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 50, 50)
                end
                b1.Text = "1: ".. SavedBicho1
                b2.Text = "2: ".. SavedBicho2
            end)
            task.wait(1)
        end
    end)

    local close = Instance.new("TextButton", frame)
    close.Size, close.Position, close.Text = UDim2.new(0,20,0,20), UDim2.new(1,-25,0,5), "X"
    close.TextColor3, close.BackgroundTransparency = Color3.new(1,0,0), 1
    close.MouseButton1Click:Connect(function() sg:Destroy() end)
end)

-- TAB: MAIN
local TabMain = Window:NewTab("🛠Main")
local SectionMain = TabMain:NewSection("Oceanic Core Settings")

-- NEW FEATURE: INSTANT PROMPT
SectionMain:NewToggle("Instant Prompt", "Removes interaction wait time", function(state)
    _G.InstantPrompt = state
    task.spawn(function()
        while _G.InstantPrompt do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    v.HoldDuration = 0
                end
            end
            task.wait(2)
        end
    end)
end)

local TsunamiActive = false
SectionMain:NewToggle("♻ Delete Tsunami", "Continuous background removal", function(state)
    TsunamiActive = state
    if state then
        task.spawn(function()
            while TsunamiActive do
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj and obj.Name:find("Tsunami") then
                        pcall(function() obj:Destroy() end)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

SectionMain:NewButton("Force Delete Tsunamis", "Manual deep clean", function()
    for _, v in pairs(game:GetDescendants()) do
        if v and v.Name:find("Tsunami") then pcall(function() v:Destroy() end) end
    end
end)

SectionMain:NewButton("🌊 Clear Waves", "Cleans the Waves folder", function()
    local wf = workspace:FindFirstChild("Waves")
    if wf then
        for _, part in pairs(wf:GetChildren()) do pcall(function() part:Destroy() end) end
    end
end)

-- TAB: VISUALS
local TabESP = Window:NewTab("👀Visuals")
local SectionESP = TabESP:NewSection("ESP Systems")

local function CreateSecretESP(obj, valor)
    if obj:FindFirstChild("SecretESP") then return end
    local bgui = Instance.new("BillboardGui", obj)
    bgui.Name = "SecretESP"; bgui.AlwaysOnTop = true; bgui.Size = UDim2.new(0, 250, 0, 80)
    bgui.ExtentsOffset = Vector3.new(0, 4, 0)
    local label = Instance.new("TextLabel", bgui)
    label.BackgroundTransparency = 1; label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "⭐ ".. obj.Name:upper().. " ⭐\nVALUE: ".. valor
    label.TextColor3 = Color3.fromRGB(0, 200, 255); label.Font = Enum.Font.GothamBold
    label.TextSize = 18; label.TextStrokeTransparency = 0
    Instance.new("UIStroke", label).Thickness = 2.5
    local high = Instance.new("Highlight", obj); high.Name = "SecretHigh"
    high.FillColor = Color3.new(1, 1, 1); high.OutlineColor = Color3.fromRGB(0, 120, 215)
end

SectionESP:NewToggle("Secret ESP", "High-definition ESP markers", function(state)
    _G.ESP = state
    while _G.ESP do
        for _, child in pairs(workspace:GetChildren()) do
            if SecretsList[child.Name] then CreateSecretESP(child, SecretsList[child.Name]) end
        end
        task.wait(2)
    end
    if not state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "SecretESP" or v.Name == "SecretHigh" then v:Destroy() end
        end
    end
end)

-- TAB: TIMER
local TabTimer = Window:NewTab("🕐Timer")
local SectionTimer = TabTimer:NewSection("Secret Spawning")
local TimerLabel = SectionTimer:NewLabel("🔥 Secret in: 00:00")

SectionTimer:NewButton("🔲 Open Floating Timer", "Floating countdown window", function()
    if game:GetService("CoreGui"):FindFirstChild("OceanicTimerPopup") then return end
    local sg = Instance.new("ScreenGui", game:GetService("CoreGui")); sg.Name = "OceanicTimerPopup"
    local f = Instance.new("Frame", sg); f.Size, f.Position, f.BackgroundColor3 = UDim2.new(0, 160, 0, 65), UDim2.new(0.5, -80, 0.15, 0), Color3.fromRGB(20, 30, 40); f.Active, f.Draggable = true, true; Instance.new("UICorner", f)
    local display = Instance.new("TextLabel", f); display.Size, display.BackgroundTransparency, display.TextColor3, display.Font, display.TextSize = UDim2.new(1, 0, 1, 0), 1, Color3.new(1, 1, 1), Enum.Font.GothamBold, 16
    task.spawn(function() while sg.Parent do display.Text = "🌊 SECRET IN:\n".. GetSecretTime(); task.wait(1) end end)
end)

-- TAB: BOOST
local TabFPS = Window:NewTab("🚀Boost")
TabFPS:NewSection("Optimization"):NewButton("💨 FPS Boost", "Removes high-impact textures", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then 
            v.Material = Enum.Material.Plastic 
            v.Reflectance = 0
        elseif v:IsA("Decal") then 
            v:Destroy() 
        end
    end
end)

-- TAB: SERVER
local TabServer = Window:NewTab("🗺Server")
TabServer:NewSection("Connection"):NewButton("🔀 Server Hop", "Find a new server", function()
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/".. game.PlaceId.. "/servers/Public?sortOrder=Asc&limit=100"
    local Success, Body = pcall(function() return game:GetService("HttpService"):JSONDecode(game:HttpGet(Api)) end)
    if Success then
        for _, s in pairs(Body.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, s.id, game.Players.LocalPlayer)
                break
            end
        end
    end
end)

-- TAB: CREDITS
local TabCredits = Window:NewTab("🤔Credits")
TabCredits:NewSection("By Domingos0_0"):NewButton("YouTube Channel", "Follow for updates", function() print("https://youtube.com/@Domingos0_0") end)

-- MASTER TOGGLE: RAINBOW "OC" BUTTON
local function CreateMasterButton()
    local sg = Instance.new("ScreenGui", game:GetService("CoreGui")); sg.Name = "OceanicMasterToggle"
    local btn = Instance.new("TextButton", sg)
    btn.Size, btn.Position, btn.BackgroundColor3 = UDim2.new(0, 55, 0, 55), UDim2.new(0, 50, 0, 150), Color3.fromRGB(10, 15, 20)
    btn.Text, btn.TextColor3, btn.Font, btn.TextSize = "OC", Color3.new(1,1,1), Enum.Font.LuckiestGuy, 22
    btn.Draggable, btn.Active = true, true -- Requirement: Draggable
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", btn); stroke.Thickness = 3
    
    -- OC Rainbow Logic
    task.spawn(function() 
        while true do 
            for i = 0, 1, 0.01 do 
                stroke.Color = Color3.fromHSV(i, 0.8, 1) 
                task.wait(0.02) 
            end 
        end 
    end)

    btn.MouseButton1Click:Connect(function()
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                local mainFrame = gui.Main
                if gui.Enabled then
                    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
                    task.delay(0.3, function() gui.Enabled = false end)
                else
                    gui.Enabled = true
                    mainFrame.Size = UDim2.new(0, 0, 0, 0)
                    mainFrame:TweenSize(UDim2.new(0, 525, 0, 318), "Out", "Back", 0.5, true)
                end
            end
        end
    end)
end

task.spawn(CreateMasterButton)
task.spawn(function() while true do pcall(function() TimerLabel:UpdateLabel("🔥 Secret in: ".. GetSecretTime()) end) task.wait(1) end end)
