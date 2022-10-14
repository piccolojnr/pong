---@diagnostic disable: lowercase-global
push = require "push"


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

    -- initializing score variables used for rensering on the screen and keeping
    -- track of the winner
    player1Score = 0
    player2Score = 0

    -- paddle positions on the y axis (they can only move in on dimension that is up and down)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    -- velocity and position variables for our ball when play starts
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)


    -- variable used to transition between different parts of the game
    gameState = 'start'
end

-- UPDATE GAME
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    -- update our ball based on its DX and DY only if we're in play state;
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end


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

            -- start ball's position in the middle of the screen
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            -- given ball's x and y velocity a random starting value
            -- the and/or pattern here is Lua's way of accomplishing a ternary operation
            -- in other programming languages like C
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
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


    -- draw score ont the left and right center of the screen
    -- need to switdh font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    love.graphics.setFont(smallFont)

    -- render first paddle(left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- render first paddle(right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- render ball(center)
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)


    -- end rendering at virtual resolution
    push:apply('end')
end
