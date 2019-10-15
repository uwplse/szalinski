width = 17;
length = 40;
walls = 2;
bottom = 1.6;
spacing = 3.2;
boardHeight = 2;
top = 1;
cutoutDepth = 2;

wireCutoutOffset = 3.8;
wireCutout = 5;

/* [Hidden] */
totalHeight = bottom + spacing + boardHeight + top;
totalLength = length + (walls) * 2;
totalWidth = width + (walls) * 2;

rotate([0, -90, 90])
difference() {
  cube([totalLength, totalWidth, totalHeight]);
  
  translate([walls + cutoutDepth, walls + cutoutDepth, bottom])
    cube([length - cutoutDepth * 2, width - cutoutDepth * 2, totalHeight]);
  
  translate([walls, walls, bottom + spacing])
    cube([length, width, boardHeight]);
  translate([-1, wireCutoutOffset + walls, bottom])
    cube([walls + cutoutDepth + 2, wireCutout, spacing]);
}