WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280


-- USED TO  INITIALIZE GAME
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

--  USED TO DRAW ANYTHING TO THE SCREEN
function love.draw()
    love.graphics.printf('Hello Pong!', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
end
