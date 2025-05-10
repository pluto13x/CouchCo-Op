// Block properties
isDragging = false;
isPlaced = false;
gridRef = instance_find(oGrid, 0); // Reference to grid
gridCell = -1; // Tracks which cell we're in (-1 = not placed)

// Sprite alignment
spriteHalfWidth = sprite_width / 2;
spriteHalfHeight = sprite_height / 2;
image_speed = 0; // Freeze animation by default

cellX = 0;
cellY = 0;

blockRows = 1;
blockCols = 1;