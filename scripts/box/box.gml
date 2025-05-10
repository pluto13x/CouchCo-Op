/// @function handleMouseInput()
/// @description Handles all mouse interactions for the block

// Check mouse press
function handleMouseInput()
{
	if (mouse_check_button_pressed(mb_left)) {
	    if (position_meeting(mouse_x, mouse_y, id)) {
	        isDragging = true;
	        isPlaced = false;
	        gridCell = -1; // Detach from grid
	        depth = -100; // Bring to front while dragging
	    }
	}

	// Handle mouse release
	if (mouse_check_button_released(mb_left) && isDragging) {
	    isDragging = false;
	    depth = 0; // Reset depth
    
	    if (instance_exists(oGrid)) {
	        snapToNearestGridCell();
	    }
	}

	// Follow mouse while dragging
	if (isDragging) {
	    x = mouse_x;
	    y = mouse_y;
	}
}

function snapToNearestGridCell() {
    // Safety check - ensure grid exists
    if (!instance_exists(oGrid)) {
        show_debug_message("Error: oGrid doesn't exist!");
        return;
    }
    
    var closestDist = infinity;
    var closestCell = -1;
    var grid = oGrid; // Local reference

    // Find nearest available cell
    for (var i = 0; i < array_length(grid.gridCenters); i++) {
        // Skip occupied cells if system exists
        if (grid.gridOccupied[i] != true) {
            var cellPos = grid.gridCenters[i];
	        var dist = point_distance(x, y, cellPos[0], cellPos[1]);
        
	        if (dist < closestDist) {
	            closestDist = dist;
	            closestCell = i;
	        }
        }    
    }

    // Snap to cell if found
    if (closestCell != -1) {
        var targetPos = grid.gridCenters[closestCell];
        x = targetPos[0]; // Move THIS instance, not oBlock
        y = targetPos[1];
        isPlaced = true;
        gridCell = closestCell;
    
	
        grid.gridOccupied[closestCell] = true;
           
        // Debug output
        show_debug_message("Snapped to cell "+string(closestCell)+
                         " at "+string(x)+","+string(y));
    } else {
        show_debug_message("No available cell found!");
    }
}
