local Meshid1 = "rbxassetid://7606070501"
local TextureId1 = "rbxassetid://1577349"
local a_offset1 = -0.5
local b_offset1 = 0.35
local c_offset1 = 0

local d_offset1 = 1
local e_offset1 = 1
local f_offset1 = 1

-- Define orientation offsets in degrees
local pitch = 1 -- Rotation around X-axis
local yaw = 100   -- Rotation around Y-axis
local roll = 0  -- Rotation around Z-axis

-- Convert degrees to radians for CFrame rotation
local orientationCFrame = CFrame.Angles(math.rad(pitch), math.rad(yaw), math.rad(roll))

-- Check if the player is using R6 or R15 character model
local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
if humanoid.RigType == Enum.HumanoidRigType.R6 then
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character
    local Torso = Character.Torso

    function Weld(x, y)
        local W = Instance.new("Weld")
        W.Part0 = x
        W.Part1 = y
        local CJ = CFrame.new(x.Position)
        local C0 = x.CFrame:inverse() * CJ
        local C1 = (y.CFrame:inverse() * CJ) * orientationCFrame -- Apply orientation to CFrame
        W.C0 = C0
        W.C1 = C1
        W.Parent = x
    end

    local fuc = Instance.new("Part", workspace)
    fuc.CFrame = Torso.CFrame
    fuc.CanCollide = false
    local fuck = Instance.new("SpecialMesh")
    fuck.Parent = fuc
    fuck.MeshType = "FileMesh"
    fuck.Scale = Vector3.new(d_offset1, e_offset1, f_offset1)
    fuck.Offset = Vector3.new(a_offset1, b_offset1, c_offset1)
    fuck.TextureId = TextureId1
    fuck.MeshId = Meshid1
    Weld(Torso, fuc)

elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character
    local Torso = Character.UpperTorso

    function Weld(x, y)
        local W = Instance.new("Weld")
        W.Part0 = x
        W.Part1 = y
        local CJ = CFrame.new(x.Position)
        local C0 = x.CFrame:inverse() * CJ
        local C1 = (y.CFrame:inverse() * CJ) * orientationCFrame -- Apply orientation to CFrame
        W.C0 = C0
        W.C1 = C1
        W.Parent = x
    end

    local fuc = Instance.new("Part", workspace)
    fuc.CFrame = Torso.CFrame
    fuc.CanCollide = false
    local fuck = Instance.new("SpecialMesh")
    fuck.Parent = fuc
    fuck.MeshType = "FileMesh"
    fuck.Scale = Vector3.new(d_offset1, e_offset1, f_offset1)
    fuck.Offset = Vector3.new(a_offset1, b_offset1, c_offset1)
    fuck.TextureId = TextureId1
    fuck.MeshId = Meshid1
    Weld(Torso, fuc)
else
    print("Player is not using R6 or R15 character model")
end
wait(1)
