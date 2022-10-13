local push = require "push"


WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


-- USED TO  INITIALIZE GAME
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    -- to prevent blurring of text
    love.graphics.setDefaultFilter('nearest', 'nearest')

    local smallFont = love.graphics.newFont('font.ttf', 8)

    -- set love2ds active font to the smallFont
    love.graphics.setFont(smallFont)

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


    -- clear the screen with a specific color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- draw welcome text towards the top of the screen
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')


    --
    -- paddles are simply rectangles we draw on the screen at certain points,
    -- as is the ball
    --

    -- render first paddle(left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- render first paddle(right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball(center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)




    -- end rendering at virtual resolution
    push:apply('end')
end
