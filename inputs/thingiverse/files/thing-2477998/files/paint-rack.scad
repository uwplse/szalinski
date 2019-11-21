// Parametric paint bottle holder, created by Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons - share alike - attribution license

bottle_dia = 34; // diameter of the bottle
bottle_depth = 20; // Depth at front; if the top is angled, the back will be deeper.
bottle_space = 2; // extra space added to give the bottle some wiggle room
bottle_gap = -1; // How much gap should be between the holes.  Increase bottle_space and make this negative to blend the holes together.

thickness = 1.98; // How thick should the walls be at their thinnest point.  A multiple of your extrusion width will optimize the paths going by the edges.

rows = 4; // rows of bottles
cols = 5; // columns of bottles
angle = 15; // angle of the top

// No user input below this line.

hole_dia=bottle_dia+bottle_space*2;
width = (hole_dia+bottle_gap)*cols+thickness*2-bottle_gap;
height = (hole_dia+bottle_gap)*rows+thickness*2-bottle_gap;

angular_height = tan(angle)*height;

front_depth = bottle_depth+thickness;
back_depth = bottle_depth+thickness+angular_height;

$fs = 0.2;
$fa = 0.2;

difference() {
    polyhedron(points = [[0,0,0], [width,0,0], [width,height,0], [0,height,0], [0,0,front_depth], [width,0,front_depth], [width,height,back_depth], [0,height,back_depth]], faces = [[0,1,2,3], [4,5,1,0], [7,6,5,4], [5,6,2,1], [6,7,3,2], [7,4,0,3]]);
    for (row = [0:rows-1]) {
        row_offset = thickness+hole_dia/2+(hole_dia+bottle_gap)*row;
        height_offset = tan(angle)*(row_offset-hole_dia/2)+thickness;
        for (col = [0:cols-1]) {
            col_offset = thickness+hole_dia/2+(hole_dia+bottle_gap)*col;
            translate([col_offset, row_offset, height_offset]) cylinder(bottle_depth*2, d=hole_dia);
        }
    }
}