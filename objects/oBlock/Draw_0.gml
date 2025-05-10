// Draw sprite (automatically centered)
draw_self();
image_xscale = 0.5;
image_yscale = 0.5;

// Draw selection outline when dragging
if (isDragging) {
    draw_set_color(c_white);
    draw_set_alpha(0.5);
    draw_rectangle(
        x - spriteHalfWidth * image_xscale, 
        y - spriteHalfHeight * image_yscale,
        x + spriteHalfWidth * image_xscale,
        y + spriteHalfHeight * image_yscale,
        false
    );
    draw_set_alpha(1);
}

if (isPlaced) {
	x = cellX;
	y = cellY;
}