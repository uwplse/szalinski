inside_x = 13;
inside_y = 19.5;
wall_thickness = 2;
length = 25;
screwhole_radius = 1.5;

$fn=100;

difference() {

cube(size=[inside_x+wall_thickness*2, inside_y+wall_thickness*2, length], center = true);

cube(size=[inside_x, inside_y, length+2], center = true);

rotate([0,90,0])
    cylinder(h=inside_x, r=screwhole_radius);

}
