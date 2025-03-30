-- Đợi game load xong
repeat task.wait() until game:IsLoaded()

-- Kiểm tra PlaceId và teleport nếu cần
while task.wait() do
    if game.PlaceId ~= 116614712661486 then
        game:GetService("TeleportService"):Teleport(116614712661486)
    end
end

-- Chống kick do idling
local VirtualUser = game:service("VirtualUser")
game:service("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

--------------------------------------------------------------------
-- Phần gửi thông báo Discord khi nhận được "Ziru G" trong AFK Rewards

local webhookUrl = "https://discord.com/api/webhooks/1355900472157929694/bc_WBnZYzQpgEcb7BTePc6yES3_JzsZ6LqQStUlOclZc0OdreD3p0GwfBTyZS3BSiknC"  -- Thay bằng URL webhook của bạn
local HttpService = game:GetService("HttpService")

local function sendDiscordNotification(message)
    local data = {
        ["content"] = message
    }
    local jsonData = HttpService:JSONEncode(data)
    
    -- Lệnh request phụ thuộc vào executor bạn dùng (ví dụ: Synapse X, Fluxus, v.v.)
    request({
        Url = webhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    })
end

-- Vòng lặp kiểm tra GUI của LocalPlayer xem có xuất hiện "Ziru G" trong AFK Rewards hay không
while task.wait(1) do
    local found = false
    for _, obj in ipairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
        if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Text then
            if obj.Text:find("100 GEMS") then
                found = true
                break
            end
        end
    end

    if found then
        sendDiscordNotification("Đã nhận được Ziru G trong AFK Rewards!")
        break  -- Dừng vòng lặp sau khi gửi thông báo (nếu cần lặp lại thì loại bỏ dòng này)
    end
end