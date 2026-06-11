dofile('rive_build_config.lua')
local dependency = require('dependency')
miniaudio = dependency.github('rive-app/miniaudio', '3a8b070f80e203a35ec763c5118da20805a90d5a')

project('miniaudio')
do
    kind('StaticLib')
    includedirs({ miniaudio })

    filter('system:ios')
    do
        files({ 'miniaudio.m' })
    end

    filter('system:macosx', 'options:variant=maccatalyst')
    do
        files({ 'miniaudio.m' })
        compileas "Objective-C++"
    end
    
    filter('system:not ios')
    do
        files({ miniaudio .. '/miniaudio.c' })
    end
end
