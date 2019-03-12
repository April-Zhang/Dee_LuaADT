---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dee.
--- DateTime: 2019/3/7 14:00
--- 快速遍历修改,低效的增删
---

vector = vector or {}

function vector.create()
    local data = {}

    ---获取长度(已经重载了#运算符,但是ulua是5.1确实__len)
    local len = function()
        return #data
    end

    ---尾添加元素(高效)
    local add = function(v)
        assert(v)
        table.insert(data, v)
    end

    ---插入(低效)
    local insert = function(idx, v)
        assert(idx > 0 and idx <= #data, "outrange of vector")
        table.insert(data, idx, v)
    end

    ---尾添加数组(高效)
    local addRange = function(t)
        assert(type(t) == "table")

        table.move(t,1, #t, #data+1, data )
    end

    ---是否存在某元素
    local contains = function (v)
        local ret = false
        for i, v in ipairs(data) do
            if v == i_v then
                ret = true
                break
            end
        end

        return ret
    end

    ---值的索引
    local indexOf = function(i_v)
        local ret = -1
        for i, v in ipairs(data) do
            if v == i_v then
                ret = i
                break
            end
        end

        return ret
    end

    ---根据下标索引移除元素(低效)
    local removeAt = function(idx)
        assert(idx <= #data)
        table.remove(data, idx)
    end

    ---删除值(非贪婪)
    local remove = function(v)
        local ret = indexOf(v)
        if ret ~= -1 then
            removeAt(ret)
        end

        return ret
    end

    ---删除所有值
    local removeAll = function(v)

    end

    ---排序
    local sort = function(comparer)
        table.sort(data, comparer)
    end

    ---匹配
    ---@param 匹配函数
    ---@return idx,value
    local find = function(matcher)
        local _idx, _value = -1, nil
        local cnt = len()
        for i = 1, cnt do
            if matcher(i, data[i]) then
                _value = data[i]
                _idx = i
                break
            end
        end

        return _idx, _value
    end

    local t = {
        len = len,
        add = add,
        insert = insert,
        addRange = addRange,
        removeAt = removeAt,
        remove = remove,
        removeAll = removeAll,
        contains = contains,
        indexOf = indexOf,
        sort = sort,
        find = find
    }

    local mt = {
        __index = function(t,k)
            return data[k]
        end,
        __newindex = function(t,k,v)
            assert(k > 0 and k <= #data, "outrange of vector")
            data[k] = v
        end,
        __tostring = function()
            return table.concat(data, ',')
        end,
        __len = function(v)
            return #data
        end,
        __pairs = function(...)
            error(">> Dee: Limited access")
        end
    }

    setmetatable(t, mt)

    return t
end

return vector