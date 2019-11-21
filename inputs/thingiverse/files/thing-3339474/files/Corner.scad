/* [Dimensions] */

// preview[view:north east, tilt:top diagonal]

// Thickness
thickness = 0.7;

// Height
z = 10;

// Dimension 1
x = 30;

// Dimension 2
y = 40;

/* [Hidden] */

xd = min(x, y, z);
yd = min(x, y, z);

cube(size = [x,xd,thickness]);
cube(size = [yd,y,thickness]);

cube(size = [thickness,y,z]);
cube(size = [x,thickness,z]);