// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function updateGridCenters(){
	for (var row = 0; row < gridRows; row++) {
	    for (var col = 0; col < gridCols; col++) {
        
	        // Calculate center position of this cell
	        var centerX = gridOffsetX + (col * cellWidth) + (cellWidth / 2);
	        var centerY = gridOffsetY + (row * cellHeight) + (cellHeight / 2);
        
	        // Store in 1D array (index = row * cols + col)
	        gridCenters[row * gridCols + col] = [centerX, centerY];
	    }
	}
}