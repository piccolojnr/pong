push = require "push"


WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


-- USED TO  INITIALIZE GAME
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    -- to prevent blurring of text
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- initialize our virtual resolution, which will be rendered within
    -- our actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

-- KEYBOARD HANDLING
function love.keypressed(key)
    if key == 'escape' then
        -- function to terminate application
        love.event.quit()
    end
end

--  USED TO DRAW ANYTHING TO THE SCREEN
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')


    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    -- end rendering at virtual resolution
    push:apply('end')


end
