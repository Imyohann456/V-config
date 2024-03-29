local identity = (getidentity or syn and syn.getidentity or function() return 2 end)
local setidentity = (setthreadcaps or syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end)

local function isfile(file)
    local success, filecontents = pcall(readfile, file)
    return success and type(filecontents) == 'string'
end

local function MainScript()
    local scriptURL = 'https://raw.githubusercontent.com/Imyohann456/V-config/main/menu/MainScript.lua'
    local success, mainscript = pcall(game.HttpGet, game, scriptURL)
    if success and mainscript then
        local scriptFunction, errorMessage = loadstring(mainscript)
        if scriptFunction then
            scriptFunction()
            writefile('vape/MainScript.lua', mainscript)
        else
            warn("Failed to load main script:", errorMessage)
        end
    else
        warn("Failed to fetch main script from URL:", scriptURL)
    end
end

if shared.VapeExecuted then
    -- Hook into __namecall metamethod for httpService calls
    local oldcall = hookmetamethod(game, '__namecall', function(self, ...)
        local oldidentity = identity()
        setidentity(8)
        local res = oldcall(self, ...)
        setidentity(oldidentity)
        return res
    end)
end

if isfile('vape/MainScript.lua') then
    loadfile('vape/MainScript.lua')()
else
    task.spawn(MainScript)
end
