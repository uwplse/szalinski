rail_width = 34;
shim_length = 45;
screw_diameter = 5;
rake_angle = 2; // Ceiling or rafter angle in degrees
seat_height = 2; // How tall should seating ridges be in mm
seat_width = 2; // How wide should seating ridges be on either side of shim
min_shim_depth = 1.5; // Minimum depth of the shim, not including seat part
rotate_shim = true;

/* [ Hidden ] */
$fn = 36;
screw_radius = screw_diameter / 2;
shim_width = rail_width + (2 * seat_width);

// from wiki  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
module cylinder_outer(height,radius){
   fudge = 1/cos(180/$fn);
   cylinder(h=height,r=radius*fudge);}

// tan(x) * A = O
opposite_length = tan(rake_angle) * shim_width;

// draw out the shim, then extrude
points = [
    [0, -min_shim_depth],
    [shim_width, -min_shim_depth - opposite_length],
    [shim_width, seat_height],
    [shim_width - seat_width, seat_height],
    [shim_width - seat_width, 0],
    [seat_width, 0],
    [seat_width, seat_height],
    [0, seat_height]
];

rotate([
   0,
      rotate_shim ? -rake_angle : 0,
   0
   ]) difference() {
    translate([0, shim_length, 0]) rotate([90, 0, 0]) linear_extrude(shim_length) polygon(points);

    // make a hole for the screw
    translate([shim_width / 2, shim_length /2, -opposite_length -min_shim_depth]) cylinder_outer(opposite_length + min_shim_depth, screw_radius);
}