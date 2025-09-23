local dependency = require('dependency')
local luau = dependency.github('luigi-rosso/luau', '1a2b9dc54a9544ad5d8d8ee351145ccdba3d5cfb')

dofile('rive_build_config.lua')

includedirs({
    './',
})
forceincludes({ 'rive_luau.hpp' })

project('luau_vm')
do
    kind('StaticLib')

    includedirs({
        luau .. '/VM/include',
        luau .. '/Common/include',
    })

    files({
        luau .. '/VM/src/**.cpp',
    })
    defines({ 'LUA_USE_LONGJMP', 'RIVE_LUAU' })
    optimize('Size')
    if TESTING == true then
        filter({ 'system:windows' })
        do
            buildoptions({ '/fp:precise' })
        end
    end

    filter({ 'options:with-asan' })
    do
        defines({ 'LUAU_ENABLE_ASAN' })
    end
end

project('luau_compiler')
do
    kind('StaticLib')
    exceptionhandling('On')

    includedirs({
        luau .. '/Compiler/include',
        luau .. '/Ast/include',
        luau .. '/Common/include',
    })

    files({ luau .. '/Compiler/src/**.cpp', luau .. '/Ast/src/**.cpp' })
    defines({ 'RIVE_LUAU' })
    optimize('Size')
    filter({ 'options:with-asan' })
    do
        defines({ 'LUAU_ENABLE_ASAN' })
    end
end

return { luau = luau }
