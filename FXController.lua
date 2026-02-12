local Knit_upvr = require(game.ReplicatedStorage.Knit.Knit)
local RunService_upvr = game:GetService("RunService")
local Debris_upvr = game:GetService("Debris")
local TweenService_upvr = game:GetService("TweenService")
local LocalPlayer_upvr = game.Players.LocalPlayer
local ReplicatedStorage_upvr = game.ReplicatedStorage
local Utils_upvr = ReplicatedStorage_upvr.Utils
local var10_upvw
local var11_upvw
local Enviroment = ReplicatedStorage_upvr.Sounds.Impact.Enviroment
local tbl_6_upvr = {
    [Enum.Material.Brick] = {1.3, Enviroment.BrickImpact};
    [Enum.Material.Cobblestone] = {1.2, Enviroment.BrickImpact};
    [Enum.Material.Slate] = {1.1, Enviroment.BrickImpact};
    [Enum.Material.Glass] = {0.2, Enviroment.GlassImpact};
    [Enum.Material.Concrete] = {0.8, Enviroment.StoneImpact};
    [Enum.Material.Plastic] = {1, Enviroment.StoneImpact};
    [Enum.Material.SmoothPlastic] = {1, Enviroment.StoneImpact};
    [Enum.Material.Wood] = {0.8, Enviroment.WoodImpact};
    [Enum.Material.WoodPlanks] = {0.75, Enviroment.WoodImpact};
    [Enum.Material.Grass] = {0.6, Enviroment.GrassImpact};
    [Enum.Material.Sand] = {0.5, Enviroment.GrassImpact};
    [Enum.Material.Metal] = {0.5, Enviroment.MetalImpact};
    [Enum.Material.DiamondPlate] = {0.5, Enviroment.MetalImpact};
    [Enum.Material.Neon] = {0.5, Enviroment.NeonImpact};
}
local any_new_result1_upvr = require(game.ReplicatedStorage.Modules.PartCache).new(Utils_upvr.Damage.DebreeRef, 2000, workspace.Map.Data)
any_new_result1_upvr.ExpansionSize = 20
local abs_upvr = math.abs
local function _(arg1, arg2) -- Line 47, Named "ManhattanDistance"
    --[[ Upvalues[1]:
        [1]: abs_upvr (readonly)
    ]]
    return abs_upvr(arg1.X - arg2.X) + abs_upvr(arg1.Y - arg2.Y) + abs_upvr(arg1.Z - arg2.Z)
end
local any_CreateController_result1 = Knit_upvr.CreateController({
    Name = "FXController";
})
function any_CreateController_result1.PlaySound(arg1, arg2, arg3, arg4, arg5) -- Line 55
    local clone_3_upvr = arg2:Clone()
    clone_3_upvr.Parent = arg3
    clone_3_upvr.SoundGroup = arg4
    clone_3_upvr:Play()
    if arg2.PlayOnRemove == true then
        clone_3_upvr:Destroy()
        return
    end
    if not arg5 then
        clone_3_upvr.Ended:Connect(function() -- Line 59
            --[[ Upvalues[1]:
                [1]: clone_3_upvr (readonly)
            ]]
            clone_3_upvr:Destroy()
        end)
    end
    return clone_3_upvr
end
function any_CreateController_result1.PlayParticles(arg1, arg2) -- Line 64
    local descendants = arg2:GetDescendants()
    table.insert(descendants, arg2)
    for _, v_upvr in descendants do
        if v_upvr:IsA("ParticleEmitter") then
            local EmitDelay = v_upvr:GetAttribute("EmitDelay")
            if EmitDelay and EmitDelay ~= 0 then
                task.delay(EmitDelay, function() -- Line 72
                    --[[ Upvalues[1]:
                        [1]: v_upvr (readonly)
                    ]]
                    v_upvr:Emit(v_upvr:GetAttribute("EmitCount"))
                end)
            else
                v_upvr:Emit(v_upvr:GetAttribute("EmitCount"))
            end
        end
    end
end
function any_CreateController_result1.ResizeParticle(arg1, arg2, arg3) -- Line 82
    local tbl_7 = {}
    for _, v_2 in pairs(arg2.Size.Keypoints) do
        table.insert(tbl_7, NumberSequenceKeypoint.new(v_2.Time, v_2.Value * arg3, v_2.Envelope * arg3))
    end
    arg2.Size = NumberSequence.new(tbl_7)
end
function any_CreateController_result1.Flash(arg1, arg2, arg3, arg4) -- Line 90
    --[[ Upvalues[4]:
        [1]: abs_upvr (readonly)
        [2]: Utils_upvr (readonly)
        [3]: Debris_upvr (readonly)
        [4]: TweenService_upvr (readonly)
    ]]
    local Position_7 = workspace.CurrentCamera.CFrame.Position
    local Position_14 = arg2.PrimaryPart.Position
    if 200 < abs_upvr(Position_7.X - Position_14.X) + abs_upvr(Position_7.Y - Position_14.Y) + abs_upvr(Position_7.Z - Position_14.Z) then return end
    local clone_5 = Utils_upvr.Damage.HitGlow:Clone()
    if arg2:GetScale() ~= 1 then
        clone_5:ScaleTo(arg2:GetScale())
    end
    clone_5.Parent = workspace.Effects
    Debris_upvr:AddItem(clone_5, arg4 or 0.15)
    for _, v_3 in clone_5:GetChildren() do
        local SOME = arg2:FindFirstChild(v_3.Name)
        if SOME then
            local Weld = Instance.new("Weld", v_3)
            Weld.Part0 = v_3
            Weld.Part1 = SOME
        end
        v_3.Color = arg3
        if arg4 then
            TweenService_upvr:Create(v_3, TweenInfo.new(arg4), {
                Transparency = 1;
            }):Play()
        end
    end
    return clone_5
end
function any_CreateController_result1.ArmFlash(arg1, arg2, arg3, arg4) -- Line 110
    --[[ Upvalues[4]:
        [1]: abs_upvr (readonly)
        [2]: Utils_upvr (readonly)
        [3]: TweenService_upvr (readonly)
        [4]: Debris_upvr (readonly)
    ]]
    local Position_10 = workspace.CurrentCamera.CFrame.Position
    local Position = arg2.Position
    if 200 < abs_upvr(Position_10.X - Position.X) + abs_upvr(Position_10.Y - Position.Y) + abs_upvr(Position_10.Z - Position.Z) then
    else
        local clone_4_upvr = Utils_upvr.Damage.CombatTrail:Clone()
        clone_4_upvr.Size = arg2.Size * 1.1
        clone_4_upvr.Color = arg3
        clone_4_upvr.Trail.Color = ColorSequence.new(arg3)
        clone_4_upvr.Weld.Part0 = arg2
        clone_4_upvr.Parent = workspace.Effects
        task.delay(arg4 or 0.2, function() -- Line 119
            --[[ Upvalues[3]:
                [1]: clone_4_upvr (readonly)
                [2]: TweenService_upvr (copied, readonly)
                [3]: Debris_upvr (copied, readonly)
            ]]
            clone_4_upvr.Trail.Enabled = false
            TweenService_upvr:Create(clone_4_upvr, TweenInfo.new(0.1), {
                Transparency = 1;
            }):Play()
            Debris_upvr:AddItem(clone_4_upvr, 0.2)
        end)
    end
end
function any_CreateController_result1.Notification(arg1, arg2, arg3, arg4) -- Line 126
    --[[ Upvalues[3]:
        [1]: LocalPlayer_upvr (readonly)
        [2]: Debris_upvr (readonly)
        [3]: TweenService_upvr (readonly)
    ]]
    local var63 = arg4 or 3
    local Menus = LocalPlayer_upvr.PlayerGui:WaitForChild("Menus")
    local clone_6 = Menus.Preset.Notification:Clone()
    clone_6.Noti.Text = arg2
    clone_6.Noti.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, arg3), ColorSequenceKeypoint.new(0.4, arg3), ColorSequenceKeypoint.new(0.45, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.55, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.6, arg3), ColorSequenceKeypoint.new(1, arg3)})
    clone_6.Parent = Menus.Notif
    Debris_upvr:AddItem(clone_6, var63 + 0.5)
    local Noti = clone_6.Noti
    TweenService_upvr:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0);
        TextTransparency = 0;
    }):Play()
    TweenService_upvr:Create(Noti.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0;
    }):Play()
    TweenService_upvr:Create(Noti.UIGradient, TweenInfo.new(2), {
        Offset = Vector2.new(1, 0);
    }):Play()
    TweenService_upvr:Create(Noti.UIStroke.UIGradient, TweenInfo.new(3.5), {
        Offset = Vector2.new(1, 0);
    }):Play()
    task.wait(var63)
    TweenService_upvr:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, 0, -35);
        TextTransparency = 1;
    }):Play()
    TweenService_upvr:Create(Noti.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1;
    }):Play()
end
function any_CreateController_result1.DustBreak(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 152
    --[[ Upvalues[4]:
        [1]: abs_upvr (readonly)
        [2]: Utils_upvr (readonly)
        [3]: TweenService_upvr (readonly)
        [4]: Debris_upvr (readonly)
    ]]
    local Position_5 = workspace.CurrentCamera.CFrame.Position
    if 200 < abs_upvr(Position_5.X - arg2.X) + abs_upvr(Position_5.Y - arg2.Y) + abs_upvr(Position_5.Z - arg2.Z) then
    else
        if not _G.Settings.DesPHY then return end
        local cframe = CFrame.new(arg2, arg2 + arg3)
        for _ = 1, arg5 do
            local workspace_Raycast_result1_4 = workspace:Raycast((cframe * CFrame.Angles(0, 0, math.random(0, math.pi)) * CFrame.new(math.random(0, arg4 * 10) / 10, 0, 0)).Position, cframe.LookVector * -(arg8 or 8), _G.MapParams)
            if workspace_Raycast_result1_4 then
                local clone_2_upvr = Utils_upvr.Damage.DebreeRef:Clone()
                clone_2_upvr.Color = workspace_Raycast_result1_4.Instance.Color
                clone_2_upvr.Material = workspace_Raycast_result1_4.Instance.Material
                clone_2_upvr.Transparency = workspace_Raycast_result1_4.Instance.Transparency
                clone_2_upvr.Size = Vector3.new(math.random(arg6 * 10, arg7 * 10) / 10, math.random(arg6 * 10, arg7 * 10) / 10, math.random(arg6 * 10, arg7 * 10) / 10)
                clone_2_upvr.Position = workspace_Raycast_result1_4.Position
                clone_2_upvr.CollisionGroup = "Effects"
                clone_2_upvr.Anchored = false
                clone_2_upvr.Velocity = Vector3.new(math.random(-20, 20), math.random(20, 40), math.random(-20, 20))
                clone_2_upvr.RotVelocity = Vector3.new(math.random(-200, 200), math.random(-200, 200), math.random(-200, 200))
                clone_2_upvr.Parent = workspace.Effects
                task.delay(3, function() -- Line 175
                    --[[ Upvalues[3]:
                        [1]: TweenService_upvr (copied, readonly)
                        [2]: clone_2_upvr (readonly)
                        [3]: Debris_upvr (copied, readonly)
                    ]]
                    TweenService_upvr:Create(clone_2_upvr, TweenInfo.new(1), {
                        Transparency = 1;
                    }):Play()
                    Debris_upvr:AddItem(clone_2_upvr, 1)
                end)
            end
        end
    end
end
function any_CreateController_result1.DustTrail(arg1, arg2, arg3, arg4) -- Line 183
    --[[ Upvalues[5]:
        [1]: abs_upvr (readonly)
        [2]: Utils_upvr (readonly)
        [3]: Debris_upvr (readonly)
        [4]: TweenService_upvr (readonly)
        [5]: RunService_upvr (readonly)
    ]]
    local Position_12 = workspace.CurrentCamera.CFrame.Position
    local Position_2 = arg2.PrimaryPart.Position
    if 200 < abs_upvr(Position_12.X - Position_2.X) + abs_upvr(Position_12.Y - Position_2.Y) + abs_upvr(Position_12.Z - Position_2.Z) then
    else
        local HumanoidRootPart_upvr_2 = arg2.HumanoidRootPart
        if not HumanoidRootPart_upvr_2 then return end
        local clone_11_upvr = Utils_upvr.Misc.SmokeTrail:Clone()
        clone_11_upvr.Parent = workspace.Effects
        local var97 = arg4
        if not var97 then
            var97 = CFrame.new()
        end
        clone_11_upvr.CFrame = HumanoidRootPart_upvr_2.CFrame * var97
        Debris_upvr:AddItem(clone_11_upvr, arg3 + 0.6)
        if arg4 then
            clone_11_upvr.Dash.Smoke.Enabled = true
            TweenService_upvr:Create(clone_11_upvr.Dash.Smoke, TweenInfo.new(arg3), {
                Rate = 0;
            }):Play()
            local workspace_Raycast_result1 = workspace:Raycast(HumanoidRootPart_upvr_2.Position, Vector3.new(0, -HumanoidRootPart_upvr_2.Size.Y * 1.6, 0), _G.MapParams)
            if workspace_Raycast_result1 then
                clone_11_upvr.Position = workspace_Raycast_result1.Position
                clone_11_upvr.Dash.Smoke:Emit(15)
            end
        end
        local var100_upvw
        local any_Connect_result1_upvr_2 = RunService_upvr.RenderStepped:Connect(function() -- Line 203
            --[[ Upvalues[4]:
                [1]: HumanoidRootPart_upvr_2 (readonly)
                [2]: arg4 (readonly)
                [3]: clone_11_upvr (readonly)
                [4]: var100_upvw (read and write)
            ]]
            -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
            local workspace_Raycast_result1_5 = workspace:Raycast(HumanoidRootPart_upvr_2.Position, Vector3.new(0, -HumanoidRootPart_upvr_2.Size.Y * 1.6, 0), _G.MapParams)
            -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [105] 74. Error Block 9 start (CF ANALYSIS FAILED)
            var100_upvw = clone_11_upvr.Smoke
            var100_upvw.Color = ColorSequence.new(workspace_Raycast_result1_5.Instance.Color)
            var100_upvw.Enabled = true
            do
                return
            end
            -- KONSTANTERROR: [105] 74. Error Block 9 end (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [124] 87. Error Block 13 start (CF ANALYSIS FAILED)
            clone_11_upvr.Dash.Smoke.Enabled = false
            if var100_upvw then
                var100_upvw.Enabled = false
            end
            -- KONSTANTERROR: [124] 87. Error Block 13 end (CF ANALYSIS FAILED)
        end)
        task.delay(arg3, function() -- Line 228
            --[[ Upvalues[3]:
                [1]: any_Connect_result1_upvr_2 (readonly)
                [2]: var100_upvw (read and write)
                [3]: clone_11_upvr (readonly)
            ]]
            any_Connect_result1_upvr_2:Disconnect()
            if var100_upvw then
                var100_upvw.Enabled = false
            end
            clone_11_upvr.Dash.Smoke.Enabled = false
        end)
    end
end
local BloodyZee_upvr = require(ReplicatedStorage_upvr.Modules.BloodyZee)
function any_CreateController_result1.Bleed(arg1, arg2) -- Line 235
    --[[ Upvalues[2]:
        [1]: Utils_upvr (readonly)
        [2]: BloodyZee_upvr (readonly)
    ]]
    if _G.Settings.Gore ~= true then
    else
        for _, v_23 in Utils_upvr.Damage.Explode:GetDescendants() do
            if v_23:IsA("Attachment") then
                v_23:Clone().Parent = arg2:FindFirstChild(v_23.Parent.Name)
            end
        end
        if arg2:GetAttribute("Bleeding") then return end
        arg2:SetAttribute("Bleeding", true)
        task.spawn(function() -- Line 245
            --[[ Upvalues[2]:
                [1]: BloodyZee_upvr (copied, readonly)
                [2]: arg2 (readonly)
            ]]
            repeat
                BloodyZee_upvr:Blood(arg2.Torso.CFrame, 50, 180, 180)
                task.wait(0.1)
            until not arg2.Parent
        end)
    end
end
function any_CreateController_result1.Burn(arg1, arg2) -- Line 253
    --[[ Upvalues[1]:
        [1]: Utils_upvr (readonly)
    ]]
    for _, v_4 in arg2:GetChildren() do
        if v_4:IsA("BasePart") then
            v_4.Color = Color3.new(0.1, 0.1, 0.1)
            Utils_upvr.Damage.LegBurn.Smoke:Clone().Parent = v_4
        elseif v_4:IsA("Shirt") or v_4:IsA("Pants") or v_4:IsA("TShirt") then
            v_4.Color3 = Color3.new(0.1, 0.1, 0.1)
        elseif v_4:IsA("Accessory") then
            local Handle = v_4:FindFirstChild("Handle", true)
            Handle.Color = Color3.new(0.1, 0.1, 0.1)
            Handle:FindFirstChildWhichIsA("SpecialMesh").TextureId = ""
        end
    end
end
function any_CreateController_result1.DomainMapFade(arg1, arg2, arg3, arg4) -- Line 269
    --[[ Upvalues[2]:
        [1]: TweenService_upvr (readonly)
        [2]: Debris_upvr (readonly)
    ]]
    local Highlight_upvr = Instance.new("Highlight", workspace.Map)
    Highlight_upvr.FillColor = arg2
    Highlight_upvr.OutlineColor = arg2
    Highlight_upvr.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight_upvr.OutlineTransparency = 1
    Highlight_upvr.FillTransparency = 1
    TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(arg3), {
        FillTransparency = 0;
        OutlineTransparency = 0;
    }):Play()
    Debris_upvr:AddItem(Highlight_upvr, arg4 + 0.5)
    task.delay(arg4, function() -- Line 277
        --[[ Upvalues[2]:
            [1]: TweenService_upvr (copied, readonly)
            [2]: Highlight_upvr (readonly)
        ]]
        TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(0.5), {
            FillTransparency = 1;
            OutlineTransparency = 1;
        }):Play()
    end)
end
function any_CreateController_result1.DomainBurst(arg1, arg2) -- Line 282
    --[[ Upvalues[4]:
        [1]: Utils_upvr (readonly)
        [2]: TweenService_upvr (readonly)
        [3]: Debris_upvr (readonly)
        [4]: ReplicatedStorage_upvr (readonly)
    ]]
    local clone_12 = Utils_upvr.DomainBurst:Clone()
    clone_12.Position = arg2.Position
    clone_12.Parent = workspace.Effects
    TweenService_upvr:Create(clone_12, TweenInfo.new(0.3), {
        Size = Vector3.new(75, 75, 75);
        Transparency = 1;
    }):Play()
    clone_12.Attachment.Spark:Emit(1)
    Debris_upvr:AddItem(clone_12, 0.4)
    arg1:PlaySound(ReplicatedStorage_upvr.Sounds.Misc.Domain.DomainOpen, arg2, game.SoundService.Effect)
end
local tbl_3_upvr = {0.3, 0.7, 0.5}
for _, v_5 in ReplicatedStorage_upvr.Animations:GetDescendants() do
    if v_5.Name == "DomainWarn" then
        Utils_upvr.DomainWarn.Panel.Viewport.Display.Humanoid:LoadAnimation(v_5)
    end
end
function any_CreateController_result1.ApplyCopyOutfit(arg1, arg2, arg3) -- Line 297
    --[[ Upvalues[1]:
        [1]: Utils_upvr (readonly)
    ]]
    arg3:ScaleTo(arg2:GetScale())
    local tbl_11 = {"Head", "Left Arm", "Left Leg", "Right Arm", "Right Leg", "Torso"}
    for _, v_6 in arg2:GetChildren() do
        if v_6:IsA("Shirt") or v_6:IsA("TShirt") or v_6:IsA("Pants") or v_6:IsA("BodyColors") then
            v_6:Clone().Parent = arg3
        elseif v_6:IsA("Accessory") then
            local clone = v_6:Clone()
            clone.Parent = arg3
            local AccessoryWeld = clone:FindFirstChild("AccessoryWeld", true)
            AccessoryWeld.Part1 = arg3:FindFirstChild(AccessoryWeld.Part1.Name)
        elseif v_6:IsA("CharacterMesh") then
            v_6:Clone().Parent = arg3
        end
    end
    arg3:ScaleTo(1)
    local face = arg2.Head:FindFirstChild("face")
    if face then
        arg3.Head.face.Texture = face.Texture
    end
    if arg2:FindFirstChild("Outfit") then
        local clone_7 = Utils_upvr.Megumi.Mahoraga.Mahoraga.Outfit:Clone()
        clone_7.Head.Beard:Destroy()
        clone_7.Head.Hat:Destroy()
        clone_7:ScaleTo(0.6666666666666666)
        for _, v_7 in clone_7:GetDescendants() do
            if v_7:IsA("Weld") or v_7:IsA("Motor6D") then
                if table.find(tbl_11, v_7.Part0.Name) then
                    v_7.Part0 = arg3:FindFirstChild(v_7.Part0.Name)
                end
                if table.find(tbl_11, v_7.Part1.Name) then
                    v_7.Part1 = arg3:FindFirstChild(v_7.Part1.Name)
                end
            end
        end
        clone_7.Parent = arg3
    end
    if arg3["Left Arm"]:FindFirstChild("FingersL") then
        for _, v_8 in arg3["Left Arm"].FingersL:GetChildren() do
            v_7 = v_8:IsA("BasePart")
            if v_7 then
                v_7 = arg2["Left Arm"].Color
                v_8.Color = v_7
            end
        end
        for _, v_9 in arg3["Right Arm"].FingersR:GetChildren() do
            v_7 = v_9:IsA("BasePart")
            if v_7 then
                v_7 = arg2["Right Arm"].Color
                v_9.Color = v_7
            end
        end
    end
end
function any_CreateController_result1.WorldModelChar(arg1, arg2, arg3) -- Line 333
    --[[ Upvalues[1]:
        [1]: RunService_upvr (readonly)
    ]]
    local clone_8 = arg2:Clone()
    local WorldModel_upvr = Instance.new("WorldModel")
    for _, v_10 in clone_8:GetChildren() do
        v_10.Parent = WorldModel_upvr
    end
    WorldModel_upvr.PrimaryPart = WorldModel_upvr.Humanoid.RootPart
    for _, v_11 in WorldModel_upvr:GetDescendants() do
        if v_11:IsA("Sound") or v_11:IsA("Script") then
            v_11:Destroy()
        end
    end
    clone_8:Destroy()
    WorldModel_upvr.Parent = arg3
    for _, v_12 in WorldModel_upvr:GetChildren() do
        if v_12:IsA("BasePart") then
            v_12.Anchored = true
        end
    end
    local var177_upvw
    var177_upvw = RunService_upvr.Stepped:Connect(function() -- Line 348
        --[[ Upvalues[4]:
            [1]: arg2 (readonly)
            [2]: arg3 (readonly)
            [3]: var177_upvw (read and write)
            [4]: WorldModel_upvr (readonly)
        ]]
        if not arg2.Parent or not arg3.Parent then
            var177_upvw:Disconnect()
            WorldModel_upvr:Destroy()
        else
            for _, v_24 in WorldModel_upvr:GetChildren() do
                if v_24:IsA("BasePart") then
                    local SOME_2 = arg2:FindFirstChild(v_24.Name)
                    if SOME_2 then
                        v_24.CFrame = SOME_2.CFrame
                    end
                end
            end
        end
    end)
    return WorldModel_upvr
end
function any_CreateController_result1.Domain(arg1, arg2, arg3) -- Line 365
    --[[ Upvalues[5]:
        [1]: Utils_upvr (readonly)
        [2]: LocalPlayer_upvr (readonly)
        [3]: TweenService_upvr (readonly)
        [4]: tbl_3_upvr (readonly)
        [5]: Debris_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local clone_9_upvr = Utils_upvr.DomainWarn:Clone()
    clone_9_upvr.Parent = LocalPlayer_upvr.PlayerGui
    local Display_upvr = clone_9_upvr.Panel.Viewport.Display
    pcall(function() -- Line 370
        --[[ Upvalues[3]:
            [1]: arg1 (readonly)
            [2]: arg2 (readonly)
            [3]: Display_upvr (readonly)
        ]]
        arg1:ApplyCopyOutfit(arg2, Display_upvr)
    end)
    local Camera = Instance.new("Camera", clone_9_upvr.Panel)
    Camera.FieldOfView = 40
    Camera.CFrame = Display_upvr.HumanoidRootPart.CFrame * CFrame.new(0, 1, -5) * CFrame.Angles(0, math.pi, 0)
    clone_9_upvr.Panel.Viewport.CurrentCamera = Camera
    arg3(clone_9_upvr, Display_upvr)
    TweenService_upvr:Create(clone_9_upvr.FlashText, TweenInfo.new(1.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.5, 0, 0.43, 0);
    }):Play()
    task.delay(0.625, function() -- Line 379
        --[[ Upvalues[2]:
            [1]: TweenService_upvr (copied, readonly)
            [2]: clone_9_upvr (readonly)
        ]]
        TweenService_upvr:Create(clone_9_upvr.FlashText.Text1, TweenInfo.new(0.625), {
            TextTransparency = 1;
        }):Play()
        TweenService_upvr:Create(clone_9_upvr.FlashText.Text1.UIStroke, TweenInfo.new(0.625), {
            Transparency = 1;
        }):Play()
        TweenService_upvr:Create(clone_9_upvr.FlashText.Text2, TweenInfo.new(0.625), {
            TextTransparency = 1;
        }):Play()
        TweenService_upvr:Create(clone_9_upvr.FlashText.Text2.UIStroke, TweenInfo.new(0.625), {
            Transparency = 1;
        }):Play()
    end)
    local var219
    for _, v_13 in LocalPlayer_upvr.PlayerGui:GetChildren() do
        if v_13.Name == "DomainWarn" and v_13 ~= clone_9_upvr then
            var219 += 1
        end
    end
    for _, v_14 in clone_9_upvr:GetChildren() do
        TweenService_upvr:Create(v_14, TweenInfo.new(1.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, tbl_3_upvr[var219 % 3 + 1], 0);
        }):Play()
        local _
    end
    TweenService_upvr:Create(clone_9_upvr.Panel, TweenInfo.new(0.625, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.5, 0, 0.4, 0);
    }):Play()
    TweenService_upvr:Create(clone_9_upvr.PanelBack, TweenInfo.new(0.625, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.5, 0, 0.43, 0);
    }):Play()
    task.wait(0.625)
    TweenService_upvr:Create(clone_9_upvr.Panel, TweenInfo.new(0.625, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Size = UDim2.new(1.5, 0, 0, 0);
    }):Play()
    TweenService_upvr:Create(clone_9_upvr.PanelBack, TweenInfo.new(0.625, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Size = UDim2.new(1.5, 0, 0.03, 0);
    }):Play()
    Debris_upvr:AddItem(clone_9_upvr, 0.625)
end
function any_CreateController_result1.DebreeSound(arg1, arg2) -- Line 405
    --[[ Upvalues[2]:
        [1]: abs_upvr (readonly)
        [2]: tbl_6_upvr (readonly)
    ]]
    local Position_13 = workspace.CurrentCamera.CFrame.Position
    local Position_11 = arg2.Position
    if 300 < abs_upvr(Position_13.X - Position_11.X) + abs_upvr(Position_13.Y - Position_11.Y) + abs_upvr(Position_13.Z - Position_11.Z) then
    else
        local var231 = tbl_6_upvr[arg2.Material]
        if var231 then
            local children_11 = var231[2]:GetChildren()
            arg1:PlaySound(children_11[math.random(1, #children_11)], arg2, game.SoundService.Effect)
        end
    end
end
any_CreateController_result1.Voxels = {}
local Sounds_upvr = ReplicatedStorage_upvr.Sounds
local tbl_8_upvr = {}
local Remotes_upvr = ReplicatedStorage_upvr.Remotes
function any_CreateController_result1.KnitStart(arg1) -- Line 417
    --[[ Upvalues[12]:
        [1]: var10_upvw (read and write)
        [2]: Sounds_upvr (readonly)
        [3]: var11_upvw (read and write)
        [4]: LocalPlayer_upvr (readonly)
        [5]: any_new_result1_upvr (readonly)
        [6]: abs_upvr (readonly)
        [7]: TweenService_upvr (readonly)
        [8]: Debris_upvr (readonly)
        [9]: tbl_8_upvr (readonly)
        [10]: Utils_upvr (readonly)
        [11]: RunService_upvr (readonly)
        [12]: Remotes_upvr (readonly)
    ]]
    var10_upvw.Sound:Connect(function(arg1_2) -- Line 418
        --[[ Upvalues[1]:
            [1]: arg1 (readonly)
        ]]
        if not arg1_2 then
        else
            if typeof(arg1_2) == "buffer" then
                for i_30 = 1, buffer.len(arg1_2) / 2 do
                    local var242 = arg1.Voxels[buffer.readi16(arg1_2, (i_30 - 1) * 2)]
                    if var242 then
                        arg1:DebreeSound(var242[1])
                    end
                end
                return
            end
            if typeof(arg1_2) == "number" then
                local var243 = arg1.Voxels[arg1_2]
                if not var243 then
                else
                    arg1:DebreeSound(var243[1])
                end
            end
            arg1:DebreeSound(arg1_2)
        end
    end)
    var10_upvw.Domain:Connect(function(arg1_3) -- Line 438
        --[[ Upvalues[2]:
            [1]: arg1 (readonly)
            [2]: Sounds_upvr (copied, readonly)
        ]]
        arg1:PlaySound(Sounds_upvr.Misc.Domain.DomainHit, arg1_3, game.SoundService.Effect)
        local DomainCollider = arg1_3:FindFirstChild("DomainCollider")
        if DomainCollider then
            arg1:PlaySound(Sounds_upvr.Misc.Domain.DomainHit, DomainCollider, game.SoundService.Effect)
        end
    end)
    var11_upvw.CFix:Connect(function(arg1_4) -- Line 444
        --[[ Upvalues[1]:
            [1]: LocalPlayer_upvr (copied, readonly)
        ]]
        local Character = LocalPlayer_upvr.Character
        if not Character then
        else
            local Freecam = LocalPlayer_upvr.PlayerGui:FindFirstChild("Freecam")
            if Freecam then
                Freecam:SetAttribute("ow", workspace.CurrentCamera.CFrame.Position + arg1_4)
            end
            for _, v_25 in Character:GetDescendants() do
                if v_25:IsA("BodyPosition") or v_25:IsA("AlignPosition") and v_25.Mode == Enum.PositionAlignmentMode.OneAttachment then
                    v_25.Position += arg1_4
                end
            end
        end
    end)
    local tbl_9_upvr = {}
    for i_15, v_15 in Enum.Material:GetEnumItems() do
        tbl_9_upvr[tostring(i_15)] = v_15
    end
    var10_upvw.Create:Connect(function(arg1_5, arg2) -- Line 460
        --[[ Upvalues[8]:
            [1]: tbl_9_upvr (readonly)
            [2]: arg1 (readonly)
            [3]: any_new_result1_upvr (copied, readonly)
            [4]: abs_upvr (copied, readonly)
            [5]: TweenService_upvr (copied, readonly)
            [6]: Debris_upvr (copied, readonly)
            [7]: tbl_8_upvr (copied, readonly)
            [8]: Utils_upvr (copied, readonly)
        ]]
        local tbl_5 = {}
        local Position_9 = workspace.CurrentCamera.CFrame.Position
        local var283
        for i_16, v_16 in arg1_5 do
            for i_17, var313 in v_16 do
                for i_18, v_18 in var313 do
                    local _1_4 = v_18[1]
                    local _2 = v_18[2]
                    local _3 = v_18[3]
                    local var287
                    if _1_4 ~= nil then
                        for i_19 = 1, buffer.len(_1_4) / 32 do
                            local var288 = (i_19 - 1) * 32
                            local buffer_readu16_result1 = buffer.readu16(_1_4, var288 + 30)
                            if not arg1.Voxels[buffer_readu16_result1] then
                                local any_GetPart_result1 = any_new_result1_upvr:GetPart()
                                any_GetPart_result1.Color = Color3.fromRGB(table.unpack(string.split(i_18, ',')))
                                any_GetPart_result1.Material = tbl_9_upvr[i_17]
                                any_GetPart_result1.Size = Vector3.new(buffer.readf32(_1_4, var288 + 18), buffer.readf32(_1_4, var288 + 22), buffer.readf32(_1_4, var288 + 26))
                                any_GetPart_result1.Transparency = tonumber(i_16)
                                any_GetPart_result1.Locked = false
                                any_GetPart_result1.CastShadow = true
                                arg1.Voxels[buffer_readu16_result1] = {any_GetPart_result1}
                                table.insert(tbl_5, any_GetPart_result1)
                                table.insert({}, CFrame.new(Vector3.new(buffer.readf32(_1_4, var288 + 0), buffer.readf32(_1_4, var288 + 4), buffer.readf32(_1_4, var288 + 8))) * CFrame.fromOrientation(math.rad(buffer.readi16(_1_4, var288 + 12) / 100), math.rad(buffer.readi16(_1_4, var288 + 14) / 100), math.rad(buffer.readi16(_1_4, var288 + 16) / 100)))
                            end
                        end
                    end
                    if _2 ~= nil then
                        for i_20 = 1, buffer.len(_2) / 32 do
                            local var292 = (i_20 - 1) * 32
                            local buffer_readf32_result1_5 = buffer.readf32(_2, var292 + 0)
                            local buffer_readf32_result1_6 = buffer.readf32(_2, var292 + 4)
                            local buffer_readf32_result1 = buffer.readf32(_2, var292 + 8)
                            local buffer_readu16_result1_2 = buffer.readu16(_2, var292 + 30)
                            if not arg1.Voxels[buffer_readu16_result1_2] then
                                if i_20 == 1 then
                                    local tbl_4 = {
                                        X = buffer_readf32_result1_5;
                                        Y = buffer_readf32_result1_6;
                                        Z = buffer_readf32_result1;
                                    }
                                    if abs_upvr(Position_9.X - tbl_4.X) + abs_upvr(Position_9.Y - tbl_4.Y) + abs_upvr(Position_9.Z - tbl_4.Z) >= 100 then
                                        var287 = false
                                    else
                                        var287 = true
                                    end
                                end
                                local any_GetPart_result1_2 = any_new_result1_upvr:GetPart()
                                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                any_GetPart_result1_2.Color = Color3.fromRGB(table.unpack(string.split(i_18, ',')))
                                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                any_GetPart_result1_2.Material = tbl_9_upvr[i_17]
                                any_GetPart_result1_2.Size = Vector3.new(buffer.readf32(_2, var292 + 18), buffer.readf32(_2, var292 + 22), buffer.readf32(_2, var292 + 26))
                                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                any_GetPart_result1_2.Transparency = tonumber(i_16)
                                any_GetPart_result1_2.Locked = true
                                any_GetPart_result1_2.CastShadow = false
                                arg1.Voxels[buffer_readu16_result1_2] = {any_GetPart_result1_2, var287}
                                table.insert(tbl_5, any_GetPart_result1_2)
                                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                table.insert({}, CFrame.new(Vector3.new(buffer_readf32_result1_5, buffer_readf32_result1_6, buffer_readf32_result1)) * CFrame.fromOrientation(math.rad(buffer.readi16(_2, var292 + 12) / 100), math.rad(buffer.readi16(_2, var292 + 14) / 100), math.rad(buffer.readi16(_2, var292 + 16) / 100)))
                            end
                        end
                    end
                    if var283 == false then
                        if var287 ~= true then
                            var283 = false
                        else
                            var283 = true
                        end
                    end
                    if _3 ~= nil then
                        for i_21 = 1, buffer.len(_3) / 44 do
                            local var300 = (i_21 - 1) * 44
                            local buffer_readf32_result1_4 = buffer.readf32(_3, var300 + 0)
                            local buffer_readf32_result1_2 = buffer.readf32(_3, var300 + 4)
                            local buffer_readf32_result1_3 = buffer.readf32(_3, var300 + 8)
                            local buffer_readu16_result1_upvr = buffer.readu16(_3, var300 + 30)
                            if not arg1.Voxels[buffer_readu16_result1_upvr] then
                                if i_21 == 1 then
                                    local tbl_13 = {
                                        X = buffer_readf32_result1_4;
                                        Y = buffer_readf32_result1_2;
                                        Z = buffer_readf32_result1_3;
                                    }
                                    if abs_upvr(Position_9.X - tbl_13.X) + abs_upvr(Position_9.Y - tbl_13.Y) + abs_upvr(Position_9.Z - tbl_13.Z) >= 150 then
                                    else
                                    end
                                end
                                if true ~= false then
                                    local any_GetPart_result1_3_upvr = any_new_result1_upvr:GetPart()
                                    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                    any_GetPart_result1_3_upvr.Color = Color3.fromRGB(table.unpack(string.split(i_18, ',')))
                                    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                    any_GetPart_result1_3_upvr.Material = tbl_9_upvr[i_17]
                                    any_GetPart_result1_3_upvr.Size = Vector3.new(buffer.readf32(_3, var300 + 18), buffer.readf32(_3, var300 + 22), buffer.readf32(_3, var300 + 26))
                                    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                    any_GetPart_result1_3_upvr.Transparency = tonumber(i_16)
                                    any_GetPart_result1_3_upvr.Anchored = false
                                    any_GetPart_result1_3_upvr.Locked = true
                                    any_GetPart_result1_3_upvr.CastShadow = false
                                    any_GetPart_result1_3_upvr.AssemblyLinearVelocity = Vector3.new(buffer.readi16(_3, var300 + 32) / 100, buffer.readi16(_3, var300 + 34) / 100, buffer.readi16(_3, var300 + 36) / 100)
                                    any_GetPart_result1_3_upvr.AssemblyAngularVelocity = Vector3.new(buffer.readi16(_3, var300 + 38) / 100, buffer.readi16(_3, var300 + 40) / 100, buffer.readi16(_3, var300 + 42) / 100)
                                    arg1.Voxels[buffer_readu16_result1_upvr] = {any_GetPart_result1_3_upvr, false}
                                    table.insert(tbl_5, any_GetPart_result1_3_upvr)
                                    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                    table.insert({}, CFrame.new(Vector3.new(buffer_readf32_result1_4, buffer_readf32_result1_2, buffer_readf32_result1_3)) * CFrame.fromOrientation(math.rad(buffer.readi16(_3, var300 + 12) / 100), math.rad(buffer.readi16(_3, var300 + 14) / 100), math.rad(buffer.readi16(_3, var300 + 16) / 100)))
                                    task.delay(3, function() -- Line 551
                                        --[[ Upvalues[5]:
                                            [1]: arg1 (copied, readonly)
                                            [2]: buffer_readu16_result1_upvr (readonly)
                                            [3]: TweenService_upvr (copied, readonly)
                                            [4]: any_GetPart_result1_3_upvr (readonly)
                                            [5]: Debris_upvr (copied, readonly)
                                        ]]
                                        if not arg1.Voxels[buffer_readu16_result1_upvr] then
                                        else
                                            local any_Create_result1_4 = TweenService_upvr:Create(any_GetPart_result1_3_upvr, TweenInfo.new(1), {
                                                Transparency = 1;
                                            })
                                            any_Create_result1_4:Play()
                                            Debris_upvr:AddItem(any_Create_result1_4, 1)
                                            arg1.Voxels[buffer_readu16_result1_upvr][3] = any_Create_result1_4
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        i_16 = {}
        v_16 = Enum.BulkMoveMode.FireCFrameChanged
        workspace:BulkMoveTo(tbl_5, i_16, v_16)
        if var283 and arg2 == nil and _G.Settings.DesVFX == true then
            for _, v_19 in tbl_5 do
                if v_19.Locked ~= false then
                    local var311_upvw
                    local len = #tbl_8_upvr
                    i_17 = tbl_8_upvr
                    if i_17[len] then
                        var311_upvw = tbl_8_upvr[len]
                        i_17 = nil
                        tbl_8_upvr[len] = i_17
                    else
                        var313 = Utils_upvr
                        i_17 = var313.Damage
                        var311_upvw = i_17.Break:Clone()
                    end
                    i_17 = v_19.Color
                    var311_upvw.Color = ColorSequence.new(i_17)
                    var311_upvw.Parent = v_19
                    var313 = 1
                    var311_upvw:Emit(var313)
                    i_17 = 1.5
                    function var313() -- Line 577
                        --[[ Upvalues[2]:
                            [1]: var311_upvw (read and write)
                            [2]: tbl_8_upvr (copied, readonly)
                        ]]
                        var311_upvw.Parent = nil
                        table.insert(tbl_8_upvr, var311_upvw)
                    end
                    task.delay(i_17, var313)
                end
            end
        end
    end)
    local TweenInfo_new_result1_upvr = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    var10_upvw.Physics:Connect(function(arg1_6) -- Line 588
        --[[ Upvalues[4]:
            [1]: arg1 (readonly)
            [2]: TweenService_upvr (copied, readonly)
            [3]: TweenInfo_new_result1_upvr (readonly)
            [4]: TweenInfo_new_result1_upvr_2 (readonly)
        ]]
        local var334 = buffer.len(arg1_6) / 21
        if _G.Settings.DesINT == true then
            for i_23 = 1, var334 do
                local var335 = (i_23 - 1) * 21
                local var336 = arg1.Voxels[buffer.readu16(arg1_6, var335 + 18)]
                if var336 then
                    local _1_2 = var336[1]
                    if _1_2 and _1_2.Locked ~= false then
                        if var336[2] == true then
                            if var336[3] then
                                var336[3]:Destroy()
                            end
                            if buffer.readu8(arg1_6, var335 + 20) == 1 then
                                local any_Create_result1_5 = TweenService_upvr:Create(_1_2, TweenInfo_new_result1_upvr, {
                                    CFrame = CFrame.new(Vector3.new(buffer.readf32(arg1_6, var335 + 0), buffer.readf32(arg1_6, var335 + 4), buffer.readf32(arg1_6, var335 + 8))) * CFrame.fromOrientation(math.rad(buffer.readi16(arg1_6, var335 + 12) / 100), math.rad(buffer.readi16(arg1_6, var335 + 14) / 100), math.rad(buffer.readi16(arg1_6, var335 + 16) / 100));
                                })
                                any_Create_result1_5:Play()
                                var336[3] = any_Create_result1_5
                            else
                                local tbl = {}
                                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                                tbl.CFrame = _1_2.CFrame:Lerp(CFrame.new(Vector3.new(buffer.readf32(arg1_6, var335 + 0), buffer.readf32(arg1_6, var335 + 4), buffer.readf32(arg1_6, var335 + 8))) * CFrame.fromOrientation(math.rad(buffer.readi16(arg1_6, var335 + 12) / 100), math.rad(buffer.readi16(arg1_6, var335 + 14) / 100), math.rad(buffer.readi16(arg1_6, var335 + 16) / 100)), 1.5)
                                local any_Create_result1 = TweenService_upvr:Create(_1_2, TweenInfo_new_result1_upvr_2, tbl)
                                any_Create_result1:Play()
                                var336[3] = any_Create_result1
                            end
                        else
                            -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                            _1_2.CFrame = CFrame.new(Vector3.new(buffer.readf32(arg1_6, var335 + 0), buffer.readf32(arg1_6, var335 + 4), buffer.readf32(arg1_6, var335 + 8))) * CFrame.fromOrientation(math.rad(buffer.readi16(arg1_6, var335 + 12) / 100), math.rad(buffer.readi16(arg1_6, var335 + 14) / 100), math.rad(buffer.readi16(arg1_6, var335 + 16) / 100))
                        end
                    end
                end
            end
        else
            for i_32 = 1, var334 do
                local var342 = (i_32 - 1) * 21
                local var343 = arg1.Voxels[buffer.readu16(arg1_6, var342 + 18)]
                if var343 then
                    local _1 = var343[1]
                    if _1 then
                        table.insert({}, _1)
                        table.insert({}, CFrame.new(Vector3.new(buffer.readf32(arg1_6, var342 + 0), buffer.readf32(arg1_6, var342 + 4), buffer.readf32(arg1_6, var342 + 8))) * CFrame.fromOrientation(math.rad(buffer.readi16(arg1_6, var342 + 12) / 100), math.rad(buffer.readi16(arg1_6, var342 + 14) / 100), math.rad(buffer.readi16(arg1_6, var342 + 16) / 100)))
                    end
                end
            end
            -- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
            workspace:BulkMoveTo({}, {}, Enum.BulkMoveMode.FireCFrameChanged)
        end
    end)
    local var346_upvw = false
    local DomainFade_upvr = LocalPlayer_upvr.PlayerGui:WaitForChild("Main").DomainFade
    RunService_upvr.RenderStepped:Connect(function(arg1_7) -- Line 640
        --[[ Upvalues[4]:
            [1]: LocalPlayer_upvr (copied, readonly)
            [2]: var346_upvw (read and write)
            [3]: DomainFade_upvr (readonly)
            [4]: TweenService_upvr (copied, readonly)
        ]]
        -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
        local children_9, NONE_4, NONE_14 = workspace.Domains:GetChildren()
        -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [41] 28. Error Block 6 start (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [41] 28. Error Block 6 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [17] 11. Error Block 2 start (CF ANALYSIS FAILED)
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.8]
        -- KONSTANTERROR: [17] 11. Error Block 2 end (CF ANALYSIS FAILED)
    end)
    task.spawn(function() -- Line 667
        --[[ Upvalues[2]:
            [1]: arg1 (readonly)
            [2]: abs_upvr (copied, readonly)
        ]]
        while task.wait() do
            if _G.Settings.DesINT ~= false then
                local Position_8 = workspace.CurrentCamera.CFrame.Position
                for i_24, v_20 in arg1.Voxels do
                    if v_20[1].Locked ~= false and v_20[1].Anchored ~= false then
                        local Position_6 = v_20[1].Position
                        if abs_upvr(Position_8.X - Position_6.X) + abs_upvr(Position_8.Y - Position_6.Y) + abs_upvr(Position_8.Z - Position_6.Z) < 100 then
                            arg1.Voxels[i_24][2] = true
                        else
                            arg1.Voxels[i_24][2] = true
                        end
                        if 20 < 0 + 1 then
                            task.wait()
                        end
                    end
                end
            end
        end
    end)
    var10_upvw.Prop:Connect(function(arg1_8) -- Line 686
        --[[ Upvalues[2]:
            [1]: arg1 (readonly)
            [2]: any_new_result1_upvr (copied, readonly)
        ]]
        for _, v_21 in arg1_8 do
            local var359 = arg1.Voxels[v_21]
            if var359 then
                arg1.Voxels[v_21] = nil
                if var359[3] then
                    var359[3]:Cancel()
                end
                any_new_result1_upvr:ReturnPart(var359[1])
            end
        end
    end)
    Remotes_upvr.Message.OnClientEvent:Connect(function(arg1_9) -- Line 697
        game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(arg1_9)
    end)
    pcall(function() -- Line 702
        local Humanoid = Instance.new("Humanoid")
        Humanoid.Parent = workspace.Effects
        for _, v_22 in next, game:GetService("ReplicatedStorage").Utils.Preload:GetChildren() do
            if v_22:IsA("Animation") then
                pcall(Humanoid.LoadAnimation, Humanoid, v_22)
            end
        end
        task.delay(10, Humanoid.Destroy, Humanoid)
    end)
end
function any_CreateController_result1.KnitInit(arg1) -- Line 715
    --[[ Upvalues[3]:
        [1]: var10_upvw (read and write)
        [2]: Knit_upvr (readonly)
        [3]: var11_upvw (read and write)
    ]]
    var10_upvw = Knit_upvr.GetService("DebreeService")
    var11_upvw = Knit_upvr.GetService("DomainService")
end
return any_CreateController_result1
