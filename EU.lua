local EasyUtils = {}
EasyUtils.Drawings = {}

function EasyUtils.dumpgc(self, path: string, filtertbl: table)
    assert(path, 'missing_arg = path')

    local filters = filtertbl or {}
    for index, garbage in next, getgc() do
        if not table.find(filters, tostring(typeof(garbage))) then
            if typeof(garbage) == "Instance" then
                if not table.find(filters, tostring(garbage.ClassName)) then
                    appendfile(tostring(path), '[IDX] = '..tostring(index)..' | [Item]: '..tostring(garbage)..' ~ [CType]: \''..typeof(garbage)..' = [RType]: \''..garbage.ClassName..'\'\n')
                end
            elseif typeof(garbage) == "function" then
                appendfile(tostring(path), '[IDX] = '..tostring(index)..' | [Item]: '..tostring(garbage)..' ~ [Name]: '..tostring(debug.getinfo(garbage).name)..' ~ [CType]: \''..typeof(garbage)..'\'\n')
            else
                appendfile(tostring(path), '[IDX] = '..tostring(index)..' | [Item]: '..tostring(garbage)..' ~ [CType]: \''..typeof(garbage)..'\'\n')
            end
        end
    end
end





-- Drawing funcs
function EasyUtils.newdraw(self, type: string, props: table, where: table)
    assert(type, 'missing_arg: type')
    assert(props, 'missing_arg: props')
    local proptbl = props
    local whereidx = where or EasyUtils.Drawings

    local draw = Drawing.new(type)
    for prop, val in pairs(proptbl) do
        draw[prop] = val
    end

    table.insert(whereidx, draw)
    return draw
end

function EasyUtils.editdraw(self, drawing, props: table)
    assert(drawing, 'missing_arg: drawing')
    assert(props, 'missing_arg: props')
    local proptbl = props

    for prop, val in pairs(proptbl) do
        drawing[prop] = val
    end
    return drawing
end

return EasyUtils
