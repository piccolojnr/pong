---@diagnostic disable: lowercase-global
push = require "push"

Class = require 'class'

-- paddle which stores position and dimension for each paddle
-- and the logic for rendering them
require "Paddle"

-- our ball class
require "Ball"


WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move outr paddle
PADDLE_SPEED = 200


-- USED TO  INITIALIZE GAME
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    -- to prevent blurring of text
    love.graphics.setDefaultFilter('nearest', 'nearest')


    -- seed so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set love2ds active font to the smallFont
    love.graphics.setFont(smallFont)

    -- initialize our virtual resolution, which will be rendered within
    -- our actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })



    -- paddle positions on the y axis (they can only move in on dimension that is up and down)
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- velocity and position variables for our ball when play starts
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- variable used to transition between different parts of the game
    gameState = 'start'
end

-- UPDATE GAME
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- update our ball based on its DX and DY only if we're in play state;
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)

end

-- KEYBOARD HANDLING
function love.keypressed(key)
    if key == 'escape' then
        -- function to terminate application
        love.event.quit()
        -- if we press enter during the start state of the game, we'll go into play mode
        -- during play mode, the ball will move in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end

--  USED TO DRAW ANYTHING TO THE SCREEN
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')


    -- clear the screen with a specific color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)



    -- draw different things based on the state of the game
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- render first paddles
    player1:render()
    player2:render()

    -- render ball(center)
    ball:render()

    -- end rendering at virtual resolution
    push:apply('end')
end
