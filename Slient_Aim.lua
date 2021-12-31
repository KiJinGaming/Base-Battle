local global = require(game.ReplicatedStorage.Libraries.Global)
local teamTable = global.Teams
local function getTeam(plr)
    return teamTable[plr]
end
local function closeToMouse()
    local plr = game.Players.LocalPlayer
    local mouse = plr.GetMouse(plr)
    local maxdist = math.huge
    local target;
    for i, v in next, game.Players.GetPlayers(game.Players) do
        if v ~= plr and getTeam(v) and getTeam(v) ~= getTeam(plr) and v.Character and v.Character:FindFirstChild'Humanoid' and v.Character.Humanoid.Health > 0 and v.Character.PrimaryPart and not global.InSafeZone(getTeam(v), v.Character.PrimaryPart.Position) then
            local vector, onScreen = workspace.CurrentCamera.WorldToViewportPoint(workspace.CurrentCamera, v.Character.HumanoidRootPart.Position)
            local mag = (Vector2.new(vector.X, vector.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
            if mag < maxdist and onScreen then
                maxdist = mag;
                target = v;
            end
        end
    end
    return target;
end
local old;
old = hookfunction(require(game.ReplicatedStorage.Libraries.Gameplay).CastMouseRay, function(...)
    local p = closeToMouse();
    return p and p.Character and p.Character.PrimaryPart or old(...)
end)

local function closeToMouse()
    local plr = game.Players.LocalPlayer
    local mouse = plr.GetMouse(plr)
    local maxdist = math.huge
    local target;
    for i, v in next, game.Players.GetPlayers(game.Players) do
        if v ~= plr and getTeam(v) and getTeam(v) ~= getTeam(plr) and v.Character and v.Character:FindFirstChild'Humanoid' and v.Character.Humanoid.Health > 0 and v.Character.PrimaryPart and not global.InSafeZone(getTeam(v), v.Character.PrimaryPart.Position) then
            local vector, onScreen = workspace.CurrentCamera.WorldToViewportPoint(workspace.CurrentCamera, v.Character.HumanoidRootPart.Position)
            local mag = (Vector2.new(vector.X, vector.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
            if mag < maxdist and onScreen then
                maxdist = mag;
                target = v;
            end
        end
    end
    return target;
end
local old;
local p = nil;
old = hookfunction(require(game.ReplicatedStorage.Libraries.Gameplay).CastMouseRay, function(...)
    p = closeToMouse();
    return p and p.Character and p.Character.PrimaryPart or old(...)
end)
local old2;
old2 = hookfunction(require(game.ReplicatedStorage.Libraries.Gameplay).GetDir, function(...)

    local a = p and p.Character and p.Character.PrimaryPart.Position + Vector3.new(0, 0, 0);
    local rt = {old2(...)}
    rt[1] = a or rt[1];
    return table.unpack(rt)
end)
