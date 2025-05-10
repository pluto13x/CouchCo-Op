if start == true {
	x += 30;
	sofa1id = oSofa.id;
	grid1id = oGrid.id;
	instance_create_layer(2400, 570, "layerSofa", oSofa);
}

if x >= room_width {
	start = false;
	instance_destroy(sofa1id);
	instance_destroy(grid1id);
	instance_create_layer(2400, 570, "layerGrid", oGrid);
}