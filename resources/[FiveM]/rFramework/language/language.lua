Locales = {}

function _(str, ...)
    if Locales[framework._language] ~= nil then
        if Locales[framework._language][str] ~= nil then
            return string.format(Locales[framework._language][str], ...)
        else
            return 'Translation [' .. framework._language .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. framework._language .. '] does not exist'
    end
end

function _L(str, ...)
    return tostring(_(str, ...):gsub("^%l", string.upper))
end