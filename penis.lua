local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

function getPlayers()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        table.insert(players, player)
    end
    return players
end

function drawPlayers()
    local players = getPlayers()
    for _, player in ipairs(players) do
        if player ~= player then
            local playerModel = player.Character or player.CharacterAdded:Wait()
            local head = playerModel:FindFirstChild("Head")
            if head then
                local position = head.Position
                local direction = (position - camera.CFrame.p).Unit
                local ray = Ray.new(camera.CFrame.p, direction * 1000)
                local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {playerModel, player.PlayerGui, player.PlayerScripts, player.Backpack, player.StarterPack, player.PlayerScripts, player.PlayerGui})
                if hit then
                    local part = hit.Parent
                    if part:IsA("BasePart") then
                        local distance = (position - pos).Magnitude
                        local text = display.newText("Player: " .. player.Name, pos + Vector3.new(0, 2, 0), 0, 20, BrickColor.new("Bright green"), false)
                        text.TextColor3 = BrickColor.new("Bright green").Color
                        text.Parent = display
                        game:GetService("Debris"):AddItem(text, 5)
                    end
                end
            end
        end
    end
end

game:GetService("RunService").Stepped:connect(drawPlayers)