// Mouse interaction
if !isPlaced {
	handleMouseInput();
}

// Visual feedback
if (isDragging) {
    image_alpha = 0.7; // Semi-transparent while dragging
} else {
    image_alpha = 1.0; // Fully opaque when placed
}

// Keep snapped if placed
if (isPlaced && gridCell != -1 && instance_exists(gridRef)) {
	placedForever = true;
    var cellCenter = gridRef.gridCenters[gridCell];
	foreverCell = gridRef.gridCenters[gridCell];
	iIndividualGrids.build[iViewportControl.player][foreverCell] = object_index.blockIdx;
	placedX = cellCenter[0];
    placedY = cellCenter[1];
    x = cellCenter[0];
    y = cellCenter[1];
}
if placedForever {
	isPlaced = true;
	x = placedX;
	y = placedY;
}





