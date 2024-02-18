local EasyUtils = {}

EasyUtils.Functions = {} do
    function EasyUtil.Functions:dumpgc(path: string, filtertbl: table)
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
end

return EasyUtil;
