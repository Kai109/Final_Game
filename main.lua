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

local score = display.newText( appleCount, -20, 25, nil, 25 )

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

local apple = display.newCircle( math.random( 0, 15 ) * 32, math.random( 0, 10 ) * 32, 14 )
local snake = display.newRect( math.random( 0, 15 ) * 32, math.random( 0, 10 ) * 32, 32, 32 )

local function changeDirection( event )
	if event.phase == 'moved' then
		dX = event.x - event.xStart; dY = event.y - event.yStart
		if dY < 0 and math.abs(dY) > math.abs(dX) then
			-- upward swipe
			currentDirection = 'up'
		elseif dY > 0 and math.abs(dY) > math.abs(dX) then
			-- downward swipe
			currentDirection = 'down'
		elseif dX < 0 and math.abs(dX) > math.abs(dY) then
			-- left swipe
			currentDirection = 'left'
		elseif dX > 0 and math.abs(dX) > math.abs(dY) then
			-- right swipe
			currentDirection = 'right'
		end
	end
end

local function gameLoop( event )
	if hasCollided( apple, snake ) then
		transition.to( apple, {time=0, x=math.random( 0, 15 ) * 32, y=math.random( 0, 10 ) * 32} )
		appleCount = appleCount + 1
		score.text = appleCount
	end
	sX = snake.x; sY = snake.y
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
	if snake.x < 0 then
		snake.x = 0
	end
	if snake.x > 480 then
		snake.x = 480
	end
	if snake.y < 0 then
		snake.y = 0
	end
	if snake.y > 320 then
		snake.y = 320
	end
end

button:addEventListener( 'touch', changeDirection )
Runtime:addEventListener( 'enterFrame', gameLoop )