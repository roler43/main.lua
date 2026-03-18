local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "BEOK ULTIMATE",
    SubTitle = "by Gleb",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Theme = "Darker"
})

local Tabs = {
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Aim = Window:AddTab({ Title = "Aim Bot", Icon = "crosshair" }),
    Bot = Window:AddTab({ Title = "Bot [RAGE]", Icon = "skull" })
}

-- ВХ (ESP)
Tabs.Visuals:AddToggle("ESP", {Title = "Enable ESP", Default = false})

-- Аим (FOV)
Tabs.Aim:AddSlider("FOV", {Title = "FOV Radius", Default = 100, Min = 10, Max = 800, Rounding = 1})

-- Бот (Скорость)
Tabs.Bot:AddSlider("Speed", {Title = "WalkSpeed", Default = 16, Min = 16, Max = 350, Rounding = 1, Callback = function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end})

-- Логика ВХ
game:GetService("RunService").RenderStepped:Connect(function()
    if Fluent.Options.ESP.Value then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("BEOK_ESP") or Instance.new("Highlight", p.Character)
                h.Name = "BEOK_ESP"
                h.Enabled = true
            end
        end
    end
end)

Fluent:Notify({Title = "BEOK LOADED", Content = "Script is active!", Duration = 5})
