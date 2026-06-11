dofile('rive_build_config.lua')

local dependency = require('dependency')
sokol = dependency.github('luigi-rosso/sokol', 'cfedffa4e79383512c8da23608260c20545bba8f')
libtess2 = dependency.github('memononen/libtess2', '9a450cc9e5b4b79c36b89648f8b92fe65b6dd407')
earcut = dependency.github('mapbox/earcut.hpp', 'f36ced7e50254738c4e5af1a239f5fb7b1094007')

rive = '../'

dofile(path.join(path.getabsolute(rive), 'premake5_v2.lua'))

project('rive_tess_renderer')
do
    kind('StaticLib')
    includedirs({
        'include',
        rive .. '/include',
        sokol,
        earcut .. '/include/mapbox',
        libtess2 .. '/Include',
    })
    files({ 'src/**.cpp', libtess2 .. '/Source/**.c' })
    buildoptions({ '-Wall', '-fno-exceptions', '-fno-rtti', '-Werror=format' })

    filter({ 'system:emscripten' })
    do
        defines({ 'SOKOL_GLCORE33' })
    end

    filter({ 'system:macosx' })
    do
        defines({ 'SOKOL_METAL' })
    end

    filter({ 'system:windows' })
    do
        defines({ 'SOKOL_D3D11' })
    end
end

project('rive_tess_tests')
do
    dependson('rive_tess_renderer')
    dependson('rive')
    kind('ConsoleApp')
    includedirs({
        rive .. 'tests/include', -- for catch.hpp and for things rive_file_reader.hpp
        'include',
        rive .. '/include',
        sokol,
        earcut .. '/include/mapbox',
        libtess2 .. '/Include',
    })
    files({ 'test/**.cpp', rive .. 'utils/no_op_factory.cpp' })
    links({ 'rive_tess_renderer', 'rive', 'rive_harfbuzz', 'rive_sheenbidi', 'rive_yoga' })
    -- defines({ 'TESTING', 'YOGA_EXPORT=' })

    filter({ 'system:macosx' })
    do
        links({
            'Cocoa.framework',
            'IOKit.framework',
            'CoreVideo.framework',
            'OpenGL.framework',
        })
    end
end
