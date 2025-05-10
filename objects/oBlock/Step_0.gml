// Mouse interaction
handleMouseInput();

// Visual feedback
if (isDragging) {
    image_alpha = 0.7; // Semi-transparent while dragging
} else {
    image_alpha = 1.0; // Fully opaque when placed
}

// Keep snapped if placed
if (isPlaced && gridCell != -1 && instance_exists(gridRef)) {
    var cellCenter = gridRef.gridCenters[gridCell];
    x = cellCenter[0];
    y = cellCenter[1];
}