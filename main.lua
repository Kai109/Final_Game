-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local GRID_COLS = 15
local GRID_ROWS = 10

local UP = 0
local RIGHT = 1
local DOWN = 2
local LEFT = 3

local SNAKE_START_X = 8
local SNAKE_START_Y = 5

local TICK_TIME = 1000;

local cH = display.contentHeight
local cW = display.contentWidth

local function SnakeBody(startX, startY, direction)

  local self = {
    x = startX or SNAKE_START_X,
    y = startY or SNAKE_START_Y,
    direction = direction or RIGHT
  }

  local graphic = display.newRect(self.x * (cW / GRID_COLS), self.y * (cH / GRID_ROWS),
    cW / GRID_COLS, cH / GRID_ROWS);
  graphic:setFillColor(0, 1, 0);


  function self.move()
    if direction == UP then
      self.y = self.y - 1
    elseif direction == RIGHT then
      self.x = self.x - 1
    elseif direction == DOWN then
      self.y = self.y + 1
    else
      self.x = self.x + 1
    end

    setCoords();

  end

  function setCoords()
    graphic.x = self.x * (cW / GRID_COLS)
    graphic.y = self.y * (cH / GRID_ROWS)
  end

  

  return self
end



local head = SnakeBody(8, 6, UP)

local function execute(event)
  head.move()
  timer.performWithDelay(1000, execute);
end

execute();
