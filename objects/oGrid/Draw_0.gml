// Draw grid lines (for debugging)
draw_set_color(c_white);
for (var row = 0; row <= gridRows; row++) {
    var yy = gridOffsetY + row * cellHeight;
    draw_line(gridOffsetX, yy, gridOffsetX + gridCols * cellWidth, yy);
}

for (var col = 0; col <= gridCols; col++) {
    var xx = gridOffsetX + col * cellWidth;
    draw_line(xx, gridOffsetY, xx, gridOffsetY + gridRows * cellHeight);
}

// Draw center points (red dots)
draw_set_color(c_red);
for (var i = 0; i < array_length(gridCenters); i++) {
    var pos = gridCenters[i];
    draw_circle(pos[0], pos[1], 3, false);
}