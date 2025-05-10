if start == true {
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
	sofa1id = oSofa.id;
	grid1id = oGrid.id;
}

if x >= room_width or x <= 0 {
	start = false;
	if changed == false {
		instance_destroy(sofa1id);
		instance_destroy(grid1id);
		instance_create_layer(2400, 570, "layerGrid", oGrid);
		with oBlock {
			isDragging = false;
			isPlaced = false;
			gridRef = instance_find(oGrid, 0); // Reference to grid
			gridCell = -1;
		}
		changed = true;
	}
}