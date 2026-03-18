-- [[ BEOK ULTIMATE V3 - NO KEY SYSTEM - BY GLEB ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "BEOK ULTIMATE [RAGE]",
    SubTitle = "by Gleb",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Сервисы
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- Табы
local Tabs = {
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Aim = Window:AddTab({ Title = "Aim Bot", Icon = "crosshair" }),
    Bot = Window:AddTab({ Title = "Bot [RAGE]", Icon = "skull" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- [[ 1. VISUALS - УЛУЧШЕННОЕ ВХ ]] --
Tabs.Visuals:AddParagraph({ Title = "ESP & World", Content = "High-performance rendering" })

local ESP_Enabled = Tabs.Visuals:AddToggle("ESPToggle", {Title = "Enable ESP (Wallhack)", Default = false})
local ESP_Chams = Tabs.Visuals:AddToggle("Chams", {Title = "Chams (Fill Player)", Default = false})
local ESP_Names = Tabs.Visuals:AddToggle("Names", {Title = "Show Names", Default = false})

Tabs.Visuals:AddToggle("Fullbright", {Title = "Fullbright (No Shadows)", Default = false}):OnChanged(function(v)
    Lighting.Brightness = v and 2 or 1
    Lighting.ClockTime = v and 12 or 14
    Lighting.GlobalShadows = not v
end)

-- Логика отрисовки ESP через Highlight
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local highlight = char:FindFirstChild("BEOK_ESP") or Instance.new("Highlight", char)
            highlight.Name = "BEOK_ESP"
            highlight.Enabled = ESP_Enabled.Value
            highlight.FillTransparency = ESP_Chams.Value and 0.5 or 1
            highlight.OutlineTransparency = 0
            highlight.FillColor = (player.Team ~= LocalPlayer.Team) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
        end
    end
end)

-- [[ 2. AIM BOT - НАСТРОЙКИ СТРЕЛЬБЫ ]] --
Tabs.Aim:AddParagraph({ Title = "Targeting", Content = "Aimbot & Bullet Control" })

Tabs.Aim:AddToggle("Aimbot", {Title = "Enable Aimbot", Default = false})
Tabs.Aim:AddToggle("SilentAim", {Title = "Silent Aim (Bullet TP)", Default = false})
Tabs.Aim:AddSlider("FOV", {Title = "FOV Radius", Default = 100, Min = 10, Max = 600, Rounding = 1})

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Filled = false

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Options.Aimbot.Value
    FOVCircle.Radius = Options.FOV.Value
    FOVCircle.Position = UserInputService:GetMouseLocation()
end)

Tabs.Aim:AddButton({
    Title = "No Recoil & No Spread",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("NumberValue") and (v.Name:find("Recoil") or v.Name:find("Spread")) then
                v.Value = 0
            end
        end
        Fluent:Notify({Title = "Applied", Content = "Recoil and Spread removed!"})
    end
})

-- [[ 3. BOT - ЗАПРЕЩЕННЫЕ ФУНКЦИИ ]] --
Tabs.Bot:AddParagraph({ Title = "Movement & Rage", Content = "Extreme hacks" })

Tabs.Bot:AddSlider("Speed", {Title = "WalkSpeed", Default = 16, Min = 16, Max = 250, Rounding = 1, Callback = function(v)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end})

Tabs.Bot:AddToggle("Noclip", {Title = "Noclip (Walk through walls)", Default = false})

-- SpinBot logic
Tabs.Bot:AddToggle("SpinBot", {Title = "SpinBot (Anti-Aim)", Default = false})

RunService.Stepped:Connect(function()
    if Options.Noclip.Value and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    if Options.SpinBot.Value and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
    end
end)

Tabs.Bot:AddToggle("InfiniteJump", {Title = "Infinite Jump", Default = false})
UserInputService.JumpRequest:Connect(function()
    if Options.InfiniteJump.Value then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Spam Chat
Tabs.Bot:AddInput("SpamText", {Title = "Spam Message", Default = "BEOK SOFT ON TOP!"})
Tabs.Bot:AddToggle("SpamEnable", {Title = "Enable Spam", Default = false})

task.spawn(function()
    while task.wait(1) do
        if Options.SpamEnable.Value then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Options.SpamText.Value, "All")
        end
    end
end)

-- Финальные настройки
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({
    Title = "BEOK ULTIMATE",
    Content = "Script Loaded! No Key Needed.",
    Duration = 5
})

-- Фоновая загрузка оригинала (без ключа)
pcall(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Operation-One-MAP-CHANGES-Operation-One-ESP-and-more-53823"))()
end)
