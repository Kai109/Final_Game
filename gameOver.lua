local composer = require( "composer" )
 
local gameOver = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function gameOver:create( event )
 
    local sceneGroup = self.view
    
	local gOverText = display.newText( 'Game Over', display.contentCenterX, display.contentCenterY - 100, nil, 50 )
	sceneGroup:insert( gOverText )
	local scoreText = display.newText( 'Score: ', display.contentCenterX, display.contentCenterY, nil, 30)
	sceneGroup:insert( scoreText )
 
end
 
 
-- show()
function gameOver:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function gameOver:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function gameOver:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
gameOver:addEventListener( "create", scene )
gameOver:addEventListener( "show", scene )
gameOver:addEventListener( "hide", scene )
gameOver:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene