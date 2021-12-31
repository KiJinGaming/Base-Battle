local req = syn and syn.request or http_request or http and http.request
local cus_asset = getsynasset or getcustomasset
if (cus_asset) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Loading Asset",
        Text = "We are loading a present for you..."
    })
    task.wait(5)
    writefile("HNY.mp3",req({Url = "https://cdn.discordapp.com/attachments/920289867475329027/926471803948367892/HappyNewYear-ABBA-1595921.mp3"}).Body)
    local data = cus_asset("HNY.mp3")
    local Sound = Instance.new("Sound")
    Sound.SoundId = data
    Sound.Parent = game.SoundService
    Sound.Looped = true
    Sound.Volume = 2
    Sound:Play()
    task.wait(10)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Music",
        Text = "You are listening to Happy New Year - ABBA"
    })
end
