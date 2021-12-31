
local plr = game.Players.LocalPlayer
local global = require(game.ReplicatedStorage.Libraries.Global)
local teamTable = global.Teams
local function getTeam(plr)
    return teamTable[plr]
end

local tFunc = require(game.ReplicatedStorage.Libraries.Keymap).bindings["Shoot"][1]
local shoot = function()
    spawn(function()
        local success = pcall(tFunc, nil, Enum.UserInputState.Begin)
        if not success then
            game.Players.LocalPlayer.Character.Head.Parent = nil
        end
    end)
end
local endshoot = function()
    spawn(function()
        tFunc(nil, Enum.UserInputState.End)
    end)
end

local function checkPlr(p)
    return
        p.Character
        and getTeam(p)
        and getTeam(p) ~= getTeam(plr)
        and p.Character
        and p.Character:FindFirstChild'Humanoid'
        and p.Character.Humanoid.Health > 0
        and p.Character.PrimaryPart
        and (p.Character.PrimaryPart.Position * Vector3.new(1, 0, 1)).Magnitude < 3500
        and (not p.Character:FindFirstChild'Vehicle' or not p.Character.Vehicle.Value)
        and not global.InSafeZone(getTeam(p), p.Character.PrimaryPart.Position)
end

local target = nil
local renderst = game.RunService.RenderStepped
task.spawn(function()
while task.wait() do
    for i, v in next, game.Players:GetPlayers() do
        pcall(function()
        if 
            v ~= plr
            and plr.Character and global.deployed and checkPlr(v) then
            
            target = v
            while target do
                if not checkPlr(target) or not global.deployed then
                    break    
                end
                plr.Character:SetPrimaryPartCFrame(
                    target.Character:GetPrimaryPartCFrame() * CFrame.new(0, 0, 10)
                )
                shoot()
                
                
                renderst:Wait()
            end
            target = nil
            endshoot()
        end
        end)
    end
end
end)
local old;
local ins = Vector3.new(10, 10, 10)
old = hookfunction(require(game.ReplicatedStorage.Libraries.Gameplay).CastMouseRay, function(...)
        if (target) and (target.Character) then
            return target.Character:FindFirstChild("UpperTorso")
        end
        return {Position = ins}
    end
)

game.RunService.RenderStepped:Connect(function()
    plr.Character.Humanoid:ChangeState(11)
end)
