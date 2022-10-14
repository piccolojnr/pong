Ball = Class {}


function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height



    -- keep track of our velocity
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

-- PLACES THE BALL IN THE MIDDLE OF THE SCREEN, WITH AN INITIAL
--  RANDOM VELOCITY ON BOTH AXES
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

-- SIMPLY APPLYS VELOCITY TO position, SCALED BY DELTER TIME
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
