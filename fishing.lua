-- Auto Fishing Script V3
-- By Rizky

local VirtualInputManager = game:GetService("VirtualInputManager")

-- load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- buat window
local Window = Rayfield:CreateWindow({
    Name = "Auto Fishing V3",
    LoadingTitle = "Fishing Script",
    LoadingSubtitle = "By Rizky",
    ConfigurationSaving = {
        Enabled = false,
    }
})

-- state toggle & settings
local autoFishing = false
local strikeClicks = 35 -- default jumlah klik strike
local strikeWait = 10   -- default waktu tunggu strike (detik)

-- helper: key press
local function pressKey(key, holdTime)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    if holdTime and holdTime > 0 then task.wait(holdTime) end
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

-- helper: mouse click
local function clickMouse(button, holdTime)
    VirtualInputManager:SendMouseButtonEvent(0, 0, button, true, game, 0)
    if holdTime and holdTime > 0 then task.wait(holdTime) end
    VirtualInputManager:SendMouseButtonEvent(0, 0, button, false, game, 0)
end

-- Tab
local Tab = Window:CreateTab("Main")

-- Toggle Auto Fishing
Tab:CreateToggle({
    Name = "Auto Fishing",
    CurrentValue = false,
    Flag = "AutoFishingToggle",
    Callback = function(Value)
        autoFishing = Value
    end,
})

-- Slider Strike Klik
Tab:CreateSlider({
    Name = "Jumlah Strike Klik",
    Range = {10, 100}, -- bisa diatur min 10x, max 100x
    Increment = 1,
    Suffix = "x Klik",
    CurrentValue = strikeClicks,
    Flag = "StrikeClicksSlider",
    Callback = function(Value)
        strikeClicks = Value
    end,
})

-- Slider Waktu Tunggu Strike
Tab:CreateSlider({
    Name = "Waktu Tunggu Strike",
    Range = {5, 30}, -- bisa diatur 5s - 30s
    Increment = 1,
    Suffix = " detik",
    CurrentValue = strikeWait,
    Flag = "StrikeWaitSlider",
    Callback = function(Value)
        strikeWait = Value
    end,
})

-- main loop
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoFishing then
            -- 1. keluarkan joran (tekan 3)
            if not autoFishing then continue end
            pressKey(Enum.KeyCode.Three, 0.1)
            task.wait(0.5)

            -- 2. lempar joran (klik kiri tahan 1 detik)
            if not autoFishing then continue end
            clickMouse(Enum.UserInputType.MouseButton1, 1)
            task.wait(0.5)

            -- 3. tunggu strike (default 10 detik, bisa diatur)
            for i = 1, strikeWait * 10 do -- dikali 10 karena 0.1s loop
                if not autoFishing then break end
                task.wait(0.1)
            end
            if not autoFishing then continue end

            -- 4. strike klik kiri sesuai slider
            for i = 1, strikeClicks do
                if not autoFishing then break end
                clickMouse(Enum.UserInputType.MouseButton1, 0.05)
                task.wait(0.05)
            end
            if not autoFishing then continue end

            -- 5. jeda 2 detik
            for i = 1, 20 do -- 20x 0.1s = 2 detik
                if not autoFishing then break end
                task.wait(0.1)
            end
            if not autoFishing then continue end

            -- 6. masukan joran (tekan 3)
            pressKey(Enum.KeyCode.Three, 0.1)
            task.wait(0.5)
        end
    end
end)
