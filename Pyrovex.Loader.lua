local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local LogoAsset = "rbxthumb://type=Asset&id=79051478787302&w=420&h=420"
local DiscordAsset = "rbxthumb://type=Asset&id=127546963058457&w=420&h=420"
local DiscordLink = "https://discord.gg/K3ahPnJV8y"

for _, name in ipairs({"PyrovexTopLoader", "PyroVexLoader"}) do
    local old = PlayerGui:FindFirstChild(name)
    if old then old:Destroy() end
end

local Config = {
    LoadingDuration = 5,
    MainWidth = 510,
    MainHeight = 370,
    MinimumScale = 0.65,
    MaximumScale = 1,
    FloatingSize = 54,
    CardHeight = 88,
    Animation = {
        Open = 0.62, Close = 0.32, Minimize = 0.30,
        Restore = 0.46, Hover = 0.20, Button = 0.11,
        Tab = 0.28, Card = 0.38, Fade = 0.22
    }
}
local Animation = Config.Animation
local BaseAnimation = table.clone(Config.Animation)

local C = {
    Background = Color3.fromRGB(0, 0, 0),
    Background2 = Color3.fromRGB(8, 8, 8),
    Header = Color3.fromRGB(14, 14, 14),
    Header2 = Color3.fromRGB(22, 22, 22),
    Panel = Color3.fromRGB(5, 5, 5),
    Card = Color3.fromRGB(16, 16, 16),
    CardHover = Color3.fromRGB(32, 32, 32),
    Blue = Color3.fromRGB(235, 235, 235),
    LightBlue = Color3.fromRGB(255, 255, 255),
    DarkBlue = Color3.fromRGB(55, 55, 55),
    Purple = Color3.fromRGB(225, 225, 225),
    LightPurple = Color3.fromRGB(255, 255, 255),
    Red = Color3.fromRGB(170, 170, 170),
    LightRed = Color3.fromRGB(215, 215, 215),
    Green = Color3.fromRGB(195, 195, 195),
    White = Color3.fromRGB(255, 255, 255),
    Gray = Color3.fromRGB(180, 180, 180),
    DarkGray = Color3.fromRGB(90, 90, 90),
    Border = Color3.fromRGB(70, 70, 70),
    CopyBackground = Color3.fromRGB(38, 38, 38)
}

local function New(class, props, parent)
    local object = Instance.new(class)
    for property, value in pairs(props or {}) do object[property] = value end
    object.Parent = parent
    return object
end

local function Round(object, radius)
    return New("UICorner", {CornerRadius = UDim.new(0, radius)}, object)
end

local function Outline(object, color, thickness, transparency)
    return New("UIStroke", {
        Color = color, Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, object)
end

local function Gradient(object, color1, color2, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }),
        Rotation = rotation or 0
    }, object)
end

local function PremiumGradient(object, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.Blue),
            ColorSequenceKeypoint.new(0.34, C.Purple),
            ColorSequenceKeypoint.new(0.68, C.Red),
            ColorSequenceKeypoint.new(1, C.Blue)
        }),
        Rotation = rotation or 0
    }, object)
end

local function Tween(object, properties, duration, style, direction)
    if not object or not object.Parent then return nil end
    local ok, tween = pcall(function()
        return TweenService:Create(object, TweenInfo.new(
            duration or 0.25,
            style or Enum.EasingStyle.Quart,
            direction or Enum.EasingDirection.Out
        ), properties)
    end)
    if not ok then return nil end
    tween:Play()
    return tween
end

local function AnimateGradient(gradient, speed)
    task.spawn(function()
        while gradient and gradient.Parent do
            Tween(gradient, {Rotation = gradient.Rotation + 180},
                speed or 3, Enum.EasingStyle.Linear)
            task.wait(speed or 3)
        end
    end)
end

local function Pulse(object, property, value1, value2, speed)
    task.spawn(function()
        while object and object.Parent do
            Tween(object, {[property] = value1}, speed or 1)
            task.wait(speed or 1)
            if not object or not object.Parent then break end
            Tween(object, {[property] = value2}, speed or 1)
            task.wait(speed or 1)
        end
    end)
end

local function GetLoadstring(url)
    return 'loadstring(game:HttpGet("' .. url .. '"))()'
end

local function GetResponsiveScale()
    Camera = workspace.CurrentCamera or Camera
    if not Camera then return 1 end
    local viewport = Camera.ViewportSize
    return math.clamp(math.min(viewport.X / 560, viewport.Y / 430, 1),
        Config.MinimumScale, Config.MaximumScale)
end

local Scripts = {
    {
        Name = "CHILI HUB", Icon = "🌶️",
        Subtitle = "ALL IN ONE SCRIPT",
        URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"
    },
    {
        Name = "ADMIN BADGE", Icon = "🛡️",
        Subtitle = "ADMIN BADGE AND SPEED CHANGER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua.sae/main/steal.an.egg.lua"
    },
    {
        Name = "CLOUTHUB", Icon = "☁️",
        Subtitle = "CLOUTHUB FEATURED SCRIPT",
        URL = "https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua"
    }
}

local GrowScripts = {
    {
        Name = "TOKEN SPAWNER", Icon = "🎟️",
        Subtitle = "TOKEN SPOOFER",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.lua/main/Token.spawner.lua"
    },
    {
        Name = "ANTI AFK", Icon = "😴",
        Subtitle = "AFK 24/7",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex-Anti-afk/main/Pyrovex.lua"
    }
}

local UniversalScripts = {
    {
        Name = "PYROVEX DEBUGGER", Icon = "🐞",
        Subtitle = "DETECTS AN ERROR TO YOUR SCRIPT",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Pyrovex.debug/main/Pyro.lua"
    },
    {
        Name = "PYROVEX HUB SHADER", Icon = "🎨",
        Subtitle = "IMPROVE YOUR GAME VISUAL GRAPHICS",
        URL = "https://raw.githubusercontent.com/pyrovexhub-blip/Shader.lua/main/Pyrovex.lua"
    }
}

local AllScripts = {}
for _, item in ipairs(Scripts) do table.insert(AllScripts, item) end
for _, item in ipairs(GrowScripts) do table.insert(AllScripts, item) end
for _, item in ipairs(UniversalScripts) do table.insert(AllScripts, item) end

local Sections = {
    {Name = "ALL SCRIPTS", Width = 110},
    {Name = "STEAL AN EGG", Width = 125},
    {Name = "GROW A GARDEN", Width = 125},
    {Name = "UNIVERSAL SCRIPTS", Width = 155}
}

--==============================================================
-- LOADING SCREEN
--==============================================================
local LoadingGui = New("ScreenGui", {
    Name = "PyrovexTopLoader", IgnoreGuiInset = true,
    ResetOnSpawn = false, DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local LoadingDim = New("Frame", {
    Size = UDim2.fromScale(1,1),
    BackgroundColor3 = Color3.fromRGB(3, 3, 3),
    BackgroundTransparency = 0.2, BorderSizePixel = 0, ZIndex = 1
}, LoadingGui)

local LoadingMain = New("Frame", {
    Name = "LoadingContainer", Size = UDim2.fromOffset(390,126),
    Position = UDim2.new(0.5,0,0,-150),
    AnchorPoint = Vector2.new(0.5,0),
    BackgroundColor3 = C.Background, BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 10
}, LoadingGui)
Round(LoadingMain,20)
Gradient(LoadingMain,Color3.fromRGB(26, 26, 26),Color3.fromRGB(22, 22, 22),25)
local LoadingStroke = Outline(LoadingMain,C.Blue,1.8,0.05)
AnimateGradient(PremiumGradient(LoadingStroke,0),2.8)

local LoadingAccent = New("Frame", {
    Size = UDim2.new(1,-22,0,3), Position = UDim2.fromOffset(11,0),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0, ZIndex = 15
},LoadingMain)
Round(LoadingAccent,5)
AnimateGradient(PremiumGradient(LoadingAccent,0),2)

local LoadingLogoFrame = New("Frame", {
    Size = UDim2.fromOffset(54,54), Position = UDim2.fromOffset(16,18),
    BackgroundColor3 = C.Blue, BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 15
},LoadingMain)
Round(LoadingLogoFrame,15)
AnimateGradient(PremiumGradient(LoadingLogoFrame,45),2.5)
Outline(LoadingLogoFrame,C.LightBlue,1.5,0.1)

local LoadingLogo = New("ImageLabel", {
    Size = UDim2.new(1,-6,1,-6), Position = UDim2.fromOffset(3,3),
    BackgroundTransparency = 1, Image = LogoAsset,
    ScaleType = Enum.ScaleType.Fit, ZIndex = 16
},LoadingLogoFrame)
Round(LoadingLogo,12)

New("TextLabel", {
    Position = UDim2.fromOffset(82,17), Size = UDim2.new(1,-100,0,25),
    BackgroundTransparency = 1, Text = "PYROVEX HUB",
    TextColor3 = C.White, TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack, ZIndex = 15
},LoadingMain)

New("TextLabel", {
    Position = UDim2.fromOffset(83,42), Size = UDim2.new(1,-100,0,16),
    BackgroundTransparency = 1, Text = "EXTREME PREMIUM INITIALIZATION",
    TextColor3 = C.LightBlue, TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold, ZIndex = 15
},LoadingMain)

local LoadingStatus = New("TextLabel", {
    Position = UDim2.fromOffset(17,78), Size = UDim2.new(1,-90,0,15),
    BackgroundTransparency = 1, Text = "Initializing Pyrovex Hub...",
    TextColor3 = C.Gray, TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium, ZIndex = 15
},LoadingMain)

local LoadingPercentage = New("TextLabel", {
    Position = UDim2.new(1,-65,0,76), Size = UDim2.fromOffset(48,18),
    BackgroundTransparency = 1, Text = "0%", TextColor3 = C.LightBlue,
    TextSize = 11, TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.GothamBlack, ZIndex = 15
},LoadingMain)

local BarBG = New("Frame", {
    Size = UDim2.new(1,-32,0,8), Position = UDim2.fromOffset(16,101),
    BackgroundColor3 = Color3.fromRGB(43, 43, 43), BorderSizePixel = 0,
    ClipsDescendants = true, ZIndex = 15
},LoadingMain)
Round(BarBG,10)

local Bar = New("Frame", {
    Size = UDim2.new(0,0,1,0), BackgroundColor3 = C.Blue,
    BorderSizePixel = 0, ZIndex = 16
},BarBG)
Round(Bar,10)
AnimateGradient(PremiumGradient(Bar,0),1.8)

local Shine = New("Frame", {
    Size = UDim2.new(0,55,1,0), Position = UDim2.new(0,-60,0,0),
    BackgroundColor3 = C.White, BackgroundTransparency = 0.45,
    BorderSizePixel = 0, ZIndex = 17
},Bar)
Round(Shine,10)
New("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,1),
        NumberSequenceKeypoint.new(0.5,0),
        NumberSequenceKeypoint.new(1,1)
    })
},Shine)

local LoadingDots = {}
for i=1,3 do
    local dot = New("Frame", {
        Size = UDim2.fromOffset(5,5),
        Position = UDim2.fromOffset(84+i*10,62),
        BackgroundColor3 = C.LightBlue, BorderSizePixel = 0, ZIndex = 15
    },LoadingMain)
    Round(dot,100)
    LoadingDots[i] = dot
end

task.spawn(function()
    while LoadingGui.Parent do
        for _,dot in ipairs(LoadingDots) do
            if not dot.Parent then return end
            Tween(dot,{Size=UDim2.fromOffset(7,7),BackgroundTransparency=0},0.22)
            task.wait(0.12)
            Tween(dot,{Size=UDim2.fromOffset(4,4),BackgroundTransparency=0.65},0.22)
        end
        task.wait(0.12)
    end
end)

task.spawn(function()
    while LoadingLogoFrame.Parent do
        Tween(LoadingLogoFrame,{Rotation=LoadingLogoFrame.Rotation+360},5,Enum.EasingStyle.Linear)
        task.wait(5)
    end
end)

task.spawn(function()
    while LoadingGui.Parent do
        Tween(LoadingStroke,{Color=C.Purple,Transparency=0.28},0.65)
        task.wait(0.65)
        if not LoadingGui.Parent then break end
        Tween(LoadingStroke,{Color=C.LightBlue,Transparency=0.02},0.65)
        task.wait(0.65)
    end
end)

Tween(LoadingDim,{BackgroundTransparency=0.08},0.45)
Tween(LoadingMain,{
    Position=UDim2.new(0.5,0,0.5,0),
    AnchorPoint=Vector2.new(0.5,0.5)
},0.82,Enum.EasingStyle.Back)

task.spawn(function()
    while LoadingGui.Parent and Shine.Parent do
        Shine.Position=UDim2.new(0,-60,0,0)
        local shineTween=Tween(Shine,{Position=UDim2.new(1,0,0,0)},0.9,Enum.EasingStyle.Linear)
        if shineTween then shineTween.Completed:Wait() else break end
        task.wait(0.08)
    end
end)

local LoadingMessages = {
    {Time=0,Text="Initializing Pyrovex Hub..."},
    {Time=1,Text="Preparing premium interface..."},
    {Time=2,Text="Loading script collection..."},
    {Time=3,Text="Preparing UI components..."},
    {Time=4,Text="Almost ready..."}
}
for _,message in ipairs(LoadingMessages) do
    task.delay(message.Time,function()
        if not LoadingGui.Parent then return end
        Tween(LoadingStatus,{TextTransparency=1},0.12)
        task.wait(0.13)
        if not LoadingGui.Parent then return end
        LoadingStatus.Text=message.Text
        Tween(LoadingStatus,{TextTransparency=0},0.18)
    end)
end

local LoadingStart=os.clock()
Tween(Bar,{Size=UDim2.new(1,0,1,0)},Config.LoadingDuration,Enum.EasingStyle.Linear)
while os.clock()-LoadingStart<Config.LoadingDuration do
    if not LoadingGui.Parent then return end
    local progress=math.clamp((os.clock()-LoadingStart)/Config.LoadingDuration,0,1)
    LoadingPercentage.Text=math.floor(progress*100).."%"
    task.wait(0.025)
end
LoadingPercentage.Text="100%"
LoadingStatus.Text="PYROVEX HUB IS READY!"
Tween(LoadingStroke,{Color=C.Green,Transparency=0},0.25)
Tween(LoadingPercentage,{TextColor3=C.Green},0.25)
task.wait(0.35)
Tween(LoadingMain,{Position=UDim2.new(0.5,0,0.5,35),BackgroundTransparency=1},
    0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
Tween(LoadingDim,{BackgroundTransparency=1},0.5)
Tween(LoadingLogoFrame,{BackgroundTransparency=1},0.25)
Tween(LoadingLogo,{ImageTransparency=1},0.25)
Tween(LoadingStatus,{TextTransparency=1},0.25)
Tween(LoadingPercentage,{TextTransparency=1},0.25)
task.wait(0.62)
LoadingGui:Destroy()

--==============================================================
-- MAIN GUI + RESPONSIVE UI SCALE
--==============================================================
local Screen = New("ScreenGui", {
    Name="PyroVexLoader",ResetOnSpawn=false,IgnoreGuiInset=true,
    DisplayOrder=999999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling
},PlayerGui)

local Outer = New("Frame", {
    Name="OuterFrame",Size=UDim2.fromOffset(Config.MainWidth,Config.MainHeight),
    Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ClipsDescendants=false,
    Active=true,ZIndex=1
},Screen)
Round(Outer,24)
AnimateGradient(PremiumGradient(Outer,25),4)
local OuterStroke=Outline(Outer,C.LightBlue,2,0.12)
AnimateGradient(PremiumGradient(OuterStroke,0),3)

local OuterGlow=New("Frame",{
    Name="OuterGlow",Size=UDim2.new(1,14,1,14),
    Position=UDim2.fromOffset(-7,-7),BackgroundTransparency=1,
    BorderSizePixel=0,ZIndex=0
},Outer)
Round(OuterGlow,29)
local OuterGlowStroke=Outline(OuterGlow,C.Purple,3,0.72)
Pulse(OuterGlowStroke,"Transparency",0.42,0.88,1.1)

local Main=New("Frame",{
    Name="Main",Size=UDim2.new(1,-4,1,-4),Position=UDim2.fromOffset(2,2),
    BackgroundColor3=C.Background,BorderSizePixel=0,
    ClipsDescendants=true,Active=true,ZIndex=2
},Outer)
Round(Main,22)
Gradient(Main,C.Background,C.Background2,45)

local UISizePercent=100
local function GetUIScale()
    return GetResponsiveScale()*(UISizePercent/100)
end
local MainScale=New("UIScale",{Scale=GetUIScale()},Outer)
local UISizeTween
local function ApplyUISize(duration)
    if not MainScale or not MainScale.Parent then return end
    if UISizeTween then UISizeTween:Cancel() end
    UISizeTween=Tween(MainScale,{Scale=GetUIScale()},duration or 0.1,Enum.EasingStyle.Quart)
end
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        if MainScale and MainScale.Parent then ApplyUISize(0.25) end
    end)
end

local BackgroundDecoration=New("Frame",{
    Size=UDim2.fromOffset(230,230),Position=UDim2.new(1,-140,0,90),
    BackgroundColor3=C.Purple,BackgroundTransparency=0.95,
    BorderSizePixel=0,ZIndex=2
},Main)
Round(BackgroundDecoration,100)
AnimateGradient(Gradient(BackgroundDecoration,C.Blue,C.Red,45),5)

local BackgroundDecoration2=New("Frame",{
    Size=UDim2.fromOffset(170,170),Position=UDim2.new(0,-110,1,-160),
    BackgroundColor3=C.Blue,BackgroundTransparency=0.96,
    BorderSizePixel=0,ZIndex=2
},Main)
Round(BackgroundDecoration2,100)
AnimateGradient(Gradient(BackgroundDecoration2,C.Purple,C.Blue,90),6)

local TopAccent=New("Frame",{
    Size=UDim2.new(1,-24,0,3),Position=UDim2.fromOffset(12,5),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ZIndex=20
},Main)
Round(TopAccent,5)
AnimateGradient(PremiumGradient(TopAccent,0),2.5)

local Header=New("Frame",{
    Name="Header",Size=UDim2.new(1,-16,0,83),Position=UDim2.fromOffset(8,11),
    BackgroundColor3=C.Header,BorderSizePixel=0,Active=true,
    ClipsDescendants=true,ZIndex=5
},Main)
Round(Header,17)
AnimateGradient(Gradient(Header,Color3.fromRGB(33, 33, 33),Color3.fromRGB(24, 24, 24),0),6)
local HeaderStroke=Outline(Header,C.Border,1,0.18)
New("Frame",{
    Size=UDim2.new(1,-28,0,1),Position=UDim2.new(0,14,1,-1),
    BackgroundColor3=C.Border,BorderSizePixel=0,ZIndex=6
},Header)

local Logo=New("Frame",{
    Size=UDim2.fromOffset(49,49),Position=UDim2.fromOffset(13,16),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ClipsDescendants=true,ZIndex=7
},Header)
Round(Logo,14)
AnimateGradient(PremiumGradient(Logo,45),3)
local LogoStroke=Outline(Logo,C.LightPurple,1.5,0.12)
Pulse(LogoStroke,"Transparency",0.08,0.55,1)
local LogoImage=New("ImageLabel",{
    Name="LogoImage",Size=UDim2.new(1,-6,1,-6),Position=UDim2.fromOffset(3,3),
    BackgroundTransparency=1,Image=LogoAsset,ScaleType=Enum.ScaleType.Fit,ZIndex=8
},Logo)
Round(LogoImage,11)

New("TextLabel",{
    Name="Title",Position=UDim2.fromOffset(74,12),Size=UDim2.fromOffset(180,26),
    BackgroundTransparency=1,Text="PYROVEX LOADER",TextColor3=C.White,
    TextSize=17,TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamBlack,ZIndex=7
},Header)
New("TextLabel",{
    Position=UDim2.fromOffset(75,13),Size=UDim2.fromOffset(180,26),
    BackgroundTransparency=1,Text="PYROVEX LOADER",TextColor3=C.Purple,
    TextTransparency=0.78,TextSize=17,TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamBlack,ZIndex=6
},Header)
New("TextLabel",{
    Position=UDim2.fromOffset(75,39),Size=UDim2.fromOffset(250,15),
    BackgroundTransparency=1,Text="PYROVEX HUB COMMUNITY",TextColor3=C.LightBlue,
    TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamBold,ZIndex=7
},Header)
local StatusDot=New("Frame",{
    Size=UDim2.fromOffset(7,7),Position=UDim2.fromOffset(75,63),
    BackgroundColor3=C.Green,BorderSizePixel=0,ZIndex=7
},Header)
Round(StatusDot,100)
Pulse(StatusDot,"BackgroundTransparency",0.7,0,0.65)
New("TextLabel",{
    Position=UDim2.fromOffset(87,60),Size=UDim2.fromOffset(150,13),
    BackgroundTransparency=1,Text="LOADER ACTIVE",TextColor3=C.Gray,
    TextSize=7,TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamBlack,ZIndex=7
},Header)

local Matte = {
    -- Brighter theme-matched liquid glass. The base stays colored by the
    -- active theme, but is lifted enough to keep button labels/icons readable.
    Normal = C.Card:Lerp(C.Blue, 0.58):Lerp(C.LightBlue, 0.52):Lerp(C.Purple, 0.12),
    Hover = C.CardHover:Lerp(C.Blue, 0.54):Lerp(C.LightBlue, 0.58):Lerp(C.LightPurple, 0.16),
    Pressed = C.Card:Lerp(C.Blue, 0.62):Lerp(C.LightBlue, 0.44):Lerp(C.Purple, 0.16),
    Border = C.LightBlue,
    Accent = C.LightBlue,
    Text = C.White,
    Secondary = C.Gray
}

local GlassReflectionEnabled = true
local GlassHoverEnabled = true
local GlassBrightnessLevel = 4
local GlassBrightnessSteps = {0.48, 0.58, 0.68, 0.76, 0.84}

local LiquidGlassStyled = setmetatable({}, {__mode = "k"})
local function GlassColors(base)
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, base:Lerp(C.White, 0.72)),
        ColorSequenceKeypoint.new(0.16, base:Lerp(C.LightBlue, 0.66)),
        ColorSequenceKeypoint.new(0.48, base:Lerp(C.Blue, 0.16)),
        ColorSequenceKeypoint.new(0.78, base:Lerp(C.LightPurple, 0.30)),
        ColorSequenceKeypoint.new(1, base:Lerp(C.Purple, 0.22))
    })
end

local function ApplyLiquidGlassButton(button)
    if not button or not button:IsA("GuiButton") then return end
    -- FloatingButton is a self-contained circular logo image. Never place
    -- glass gradients/highlights over it or recolor its image background.
    if button.Name == "FloatingButton" then return end
    button.AutoButtonColor = false
    button.BorderSizePixel = 0
    button.BackgroundColor3 = Matte.Normal

    local corner = button:FindFirstChildOfClass("UICorner")
    if not corner then
        corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 9)
        corner.Parent = button
    end

    local gradient = button:FindFirstChild("PyrovexLiquidGlassGradient")
    if not gradient then
        gradient = Instance.new("UIGradient")
        gradient.Name = "PyrovexLiquidGlassGradient"
        gradient.Parent = button
    end
    gradient.Rotation = 90
    gradient.Color = GlassColors(Matte.Normal)
    gradient.Transparency = GlassReflectionEnabled and NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.02),
        NumberSequenceKeypoint.new(0.42, 0.07),
        NumberSequenceKeypoint.new(1, 0.025)
    }) or NumberSequence.new(0.12)
    -- Keep image/text content crisp and above the glass surface.
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("GuiObject") and child ~= gradient then
            child.ZIndex = math.max(child.ZIndex, button.ZIndex + 1)
        end
    end

    -- Keep the liquid-glass finish borderless: no outline, edge stroke,
    -- or thin line highlight. The soft gradient itself provides the sheen.
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("UIStroke") then
            child:Destroy()
        elseif child.Name == "PyrovexGlassHighlight" then
            child:Destroy()
        end
    end

    if not LiquidGlassStyled[button] then
        LiquidGlassStyled[button] = true
        button.MouseEnter:Connect(function()
            if button.Parent then
                if GlassHoverEnabled then
                    button.BackgroundColor3 = Matte.Hover
                    gradient.Color = GlassColors(Matte.Hover)
                end
            end
        end)
        button.MouseLeave:Connect(function()
            if button.Parent then
                button.BackgroundColor3 = Matte.Normal
                gradient.Color = GlassColors(Matte.Normal)
            end
        end)
        button.MouseButton1Down:Connect(function()
            if button.Parent then
                button.BackgroundColor3 = Matte.Pressed
                gradient.Color = GlassColors(Matte.Pressed)
            end
        end)
        button.MouseButton1Up:Connect(function()
            if button.Parent then
                if GlassHoverEnabled then
                    button.BackgroundColor3 = Matte.Hover
                    gradient.Color = GlassColors(Matte.Hover)
                end
            end
        end)
    end
end

local function ButtonAnimation(button, normalColor, hoverColor)
    ApplyLiquidGlassButton(button)
end

local function ApplyBoldText(object)
    if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
        object.Font = Enum.Font.GothamBold
        if object:IsA("TextButton") and object.Name~="FloatingButton" then
            object.TextStrokeTransparency = 0.88
            object.TextStrokeColor3 = Color3.fromRGB(12, 12, 12)
        end
    end
    if object:IsA("GuiButton") then
        ApplyLiquidGlassButton(object)
    end
end

local function StyleExistingTree(root)
    for _, object in ipairs(root:GetDescendants()) do
        ApplyBoldText(object)
    end
end

-- Apply the same themed liquid-glass finish to buttons created later.
Screen.DescendantAdded:Connect(function(object)
    task.defer(function()
        if object and object.Parent then ApplyBoldText(object) end
    end)
end)
StyleExistingTree(Screen)

local SettingsButton=New("ImageButton",{
    Name="SettingsButton",Size=UDim2.fromOffset(30,30),
    Position=UDim2.new(1,-82,0,101),BackgroundColor3=Matte.Normal,
    Image="rbxthumb://type=Asset&id=78633725021398&w=420&h=420",
    ScaleType=Enum.ScaleType.Crop,AutoButtonColor=false,
    BorderSizePixel=0,ZIndex=10
},Main)
Round(SettingsButton,9)
ButtonAnimation(SettingsButton,Matte.Normal,Matte.Hover)

local DiscordButton=New("ImageButton",{
    Name="DiscordButton",Size=UDim2.fromOffset(30,30),
    Position=UDim2.new(1,-46,0,101),BackgroundColor3=Matte.Normal,
    Image=DiscordAsset,ScaleType=Enum.ScaleType.Crop,AutoButtonColor=false,
    BorderSizePixel=0,ZIndex=10
},Main)
Round(DiscordButton,9)
DiscordButton.MouseEnter:Connect(function()
    Tween(DiscordButton,{BackgroundColor3=Matte.Hover},0.15)
end)
DiscordButton.MouseLeave:Connect(function()
    Tween(DiscordButton,{BackgroundColor3=Matte.Normal},0.15)
end)
local DiscordOriginalPosition = DiscordButton.Position
local DiscordShakeTween
DiscordButton.MouseButton1Click:Connect(function()
    if DiscordShakeTween then DiscordShakeTween:Cancel() end
    DiscordButton.Position = DiscordOriginalPosition
    local shakeSteps = {
        {X=5, Duration=0.055},
        {X=-5, Duration=0.055},
        {X=4, Duration=0.05},
        {X=-4, Duration=0.05},
        {X=0, Duration=0.07}
    }
    task.spawn(function()
        for _,step in ipairs(shakeSteps) do
            if not DiscordButton.Parent then return end
            DiscordShakeTween=Tween(DiscordButton,{
                Position=UDim2.new(
                    DiscordOriginalPosition.X.Scale,
                    DiscordOriginalPosition.X.Offset+step.X,
                    DiscordOriginalPosition.Y.Scale,
                    DiscordOriginalPosition.Y.Offset
                )
            },step.Duration,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
            if DiscordShakeTween then DiscordShakeTween.Completed:Wait() end
        end
        if DiscordButton.Parent then DiscordButton.Position=DiscordOriginalPosition end
    end)

    local ok,err=pcall(function()
        if not setclipboard then error("Clipboard is unsupported") end
        setclipboard(DiscordLink)
    end)
    DiscordButton.BackgroundColor3=Matte.Normal
    if not ok then warn("[PYROVEX] DISCORD COPY ERROR: "..tostring(err)) end
    task.delay(1,function()
        if DiscordButton.Parent then DiscordButton.BackgroundColor3=Matte.Normal end
    end)
end)

local Minimize=New("TextButton",{
    Name="Minimize",Size=UDim2.fromOffset(30,30),Position=UDim2.new(1,-68,0,26),
    BackgroundColor3=Matte.Normal,Text="—",TextColor3=C.White,TextSize=18,
    Font=Enum.Font.GothamBlack,AutoButtonColor=false,BorderSizePixel=0,ZIndex=10
},Header)
Round(Minimize,9)
ButtonAnimation(Minimize,Matte.Normal,Matte.Hover)

local Close=New("TextButton",{
    Name="Close",Size=UDim2.fromOffset(30,30),Position=UDim2.new(1,-34,0,26),
    BackgroundColor3=Matte.Normal,Text="×",TextColor3=Matte.Text,
    TextSize=20,Font=Enum.Font.GothamBlack,AutoButtonColor=false,
    BorderSizePixel=0,ZIndex=10
},Header)
Round(Close,9)
ButtonAnimation(Close,Matte.Normal,Matte.Hover)

local SectionAccent=New("Frame",{
    Size=UDim2.fromOffset(3,11),Position=UDim2.fromOffset(12,108),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ZIndex=6
},Main)
Round(SectionAccent,4)
PremiumGradient(SectionAccent,90)

local SectionTitle=New("TextLabel",{
    Size=UDim2.new(1,-30,0,16),Position=UDim2.fromOffset(19,105),
    BackgroundTransparency=1,Text="SCRIPT COLLECTION",TextColor3=C.Gray,
    TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,
    Font=Enum.Font.GothamBlack,ZIndex=5
},Main)
local SectionSubtitle=New("TextLabel",{
    Size=UDim2.new(1,-30,0,12),Position=UDim2.fromOffset(19,120),
    BackgroundTransparency=1,
    Text="SELECT A CATEGORY TO EXPLORE AVAILABLE SCRIPTS",
    TextColor3=C.DarkGray,TextSize=6,
    TextXAlignment=Enum.TextXAlignment.Left,Font=Enum.Font.GothamMedium,ZIndex=5
},Main)

local Tabs=New("ScrollingFrame",{
    Name="Tabs",Size=UDim2.new(1,-28,0,36),Position=UDim2.fromOffset(14,139),
    BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,
    CanvasSize=UDim2.fromOffset(0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,
    ScrollingDirection=Enum.ScrollingDirection.X,ZIndex=5
},Main)
New("UIListLayout",{
    FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,8),
    SortOrder=Enum.SortOrder.LayoutOrder
},Tabs)

local Content=New("ScrollingFrame",{
    Name="Content",Size=UDim2.new(1,-28,1,-202),Position=UDim2.fromOffset(14,183),
    BackgroundColor3=C.Panel,BorderSizePixel=0,ClipsDescendants=true,
    ScrollBarThickness=3,ScrollBarImageColor3=C.Blue,
    ScrollBarImageTransparency=0.1,CanvasSize=UDim2.fromOffset(0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ScrollingDirection=Enum.ScrollingDirection.Y,ZIndex=5
},Main)
Round(Content,15)
local ContentStroke=Outline(Content,C.Border,1,0.2)
Gradient(Content,C.Panel,Color3.fromRGB(21, 21, 21),90)
New("UIPadding",{
    PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12),
    PaddingLeft=UDim.new(0,11),PaddingRight=UDim.new(0,11)
},Content)
New("UIListLayout",{
    Padding=UDim.new(0,11),SortOrder=Enum.SortOrder.LayoutOrder
},Content)

--==============================================================
-- SETTINGS PANEL: COMPACT CONTROLS + SCROLLABLE DRAWERS
--==============================================================
local SettingsPanel=New("ScrollingFrame",{
    Name="SettingsPanel",Size=UDim2.new(1,-28,1,-151),
    Position=UDim2.fromOffset(14,139),BackgroundColor3=C.Panel,
    BorderSizePixel=0,ClipsDescendants=true,Visible=false,ZIndex=8,
    ScrollBarThickness=3,ScrollBarImageColor3=C.Blue,
    ScrollBarImageTransparency=0.12,CanvasSize=UDim2.fromOffset(0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.None,
    ScrollingDirection=Enum.ScrollingDirection.Y
},Main)
Round(SettingsPanel,15)
local SettingsPanelStroke=Outline(SettingsPanel,C.Border,1,0.2)
local SettingsGradient=Gradient(SettingsPanel,C.Panel,Color3.fromRGB(21, 21, 21),90)

local SettingsAccent=New("Frame",{
    Size=UDim2.new(1,-28,0,2),Position=UDim2.fromOffset(14,0),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ZIndex=9
},SettingsPanel)
Round(SettingsAccent,5)
AnimateGradient(PremiumGradient(SettingsAccent,0),3)

local function MakeLabel(name,text,y,size,color)
    return New("TextLabel",{
        Name=name,Position=UDim2.fromOffset(18,y),
        Size=UDim2.new(1,-36,0,size+4),BackgroundTransparency=1,
        Text=text,TextColor3=color or C.White,TextSize=size,
        TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBlack,ZIndex=10
    },SettingsPanel)
end

MakeLabel("UISizeTitle","UI SIZE",13,11,C.White)
MakeLabel("UISizeDescription","ADJUST THE SIZE OF THE INTERFACE",32,7,C.Gray)

local UISizeValue=New("TextLabel",{
    Name="UISizeValue",Position=UDim2.new(1,-86,0,12),
    Size=UDim2.fromOffset(66,22),BackgroundColor3=Color3.fromRGB(34, 34, 34),
    Text="100%",TextColor3=C.LightBlue,TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Center,Font=Enum.Font.GothamBlack,
    BorderSizePixel=0,ZIndex=10
},SettingsPanel)
Round(UISizeValue,7)
Outline(UISizeValue,C.Border,1,0.2)

local SliderContainer=New("Frame",{
    Name="UISizeSlider",Position=UDim2.fromOffset(24,65),
    Size=UDim2.new(1,-48,0,34),BackgroundTransparency=1,
    BorderSizePixel=0,ZIndex=10
},SettingsPanel)
local SegmentTrack=New("Frame",{
    Name="SegmentTrack",Position=UDim2.fromOffset(0,12),
    Size=UDim2.new(1,0,0,10),BackgroundTransparency=1,
    BorderSizePixel=0,ZIndex=10
},SliderContainer)
New("UIListLayout",{
    FillDirection=Enum.FillDirection.Horizontal,
    HorizontalAlignment=Enum.HorizontalAlignment.Left,
    VerticalAlignment=Enum.VerticalAlignment.Center,
    Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder
},SegmentTrack)

local SliderSegments={}
for i=1,11 do
    local segment=New("Frame",{
        Name="Segment_"..i,Size=UDim2.new(1/11,-4,0,7),
        BackgroundColor3=Color3.fromRGB(45, 45, 45),
        BorderSizePixel=0,LayoutOrder=i,ZIndex=11
    },SegmentTrack)
    Round(segment,4)
    SliderSegments[i]=segment
end

local SliderHitbox=New("TextButton",{
    Name="SliderHitbox",Position=UDim2.fromOffset(0,0),
    Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=13
},SliderContainer)

local SliderKnob=New("Frame",{
    Name="SliderKnob",Size=UDim2.fromOffset(17,17),
    Position=UDim2.new(1,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),
    BackgroundColor3=C.White,BorderSizePixel=0,Rotation=45,ZIndex=15
},SliderContainer)
Round(SliderKnob,4)
Outline(SliderKnob,C.LightBlue,1.5,0)
local KnobCore=New("Frame",{
    Name="KnobCore",Size=UDim2.fromOffset(5,5),
    Position=UDim2.fromScale(0.5,0.5),AnchorPoint=Vector2.new(0.5,0.5),
    BackgroundColor3=C.Blue,BorderSizePixel=0,ZIndex=16
},SliderKnob)
Round(KnobCore,2)

local ScaleGuide=New("Frame",{
    Name="ScaleGuide",Position=UDim2.fromOffset(42,99),
    Size=UDim2.new(1,-84,0,13),BackgroundTransparency=1,
    BorderSizePixel=0,ZIndex=10
},SettingsPanel)
New("UIListLayout",{
    FillDirection=Enum.FillDirection.Horizontal,
    HorizontalAlignment=Enum.HorizontalAlignment.Center,
    VerticalAlignment=Enum.VerticalAlignment.Center,
    SortOrder=Enum.SortOrder.LayoutOrder
},ScaleGuide)
for i,labelText in ipairs({"50%","60%","70%","80%","90%","100%"}) do
    New("TextLabel",{
        Name="Guide_"..i,Size=UDim2.new(1/6,0,1,0),
        BackgroundTransparency=1,Text=labelText,TextColor3=C.DarkGray,
        TextSize=7,TextXAlignment=Enum.TextXAlignment.Center,
        Font=Enum.Font.GothamBold,LayoutOrder=i,ZIndex=10
    },ScaleGuide)
end

local UISizeDragging=false
local function UpdateUISizeSlider(value,animate)
    UISizePercent=math.clamp(math.floor(value+0.5),50,100)
    local percent=(UISizePercent-50)/50
    UISizeValue.Text=tostring(UISizePercent).."%"
    local knobPosition=UDim2.new(percent,0,0.5,0)
    if animate then Tween(SliderKnob,{Position=knobPosition},0.08)
    else SliderKnob.Position=knobPosition end
    for i,segment in ipairs(SliderSegments) do
        local active=(i-1)/10<=percent+0.001
        local target=active and (i<=4 and C.Blue or (i<=8 and C.Purple or C.Red))
            or Color3.fromRGB(45, 45, 45)
        if animate then Tween(segment,{BackgroundColor3=target},0.08)
        else segment.BackgroundColor3=target end
    end
    ApplyUISize(0.08)
end

local function SetUISizeFromPosition(position)
    local absolute=SliderContainer.AbsolutePosition
    local size=SliderContainer.AbsoluteSize
    if size.X<=0 then return end
    local x=math.clamp((position.X-absolute.X)/size.X,0,1)
    UpdateUISizeSlider(50+x*50,true)
end
local function StartSlider(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1
    or input.UserInputType==Enum.UserInputType.Touch then
        UISizeDragging=true
        SetUISizeFromPosition(input.Position)
    end
end
SliderHitbox.InputBegan:Connect(StartSlider)
SliderKnob.InputBegan:Connect(StartSlider)
UserInputService.InputChanged:Connect(function(input)
    if UISizeDragging and (input.UserInputType==Enum.UserInputType.MouseMovement
    or input.UserInputType==Enum.UserInputType.Touch) then
        SetUISizeFromPosition(input.Position)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1
    or input.UserInputType==Enum.UserInputType.Touch then
        UISizeDragging=false
    end
end)
UpdateUISizeSlider(100,false)

-- SETTINGS STATE
local SettingsFeatures={
    Glow=true,Blur=false,Neon=true,
    Transparency=0,AnimationSpeed=100
}
local CurrentAnimationStyle="SMOOTH"
local BlurEffect=Lighting:FindFirstChild("PyrovexSettingsBlur")
local CreatedBlur=false
if not BlurEffect then
    BlurEffect=Instance.new("BlurEffect")
    BlurEffect.Name="PyrovexSettingsBlur"
    BlurEffect.Size=0
    BlurEffect.Parent=Lighting
    CreatedBlur=true
end

local function MakeSettingButton(name,text,y,height)
    local button=New("TextButton",{
        Name=name,Position=UDim2.fromOffset(18,y),
        Size=UDim2.new(1,-36,0,height or 29),
        BackgroundColor3=Matte.Normal,Text=text,TextColor3=Matte.Text,
        TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBold,AutoButtonColor=false,
        BorderSizePixel=0,ZIndex=11
    },SettingsPanel)
    Round(button,8)
    New("UIPadding",{PaddingLeft=UDim.new(0,11),PaddingRight=UDim.new(0,8)},button)
    button.MouseEnter:Connect(function()
        Tween(button,{BackgroundColor3=Matte.Hover},0.12)
    end)
    button.MouseLeave:Connect(function()
        Tween(button,{BackgroundColor3=Matte.Normal},0.12)
    end)
    return button
end

local function MakeSectionTitle(text,y)
    return New("TextLabel",{
        Position=UDim2.fromOffset(19,y),Size=UDim2.new(1,-38,0,14),
        BackgroundTransparency=1,Text=text,TextColor3=C.LightBlue,
        TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBlack,ZIndex=10
    },SettingsPanel)
end

local function MakeToggle(name,label,y,initial,callback)
    local button=MakeSettingButton(name,label,y,28)
    local indicator=New("Frame",{
        Name="ToggleIndicator",Size=UDim2.fromOffset(32,16),
        Position=UDim2.new(1,-44,0.5,-8),
        BackgroundColor3=initial and Matte.Accent or Matte.Pressed,
        BorderSizePixel=0,ZIndex=12
    },button)
    Round(indicator,20)
    local knob=New("Frame",{
        Size=UDim2.fromOffset(12,12),
        Position=initial and UDim2.new(1,-14,0.5,-6) or UDim2.fromOffset(2,2),
        BackgroundColor3=C.White,BorderSizePixel=0,ZIndex=13
    },indicator)
    Round(knob,20)
    local enabled=initial
    local function Refresh()
        button.Text=label
        Tween(indicator,{BackgroundColor3=enabled and Matte.Accent or Matte.Pressed},0.15)
        Tween(knob,{
            Position=enabled and UDim2.new(1,-14,0.5,-6) or UDim2.fromOffset(2,2)
        },0.15,Enum.EasingStyle.Back)
    end
    button.MouseButton1Click:Connect(function()
        enabled=not enabled
        Refresh()
        callback(enabled)
    end)
    return button,function(value)
        enabled=value
        Refresh()
        callback(enabled)
    end
end

MakeSectionTitle("VISUAL EFFECTS",122)

local GlowToggle,SetGlow=MakeToggle(
    "GlowToggle","UI GLOW",140,true,function(enabled)
        SettingsFeatures.Glow=enabled
        OuterGlow.Visible=enabled
        OuterStroke.Enabled=enabled or SettingsFeatures.Neon
    end
)

local TransparencyLabel=MakeSectionTitle("UI TRANSPARENCY",176)
local TransparencyButton=MakeSettingButton("TransparencyButton","TRANSPARENCY: 0%",194,27)
local function ApplyTransparency()
    local amount=SettingsFeatures.Transparency/100
    Main.BackgroundTransparency=amount
    Header.BackgroundTransparency=amount*0.55
    Content.BackgroundTransparency=amount
    SettingsPanel.BackgroundTransparency=amount
    TransparencyButton.Text="TRANSPARENCY: "..SettingsFeatures.Transparency.."%"
end
MakeSectionTitle("ANIMATION SPEED",228)
local SpeedButton=MakeSettingButton("AnimationSpeedButton","ANIMATION SPEED: 100%",246,27)
local SpeedOptions={50,75,100,125,150,175,200}
local function ApplyAnimationSpeed()
    local styleMultipliers = {
        SMOOTH=1.00, BOUNCE=1.10, ELASTIC=1.22,
        SLIDE=0.92, ZOOM=0.88, FADE=0.78, SNAPPY=0.68
    }
    local factor=(100/SettingsFeatures.AnimationSpeed)
        *(styleMultipliers[CurrentAnimationStyle] or 1)
    for key,baseValue in pairs(BaseAnimation) do
        Animation[key]=baseValue*factor
    end
    SpeedButton.Text="ANIMATION SPEED: "..SettingsFeatures.AnimationSpeed.."%"
end
SpeedButton.MouseButton1Click:Connect(function()
    local index=table.find(SpeedOptions,SettingsFeatures.AnimationSpeed) or 3
    index=index%#SpeedOptions+1
    SettingsFeatures.AnimationSpeed=SpeedOptions[index]
    ApplyAnimationSpeed()
end)

MakeSectionTitle("BACKGROUND EFFECTS",280)
local BlurToggle,SetBlur=MakeToggle(
    "BlurToggle","UI BACKGROUND BLUR",298,false,function(enabled)
        SettingsFeatures.Blur=enabled
        Tween(BlurEffect,{Size=enabled and 12 or 0},0.22)
    end
)
local NeonToggle,SetNeon=MakeToggle(
    "NeonToggle","NEON EFFECTS",332,true,function(enabled)
        SettingsFeatures.Neon=enabled
        TopAccent.Visible=enabled
        SettingsAccent.Visible=enabled
        OuterStroke.Enabled=enabled or SettingsFeatures.Glow
    end
)

MakeSectionTitle("APPEARANCE",370)

local ThemeNames={"PURPLE NEON","OCEAN BLUE","CRIMSON RED","CYBERPUNK","MIDNIGHT","EMERALD","DARK","GRAY","SUNSET","ROSE","GOLD","ARCTIC","MATRIX","LAVENDER","MONOCHROME"}
local Themes={
    ["PURPLE NEON"]={
        Blue=Color3.fromRGB(101, 101, 101),LightBlue=Color3.fromRGB(163, 163, 163),
        DarkBlue=Color3.fromRGB(38, 38, 38),Purple=Color3.fromRGB(111, 111, 111),
        LightPurple=Color3.fromRGB(192, 192, 192),Red=Color3.fromRGB(78, 78, 78),
        LightRed=Color3.fromRGB(144, 144, 144),Background=Color3.fromRGB(3, 3, 3),
        Background2=Color3.fromRGB(6, 6, 6),Header=Color3.fromRGB(10, 10, 10),
        Header2=Color3.fromRGB(17, 17, 17),Panel=Color3.fromRGB(5, 5, 5),
        Card=Color3.fromRGB(13, 13, 13),CardHover=Color3.fromRGB(25, 25, 25),
        Border=Color3.fromRGB(59, 59, 59),CopyBackground=Color3.fromRGB(28, 28, 28)
    },
    ["OCEAN BLUE"]={
        Blue=Color3.fromRGB(127, 127, 127),LightBlue=Color3.fromRGB(199, 199, 199),
        DarkBlue=Color3.fromRGB(59, 59, 59),Purple=Color3.fromRGB(114, 114, 114),
        LightPurple=Color3.fromRGB(184, 184, 184),Red=Color3.fromRGB(169, 169, 169),
        LightRed=Color3.fromRGB(215, 215, 215),Background=Color3.fromRGB(9, 9, 9),
        Background2=Color3.fromRGB(18, 18, 18),Header=Color3.fromRGB(23, 23, 23),
        Header2=Color3.fromRGB(34, 34, 34),Panel=Color3.fromRGB(16, 16, 16),
        Card=Color3.fromRGB(28, 28, 28),CardHover=Color3.fromRGB(44, 44, 44),
        Border=Color3.fromRGB(68, 68, 68),CopyBackground=Color3.fromRGB(49, 49, 49)
    },
    ["CRIMSON RED"]={
        Blue=Color3.fromRGB(95, 95, 95),LightBlue=Color3.fromRGB(161, 161, 161),
        DarkBlue=Color3.fromRGB(42, 42, 42),Purple=Color3.fromRGB(75, 75, 75),
        LightPurple=Color3.fromRGB(172, 172, 172),Red=Color3.fromRGB(91, 91, 91),
        LightRed=Color3.fromRGB(153, 153, 153),Background=Color3.fromRGB(8, 8, 8),
        Background2=Color3.fromRGB(13, 13, 13),Header=Color3.fromRGB(17, 17, 17),
        Header2=Color3.fromRGB(22, 22, 22),Panel=Color3.fromRGB(10, 10, 10),
        Card=Color3.fromRGB(19, 19, 19),CardHover=Color3.fromRGB(31, 31, 31),
        Border=Color3.fromRGB(50, 50, 50),CopyBackground=Color3.fromRGB(32, 32, 32)
    },
    ["CYBERPUNK"]={
        Blue=Color3.fromRGB(184, 184, 184),LightBlue=Color3.fromRGB(226, 226, 226),
        DarkBlue=Color3.fromRGB(79, 79, 79),Purple=Color3.fromRGB(101, 101, 101),
        LightPurple=Color3.fromRGB(174, 174, 174),Red=Color3.fromRGB(106, 106, 106),
        LightRed=Color3.fromRGB(173, 173, 173),Background=Color3.fromRGB(8, 8, 8),
        Background2=Color3.fromRGB(11, 11, 11),Header=Color3.fromRGB(17, 17, 17),
        Header2=Color3.fromRGB(16, 16, 16),Panel=Color3.fromRGB(14, 14, 14),
        Card=Color3.fromRGB(22, 22, 22),CardHover=Color3.fromRGB(37, 37, 37),
        Border=Color3.fromRGB(87, 87, 87),CopyBackground=Color3.fromRGB(45, 45, 45)
    },
    ["MIDNIGHT"]={
        Blue=Color3.fromRGB(133, 133, 133),LightBlue=Color3.fromRGB(193, 193, 193),
        DarkBlue=Color3.fromRGB(59, 59, 59),Purple=Color3.fromRGB(114, 114, 114),
        LightPurple=Color3.fromRGB(183, 183, 183),Red=Color3.fromRGB(113, 113, 113),
        LightRed=Color3.fromRGB(171, 171, 171),Background=Color3.fromRGB(7, 7, 7),
        Background2=Color3.fromRGB(15, 15, 15),Header=Color3.fromRGB(19, 19, 19),
        Header2=Color3.fromRGB(24, 24, 24),Panel=Color3.fromRGB(12, 12, 12),
        Card=Color3.fromRGB(22, 22, 22),CardHover=Color3.fromRGB(38, 38, 38),
        Border=Color3.fromRGB(65, 65, 65),CopyBackground=Color3.fromRGB(43, 43, 43)
    },
    ["EMERALD"]={
        Blue=Color3.fromRGB(150, 150, 150),LightBlue=Color3.fromRGB(215, 215, 215),
        DarkBlue=Color3.fromRGB(80, 80, 80),Purple=Color3.fromRGB(138, 138, 138),
        LightPurple=Color3.fromRGB(213, 213, 213),Red=Color3.fromRGB(182, 182, 182),
        LightRed=Color3.fromRGB(228, 228, 228),Background=Color3.fromRGB(12, 12, 12),
        Background2=Color3.fromRGB(21, 21, 21),Header=Color3.fromRGB(26, 26, 26),
        Header2=Color3.fromRGB(35, 35, 35),Panel=Color3.fromRGB(17, 17, 17),
        Card=Color3.fromRGB(29, 29, 29),CardHover=Color3.fromRGB(46, 46, 46),
        Border=Color3.fromRGB(77, 77, 77),CopyBackground=Color3.fromRGB(54, 54, 54)
    }
}


-- Nine additional full-interface palettes (15 themes total).
local function BuildTheme(primary, light, deep, purple, lightPurple, accentRed,
    background, background2, header, panel, card, hover, border, copy)
    return {
        Blue=primary, LightBlue=light, DarkBlue=deep,
        Purple=purple, LightPurple=lightPurple,
        Red=accentRed, LightRed=accentRed:Lerp(Color3.new(1,1,1),0.38),
        Background=background, Background2=background2,
        Header=header, Header2=header:Lerp(purple,0.28),
        Panel=panel, Card=card, CardHover=hover,
        Border=border, CopyBackground=copy
    }
end

Themes["DARK"] = BuildTheme(
    Color3.fromRGB(114, 114, 114), Color3.fromRGB(197, 197, 197),
    Color3.fromRGB(48, 48, 48), Color3.fromRGB(105, 105, 105),
    Color3.fromRGB(184, 184, 184), Color3.fromRGB(134, 134, 134),
    Color3.fromRGB(6, 6, 6), Color3.fromRGB(12, 12, 12),
    Color3.fromRGB(16, 16, 16), Color3.fromRGB(11, 11, 11),
    Color3.fromRGB(23, 23, 23), Color3.fromRGB(39, 39, 39),
    Color3.fromRGB(62, 62, 62), Color3.fromRGB(39, 39, 39)
)
Themes["GRAY"] = BuildTheme(
    Color3.fromRGB(134, 134, 134), Color3.fromRGB(211, 211, 211),
    Color3.fromRGB(61, 61, 61), Color3.fromRGB(114, 114, 114),
    Color3.fromRGB(197, 197, 197), Color3.fromRGB(152, 152, 152),
    Color3.fromRGB(20, 20, 20), Color3.fromRGB(30, 30, 30),
    Color3.fromRGB(39, 39, 39), Color3.fromRGB(26, 26, 26),
    Color3.fromRGB(47, 47, 47), Color3.fromRGB(63, 63, 63),
    Color3.fromRGB(88, 88, 88), Color3.fromRGB(62, 62, 62)
)
Themes["SUNSET"] = BuildTheme(
    Color3.fromRGB(149, 149, 149), Color3.fromRGB(201, 201, 201),
    Color3.fromRGB(70, 70, 70), Color3.fromRGB(113, 113, 113),
    Color3.fromRGB(190, 190, 190), Color3.fromRGB(128, 128, 128),
    Color3.fromRGB(12, 12, 12), Color3.fromRGB(20, 20, 20),
    Color3.fromRGB(26, 26, 26), Color3.fromRGB(16, 16, 16),
    Color3.fromRGB(29, 29, 29), Color3.fromRGB(41, 41, 41),
    Color3.fromRGB(62, 62, 62), Color3.fromRGB(41, 41, 41)
)
Themes["ROSE"] = BuildTheme(
    Color3.fromRGB(134, 134, 134), Color3.fromRGB(195, 195, 195),
    Color3.fromRGB(56, 56, 56), Color3.fromRGB(115, 115, 115),
    Color3.fromRGB(183, 183, 183), Color3.fromRGB(138, 138, 138),
    Color3.fromRGB(10, 10, 10), Color3.fromRGB(17, 17, 17),
    Color3.fromRGB(22, 22, 22), Color3.fromRGB(13, 13, 13),
    Color3.fromRGB(25, 25, 25), Color3.fromRGB(38, 38, 38),
    Color3.fromRGB(60, 60, 60), Color3.fromRGB(37, 37, 37)
)
Themes["GOLD"] = BuildTheme(
    Color3.fromRGB(158, 158, 158), Color3.fromRGB(221, 221, 221),
    Color3.fromRGB(78, 78, 78), Color3.fromRGB(130, 130, 130),
    Color3.fromRGB(202, 202, 202), Color3.fromRGB(171, 171, 171),
    Color3.fromRGB(13, 13, 13), Color3.fromRGB(23, 23, 23),
    Color3.fromRGB(31, 31, 31), Color3.fromRGB(18, 18, 18),
    Color3.fromRGB(34, 34, 34), Color3.fromRGB(50, 50, 50),
    Color3.fromRGB(80, 80, 80), Color3.fromRGB(50, 50, 50)
)
Themes["ARCTIC"] = BuildTheme(
    Color3.fromRGB(170, 170, 170), Color3.fromRGB(223, 223, 223),
    Color3.fromRGB(79, 79, 79), Color3.fromRGB(138, 138, 138),
    Color3.fromRGB(206, 206, 206), Color3.fromRGB(184, 184, 184),
    Color3.fromRGB(13, 13, 13), Color3.fromRGB(22, 22, 22),
    Color3.fromRGB(30, 30, 30), Color3.fromRGB(19, 19, 19),
    Color3.fromRGB(35, 35, 35), Color3.fromRGB(51, 51, 51),
    Color3.fromRGB(81, 81, 81), Color3.fromRGB(50, 50, 50)
)
Themes["MATRIX"] = BuildTheme(
    Color3.fromRGB(160, 160, 160), Color3.fromRGB(224, 224, 224),
    Color3.fromRGB(74, 74, 74), Color3.fromRGB(127, 127, 127),
    Color3.fromRGB(214, 214, 214), Color3.fromRGB(186, 186, 186),
    Color3.fromRGB(10, 10, 10), Color3.fromRGB(18, 18, 18),
    Color3.fromRGB(25, 25, 25), Color3.fromRGB(14, 14, 14),
    Color3.fromRGB(27, 27, 27), Color3.fromRGB(44, 44, 44),
    Color3.fromRGB(72, 72, 72), Color3.fromRGB(46, 46, 46)
)
Themes["LAVENDER"] = BuildTheme(
    Color3.fromRGB(139, 139, 139), Color3.fromRGB(204, 204, 204),
    Color3.fromRGB(65, 65, 65), Color3.fromRGB(139, 139, 139),
    Color3.fromRGB(200, 200, 200), Color3.fromRGB(151, 151, 151),
    Color3.fromRGB(10, 10, 10), Color3.fromRGB(17, 17, 17),
    Color3.fromRGB(23, 23, 23), Color3.fromRGB(14, 14, 14),
    Color3.fromRGB(28, 28, 28), Color3.fromRGB(41, 41, 41),
    Color3.fromRGB(66, 66, 66), Color3.fromRGB(40, 40, 40)
)
Themes["MONOCHROME"] = BuildTheme(
    Color3.fromRGB(160, 160, 160), Color3.fromRGB(228, 228, 228),
    Color3.fromRGB(68, 68, 68), Color3.fromRGB(130, 130, 130),
    Color3.fromRGB(210, 210, 210), Color3.fromRGB(180, 180, 180),
    Color3.fromRGB(9, 9, 9), Color3.fromRGB(17, 17, 17),
    Color3.fromRGB(25, 25, 25), Color3.fromRGB(14, 14, 14),
    Color3.fromRGB(30, 30, 30), Color3.fromRGB(47, 47, 47),
    Color3.fromRGB(75, 75, 75), Color3.fromRGB(47, 47, 47)
)

local UIStyles={"GLASSMORPHISM","NEON","MINIMAL","MODERN","PREMIUM"}
local AnimationStyles={"SMOOTH","BOUNCE","ELASTIC","SLIDE","ZOOM","FADE","SNAPPY"}
local CurrentTheme="PURPLE NEON"
local CurrentStyle="PREMIUM"
local ThemeDrawerOpen=false
local StyleDrawerOpen=false
local AnimationDrawerOpen=false

local ThemeButton=MakeSettingButton("ThemeDrawerButton","SELECT THEME   ▼",392,29)
local ThemeOptionsFrame=New("Frame",{
    Name="ThemeOptions",Position=UDim2.fromOffset(18,425),
    Size=UDim2.new(1,-36,0,0),BackgroundTransparency=1,
    Visible=false,ClipsDescendants=true,BorderSizePixel=0,ZIndex=10
},SettingsPanel)

local StyleButton=MakeSettingButton("StyleDrawerButton","SELECT UI STYLE   ▼",428,29)
local StyleOptionsFrame=New("Frame",{
    Name="StyleOptions",Position=UDim2.fromOffset(18,461),
    Size=UDim2.new(1,-36,0,0),BackgroundTransparency=1,
    Visible=false,ClipsDescendants=true,BorderSizePixel=0,ZIndex=10
},SettingsPanel)

local AnimationButton=MakeSettingButton("AnimationDrawerButton","SELECT ANIMATION STYLE   ▼",464,29)
local AnimationOptionsFrame=New("Frame",{
    Name="AnimationOptions",Position=UDim2.fromOffset(18,497),
    Size=UDim2.new(1,-36,0,0),BackgroundTransparency=1,
    Visible=false,ClipsDescendants=true,BorderSizePixel=0,ZIndex=10
},SettingsPanel)

local ThemeOptionButtons={}
local StyleOptionButtons={}
local AnimationOptionButtons={}
local ExtraSettingsTitle, ReflectionToggle, HoverToggle, BrightnessButton

local DrawerTweenTokens = {
    Theme = 0,
    Style = 0,
    Animation = 0
}

local function AnimateDrawer(frame, isOpen, itemButtons, itemCount, tokenName)
    local token = (DrawerTweenTokens[tokenName] or 0) + 1
    DrawerTweenTokens[tokenName] = token

    local targetHeight = isOpen and (itemCount * 27) or 0
    if isOpen then
        frame.Visible = true
        frame.Size = UDim2.new(1, -36, 0, 0)
    end

    for index, option in ipairs(itemButtons) do
        local targetPosition = UDim2.fromOffset(0, (index - 1) * 27)
        if isOpen then
            option.Position = UDim2.fromOffset(0, (index - 1) * 27 - 10)
            option.TextTransparency = 1
            option.BackgroundTransparency = 1
            Tween(option, {
                Position = targetPosition,
                TextTransparency = 0,
                BackgroundTransparency = 0
            }, 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        else
            Tween(option, {
                Position = UDim2.fromOffset(0, (index - 1) * 27 - 7),
                TextTransparency = 1,
                BackgroundTransparency = 1
            }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        end
    end

    local drawerTween = Tween(frame, {
        Size = UDim2.new(1, -36, 0, targetHeight)
    }, isOpen and 0.38 or 0.22,
        isOpen and Enum.EasingStyle.Quint or Enum.EasingStyle.Quad,
        isOpen and Enum.EasingDirection.Out or Enum.EasingDirection.In)

    if not isOpen then
        task.spawn(function()
            if drawerTween then drawerTween.Completed:Wait() end
            if DrawerTweenTokens[tokenName] == token and frame.Parent then
                frame.Visible = false
                for index, option in ipairs(itemButtons) do
                    if option.Parent then
                        option.Position = UDim2.fromOffset(0, (index - 1) * 27)
                        option.TextTransparency = 0
                        option.BackgroundTransparency = 0
                    end
                end
            end
        end)
    end
end

local function UpdateDrawerLayout()
    ThemeButton.Text="SELECT THEME   "..(ThemeDrawerOpen and "▲" or "▼")
    local themeY=ThemeButton.Position.Y.Offset+34
    ThemeOptionsFrame.Position=UDim2.fromOffset(18,themeY)
    AnimateDrawer(ThemeOptionsFrame, ThemeDrawerOpen, ThemeOptionButtons,
        #ThemeNames, "Theme")

    local styleY=themeY+(ThemeDrawerOpen and (#ThemeNames*27+8) or 0)
    Tween(StyleButton,{Position=UDim2.fromOffset(18,styleY)},0.34,
        Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    StyleButton.Text="SELECT UI STYLE   "..(StyleDrawerOpen and "▲" or "▼")
    local styleOptionsY=styleY+34
    Tween(StyleOptionsFrame,{Position=UDim2.fromOffset(18,styleOptionsY)},0.34,
        Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    AnimateDrawer(StyleOptionsFrame, StyleDrawerOpen, StyleOptionButtons,
        #UIStyles, "Style")

    local animationY=styleOptionsY+(StyleDrawerOpen and (#UIStyles*27+8) or 0)
    Tween(AnimationButton,{Position=UDim2.fromOffset(18,animationY)},0.34,
        Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    AnimationButton.Text="SELECT ANIMATION STYLE   "..(AnimationDrawerOpen and "▲" or "▼")
    local animationOptionsY=animationY+34
    Tween(AnimationOptionsFrame,{Position=UDim2.fromOffset(18,animationOptionsY)},0.34,
        Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    AnimateDrawer(AnimationOptionsFrame, AnimationDrawerOpen,
        AnimationOptionButtons, #AnimationStyles, "Animation")

    local extraY=animationOptionsY+(AnimationDrawerOpen and (#AnimationStyles*27+8) or 0)+14
    if ExtraSettingsTitle then
        Tween(ExtraSettingsTitle,{Position=UDim2.fromOffset(19,extraY)},0.36,
            Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
        Tween(ReflectionToggle,{Position=UDim2.fromOffset(18,extraY+18)},0.36,
            Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
        Tween(HoverToggle,{Position=UDim2.fromOffset(18,extraY+50)},0.36,
            Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
        Tween(BrightnessButton,{Position=UDim2.fromOffset(18,extraY+82)},0.36,
            Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    end
    local canvasBottom=extraY+122
    SettingsPanel.CanvasSize=UDim2.fromOffset(0,math.max(470,canvasBottom))
end

local function RefreshThemeColors()
    local lift = GlassBrightnessSteps[GlassBrightnessLevel] or 0.68
    Matte.Normal = C.Card:Lerp(C.Blue, lift):Lerp(C.LightBlue, lift * 0.78):Lerp(C.Purple, 0.12)
    Matte.Hover = C.CardHover:Lerp(C.Blue, math.min(lift + 0.06, 0.90)):Lerp(C.LightBlue, math.min(lift + 0.12, 0.94))
    Matte.Pressed = C.Card:Lerp(C.Blue, math.min(lift + 0.04, 0.90)):Lerp(C.LightBlue, lift * 0.62):Lerp(C.Purple, 0.16)
    Matte.Border = C.LightBlue
    Matte.Accent = C.LightBlue
    Matte.Text = C.White
    Matte.Secondary = C.Gray
    Main.BackgroundColor3=C.Background
    Header.BackgroundColor3=C.Header
    Content.BackgroundColor3=C.Panel
    SettingsPanel.BackgroundColor3=C.Panel
    OuterStroke.Color=C.LightBlue
    OuterGlowStroke.Color=C.Purple
    HeaderStroke.Color=C.Border
    ContentStroke.Color=C.Border
    SettingsPanelStroke.Color=C.Border
    SettingsAccent.BackgroundColor3=C.Blue
    TopAccent.BackgroundColor3=C.Blue
    SectionAccent.BackgroundColor3=C.Blue
    StatusDot.BackgroundColor3=C.Green
    Logo.BackgroundColor3=C.Blue
    LoadingAccent.BackgroundColor3=C.Blue
    LoadingStroke.Color=C.Blue
    LoadingPercentage.TextColor3=C.LightBlue
    for _,child in ipairs(SliderKnob:GetChildren()) do
        if child:IsA("UIStroke") then child.Color=C.LightBlue end
    end
    KnobCore.BackgroundColor3=C.Blue
    for _,segment in ipairs(SliderSegments) do
        segment.BackgroundColor3=Color3.fromRGB(45, 45, 45)
    end
    UpdateUISizeSlider(UISizePercent,false)

    for _,obj in ipairs(Screen:GetDescendants()) do
        if obj:IsA("GuiButton") then
            obj.BackgroundColor3 = Matte.Normal
            ApplyLiquidGlassButton(obj)
        elseif obj:IsA("Frame") and obj.Name=="Card" then
            obj.BackgroundColor3=C.Card
        elseif obj:IsA("UIStroke") then
            if obj.Name=="CardStroke" then obj.Color=C.Border end
        elseif obj:IsA("UIGradient") then
            if obj.Parent==Main then
                obj.Color=ColorSequence.new(C.Background,C.Background2)
            elseif obj.Parent==Header then
                obj.Color=ColorSequence.new(C.Header,C.Header2)
            elseif obj.Parent==Content or obj.Parent==SettingsPanel then
                obj.Color=ColorSequence.new(C.Panel,C.Background2)
            end
        end
    end

    for _,obj in ipairs(SettingsPanel:GetDescendants()) do
        if obj:IsA("TextButton") then
            obj.BackgroundColor3=Matte.Normal
            for _,child in ipairs(obj:GetChildren()) do
                if child:IsA("UIStroke") then child:Destroy() end
            end
        end
    end
    for _,button in ipairs(ThemeOptionButtons) do
        local active=button.Name=="Theme_"..CurrentTheme
        button.BackgroundColor3=Matte.Normal
        local accent=button:FindFirstChild("MatteSelectedAccent")
        if accent then accent.Visible=active end
        button.TextColor3=active and Matte.Text or Matte.Secondary
    end
    for _,button in ipairs(StyleOptionButtons) do
        local active=button.Name=="Style_"..CurrentStyle
        button.BackgroundColor3=Matte.Normal
        local accent=button:FindFirstChild("MatteSelectedAccent")
        if accent then accent.Visible=active end
        button.TextColor3=active and Matte.Text or Matte.Secondary
    end
    for _,button in ipairs(AnimationOptionButtons) do
        local active=button.Name=="Animation_"..CurrentAnimationStyle
        button.BackgroundColor3=Matte.Normal
        local accent=button:FindFirstChild("MatteSelectedAccent")
        if accent then accent.Visible=active end
        button.TextColor3=active and Matte.Text or Matte.Secondary
    end
end

local function ApplyAnimationStyle(styleName)
    if not table.find(AnimationStyles,styleName) then return end
    CurrentAnimationStyle=styleName
    local durationMultipliers = {
        SMOOTH=1.00, BOUNCE=1.10, ELASTIC=1.22,
        SLIDE=0.92, ZOOM=0.88, FADE=0.78, SNAPPY=0.68
    }
    local multiplier=durationMultipliers[styleName] or 1
    local speedFactor=100/(SettingsFeatures.AnimationSpeed or 100)
    for key,baseValue in pairs(BaseAnimation) do
        Animation[key]=baseValue*speedFactor*multiplier
    end
    for _,button in ipairs(AnimationOptionButtons) do
        local active=button.Name=="Animation_"..styleName
        button.BackgroundColor3=Matte.Normal
        button.TextColor3=active and Matte.Text or Matte.Secondary
        local accent=button:FindFirstChild("MatteSelectedAccent")
        if accent then accent.Visible=active end
    end
    AnimationDrawerOpen=false
    UpdateDrawerLayout()
end

local function ApplyTheme(themeName)
    local palette=Themes[themeName]
    if not palette then return end
    CurrentTheme=themeName
    for key,value in pairs(palette) do C[key]=value end
    RefreshThemeColors()
    ThemeDrawerOpen=false
    UpdateDrawerLayout()
end

local function ApplyUIStyle(styleName)
    CurrentStyle=styleName
    if styleName=="GLASSMORPHISM" then
        Main.BackgroundTransparency=math.max(SettingsFeatures.Transparency/100,0.12)
        Header.BackgroundTransparency=0.18
        Content.BackgroundTransparency=0.14
        SettingsPanel.BackgroundTransparency=0.14
        OuterStroke.Thickness=2
        OuterStroke.Transparency=0.15
        OuterGlow.Visible=SettingsFeatures.Glow
    elseif styleName=="NEON" then
        Main.BackgroundTransparency=SettingsFeatures.Transparency/100
        Header.BackgroundTransparency=0
        Content.BackgroundTransparency=0
        SettingsPanel.BackgroundTransparency=0
        OuterStroke.Thickness=3
        OuterStroke.Transparency=0
        OuterGlow.Visible=SettingsFeatures.Glow
        SettingsFeatures.Neon=true
        TopAccent.Visible=true
        SettingsAccent.Visible=true
    elseif styleName=="MINIMAL" then
        Main.BackgroundTransparency=SettingsFeatures.Transparency/100
        Header.BackgroundTransparency=0
        Content.BackgroundTransparency=0
        SettingsPanel.BackgroundTransparency=0
        OuterStroke.Thickness=1
        OuterStroke.Transparency=0.45
        OuterGlow.Visible=false
        TopAccent.Visible=false
        SettingsAccent.Visible=false
    elseif styleName=="MODERN" then
        Main.BackgroundTransparency=SettingsFeatures.Transparency/100
        Header.BackgroundTransparency=0.04
        Content.BackgroundTransparency=0.03
        SettingsPanel.BackgroundTransparency=0.03
        OuterStroke.Thickness=1.5
        OuterStroke.Transparency=0.22
        OuterGlow.Visible=SettingsFeatures.Glow
    elseif styleName=="PREMIUM" then
        Main.BackgroundTransparency=SettingsFeatures.Transparency/100
        Header.BackgroundTransparency=0
        Content.BackgroundTransparency=0
        SettingsPanel.BackgroundTransparency=0
        OuterStroke.Thickness=2.5
        OuterStroke.Transparency=0.05
        OuterGlow.Visible=SettingsFeatures.Glow
        TopAccent.Visible=SettingsFeatures.Neon
        SettingsAccent.Visible=SettingsFeatures.Neon
    end
    for _,button in ipairs(StyleOptionButtons) do
        local active=button.Name=="Style_"..styleName
        button.BackgroundColor3=Matte.Normal
        button.TextColor3=active and Matte.Text or Matte.Secondary
        local accent=button:FindFirstChild("MatteSelectedAccent")
        if accent then accent.Visible=active end
    end
    StyleDrawerOpen=false
    UpdateDrawerLayout()
end

for i,name in ipairs(ThemeNames) do
    local option=New("TextButton",{
        Name="Theme_"..name,Position=UDim2.fromOffset(0,(i-1)*27),
        Size=UDim2.new(1,0,0,24),BackgroundColor3=C.Card,
        Text=name,TextColor3=C.White,TextSize=8,
        Font=Enum.Font.GothamBold,AutoButtonColor=false,
        BorderSizePixel=0,ZIndex=12
    },ThemeOptionsFrame)
    Round(option,9)
    local selectedAccent=New("Frame",{Name="MatteSelectedAccent",Size=UDim2.fromOffset(3,14),Position=UDim2.fromOffset(5,5),BackgroundColor3=Matte.Accent,BorderSizePixel=0,Visible=false,ZIndex=14},option)
    Round(selectedAccent,3)
    table.insert(ThemeOptionButtons,option)
    option.MouseButton1Click:Connect(function() ApplyTheme(name) end)
end

for i,name in ipairs(UIStyles) do
    local option=New("TextButton",{
        Name="Style_"..name,Position=UDim2.fromOffset(0,(i-1)*27),
        Size=UDim2.new(1,0,0,24),BackgroundColor3=C.Card,
        Text=name,TextColor3=C.White,TextSize=8,
        Font=Enum.Font.GothamBold,AutoButtonColor=false,
        BorderSizePixel=0,ZIndex=12
    },StyleOptionsFrame)
    Round(option,9)
    local selectedAccent=New("Frame",{Name="MatteSelectedAccent",Size=UDim2.fromOffset(3,14),Position=UDim2.fromOffset(5,5),BackgroundColor3=Matte.Accent,BorderSizePixel=0,Visible=false,ZIndex=14},option)
    Round(selectedAccent,3)
    table.insert(StyleOptionButtons,option)
    option.MouseButton1Click:Connect(function() ApplyUIStyle(name) end)
end

for i,name in ipairs(AnimationStyles) do
    local option=New("TextButton",{
        Name="Animation_"..name,Position=UDim2.fromOffset(0,(i-1)*27),
        Size=UDim2.new(1,0,0,24),BackgroundColor3=C.Card,
        Text=name,TextColor3=C.White,TextSize=8,
        Font=Enum.Font.GothamBold,AutoButtonColor=false,
        BorderSizePixel=0,ZIndex=12
    },AnimationOptionsFrame)
    Round(option,9)
    local selectedAccent=New("Frame",{
        Name="MatteSelectedAccent",Size=UDim2.fromOffset(3,14),
        Position=UDim2.fromOffset(5,5),BackgroundColor3=Matte.Accent,
        BorderSizePixel=0,Visible=false,ZIndex=14
    },option)
    Round(selectedAccent,3)
    table.insert(AnimationOptionButtons,option)
    option.MouseButton1Click:Connect(function() ApplyAnimationStyle(name) end)
end
AnimationButton.MouseButton1Click:Connect(function()
    AnimationDrawerOpen=not AnimationDrawerOpen
    if AnimationDrawerOpen then ThemeDrawerOpen=false; StyleDrawerOpen=false end
    UpdateDrawerLayout()
end)


-- THREE ADDITIONAL UI SETTINGS (visual-only; existing script actions stay unchanged)
ExtraSettingsTitle=MakeSectionTitle("LIQUID GLASS CONTROLS",500)
ReflectionToggle=MakeToggle(
    "GlassReflectionToggle","LIQUID GLASS REFLECTION",518,true,function(enabled)
        GlassReflectionEnabled=enabled
        for _,obj in ipairs(Screen:GetDescendants()) do
            if obj:IsA("GuiButton") and obj.Name~="FloatingButton" then
                local gradient=obj:FindFirstChild("PyrovexLiquidGlassGradient")
                if gradient then
                    gradient.Transparency=enabled and NumberSequence.new({
                        NumberSequenceKeypoint.new(0,0.02),
                        NumberSequenceKeypoint.new(0.42,0.07),
                        NumberSequenceKeypoint.new(1,0.025)
                    }) or NumberSequence.new(0.12)
                end
            end
        end
    end
)
HoverToggle=MakeToggle(
    "GlassHoverToggle","SOFT HOVER RESPONSE",550,true,function(enabled)
        GlassHoverEnabled=enabled
    end
)
BrightnessButton=MakeSettingButton("GlassBrightnessButton","BUTTON BRIGHTNESS: LEVEL 4",582,28)
local function ApplyGlassBrightness()
    local lift=GlassBrightnessSteps[GlassBrightnessLevel]
    Matte.Normal=C.Card:Lerp(C.Blue,lift):Lerp(C.LightBlue,lift*0.78):Lerp(C.Purple,0.12)
    Matte.Hover=C.CardHover:Lerp(C.Blue,math.min(lift+0.06,0.90)):Lerp(C.LightBlue,math.min(lift+0.12,0.94))
    Matte.Pressed=C.Card:Lerp(C.Blue,math.min(lift+0.04,0.90)):Lerp(C.LightBlue,lift*0.62):Lerp(C.Purple,0.16)
    BrightnessButton.Text="BUTTON BRIGHTNESS: LEVEL "..GlassBrightnessLevel
    for _,obj in ipairs(Screen:GetDescendants()) do
        if obj:IsA("GuiButton") and obj.Name~="FloatingButton" then
            obj.BackgroundColor3=Matte.Normal
            local gradient=obj:FindFirstChild("PyrovexLiquidGlassGradient")
            if gradient then gradient.Color=GlassColors(Matte.Normal) end
        end
    end
end
BrightnessButton.MouseButton1Click:Connect(function()
    GlassBrightnessLevel=GlassBrightnessLevel%#GlassBrightnessSteps+1
    ApplyGlassBrightness()
end)

ThemeButton.MouseButton1Click:Connect(function()
    ThemeDrawerOpen=not ThemeDrawerOpen
    if ThemeDrawerOpen then
        StyleDrawerOpen=false
        AnimationDrawerOpen=false
    end
    UpdateDrawerLayout()
end)
StyleButton.MouseButton1Click:Connect(function()
    StyleDrawerOpen=not StyleDrawerOpen
    if StyleDrawerOpen then
        ThemeDrawerOpen=false
        AnimationDrawerOpen=false
    end
    UpdateDrawerLayout()
end)

TransparencyButton.MouseButton1Click:Connect(function()
    SettingsFeatures.Transparency=(SettingsFeatures.Transparency+10)%60
    ApplyTransparency()
end)

-- Keep current UI style and toggles in sync when transparency changes.
local oldApplyTransparency=ApplyTransparency
ApplyTransparency=function()
    oldApplyTransparency()
    if CurrentStyle=="GLASSMORPHISM" then
        Main.BackgroundTransparency=math.max(SettingsFeatures.Transparency/100,0.12)
    end
end

-- Initial drawer layout and default theme/style.
UpdateDrawerLayout()
ApplyTheme("PURPLE NEON")
ApplyUIStyle("PREMIUM")

--==============================================================
-- SETTINGS NAVIGATION
--==============================================================
local SettingsOpen=false
local SettingsRotation = 0
local SettingsRotationTween
local SettingsPanelTween

SettingsButton.MouseButton1Click:Connect(function()
    SettingsOpen=not SettingsOpen

    if SettingsPanelTween then SettingsPanelTween:Cancel() end
    if SettingsRotationTween then SettingsRotationTween:Cancel() end
    -- Alternate direction on every press: clockwise into Settings, counter-
    -- clockwise back to the original orientation when leaving Settings.
    SettingsRotation = SettingsRotation + (SettingsOpen and 90 or -90)
    SettingsRotationTween = Tween(SettingsButton,{Rotation=SettingsRotation},
        0.42,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    if SettingsOpen then
        SectionAccent.Visible=false
        SectionTitle.Visible=false
        SectionSubtitle.Visible=false
        Tabs.Visible=false
        Content.Visible=false

        SettingsPanel.Visible=true
        SettingsPanel.Position=UDim2.fromOffset(14,153)
        SettingsPanel.BackgroundTransparency=1
        SettingsPanel.CanvasPosition=Vector2.new(0,0)
        Tween(SettingsPanel,{
            Position=UDim2.fromOffset(14,139),
            BackgroundTransparency=0
        },0.38,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    else
        if SettingsPanelTween then SettingsPanelTween:Cancel() end
        SettingsPanelTween=Tween(SettingsPanel,{
            Position=UDim2.fromOffset(14,153),
            BackgroundTransparency=1
        },0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        if SettingsPanelTween then SettingsPanelTween.Completed:Wait() end
        if not SettingsOpen and SettingsPanel.Parent then
            SettingsPanel.Visible=false
            SettingsPanel.Position=UDim2.fromOffset(14,139)
            SettingsPanel.BackgroundTransparency=0
            SectionAccent.Visible=true
            SectionTitle.Visible=true
            SectionSubtitle.Visible=true
            Tabs.Visible=true
            Content.Visible=true
        end
    end
end)

--==============================================================
-- SCRIPT CARDS
--==============================================================
local function CreateScriptCard(scriptInfo,index)
    local Card=New("Frame",{
        Name=scriptInfo.Name,Size=UDim2.new(1,0,0,Config.CardHeight),
        BackgroundColor3=C.Card,BorderSizePixel=0,LayoutOrder=index,
        BackgroundTransparency=1,ClipsDescendants=true,ZIndex=6
    },Content)
    Round(Card,15)
    local CardStroke=Outline(Card,C.Border,1,0.08)
    Gradient(Card,C.Card,Color3.fromRGB(33, 33, 33),0)
    local CardScale=New("UIScale",{Scale=0.92},Card)

    local CardAccent=New("Frame",{
        Size=UDim2.new(0,3,1,-24),Position=UDim2.fromOffset(5,12),
        BackgroundColor3=C.Blue,BorderSizePixel=0,ZIndex=7
    },Card)
    Round(CardAccent,5)
    AnimateGradient(PremiumGradient(CardAccent,90),3.5)

    local ScriptLogo
    if scriptInfo.Name=="CHILI HUB" then
        ScriptLogo="rbxthumb://type=Asset&id=103785364011347&w=420&h=420"
    elseif scriptInfo.Name=="CLOUTHUB" then
        ScriptLogo="rbxthumb://type=Asset&id=129249733345141&w=420&h=420"
    else
        ScriptLogo="rbxthumb://type=Asset&id=79051478787302&w=420&h=420"
    end
    local Icon=New("ImageLabel",{
        Name="ScriptLogo",Size=UDim2.fromOffset(47,47),
        Position=UDim2.fromOffset(13,20),BackgroundTransparency=1,
        BorderSizePixel=0,Image=ScriptLogo,ScaleType=Enum.ScaleType.Fit,
        ImageTransparency=0,ZIndex=8
    },Card)
    Round(Icon,12)

    New("TextLabel",{
        Position=UDim2.fromOffset(71,11),Size=UDim2.new(1,-235,0,19),
        BackgroundTransparency=1,Text=scriptInfo.Name,TextColor3=C.White,
        TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBlack,ZIndex=7
    },Card)
    New("TextLabel",{
        Position=UDim2.fromOffset(71,32),Size=UDim2.new(1,-235,0,17),
        BackgroundTransparency=1,Text=scriptInfo.Subtitle,TextColor3=C.Gray,
        TextSize=7,TextWrapped=false,TextTruncate=Enum.TextTruncate.AtEnd,
        TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamMedium,ZIndex=7
    },Card)

    local HasHubBadges=scriptInfo.Name=="ADMIN BADGE"
        or scriptInfo.Name=="ANTI AFK"
        or scriptInfo.Name=="PYROVEX DEBUGGER"
        or scriptInfo.Name=="PYROVEX HUB SHADER"
        or scriptInfo.Name=="TOKEN SPAWNER"
    local BadgeX=71
    local function CreateBadge(text,color,width)
        local badge=New("TextLabel",{
            Size=UDim2.fromOffset(width,14),Position=UDim2.fromOffset(BadgeX,59),
            BackgroundColor3=color,BackgroundTransparency=0.12,
            Text=text,TextColor3=C.White,TextSize=6,
            Font=Enum.Font.GothamBlack,BorderSizePixel=0,ZIndex=8
        },Card)
        Round(badge,5)
        BadgeX=BadgeX+width+5
        return badge
    end
    if scriptInfo.Name=="CHILI HUB" or scriptInfo.Name=="CLOUTHUB" then
        CreateBadge("FEATURED",C.Purple,50)
    elseif HasHubBadges then
        CreateBadge("FEATURED",C.Purple,50)
        CreateBadge("BY PYROVEX HUB",Color3.fromRGB(66, 66, 66),78)
    end
    if scriptInfo.Name=="TOKEN SPAWNER" then
        CreateBadge("KEY REQUIRED",C.Red,67)
    end

    local Execute=New("TextButton",{
        Name="ExecuteButton",Size=UDim2.fromOffset(116,34),
        Position=UDim2.new(1,-130,0,27),BackgroundColor3=Color3.fromRGB(232,232,232),
        Text="▶  EXECUTE",TextColor3=Color3.fromRGB(12,12,12),TextSize=9,
        Font=Enum.Font.GothamBlack,AutoButtonColor=false,
        BorderSizePixel=0,ZIndex=9
    },Card)
    Round(Execute,10)
    local ExecuteStroke=Instance.new("UIStroke")
    ExecuteStroke.Color=Color3.fromRGB(255,255,255)
    ExecuteStroke.Transparency=0.18
    ExecuteStroke.Thickness=1
    ExecuteStroke.Parent=Execute
    local ExecuteGradient=Instance.new("UIGradient")
    ExecuteGradient.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(245,245,245)),
        ColorSequenceKeypoint.new(0.5,Color3.fromRGB(205,205,205)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))
    })
    ExecuteGradient.Rotation=0
    ExecuteGradient.Parent=Execute
    Execute.MouseEnter:Connect(function()
        Tween(Execute,{BackgroundColor3=Color3.fromRGB(255,255,255)},0.15)
        Tween(ExecuteStroke,{Transparency=0},0.15)
    end)
    Execute.MouseLeave:Connect(function()
        Tween(Execute,{BackgroundColor3=Color3.fromRGB(232,232,232)},0.15)
        Tween(ExecuteStroke,{Transparency=0.18},0.15)
    end)
    Execute.MouseButton1Down:Connect(function()
        Tween(Execute,{BackgroundColor3=Color3.fromRGB(175,175,175)},0.08)
    end)
    Execute.MouseButton1Up:Connect(function()
        Tween(Execute,{BackgroundColor3=Color3.fromRGB(255,255,255)},0.08)
    end)

    local Executing=false
    Execute.MouseButton1Click:Connect(function()
        if Executing then return end
        Executing=true
        Execute.Text="LOADING..."
        Tween(Execute,{BackgroundColor3=Matte.Normal},0.2)
        task.spawn(function()
            local success,err=pcall(function()
                local source=game:HttpGet(scriptInfo.URL)
                local func=loadstring(source)
                if not func then error("Unable to compile script") end
                func()
            end)
            if success then
                Execute.Text="EXECUTED"
                Execute.TextColor3=C.Green
            else
                Execute.Text="FAILED"
                Execute.TextColor3=C.Red
                warn("[PYROVEX LOADER] "..scriptInfo.Name..": "..tostring(err))
            end
            task.wait(1.5)
            if Execute and Execute.Parent then
                Execute.Text="EXECUTE"
                Execute.TextColor3=C.White
                Tween(Execute,{BackgroundColor3=Matte.Normal},0.2)
            end
            Executing=false
        end)
    end)

    Card.MouseEnter:Connect(function()
        Tween(Card,{BackgroundColor3=C.CardHover},Animation.Hover)
        Tween(CardStroke,{Color=C.LightBlue,Transparency=0.02},Animation.Hover)
        Tween(CardScale,{Scale=1},Animation.Hover,Enum.EasingStyle.Back)
        Tween(CardAccent,{
            Size=UDim2.new(0,4,1,-12),Position=UDim2.fromOffset(5,6)
        },Animation.Hover)
    end)
    Card.MouseLeave:Connect(function()
        Tween(Card,{BackgroundColor3=C.Card},Animation.Hover)
        Tween(CardStroke,{Color=C.Border,Transparency=0.08},Animation.Hover)
        Tween(CardScale,{Scale=0.98},Animation.Hover)
        Tween(CardAccent,{
            Size=UDim2.new(0,3,1,-24),Position=UDim2.fromOffset(5,12)
        },Animation.Hover)
    end)
    Tween(Card,{BackgroundTransparency=0},Animation.Card)
    Tween(CardScale,{Scale=1},Animation.Card,Enum.EasingStyle.Back)
    return Card
end

--==============================================================
-- TAB SYSTEM
--==============================================================
local SelectedTab=nil
local TabButtons={}
local TabIndicators={}

local function GetSelectedScripts(name)
    if name=="ALL SCRIPTS" then return AllScripts
    elseif name=="STEAL AN EGG" then return Scripts
    elseif name=="GROW A GARDEN" then return GrowScripts
    elseif name=="UNIVERSAL SCRIPTS" then return UniversalScripts end
    return {}
end

local function SelectTab(name)
    if SelectedTab==name then return end
    SelectedTab=name
    for tabName,tab in pairs(TabButtons) do
        local active=tabName==name
        Tween(tab,{
            BackgroundColor3=Matte.Normal,
            TextColor3=active and Matte.Text or Matte.Secondary
        },Animation.Tab)
        local indicator=TabIndicators[tabName]
        if indicator then
            Tween(indicator,{
                Size=UDim2.new(0,3,active and 0.58 or 0,0),
                BackgroundTransparency=active and 0 or 1
            },Animation.Tab)
        end
    end
    for _,child in ipairs(Content:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    Content.CanvasPosition=Vector2.new(0,0)
    for index,scriptInfo in ipairs(GetSelectedScripts(name)) do
        CreateScriptCard(scriptInfo,index)
        task.wait(0.035)
    end
end

for index,section in ipairs(Sections) do
    local Tab=New("TextButton",{
        Name=section.Name,Size=UDim2.fromOffset(section.Width,34),
        BackgroundColor3=Matte.Normal,Text=section.Name,TextColor3=Matte.Secondary,
        TextSize=8,Font=Enum.Font.GothamBlack,AutoButtonColor=false,
        BorderSizePixel=0,LayoutOrder=index,ClipsDescendants=true,ZIndex=7
    },Tabs)
    Round(Tab,10)
    local Indicator=New("Frame",{
        Name="Indicator",Size=UDim2.new(0,0,0,0),
        Position=UDim2.new(0,5,0.21,0),BackgroundColor3=Matte.Accent,
        BackgroundTransparency=1,BorderSizePixel=0,ZIndex=9
    },Tab)
    Round(Indicator,5)
    TabButtons[section.Name]=Tab
    TabIndicators[section.Name]=Indicator
    Tab.MouseButton1Click:Connect(function() SelectTab(section.Name) end)
    Tab.MouseEnter:Connect(function()
        if SelectedTab~=section.Name then
            Tween(Tab,{BackgroundColor3=Matte.Hover},Animation.Hover)
        end
    end)
    Tab.MouseLeave:Connect(function()
        if SelectedTab~=section.Name then
            Tween(Tab,{BackgroundColor3=Matte.Normal},Animation.Hover)
        end
    end)
end

--==============================================================
-- FLOATING MINIMIZE BUTTON
--==============================================================
local FloatingButton=New("ImageButton",{
    Name="FloatingButton",Size=UDim2.fromOffset(Config.FloatingSize,Config.FloatingSize),
    Position=UDim2.new(0,20,0.5,-27),BackgroundColor3=C.Background,
    BackgroundTransparency=0,Image=LogoAsset,ScaleType=Enum.ScaleType.Crop,
    AutoButtonColor=false,BorderSizePixel=0,Visible=false,Active=true,ZIndex=100
},Screen)
Round(FloatingButton,100)
local FloatingStroke=Outline(FloatingButton,Matte.Border,1,0.08)
local FloatingScale=New("UIScale",{Scale=0.7},FloatingButton)
FloatingButton.MouseEnter:Connect(function()
    Tween(FloatingScale,{Scale=1.12},0.18,Enum.EasingStyle.Back)
end)
FloatingButton.MouseLeave:Connect(function()
    Tween(FloatingScale,{Scale=1},0.18)
end)

--==============================================================
-- MAIN OPEN / CLOSE ANIMATION + STATES
-- Clean directional motion: rise into place on open, settle down on close.
-- Keep one fixed resting position so repeated open/close cycles never drift.
--==============================================================
local RestingOuterPosition = Outer.Position

local function GetOffsetPosition(position, yOffset)
    return UDim2.new(
        position.X.Scale, position.X.Offset,
        position.Y.Scale, position.Y.Offset + yOffset
    )
end

local function GetMotionProfile()
    local profiles = {
        SMOOTH = {Easing=Enum.EasingStyle.Quint, Offset=20, Scale=0.94},
        BOUNCE = {Easing=Enum.EasingStyle.Back, Offset=28, Scale=0.90},
        ELASTIC = {Easing=Enum.EasingStyle.Elastic, Offset=22, Scale=0.92},
        SLIDE = {Easing=Enum.EasingStyle.Quart, Offset=42, Scale=1},
        ZOOM = {Easing=Enum.EasingStyle.Quart, Offset=0, Scale=0.78},
        FADE = {Easing=Enum.EasingStyle.Linear, Offset=0, Scale=1},
        SNAPPY = {Easing=Enum.EasingStyle.Exponential, Offset=14, Scale=0.96}
    }
    return profiles[CurrentAnimationStyle] or profiles.SMOOTH
end

local function PrepareMainWindow()
    local profile=GetMotionProfile()
    Outer.Visible = true
    Main.Visible = true
    Outer.Position = GetOffsetPosition(RestingOuterPosition, profile.Offset)
    Outer.BackgroundTransparency = 1
    Main.BackgroundTransparency = 1
    MainScale.Scale = GetUIScale() * profile.Scale
end

local function PlayMainWindowOpen(duration)
    local profile=GetMotionProfile()
    PrepareMainWindow()

    Tween(Outer, {
        Position = RestingOuterPosition,
        BackgroundTransparency = 0
    }, duration, profile.Easing, Enum.EasingDirection.Out)

    Tween(Main, {
        BackgroundTransparency = 0
    }, duration * 0.82, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local scaleTween = Tween(MainScale, {
        Scale = GetUIScale()
    }, duration, profile.Easing, Enum.EasingDirection.Out)

    return scaleTween
end

local function PlayMainWindowClose(duration, finalScale)
    local profile=GetMotionProfile()
    local moveTween = Tween(Outer, {
        Position = GetOffsetPosition(RestingOuterPosition, profile.Offset * 0.75),
        BackgroundTransparency = 1
    }, duration, profile.Easing, Enum.EasingDirection.In)

    Tween(Main, {
        BackgroundTransparency = 1
    }, duration * 0.78, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    Tween(MainScale, {
        Scale = GetUIScale() * (finalScale or profile.Scale)
    }, duration, profile.Easing, Enum.EasingDirection.In)

    return moveTween
end

Main.BackgroundTransparency = 1
Outer.BackgroundTransparency = 1
MainScale.Scale = GetUIScale() * 0.94
Outer.Position = GetOffsetPosition(RestingOuterPosition, 20)
PlayMainWindowOpen(Animation.Open)

local IsAnimating = false
local Closing = false

Minimize.MouseButton1Click:Connect(function()
    if IsAnimating or Closing then return end
    IsAnimating = true

    local closeTween = PlayMainWindowClose(Animation.Minimize, 0.90)
    if closeTween then closeTween.Completed:Wait() end

    if not Screen.Parent then return end
    Main.Visible = false
    Outer.Visible = false
    Outer.Position = RestingOuterPosition

    FloatingButton.Visible = true
    FloatingScale.Scale = 0.72
    Tween(FloatingScale, {Scale = 1}, Animation.Restore,
        Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    IsAnimating = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    if IsAnimating or Closing then return end
    IsAnimating = true

    local floatingTween = Tween(FloatingScale, {Scale = 0.72}, 0.14,
        Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    if floatingTween then floatingTween.Completed:Wait() end
    if not Screen.Parent then return end

    FloatingButton.Visible = false
    local restore = PlayMainWindowOpen(Animation.Restore)
    if restore then restore.Completed:Wait() end
    IsAnimating = false
end)

Close.MouseButton1Click:Connect(function()
    if Closing or IsAnimating then return end
    Closing = true
    IsAnimating = true

    local closeTween = PlayMainWindowClose(Animation.Close, 0.94)
    if closeTween then closeTween.Completed:Wait() end

    if CreatedBlur and BlurEffect and BlurEffect.Parent then
        BlurEffect:Destroy()
    elseif BlurEffect and BlurEffect.Parent then
        BlurEffect.Size = 0
    end

    if Screen and Screen.Parent then
        Screen:Destroy()
    end
end)

--==============================================================
-- DRAG MAIN WINDOW
--==============================================================
local Dragging,DragStart,StartPosition,DragInput=false,nil,nil,nil
Header.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1
    or input.UserInputType==Enum.UserInputType.Touch then
        Dragging=true
        DragStart=input.Position
        StartPosition=Outer.Position
        input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then Dragging=false end
        end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseMovement
    or input.UserInputType==Enum.UserInputType.Touch then DragInput=input end
end)
UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input==DragInput or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-DragStart
        Outer.Position=UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset+delta.X,
            StartPosition.Y.Scale,StartPosition.Y.Offset+delta.Y)
    end
end)

--==============================================================
-- DRAG FLOATING BUTTON
--==============================================================
local FloatingDragging,FloatingDragStart,FloatingStartPosition,FloatingDragInput=
    false,nil,nil,nil
FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1
    or input.UserInputType==Enum.UserInputType.Touch then
        FloatingDragging=true
        FloatingDragStart=input.Position
        FloatingStartPosition=FloatingButton.Position
        input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then
                FloatingDragging=false
            end
        end)
    end
end)
FloatingButton.InputChanged:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseMovement
    or input.UserInputType==Enum.UserInputType.Touch then
        FloatingDragInput=input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if FloatingDragging and (input==FloatingDragInput
    or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-FloatingDragStart
        FloatingButton.Position=UDim2.new(
            FloatingStartPosition.X.Scale,FloatingStartPosition.X.Offset+delta.X,
            FloatingStartPosition.Y.Scale,FloatingStartPosition.Y.Offset+delta.Y
        )
    end
end)

--==============================================================
-- DISCORD WELCOME POPUP (SEPARATE MINI LIQUID-GLASS UI)
-- Appears together with the main menu after the loading screen.
-- The Discord artwork is kept as its own image; no glass overlay is placed on it.
--==============================================================
local DiscordPopup = New("Frame", {
    Name = "DiscordWelcomePopup",
    Size = UDim2.fromOffset(338, 142),
    Position = UDim2.new(0.5, 0, 0, 18),
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = C.Blue,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = false,
    ZIndex = 100,
    Visible = true
}, Screen)
Round(DiscordPopup, 18)
local DiscordPopupGradient = Gradient(
    DiscordPopup,
    C.Blue:Lerp(C.LightBlue, 0.42),
    C.Purple:Lerp(C.Background, 0.18),
    25
)
DiscordPopupGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.08),
    NumberSequenceKeypoint.new(0.55, 0.02),
    NumberSequenceKeypoint.new(1, 0.10)
})

local DiscordPopupImage = New("ImageLabel", {
    Name = "DiscordPopupImage",
    Size = UDim2.fromOffset(54, 54),
    Position = UDim2.fromOffset(14, 13),
    BackgroundTransparency = 1,
    Image = DiscordAsset,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 102
}, DiscordPopup)
Round(DiscordPopupImage, 100)

New("TextLabel", {
    Name = "DiscordPopupTitle",
    Size = UDim2.new(1, -88, 0, 22),
    Position = UDim2.fromOffset(78, 13),
    BackgroundTransparency = 1,
    Text = "JOIN OUR DISCORD",
    TextColor3 = C.White,
    TextSize = 14,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 102
}, DiscordPopup)

New("TextLabel", {
    Name = "DiscordPopupDescription",
    Size = UDim2.new(1, -88, 0, 17),
    Position = UDim2.fromOffset(78, 36),
    BackgroundTransparency = 1,
    Text = "Updates, support and community",
    TextColor3 = C.White,
    TextTransparency = 0.12,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 102
}, DiscordPopup)

New("TextLabel", {
    Name = "DiscordPopupInviteLink",
    Size = UDim2.new(1, -88, 0, 17),
    Position = UDim2.fromOffset(78, 54),
    BackgroundTransparency = 1,
    Text = DiscordLink,
    TextColor3 = Color3.fromRGB(234, 234, 234),
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 102
}, DiscordPopup)

local DiscordCopyPopupButton = New("TextButton", {
    Name = "DiscordCopyPopupButton",
    Size = UDim2.new(0.5, -21, 0, 31),
    Position = UDim2.fromOffset(14, 98),
    BackgroundColor3 = Matte.Normal,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "COPY LINK",
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.GothamBlack,
    ZIndex = 103
}, DiscordPopup)
Round(DiscordCopyPopupButton, 10)
ApplyLiquidGlassButton(DiscordCopyPopupButton)

local DiscordLaterButton = New("TextButton", {
    Name = "DiscordMaybeLaterButton",
    Size = UDim2.new(0.5, -21, 0, 31),
    Position = UDim2.new(0.5, 7, 0, 98),
    BackgroundColor3 = Matte.Normal,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "MAYBE LATER",
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    ZIndex = 103
}, DiscordPopup)
Round(DiscordLaterButton, 10)
ApplyLiquidGlassButton(DiscordLaterButton)

DiscordCopyPopupButton.MouseButton1Click:Connect(function()
    local copied = pcall(function()
        if not setclipboard then error("Clipboard is unsupported") end
        setclipboard(DiscordLink)
    end)
    if copied then
        DiscordCopyPopupButton.Text = "COPIED!"
        task.delay(1.25, function()
            if DiscordCopyPopupButton and DiscordCopyPopupButton.Parent then
                DiscordCopyPopupButton.Text = "COPY LINK"
            end
        end)
    else
        DiscordCopyPopupButton.Text = "COPY UNAVAILABLE"
        task.delay(1.5, function()
            if DiscordCopyPopupButton and DiscordCopyPopupButton.Parent then
                DiscordCopyPopupButton.Text = "COPY LINK"
            end
        end)
    end
end)

DiscordLaterButton.MouseButton1Click:Connect(function()
    if not DiscordPopup or not DiscordPopup.Parent then return end
    Tween(DiscordPopup, {
        Position = DiscordPopup.Position - UDim2.fromOffset(0, 12),
        BackgroundTransparency = 1
    }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    for _, obj in ipairs(DiscordPopup:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            Tween(obj, {TextTransparency = 1}, 0.18)
        elseif obj:IsA("ImageLabel") then
            Tween(obj, {ImageTransparency = 1}, 0.18)
        end
    end
    task.wait(0.24)
    if DiscordPopup and DiscordPopup.Parent then DiscordPopup:Destroy() end
end)

-- Soft entrance; the circular Discord image remains completely untouched.
DiscordPopup.Position = UDim2.new(0.5, 0, 0, 4)
DiscordPopup.BackgroundTransparency = 1
Tween(DiscordPopup, {
    Position = UDim2.new(0.5, 0, 0, 18),
    BackgroundTransparency = 0.08
}, 0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

--==============================================================
-- INITIALIZE
--==============================================================
SelectTab("ALL SCRIPTS")
print("==================================================")
print("PYROVEX LOADER V18")
print("EXTREME PREMIUM UI EDITION")
print("BLUE x PURPLE x RED x BLACK")
print("ADVANCED LOADING AND UI ANIMATIONS ENABLED")
print("CUSTOM UI SIZE SETTINGS ENABLED")
print("UI GLOW / TRANSPARENCY / ANIMATION SPEED ENABLED")
print("BLUR AND NEON EFFECTS ENABLED")
print("THEME AND UI STYLE DRAWERS ENABLED")
print("INSTANT SETTINGS SWITCHING ENABLED")
print("ALL SCRIPTS COLLECTION INITIALIZED")
print("7 SCRIPTS AVAILABLE")
print("PYROVEX HUB SUCCESSFULLY LOADED")
print("==================================================")
