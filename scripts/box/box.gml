/// @function handleMouseInput()
/// @description Handles all mouse interactions for the block

// Check mouse press
function handleMouseInput()
{
    if (mouse_check_button_pressed(mb_left)) {
        if (position_meeting(mouse_x, mouse_y, id)) {
            isDragging = true;
            isPlaced = false;
            // Clear previous occupied cells when starting to drag
            if (gridCell != -1 && instance_exists(oGrid)) {
                clearOccupiedCells();
            }
            gridCell = -1; // Detach from grid
            depth = -100; // Bring to front while dragging
        }
    }

    // Handle mouse release
    if (mouse_check_button_released(mb_left) && isDragging) {
        isDragging = false;
        depth = 0; // Reset depth
    
        if (instance_exists(oGrid))  {
            snapToNearestGridCell();
        }
    }

    // Follow mouse while dragging
    if (isDragging) {
        x = mouse_x;
        y = mouse_y;
    }
}

/// @function clearOccupiedCells()
/// @description Clears the grid cells this block was occupying
function clearOccupiedCells() {
    var grid = oGrid;
    var startCol = gridCell mod grid.gridCols;
    var startRow = gridCell div grid.gridCols;
    
    for (var r = 0; r < blockRows; r++) {
        for (var c = 0; c < blockCols; c++) {
            var cellIndex = (startRow + r) * grid.gridCols + (startCol + c);
            if (cellIndex < array_length(grid.gridOccupied)) {
                grid.gridOccupied[cellIndex] = false;
            }
        }
    }
}

/// @function snapToNearestGridCell()
/// @description Snaps the block to the nearest available grid space that can accommodate its size with gravity
function snapToNearestGridCell() {
    // Safety check - ensure grid exists
    if (!instance_exists(oGrid)) {
        show_debug_message("Error: oGrid doesn't exist!");
        return;
    }
    
    var grid = oGrid;
    var closestDist = infinity;
    var closestCell = -1;
    var finalCell = -1;
    
    // Check if block fits in grid dimensions
    if (blockCols > grid.gridCols || blockRows > grid.gridRows) {
        show_debug_message("Block is larger than grid!");
        return;
    }

    // Find nearest available top-left cell in X axis
    for (var i = 0; i < array_length(grid.gridCenters); i++) {
        var cellCol = i mod grid.gridCols;
        var cellRow = i div grid.gridCols;
        
        // Check if block would fit starting at this column
        if (cellCol + blockCols <= grid.gridCols) {
            var dist = point_distance(x, y, grid.gridCenters[i][0], grid.gridCenters[i][1]);
            
            if (dist < closestDist) {
                closestDist = dist;
                closestCell = i;
            }
        }
    }

    // If we found a column that fits horizontally
    if (closestCell != -1) {
        var startCol = closestCell mod grid.gridCols;
        var startRow = closestCell div grid.gridCols;
        
        // Apply gravity - find lowest available row for this column group
        var lowestValidRow = startRow;
        var foundObstacle = false;
        
        // Check how far down we can go
        while (lowestValidRow + blockRows <= grid.gridRows) {
            // Check if all required cells are free in this row
            var allFree = true;
            for (var r = 0; r < blockRows; r++) {
                for (var c = 0; c < blockCols; c++) {
                    var checkIndex = (lowestValidRow + r) * grid.gridCols + (startCol + c);
                    if (checkIndex >= array_length(grid.gridOccupied) || grid.gridOccupied[checkIndex]) {
                        allFree = false;
                        break;
                    }
                }
                if (!allFree) break;
            }
            
            if (!allFree) {
                foundObstacle = true;
                break;
            }
            
            lowestValidRow++;
        }
        
        // Adjust for the last successful position
        if (foundObstacle) {
            lowestValidRow--;
        } else {
            lowestValidRow = grid.gridRows - blockRows;
        }
        
        // Ensure we don't go above the grid
        lowestValidRow = max(lowestValidRow, 0);
        
        finalCell = lowestValidRow * grid.gridCols + startCol;
        
        // Calculate center position for multi-cell block
        var firstCellPos = grid.gridCenters[finalCell];
        var lastCellIndex = (lowestValidRow + blockRows - 1) * grid.gridCols + (startCol + blockCols - 1);
        var lastCellPos = grid.gridCenters[lastCellIndex];
        
        x = (firstCellPos[0] + lastCellPos[0]) / 2; //ne radi ništa?
        y = (firstCellPos[1] + lastCellPos[1]) / 2;
	    whoPicked = iViewportControl.player;
        
        isPlaced = true;
		oNextPlayer.switchPlayers = true;
        gridCell = finalCell;
    
        // Mark all occupied cells
        for (var r = 0; r < blockRows; r++) {
            for (var c = 0; c < blockCols; c++) {
                var cellIndex = (lowestValidRow + r) * grid.gridCols + (startCol + c);
                grid.gridOccupied[cellIndex] = true;
            }
        }
           
        // Debug output
        show_debug_message("Snapped to cells starting at "+string(finalCell)+
                         " at "+string(x)+","+string(y)+
                         " (Size: "+string(blockCols)+"x"+string(blockRows)+")");
    } else {
        show_debug_message("No available space found for block size "+string(blockCols)+"x"+string(blockRows)+"!");
    }
}