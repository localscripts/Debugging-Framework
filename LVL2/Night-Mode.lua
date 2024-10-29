-- Get the Lighting service
local Lighting = game:GetService("Lighting")

-- Function to delete all children in Lighting, set properties, and add Sky
local function clearLighting()
    -- Delete all children in Lighting
    for _, child in ipairs(Lighting:GetChildren()) do
        child:Destroy()
    end
    
    -- Set Lighting properties
    Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    Lighting.Brightness = 0.45
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)  -- Adjust as needed
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)     -- Adjust as needed
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.GlobalShadows = true 
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    Lighting.ShadowSoftness = 0.2
    Lighting.ClockTime = 14.5
    Lighting.GeographicLatitude = 0
    Lighting.ExposureCompensation = -0.6

    -- Create and add a Sky to Lighting
    local sky = Instance.new("Sky")
    
    -- Set the properties of the Sky
    sky.SkyboxBk = "rbxassetid://48020371"
    sky.SkyboxDn = "rbxassetid://48020144"
    sky.SkyboxFt = "rbxassetid://48020234"
    sky.SkyboxLf = "rbxassetid://48020211"
    sky.SkyboxRt = "rbxassetid://48020254"
    sky.SkyboxUp = "rbxassetid://48020383"
    
    -- Parent the Sky to the Lighting service
    sky.Parent = Lighting
end

-- Call the function to clear Lighting, adjust properties, and add Sky
clearLighting()
