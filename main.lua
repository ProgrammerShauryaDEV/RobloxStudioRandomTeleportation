-- Get the Players service
local Players = game:GetService("Players")

-- Get the LocalPlayer and their character
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Teleport function that takes a player and a character as arguments
local function teleportToPlayer(player, character)
    -- Get the player's character and humanoid
    local targetCharacter = player.Character or player.CharacterAdded:Wait()
    local humanoid = targetCharacter:WaitForChild("Humanoid")

    -- Teleport the local player to the target player's character
    character:SetPrimaryPartCFrame(targetCharacter:GetPrimaryPartCFrame() + Vector3.new(0, 5, 0))

    -- Wait for the local player to land
    repeat
        wait()
    until humanoid.FloorMaterial ~= Enum.Material.Air
end

-- Function to choose two random players and teleport to them
local function teleportToRandomPlayers()
    local players = Players:GetPlayers()
    local playerCount = #players

    if playerCount > 1 then
        -- Choose two random players
        local randomIndex1 = math.random(1, playerCount)
        local randomIndex2 = math.random(1, playerCount - 1)
        if randomIndex2 >= randomIndex1 then
            randomIndex2 = randomIndex2 + 1
        end

        local player1 = players[randomIndex1]
        local player2 = players[randomIndex2]

        -- Teleport to the first player
        teleportToPlayer(player1, Character)

        -- Wait a few seconds
        wait(5)

        -- Teleport to the second player
        teleportToPlayer(player2, Character)
    end
end

-- Function to handle the "x" key being pressed
local function onKeyPressed(inputObject, gameProcessedEvent)
    -- Check if the "x" key was pressed and not already being processed
    if inputObject.KeyCode == Enum.KeyCode.X and not gameProcessedEvent then
        -- Teleport to two random players
        teleportToRandomPlayers()
        teleportToRandomPlayers()
    end
end

-- Bind the onKeyPressed function to the InputBegan event
game:GetService("UserInputService").InputBegan:Connect(onKeyPressed)
