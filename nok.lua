-- BEOK SOFTWARE V2 | HARD PROTECT
repeat task.wait() until game:IsLoaded()

-- БЛОК СУПЕР АНТИ-БАНА (Stealth Mode)
local function UltraProtect()
    -- Удаляем методы слежки
    local raw = getrawmetatable(game)
    setreadonly(raw, false)
    local oldNamecall = raw.__namecall
    
    raw.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Блокируем отправку репортов античита на сервер
        if method == "FireServer" and (tostring(self) == "MainEvent" or tostring(self) == "Checker") then
            return nil
        end
        return oldNamecall(self, unpack(args))
    end)
    
    -- Скрываем чит от проверок на WalkSpeed и GUI
    local oldIndex = raw.__index
    raw.__index = newcclosure(function(t, k)
        if not checkcaller() and (k == "WalkSpeed" or k == "JumpPower") then
            return 16
        end
        return oldIndex(t, k)
    end)
    setreadonly(raw, true)
end

-- Запуск защиты
pcall(UltraProtect)

-- БИБЛИОТЕКА МЕНЮ (Минималистичная, чтобы не палиться)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Venyx/Venyx-UI-Library/main/source.lua"))()
local Venyx = Library.new("BEOK SOFTWARE | ULTIMATE", 5013109572)

-- КЛЮЧ (Всегда strike)
local Auth = Venyx:addPage("Auth", 5013109572)
local KeySec = Auth:addSection("Система доступа")

KeySec:addTextbox("Введите ключ", "strike", function(text)
    if text == "strike" then
        Venyx:Notify("Успех", "Доступ разрешен!")
    end
end)

-- ФУНКЦИОНАЛ (Вшиваем лучшее сразу)
local Main = Venyx:addPage("Main", 5013109572)
local Combat = Main:addSection("Убийство")

Combat:addButton("Активировать Rage (Silent + Wallbang)", function()
    -- Загружаем самый мощный функционал без лишних окон
    loadstring(game:HttpGet("https://rawscripts.net/raw/DUST-II-BloxStrike-NEW-WALLBANG-RAGEBOT-AUTOSHOOT-TRIGGERBOT-AIMBOT-ESP-SILENT-135239"))()
end)

-- НАСТРОЙКИ И ИКОНКА
local Settings = Venyx:addPage("Settings", 5013109572)
local Visuals = Settings:addSection("Интерфейс")

Visuals:addButton("Скрыть меню (Клавиша RightControl)", function()
    -- Меню закроется само
end)

-- Иконка и авто-уведомление
Venyx:Notify("BEOK", "Защита активна. Не пались перед админами!")
