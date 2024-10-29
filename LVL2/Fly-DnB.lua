
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")
    local Debris = game:GetService("Debris") -- Service to manage cleanup
    
    -- Toggle variable to apply the round parts to all players
    local applyToAllPlayers = true -- Change to false to apply only to the local player
    
    -- Local variables for colors and settings
    local highlightColor = Color3.fromRGB(255, 255, 255) -- White color for highlight
    local outlineColor = Color3.fromRGB(255, 255, 255) -- White color for outline
    local transparencySetting = 0 -- Set transparency (0 = fully opaque, 1 = fully transparent)
    local normalPartSize = Vector3.new(0.5, 0.5, 0.5) -- Normal width size
    local widerPartSize = Vector3.new(0.25, 0.25, 30.5) -- Wider part size (X is greater for width)
    local positionOffsets = {
        CFrame.new(0.25, -1, -0.75), -- Offset for first normal part
        CFrame.new(-0.25, -1, -0.75), -- Offset for second normal part
        CFrame.new(0, -1, -16.2) -- Offset for the wider part
    }
    
    -- Table to hold references to the created parts
    local roundParts = {}
    
    -- Function to create the round part and highlight
    local function createRoundPart(character, positionOffset, size)
        -- Determine torso part based on R6 or R15
        local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
        if not torso then return end -- Stop if no torso is found
    
        -- Create the part
        local roundPart = Instance.new("Part")
        roundPart.Size = size -- Use the provided size
        roundPart.CanCollide = true -- Enable collision
        roundPart.Anchored = false
        roundPart.Parent = game.Workspace -- Ensure part is parented to Workspace
        roundPart.BrickColor = BrickColor.new(highlightColor) -- Set color of the part
        roundPart.Transparency = transparencySetting -- Set transparency
    
        -- If the size is normal, make it a ball; otherwise, make it a block
        if size == normalPartSize then
            roundPart.Shape = Enum.PartType.Ball
        else
            roundPart.Shape = Enum.PartType.Block
        end
    
        -- Set the material to glossy
        roundPart.Material = Enum.Material.SmoothPlastic
    
        -- Position the part directly under the torso with the provided offset
        roundPart.CFrame = torso.CFrame * positionOffset
    
        -- Add highlight effect
        local highlight = Instance.new("Highlight")
        highlight.Adornee = roundPart -- Set the part as the highlight's target
        highlight.FillColor = highlightColor -- White color for highlight
        highlight.OutlineColor = outlineColor -- White outline
        highlight.Parent = roundPart -- Parent the highlight to the part
    
        -- Create a weld to attach the part to the torso
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = torso
        weld.Part1 = roundPart
        weld.Parent = roundPart
    
        -- Store the part reference
        table.insert(roundParts, roundPart)
    end
    
    -- Function to create round parts for all players
    local function createRoundPartsForCharacter(character)
        createRoundPart(character, positionOffsets[1], normalPartSize) -- Normal width
        createRoundPart(character, positionOffsets[2], normalPartSize) -- Normal width
        createRoundPart(character, positionOffsets[3], widerPartSize) -- Wider part
    end
    
    -- Function to apply the round parts based on the toggle
    local function applyRoundParts()
        if applyToAllPlayers then
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character then
                    createRoundPartsForCharacter(p.Character)
                end
            end
        else
            createRoundPartsForCharacter(player.Character)
        end
    end
    
    -- Wait for the player's character to load
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid") -- Ensure the Humanoid is loaded
        wait(1) -- Wait a moment to ensure the character is fully loaded
        applyRoundParts()
    end)
    
    -- If the character already exists, create the round parts immediately
    if player.Character then
        applyRoundParts()
    end
    
    -- Function to destroy all round parts with an explosion effect
    local function destroyRoundParts()
        for _, part in ipairs(roundParts) do
            if part then
                -- Create an explosion at the part's position
                local explosion = Instance.new("Explosion")
                explosion.Position = part.Position
                explosion.BlastRadius = 0.01 -- Set the blast radius
                explosion.BlastPressure = 1000 -- Set a blast pressure to push nearby objects
                explosion.ExplosionType = Enum.ExplosionType.NoCraters -- Ensure no craters are created
                explosion.Parent = game.Workspace
                
                -- Destroy the part after creating the explosion
                part:Destroy()
            end
        end
        roundParts = {} -- Clear the table
    end
    
    -- Detect when the player presses the "E" key to destroy all parts
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.E then
                destroyRoundParts()
            end
        end
    end)
