repeat task.wait() until game:IsLoaded()

while task.wait() do
    if game.PlaceId ~= 116614712661486 then
        game:GetService("TeleportService"):Teleport(116614712661486)
    end
end

local VirtualUser = game:service "VirtualUser"

game:service("Players").LocalPlayer.Idled:connect(
	function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
)



