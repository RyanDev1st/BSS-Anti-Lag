--[[game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Loading Anti-lag...",
        Text = "Executing Script..",
        Icon = "rbxassetid://6238537240",
        Duration = 3,
    })]]
 
    local RunService = game:GetService("RunService")
    local time1 = os.clock()
    --local noti = "Took %f seconds to load"
    local player = game.Players.LocalPlayer
    --local char = player.Character or player.CharacterAdded:Wait()
    local honeycomb = player:FindFirstChild("Honeycomb") or nil
    local options = getgenv().settings
    --local connections = {}
    local l = game.Lighting
    local t = workspace.Terrain
          t.WaterWaveSize = 0
          t.WaterWaveSpeed = 0
          t.WaterReflectance = 0
          t.WaterTransparency = 0
          l.GlobalShadows = false
          l.FogEnd = 9e9
    --[[local ignore = {
        ["Union"] = 
 
    }]]
    --local Debris = game:GetService("Debris")
 
    local function onPlayerAdded(p, meta)
        local warning = p == player and "You are processed" or ((not meta) and (p.Name.." Joined")) or p.Name.."is processsed"
        print(warning)
        warning = nil
        p.CharacterAdded:Connect(function(c)
            task.wait(0.5)    
                for _,v in pairs(c:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.CastShadow = false
                             if p ~= player then 
                                v.CanQuery = false
                                v.CanTouch = false
                                if v:FindFirstAncestorWhichIsA("Accessory") or v:FindFirstAncestorWhichIsA("Tool") then
									v.Transparency = 1
                                end
                            end
                        if v:IsA("MeshPart") then
                           v.TextureID = 10385902758728957
                        end
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                        v.Enabled = false
                        pcall(function()
                                v.Lifetime = NumberRange.new(0)
                                v.Rate = 0
                        end)
                    elseif v:IsA("Decal") or v:IsA("Texture") then
						v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                        v:Destroy()
                    elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    	v.Enabled = false
                        v:Destroy()
                    elseif v:IsA("SurfaceGui") then
                       v.Active = false
                       v.Enabled = false
                    end
            end
        end)
    end
 
    for _, p in pairs(game.Players:GetPlayers()) do
        onPlayerAdded(p, true)
        local c = p.Character or p.CharacterAdded:Wait()
        for _,v in pairs(c:GetDescendants()) do
            --[[v.Transparency = (v:FindFirstAncestorWhichIsA("Accessory") or v:FindFirstAncestorWhichIsA("Tool")) and 1
            v.Enabled = false]]
                  if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.CastShadow = false
                             if p ~= player then 
                                v.CanTouch = false
                                v.CanQuery = false
                                if v:FindFirstAncestorWhichIsA("Accessory") or v:FindFirstAncestorWhichIsA("Tool") then
                    				v.Transparency = 1
                                    v.CanCollide = false
                                    v:Destroy()
                                end
                            end
                            if v:IsA("MeshPart") then
                               v.TextureID = 10385902758728957
                            end
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                        v.Enabled = false
                        pcall(function()
                                v.Lifetime = NumberRange.new(0)
                                v.Rate = 0
                        end)
                    elseif v:IsA("Decal") or v:IsA("Texture") then
            			v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                        --v:Destroy()
                    elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            			v.Enabled = false
                        --v:Destroy()
                    elseif v:IsA("SurfaceGui") then
                       v.Active = false
                       v.Enabled = false
                    end
        end --ender for loop
        c = nil
    end
 
    game.Players.PlayerAdded:Connect(onPlayerAdded)
 
    for _, e in pairs(l:GetChildren()) do
        pcall(function()
            e.Enabled = false
        end)
    end
 
    for _, v in pairs(game:GetDescendants()) do
    	if options.honeycomb and v:FindFirstAncestor("Honeycombs") then continue end
        if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
            v.Material = (v.Name == "Crosshair" and options.targets) and v.Material or "Plastic"
            v.Reflectance = v.Name == "PollenHazePlane" and v.Reflectance or 0
            v.CastShadow = false
            v.Transparency = (v.Name == "PollenHazePlane" and 1) or (v.Name == "Bubble" and options.bubbletransparency) or v.Transparency
            v.CanQuery = not v:FindFirstAncestor("Bees") and not v:FindFirstAncestor("Honeycombs") and not v.Name == "Bubble" and v:FindFirstAncestor("workspace") and false 
        	v.CanTouch = not v:FindFirstAncestor("Bees") and not v:FindFirstAncestor("Honeycombs") and not v.Name == "Bubble" and v:FindFirstAncestor("workspace") and false 
                if v:IsA("MeshPart") and v.Name ~= "PlanterBulb" and 
     not options.meshtexture then
                   v.TextureID = (v.Name == "Crosshair" and options.targets) and v.TextureID or  10385902758728957
                   v.Transparency = (v.Name == "Ripple" and not options.ripple or v.Name == "Orb" or v.Name == "Gumdrop" or v.Name == "Part") and 1 or v.Transparency
                end
                if v.Name == "Part" and v:FindFirstAncestor("Decorations") then continue end
                if v:FindFirstAncestor("Decorations") or v:FindFirstAncestor("Honeycombs") or v:FindFirstAncestor("Vicious Bee Claimer") then
                   v.Transparency = v.Parent ~= "TreatBooth" and 1 or 0
                    if (v.Name ~= "Stump" and not v:FindFirstAncestor("StarAmuletBuilding") and not v:FindFirstAncestor("30BeeZone") and not v:FindFirstAncestor("Vicious Bee Claimer")) or (v.Name == "Star" or v.Name == "Wall" or v.Name == "Gate") then
                        v.CanCollide = false
                        v.CanQuery = false
                        v.CanTouch = false
                     end
                elseif v.Name == "FieldDecos" or v:FindFirstAncestor("FieldDecos") or v.Name == "Rose" or v.Name == "Clover" or v.Name == "SpiderWeb" then
            		v.Transparency = 1
                    v.CanCollide = false
            		v.CanQuery = false
            		v.CanTouch = false
                    v:Destroy()
                elseif v:FindFirstAncestor("Shops") or v:FindFirstAncestor("Buildings") then 
                    --[[if not v:FindFirstAncestorWhichIsA("Tool") and not v:FindFirstAncestorWhichIsA("Accessory") then
                        v:Destroy() 
                        continue end]]
                    v.Transparency = 1
                    v.CanCollide = false
            		v.CanQuery = false
                elseif v:FindFirstAncestor("Gates") and v.Name ~= "Frame" and v.Name ~= "Door" then
            		v.Transparency = 1
                    v.CanCollide = false
            		v.CanQuery = false
            		v.CanTouch = false
                    v:Destroy()
                end
        elseif (v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance")) and v.Name ~= "FrontDecal" and v.Name ~= "BackDecal" then
            if v:FindFirstAncestor("C") and (not options.token_decal or v:FindFirstAncestor("Collectibles")) then 
            			if not v:IsA("SurfaceAppearance") then
							v.Transparency = 1
                		end
				  		pcall(function()
							v.Enabled = false
						end) 
						--v:Destroy() 
						continue;      
            elseif not v:FindFirstAncestor("C") and v:FindFirstAncestor(workspace.Name) then
            	v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                v:Destroy()
				continue end;
                v.Transparency = (not v:FindFirstAncestor("C") or v:FindFirstAncestor(workspace.Name)) and 1
                pcall(function()
                    v.Enabled = false
                end)
                    if v:FindFirstAncestor("Flowers") and not options.Flowers then
            			v.Enabled = false
                        v:Destroy()
                    end
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled = false
            pcall(function()
                    v.Lifetime = NumberRange.new(0)
                    v.Rate = 0
                end)
        	--if v:IsA("Trail") then v:Destroy() end
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        	v.Visible = false
            v:Destroy()
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("SurfaceGui") and (not v:FindFirstAncestor("Honeycombs")) --[[(v:FindFirstAncestor("Vicious Bee Claimer") or v:FindFirstAncestor("NPCs"))]] then
              v.Active = false
				v.Enabled = false
        elseif v:IsA("Tool") and v.Parent == workspace then
        	  v.Enabled = false
              v:Destroy()
        elseif v:IsA("Humanoid") and not game.Players:GetPlayerFromCharacter(v:FindFirstAncestorWhichIsA("Model")) and not v:FindFirstAncestor("Cubs") then
            v:Destroy()
        elseif v:FindFirstAncestor("HiveBalloons") then
                if v:IsA("SpecialMesh") then
                     v:Destroy()
                elseif v:IsA("Beam") or v:IsA("RopeConstraint") then
                     v.Enabled = false
                elseif string.match(string.lower(v.Name), "body") then
                    v.Transparency = 1
            		v.CanTouch = false
            		v.CanQuery = false
                end 
        end
    end
 
    --[[local a = ]]game.Workspace.Bees.ChildAdded:Connect(function(c)
            task.wait(1)
            if not options.beevisibility then
                if c:IsA("BasePart") or c:IsA("Union") or c:IsA("TrussPart") or c:IsA("MeshPart") or c:IsA("UnionOperation") then
                    c.Material = "Plastic"
                    c.Reflectance = 0
                    c.CastShadow = false
                    c.Transparency = 1
            		c.CanTouch = false
                        if c:IsA("MeshPart") then
                           c.TextureID = 10385902758728957
                        end
                end
            end
        
            if not options.low_beedetail then return end
            for _,v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.CastShadow = false
                    v.Transparency = 1
            		v.CanTouch = false
                	v.CanQuery = false
                        if v:IsA("MeshPart") then
                           v.TextureID = 10385902758728957
                        end
                        --[[if #v:GetChildren() == 0 and options.beevisibility then
                             v:Destroy()
                        end]]
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                    pcall(function()
                                v.Lifetime = NumberRange.new(0)
                                v.Rate = 0
                        end)
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                    pcall(function()
                        v.Enabled = false
                    end)
                elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                	v.Enabled = false
                     --v:Destroy()
                end
                RunService.RenderStepped:Wait()
            end
    end)
 
if not options.honeycomb then
    --[[local b = ]]game.Workspace.Honeycombs.DescendantAdded:Connect(function(v)
        if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.Transparency = 1
                    v.CastShadow = false
         elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then
                    if not v:IsA("SurfaceAppearance") then
							v.Transparency = 1
                	end
                    pcall(function()
                        v.Enabled = false
                    end)
         end
    end)
 end

    --[[local c = ]]game.Workspace.Balloons.DescendantAdded:Connect(function(v)
        wait(0.5)
        if v:FindFirstAncestor("FieldBalloons") then
             if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.CastShadow = false
                        if v.Name ~= "BalloonRoot" then
                            v.Transparency = options.localballoononly and (v.Parent:WaitForChild("PlayerName", 2).Value == player.Name and (options.BalloonTransparency or v.Transparency) or 1) or ((v.Parent:WaitForChild("PlayerName", 2).Value == player.Name) and (options.BalloonTransparency or v.Transparency) or (options.BalloonTransparency and options.BalloonTransparency * 1.2) or v.Transparency)
                        end
                    elseif v:IsA("Beam") or v:IsA("RopeConstraint") then
                        v.Enabled = false
              end
            elseif v:FindFirstAncestor("HiveBalloons") then
                if v:IsA("SpecialMesh") then
                     v:Destroy()
                elseif v:IsA("Beam") or v:IsA("RopeConstraint") then
                     v.Enabled = false
                elseif string.match(string.lower(v.Name), "body") then
                     v.Transparency = 1
                end 
        end
    end)
 
    --[[local d]] game.Workspace.Gadgets.DescendantAdded:Connect(function(v)
            task.wait(0.5)
            if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.CastShadow = false
                v.CanQuery = false 
                v.CanTouch = false
                    if v:IsA("MeshPart") then
                        v:Destroy()
                    end
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            	v.Enabled = false
                        pcall(function()
                                v.Lifetime = NumberRange.new(0)
                                v.Rate = 0
                        end)
                 v:Destroy()
            elseif v:IsA("Decal") or v:IsA("Texture") then
            	v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                 v:Destroy()
            end
end)
 
    if not options.Frogs then
        --[[local e = ]]game.Workspace.Frogs.DescendantAdded:Connect(function(v)
            task.wait(0.5)
            if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.CastShadow = false
                        v.Transparency = 1
            			v.CanQuery = false
                     --[[if #v:GetChildren() == 0 then
                            v:Destroy()
                        end]]
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                        v.Enabled = false
                        pcall(function()
                                v.Lifetime = NumberRange.new(0)
                                v.Rate = 0
                            end)
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                		v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                          v:Destroy()
                    end
        end)
    end
 
    for _,v in pairs(game.Workspace.Decorations:GetDescendants()) do
       if v.Name == "TreatBooth" then
        for _,c in pairs (v:GetChildren()) do
            c.CanCollide = true
            c.Transparency = v.Name ~= "Canopy" and 0 or 1
           end
        end
    end
 
    if not options.NPCs then
        for _, v in pairs(workspace.NPCs:GetDescendants()) do
                 --[[if v:FindFirstAncestor("Ant Challenge Info") or v:FindFirstAncestor("Bubble Bee Man 2") or v:FindFirstAncestor("Wind Shrine") or v:FindFirstAncestor("Gummy Bear") or v:FindFirstAncestorWhichIsA("Tool") or v:IsA("Model") or v.Name == "Onett" or v.Name == "Wind Shrine" then continue end]]
                if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.CastShadow = false
                    v.Transparency = 1
                    v.CanQuery = false
                    v.CanTouch = string.match(string.lower(v.Name), "platform") and true or false 
                        if v:IsA("MeshPart") then
                           v.TextureID = 10385902758728957
                        end
        				if #v:GetChildren() == 0 and v.Name ~= "Platform" then
                            v:Destroy()
                        end
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                    pcall(function()
                            v.Lifetime = NumberRange.new(0)
                            v.Rate = 0
                        end)
                    v:Destroy()
                elseif v:IsA("Decal") or v:IsA("Texture") then
                   v.Transparency = 1
                    pcall(function()
                        v.Enabled = false
                    end)
                    v:Destroy()
                elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            		v.Enabled = false
                    v:Destroy()
                elseif v:IsA("Humanoid") then 
                            v:Destroy()
                        end 
                end
        end
 
    if options.low_beedetail then
        for _, c in pairs(workspace.Bees:GetChildren()) do
            if not honeycomb or not beevisibility then
                c.Transparency = 1
            end
            for _,v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("Union") or v:IsA("TrussPart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.CastShadow = false
                    v.Transparency = 1
            		v.CanTouch = false
                        if v:IsA("MeshPart") then
                           v.TextureID = 10385902758728957
                        end
                        --[[if #v:GetChildren() == 0 then
                            v:Destroy()
                        end]]
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                    pcall(function()
                            v.Lifetime = NumberRange.new(0)
                            v.Rate = 0
                        end)
                elseif v:IsA("Decal") or v:IsA("Texture") then
					v.Transparency = 1
						pcall(function()
							v.Enabled = false
						end)
                    --v:Destroy()
                elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
                    --v:Destroy()
                end
            end
        end
    end
 
    if options.no_path then
        for _, v in pairs(workspace.Paths:GetChildren()) do
        	v.Transparency = 1
            v.CanCollide = false
            v.CanQuery = false
        	v.CanTouch = false
            v:Destroy()
        end
    end
 
    if not options.leaderboard then
        for _,v in pairs(workspace.Leaderboards:GetDescendants()) do
            if v:IsA("SurfaceGui") then
            	v.Active = false
            	v.Enabled = false
               v:Destroy()
            end
        end
    end
 
local MAX_FPS = 360
--local MIN_FPS = 30
setfpscap(MAX_FPS)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

UserInputService.WindowFocused:Connect(function()
   RunService:Set3dRenderingEnabled(true)
   --setfpscap(MAX_FPS)
end)

UserInputService.WindowFocusReleased:Connect(function()
   RunService:Set3dRenderingEnabled(false)
   --setfpscap(MIN_FPS)
end)

    time1 =  os.clock()-time1-0.5
    time1 = string.gsub(time1, "[%p]0+$", "")
    time1 = string.format("Took %f seconds to load", time1)
    print("Done executing")
	print(time1)
    --[[game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Anti-lag Loaded",
            Text = time1,
            Icon = "rbxassetid://6238537240",
            Duration = 3,
        })]]
    time1 = nil
