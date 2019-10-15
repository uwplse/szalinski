/* [First Layer] */
// First layer height
height = 0.3;//[0.1, 0.2, 0.3, 0.4, 0.5]
// First layer size
size = 50;//[5:5:150]

translate([-size/2, -size/2,0])
  cube([size, size, height]);