// Block properties
isDragging = false;
isPlaced = false;
gridRef = instance_find(oGrid, 0); // Reference to grid
gridCell = -1; // Tracks which cell we're in (-1 = not placed)
whoPicked = -1;
placedForever = false;
foreverCell = undefined;
blockName = string_delete(object_get_name(object_index), 1, 1);
blockIdx = -1;
blockListDone = false;

if iBlockControl.blockListDone == false {
	blockIdx = ds_list_size(iBlockControl.blockList);
	ds_list_add(iBlockControl.blockList, blockName);
	//show_debug_message("added" + string(blockIdx));
}

// Sprite alignment
//spriteHalfWidth = sprite_width / 2;
//spriteHalfHeight = sprite_height / 2;
image_speed = 0; // Freeze animation by default

cellX = 0;
cellY = 0;

blockRows = 1;
blockCols = 1;

placedX = x;
placedY = y;