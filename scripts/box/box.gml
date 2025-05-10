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
	var finalCell = -1;
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
	finalCell = closestCell;

    // Snap to cell if found
    if (closestCell != -1) {
		if (closestCell + grid.gridCols < array_length(grid.gridOccupied)) { //ako nije u poslednjem redu
			show_debug_message("nije u poslednjem redu");
			var rowsUnderneath = (array_length(grid.gridOccupied)-1 - closestCell) div grid.gridCols;
			show_debug_message("ispod ima " + string(rowsUnderneath) + " redova");
			var found = false;
			for (var i = 1; i <= rowsUnderneath; i++) {
				if (grid.gridOccupied[closestCell + grid.gridCols] == true) {
					finalCell += grid.gridCols * i;
					found = true;
					break;
				}
			}
			if (found == false) {
				finalCell += grid.gridCols * rowsUnderneath;
			}
		}
		
        var targetPos = grid.gridCenters[finalCell];
        x = targetPos[0]; // Move THIS instance, not oBlock
        y = targetPos[1];
        isPlaced = true;
        gridCell = finalCell;
    
	
        grid.gridOccupied[finalCell] = true;
           
        // Debug output
        show_debug_message("Snapped to cell "+string(finalCell)+
                         " at "+string(x)+","+string(y));
    } else {
        show_debug_message("No available cell found!");
    }
}
