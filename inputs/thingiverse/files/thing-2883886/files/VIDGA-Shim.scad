rake_angle = 2; // Ceiling or rafter angle in degrees
seat_height = 1.5; // How tall should seating ridges be in mm
seat_width = 1.5; // How wide should seating ridges be on either side of shim
min_shim_depth = 1.5; // Minimum depth of the shim, not including seat part
rotate_shim = true; // Orientates shim horizontally for faster printing

/* [ Hidden ] */
$fn = 36;
vidga_length = 31;
vidga_width = 17;
vidga_screw_diameter = 5;
vidga_screw_radius = vidga_screw_diameter / 2;

shim_width = vidga_width + (2 * seat_width);
shim_length = vidga_length;

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
    translate([shim_width / 2, shim_length /2, -opposite_length -min_shim_depth]) cylinder_outer(opposite_length + min_shim_depth, vidga_screw_radius);
}