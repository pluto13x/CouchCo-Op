if switchPlayers {
	if iViewportControl.player == 1 {
		iViewportControl.player = 2;
	}
	else {
		iViewportControl.player = 1;
	}
	iViewportControl.start = true;
	iViewportControl.sofaPresent = false;
	show_debug_message(iViewportControl.player);
	iViewportControl.changed = false;
	switchPlayers = false;
}