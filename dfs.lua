vis = {}

x = 1
y = 1
z = 1

for i = 1, x do
    vis[i] = {}
    for j = 1, y do
        vis[i][j] = {}
        for k = 1, z do
            vis[i][j][k] = 0
        end
    end
end

o = { 1, 1, 1 }
dir = 0
function move(to)
    if o[1] > to[1] then
        return turtle.back()
    end

    if o[2] > to[2] then
        turtle.turnRight()
        if turtle.forward() then
            turtle.turnLeft()
            return true
        end
        turtle.turnLeft()
        return false
    end

    if o[3] > to[3] then
        return turtle.down()
    end

    if o[1] < to[1] then
        return turtle.forward()
    end

    if o[2] < to[2] then
        turtle.turnLeft()
        if turtle.forward() then
            turtle.turnRight()
            return true
        end
        turtle.turnRight()
        return false
    end

    if o[3] < to[3] then
        return turtle.up()
    end

    return true
end

local file = fs.open("out.txt", "w")

dirs = {
    { 1,  0,  0 },
    { 0,  1,  0 },
    { 0,  0,  1 },
    { -1, 0,  0 },
    { 0,  -1, 0 },
    { 0,  0,  -1 }
}

function dfs(v, p)
    if v[1] < 1 or v[1] > x or v[2] < 1 or v[2] > y or v[3] < 1 or v[3] > z then
        return
    end
    if vis[v[1]][v[2]][v[3]] == 1 then
        return
    end
    vis[v[1]][v[2]][v[3]] = 1;

    file.write(textutils.serializeJSON({ v[1], v[2], v[3] }))

    if not move(v) then
        file.write('F\n')
        return
    end
    o = v
    file.write('\n')

    for i = 1, #dirs do
        local dir = dirs[i]
        dfs({ dir[1] + v[1], dir[2] + v[2], dir[3] + v[3] }, v)
    end

    file.write(textutils.serializeJSON({ p[1], p[2], p[3] }))
    file.write('d\n')
    if move(p) then
        o = p
    end
end

dfs({ 1, 1, 1 }, { 1, 1, 1 })

file.close()
return dfs