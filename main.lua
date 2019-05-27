-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local GRID_COLS = 15
local GRID_ROWS = 10

local TILE_WIDTH  = display.contentWidth / GRID_COLS
local TILE_HEIGHT = display.contentHeight / GRID_ROWS

local UP = 0
local RIGHT = 1
local DOWN = 2
local LEFT = 3

local SNAKE_START_X = 8
local SNAKE_START_Y = 5

local FRAMES_PER_TICK = display.fps / 2;

local cH = display.contentHeight
local cW = display.contentWidth

local function SnakeBody(startX, startY, direction)

  local self = {
    x = startX or SNAKE_START_X,
    y = startY or SNAKE_START_Y,
    direction = direction or RIGHT
  }

  local graphic = display.newRect(self.x * TILE_WIDTH, self.y * TILE_HEIGHT,
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

    self.setCoords();

  end

  function self.setCoords()
    graphic.x = self.x * TILE_WIDTH
    graphic.y = self.y * TILE_HEIGHT
  end



  return self
end


local head = SnakeBody();

local function gameLoop()
  head.move();
end


local frameCounter = 0;
local function execute()
  frameCounter = frameCounter + 1;
  if(frameCounter % FRAMES_PER_TICK == 0) then
    gameLoop();
  end
end


Runtime:addEventListener( 'enterFrame', execute )
