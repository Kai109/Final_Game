-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
cX = display.contentCenterX
cY = display.contentCenterY
math.randomseed( os.time() )

local button = display.newRect( 0, 0, 0, 0 )
button.height = cY * 2; button.width = (cX * 2) + 100
button.x = -50; button.y = 0
button.anchorX = 0; button.anchorY = 0
button.isVisible = false
button.isHitTestable = true

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

local apple = display.newCircle( cX, cY, 16 )
local snake = display.newRect( cX + 100, cY + 50, 32, 32 )

local function changeDirection( event )
	if event.phase == 'moved' then
		dX = event.x - event.xStart; dY = event.y - event.yStart
		if dY < 0 and math.abs(dY) > math.abs(dX) then
			-- upward swipe
			transition.to( snake, {time=500, y=snake.y - 32})
		elseif dY > 0 and math.abs(dY) > math.abs(dX) then
			-- downward swipe
			transition.to( snake, {time=500, y=snake.y + 32})
		elseif dX < 0 and math.abs(dX) > math.abs(dY) then
			-- left swipe
			transition.to( snake, {time=500, x=snake.x - 32})
		elseif dX > 0 and math.abs(dX) > math.abs(dY) then
			-- right swipe
			transition.to( snake, {time=500, x=snake.x + 32})
		end
	end
end

local function gameLoop( event )
	if hasCollided( apple, snake ) then
		apple.x = math.random( 15 ) * 32
		apple.y = math.random( 10 ) * 32
		print('e')
	end
end

button:addEventListener( 'touch', changeDirection )
Runtime:addEventListener( 'enterFrame', gameLoop )