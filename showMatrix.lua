x = 2
y = 1

function show(string)
    local m = term
    m.setBackgroundColor(colors.white)
    m.clear()
    m.setCursorPos(x, y)

    rw = 36
    local curr = 1
    for i=1,14 do
        for j = 0, 31 do
            if bit32.btest(bit32.rshift(string[i], j), 1) then
                m.blit(' ', 'f', 'f')
            else
                m.blit(' ', '0', '0')
            end
            if curr % rw == 0 then
                y = y + 1
                m.setCursorPos(x, y)
                if y == 13 then
                    m.setCursorPos(0, 0)
                    return
                end
            end
            curr = curr + 1
        end
    end
end
return show