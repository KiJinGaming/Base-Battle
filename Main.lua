local url = string.format("https://raw.githubusercontent.com/KiJinGaming/Base-Battle/main/%s", _G.option)
local f = loadstring(game:HttpGet(url))
task.spawn(f)

loadstring(game:HttpGet("https://raw.githubusercontent.com/KiJinGaming/Base-Battle/main/More.lua"))
