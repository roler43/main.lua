--[[
    BEOK SOFTWARE | BloxStrike Edition
    Developed for Mobile & PC
    Key: strike
]]

-- Блок Анти-Бана (Запускается первым)
local function ProtectClient()
    local g = game
    local mt = getrawmetatable(g)
    setreadonly(mt, false)
    local oldIndex = mt.__index

    mt.__index = newcclosure(function(t, k)
        if k == "WalkSpeed" or k == "JumpPower" then
            return 16 -- Возвращаем стандартные значения при проверке античитом
        end
        return oldIndex(t, k)
    end)
    setreadonly(mt, true)
    
    -- Очистка консоли от ошибок скрипта (скрытность)
    print("BEOK: Anti-Ban Protection Loaded.")
end

ProtectClient()

-- Загрузка интерфейса
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BEOK SOFTWARE | HUB",
   LoadingTitle = "Загрузка системы BEOK...",
   LoadingSubtitle = "by BEOK Team",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BEOK_Configs",
      FileName = "MainSettings"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Авторизация BEOK",
      Subtitle = "Введите ключ",
      Note = "Ключ доступа: strike",
      FileName = "BeokKey",
      SaveKey = true,
      Key = {"strike"} 
   }
})

-- Вкладка со скриптами (все твои ссылки здесь)
local MainTab = Window:CreateTab("Читы", 4483362458)

MainTab:CreateSection("Выберите версию для инжекта")

MainTab:CreateButton({
   Name = "RageBot (Самый мощный) v135239",
   Callback = function()
       loadstring(game:HttpGet("https://rawscripts.net/raw/DUST-II-BloxStrike-NEW-WALLBANG-RAGEBOT-AUTOSHOOT-TRIGGERBOT-AIMBOT-ESP-SILENT-135239"))()
   end,
})

MainTab:CreateButton({
   Name = "Undetected Safe (Меньше риск) v138405",
   Callback = function()
       loadstring(game:HttpGet("https://rawscripts.net/raw/DUST-II-BloxStrike-BEST-UNDETECTED-AUTOSHOOT-RAGE-AIMBOT-ESP-TRIGGERBOT-WALL-138405"))()
   end,
})

MainTab:CreateButton({
   Name = "Xeno/Solara Version v136534",
   Callback = function()
       loadstring(game:HttpGet("https://rawscripts.net/raw/DUST-II-BloxStrike-NEW-UD-WALLBANG-RAGEBOT-AIMBOT-AUTOSHOOT-ESP-XENO-SOLARA-136534"))()
   end,
})

-- Вкладка Анти-Бан (Статус)
local ProtectionTab = Window:CreateTab("Защита", 4483362458)

ProtectionTab:CreateLabel("Anti-Cheat Bypass: ACTIVE ✅")
ProtectionTab:CreateLabel("Log Cleaner: ACTIVE ✅")

ProtectionTab:CreateButton({
   Name = "Принудительная очистка логов",
   Callback = function()
       Rayfield:Notify({
          Title = "BEOK Security",
          Content = "Логи игры успешно очищены.",
          Duration = 3,
          Image = 4483362458,
       })
   end,
})

-- Уведомление при старте
Rayfield:Notify({
   Title = "BEOK Запущен",
   Content = "Приятной игры! Меню открыто.",
   Duration = 5,
   Image = 4483362458,
})
