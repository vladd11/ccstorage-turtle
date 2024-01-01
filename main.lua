local chest = peripheral.wrap("front")
local showMatrix = require("showMatrix")

if not fs.exists(".storagetoken") then
    local data = http.get("https://d5d6dqgog1u13p78egr4.apigw.yandexcloud.net/register")
    data = textutils.unserialiseJSON(data.readAll())
    showMatrix(data['matrix'])
    term.setBackgroundColor(colors.black)
    while true do
        local event, key, hold = os.pullEvent("key")
        if keys.getName(key) == 'enter' then
            break
        end
    end

    local file = fs.open(".storagetoken", "w")
    file.write(textutils.serialiseJSON({
        id = data.id,
        token = data.token
    }))
    file.close()
end

local file = fs.open(".storagetoken", "r")
local data = textutils.unserialiseJSON(file.readAll())
file.close()

local connection = assert(http.websocket("wss://d5d6dqgog1u13p78egr4.apigw.yandexcloud.net/ws?method=robotLogin", {
    Authorization = "Bearer " .. data.token
}))

term.clear()
term.setCursorPos(1, 1)
print("Control robot from another device")
while true do
    local event, key, hold = os.pullEvent("key")
    if keys.getName(key) == 'enter' then
        break
    end
end

connection.close()
