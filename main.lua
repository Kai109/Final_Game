-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
cX = display.contentCenterX
cY = display.contentCenterY
math.randomseed( os.time() )
currentDirection = 'left'
i = 0
appleCount = 0

local button = display.newRect( 0, 0, 0, 0 )
button.height = cY * 2; button.width = (cX * 2) + 100
button.x = -50; button.y = 0
button.anchorX = 0; button.anchorY = 0
button.isVisible = false
button.isHitTestable = true

local border = display.newLine( -16, 16, -16, 304, 496, 304, 496, 16, -16, 16 )
local score = display.newText( appleCount, -30, 15, nil, 25 )

local gOverText = display.newText( 'Game Over', cX, cY - 70, nil, 60 )
gOverText.isVisible = false
local scoreText = display.newText( 'Score: '..appleCount, cX, cY - 20, nil, 40)
scoreText.isVisible = false
local playAgain = display.newImageRect( 'playAgain.png', 90, 90)
playAgain.x = cX; playAgain.y = cY + 70
playAgain:setFillColor( 255, 255, 255 )
playAgain.isVisible = false
playAgain.isHitTestable = false


local function hasCollided( obj1, obj2 )
   if ( obj1 == nil ) then  --make sure the first object exists
      return false
   end
   if ( obj2 == nil ) then  --make sure the other object exists
      return false
   end
 
   local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
   local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
   local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
   local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
 
   return (left or right) and (up or down)
   
end

local apple = display.newCircle( math.random( 0, 15 ) * 32, math.random( 1, 9 ) * 32, 14 )
local snake = display.newRect( 352, 224, 32, 32 )

local function changeDirection( event )
	if event.phase == 'moved' then
		dX = event.x - event.xStart; dY = event.y - event.yStart
		if dY < 0 and math.abs(dY) > math.abs(dX) then
			-- upward swipe
			if currentDirection ~= 'down' then
				currentDirection = 'up'
			end
		elseif dY > 0 and math.abs(dY) > math.abs(dX) then
			-- downward swipe
			if currentDirection ~= 'up' then	
				currentDirection = 'down'
			end
		elseif dX < 0 and math.abs(dX) > math.abs(dY) then
			-- left swipe
			if currentDirection ~= 'right' then
				currentDirection = 'left'
			end
		elseif dX > 0 and math.abs(dX) > math.abs(dY) then
			-- right swipe
			if currentDirection ~= 'left' then
				currentDirection = 'right'
			end
		end
	end
end

local function toggleFlag()
	if playAgain.isHitTestable == false then
		playAgain.isHitTestable = true
	else
		playAgain.isHitTestable = false
	end
end

local function reset( event )
	playAgain.isHitTestable = false
	math.randomseed( os.time() )
	gOverText.isVisible = false
	scoreText.isVisible = false
	playAgain.isVisible = false
	border.isVisible = true
	apple.isVisible = true
	appleCount = 0
	score.text = appleCount
	score.isVisible = true
	snake.isVisible = true
	snake.x = 352; snake.y = 224
	currentDirection = 'left'
end

local function gameLoop( event )
	if hasCollided( apple, snake ) then
		transition.to( apple, {time=0, x=math.random( 0, 15 ) * 32, y=math.random( 1, 9 ) * 32} )
		appleCount = appleCount + 1
		score.text = appleCount
	end
	if i % 8 == 0 then
		if currentDirection == 'left' then
			snake.x = snake.x - 32
		elseif currentDirection == 'right' then
			snake.x = snake.x + 32
		elseif currentDirection == 'down' then
			snake.y = snake.y + 32
		elseif currentDirection == 'up' then
			snake.y = snake.y - 32
		end
	end
	i = i + 1
	
	if snake.x < 0 or snake.x > 480 or snake.y < 32 or snake.y > 288 then
		gOverText.isVisible = true
		scoreText.isVisible = true
		scoreText.text = 'Score: '..appleCount
		playAgain.isVisible = true
		border.isVisible = false
		apple.isVisible = false
		score.isVisible = false
		snake.isVisible = false
		toggleFlag()
	end
	
end

playAgain:addEventListener( 'touch', reset )
button:addEventListener( 'touch', changeDirection )
Runtime:addEventListener( 'enterFrame', gameLoop )