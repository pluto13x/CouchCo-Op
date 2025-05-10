gridRows = 3;       // Number of rows
gridCols = 4;       // Number of columns
cellWidth = 128;     // Width of each cell
cellHeight = 128;    // Height of each cell
gridOffsetX = oSofa.x  - cellWidth * gridCols / 2;    // Optional: X offset for entire grid
gridOffsetY = oSofa.y - cellHeight * gridRows / 2;    // Optional: Y offset for entire grid

// Initialize grid centers array
gridCenters = array_create(gridRows * gridCols);
gridOccupied = array_create(gridRows * gridCols);
for (var i = 0; i < array_length(gridOccupied); i++) {
	gridOccupied[i] = false;
}
updateGridCenters(); // Calculate centers immediately

/*
accessuj centere
[0] je x, [1] je y
show_debug_message("x: " + string(gridCenters[5][0]));
show_debug_message("x: " + string(gridCenters[1][0]));*/ 