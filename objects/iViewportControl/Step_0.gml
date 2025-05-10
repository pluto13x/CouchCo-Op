if start == true {
	sofa1id = oSofa.id;
	grid1id = oGrid.id;
	if player == 1 {
		x -= 50;
		if sofaPresent == false {
			instance_create_layer(480, 570, "layerSofa", oSofa);
			sofaPresent = true;
		}
	}
	else {
		x += 50;
		if sofaPresent == false {
			instance_create_layer(2400, 570, "layerSofa", oSofa);
			sofaPresent = true;
		}
	}
}

if x >= room_width or x <= 0 and start == true {
	start = false;
	if changed == false {
		instance_destroy(sofa1id);
		instance_destroy(grid1id);
		show_debug_message("uništio");
		if player == 1 {
			instance_create_layer(480, 570, "layerGrid", oGrid);
			show_debug_message("player 1");
		}
		else {
			instance_create_layer(2400, 570, "layerGrid", oGrid);
		}
		
		with oBlock {
			isDragging = false;
			isPlaced = false;
			gridRef = instance_find(oGrid, 0); // Reference to grid
			gridCell = -1;
		}
		changed = true;
	}
}