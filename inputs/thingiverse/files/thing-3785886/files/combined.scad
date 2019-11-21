// ------------ START: assembly.scad -----------------

/* [Core] */
// Number of segments in a circle. Affects all circles - mesh, pins, clasps, etc
$fn=10;

// === Mesh Variables ============
/* [Mesh] */
// XY for the mesh only. Pins and clasp will be placed outside this size
// so ensure your printer bed can handle "mesh_size + con_depth"
mesh_size = 180;
// Z height of the mesh part where the holes go
mesh_height = 1;
// Size of each hole in the mesh
mesh_hole_diameter = 15;
// Depth (in XY) of the border around the mesh itself. Needed to support the mesh
mesh_border = 2.5;
// Z height of the border. Can be equal to mesh height or the connector height
mesh_border_height = 10;
// How close the mesh circles are to each other
mesh_grid_spacing = 3; // [1:10]
// === End =======================

// === Connector Variables ============
// These define the bounding box used by both
// the clasp pin and the clasp
/* [Connector Shared Variables For Clasp And Pin] */
// Width each connector gets. We currently have one connector per side so
// we use the full width of the mesh
con_width = mesh_size;
// Height each connector gets. Printing connectors seems to be easier if they are
// bigger, so we set them to be as tall as the mesh border to get maximum height
con_height = mesh_border_height;
// Depth each connector gets. Keeping the connectors in a square bounding box
// ensures 3D assemblies work OK. If you make it non-square then one of your
// resulting axis will end up longer when assembling multiple sides together
con_depth = con_height;
// === End =======================

// === Clasp Pin Variables ============
/* [Pin] */
// Length of the clasp pin
cp_length = con_width;
// Radius of the pin. Larger values print smoother but require larger mesh border
// height. Also, the clasp (the female half) will grow larger and may be taller
// than the mesh border height. If this happens, it is probably time to stop using
// Customizer and use OpenSCAD directly where you can see/edit many more variables
cp_rad = 2.5;
// TODO define cp_mount_width = 1;
// === End =======================

// === Clasp Variables ============
/* [Clasp] */
// Lenght of the clasp. We remove a bit so there is an empty space matching up to
// the pin mounts
clasp_len = con_width - 3;
// Amount of the gap we will cut out of the clasp circumference. 2 * the radius would
// allow the pin to fall out without obstruction, so we go a bit lower than taht
clasp_mouth = cp_rad * 1.65;
// Inner radius of the clasp. We add a small buffer due to printing defects. Remember
// the pin should rotate freely in the clasp
clasp_inner_rad = cp_rad + 0.65;
// The outer radius. This effectively describes the 'thickness' of the clasp. Thicker
// values are much harder to bend, while values too small make a weak clasp that cracks.
// Note that there is no safety check that the clasp_outer_rad will fit within the
// connector's bounding box, so you need to manually look at the Z-axis when making a
// thick clasp and ensure you're not making it so large it will not print properly
clasp_outer_rad = clasp_inner_rad * 1.25;
// === End =======================

/* [Hidden] */
// Overall mode
// 1 - Generate one side (mesh with clasps & pins)
// 2 - Testing code
mode = 1;

if (mode == 1) {
mesh_with_clasps_and_pins();
} else if (mode == 2) {
test();
}


module mesh_with_clasps_and_pins() {

// Make mesh & slide to have room for connectors
translate([con_depth, con_depth, 0])
mesh(side_length = mesh_size,
hole_diameter = mesh_hole_diameter,
height = mesh_height,
border = mesh_border,
border_height = mesh_border_height,
grid_spacing = mesh_grid_spacing / 10);

// Create male sides
color("red") translate([con_depth, 0 , 0])
male_pin_and_mount();
color("red") translate([0, mesh_size + con_depth,0])
rotate([0, 0, 270])
male_pin_and_mount();

// Create female sides
color("green") translate([con_depth, mesh_size + con_depth, 0])
female_clasp_and_mount();
color("green") translate([mesh_size + con_depth, mesh_size + con_depth,0])
rotate([0, 0, -90])
female_clasp_and_mount();

module female_clasp_and_mount() {
// Helper variables
clasp_thickness = clasp_outer_rad - clasp_inner_rad;
clasp_mount_depth = con_depth - clasp_outer_rad*2; // Does not incl. thickness
// Fudge factor, we need to keep the clasp within the
// bounding box or our 3D arrangement won't work right. However, we also
// need it to be roughly aligned with the pin or the 3D arrangement will
// be hard to assemble. Calculating directly is tough, as the bigger the
// mouth cut is, the more of a fudge factor we need. So we approx an OK val
clasp_extra_mount_depth = clasp_mouth / 3.6;

// Assume we need to reserve 3mm (total) in X-axis the clasp mounts
// Realign Y-axix to zero
translate([1.5, clasp_outer_rad + clasp_mount_depth,0])
union() {

// Shift clasp down to ease alignment
translate([0,
clasp_extra_mount_depth,
(mesh_border_height / 2) - clasp_outer_rad])
clasp(length = clasp_len,
pin_radius = cp_rad,
mouth = clasp_mouth,
inner_radius = clasp_inner_rad,
outer_radius=clasp_outer_rad);
// Build + align clasp mount
translate([0, -clasp_outer_rad-clasp_mount_depth, 0])
cube([con_width - 3,
clasp_mount_depth + clasp_thickness + clasp_extra_mount_depth,
con_height]);

// Debug (for ensuring the bounding box is right)
// translate([0, -clasp_outer_rad-clasp_mount_depth, 0])
// cube([1, con_depth, con_height]);
}
}


// Helper function
module male_pin_and_mount() {
// color("green") cube([con_width, con_depth, con_height]);
// Assume mounts are each 1mm wide
// Assume we want the CP 2.5mm deep
pin_mount_height = (mesh_border_height / 2) - cp_rad;
union() {
cube([1, con_depth, con_height]);
translate([0, 2.5, pin_mount_height])
clasp_pin(radius=cp_rad, length=cp_length);
translate([con_width-1, 0, 0])
cube([1, con_depth, con_height]);
}
}
}

// ------------ END: assembly.scad -----------------
// ------------ START: clasp.scad -----------------
// clasp(length = 10);
// Need a sample pin?
//color("blue") clasp_pin(radius = 5, height = 12);

module clasp(length=20,
pin_radius=5,
// All of these are defined below due to
// SCAD language limits (no derived params)
mouth = undef,
inner_radius = undef,
outer_radius = undef
) {
mouth = is_undef(mouth) ? pin_radius * 1.75 : mouth;
inner_radius = is_undef(inner_radius) ? pin_radius + 0.25 : inner_radius;
outer_radius = is_undef(outer_radius) ? inner_radius * 1.4 : outer_radius;

echo(str("Building clasp with: "));
echo(str(" Length: ", length));
echo(str(" In Radius: ", inner_radius));
echo(str(" Out Radius: ", outer_radius));
echo(str(" Mouth : ", mouth));
echo(str(" PinRad: ", pin_radius));

// Build clasp, lay horizontally, and reorient z-axis to zero
translate([0, 0, outer_radius])
rotate([0, 90, 0])
difference() {
cylinder(r=outer_radius,h=length);

translate([0,0,-1])
cylinder(r=inner_radius,h=length+2);

cutout_mouth(mouth, inner_radius);
}

// Helper module
module cutout_mouth(mouth, radius) {
echo(str("Cutting mouth with: "));
echo(str(" Mouth: ", mouth));
echo(str(" InnerRad: ", radius));
angle_rad = mouth / radius; // circle central angle (rad)
angle_deg = angle_rad * 57.2958; // (degrees)
echo(str(" Angle: ", angle_deg));

size = length + 2;
if (angle_deg <= 90) {
// Rotate so our cut always faces +Y
rotate([0, 0, 90 - angle_deg/2])
translate([0,0,-1])
intersection() {
cube(size);
rotate(angle_deg-90) cube(size);
}
} else if (angle_deg <= 180) {
// Rotate so our cut always faces +Y
rotate([0, 0, 90 - angle_deg/2])
translate([0,0,-1])
union() {
cube(size);
rotate(angle_deg-90) cube(size);
}
} else {
echo(str("FAILURE - Angle cannot exceed 180"));
}
}

}


module clasp_pin(radius, length) {
// You can rotate it to get a better print angle, but you
// will need 8xSupports while printing
// which is tedious to clean
// rotate(a=45, v=[1,0,0])

// Lay pins horizontally & reorient z-axis to zero
translate([0,0,radius])
rotate([0, 90, 0])
cylinder(r=radius, h=length);
}

/*
THIS is not working right now. It's a good idea to combine these, but
the sad truth is a large amount of the correct clasp pin design has to do
with how you combine it with the mesh border. So it's a bit hard to embed
with the clasp.scad file after the fact
module clasp_pin(length=cp_len,
radius=cp_rad) {

difference() {
// We oversize the cube (in Y and Z) to prevent edge artifacts
translate([0, -1, -1])
cube([length, 2+cp_box_depth, mesh_height+2]);

// You can rotate it to get a better print angle, but you
// will need 8xSupports while printing
// which is tedious to clean
// rotate(a=45, v=[1,0,0])
translate([-1, cp_box_depth/2, mesh_height/2])
rotate([0, 90, 0])
cylinder(r=radius, h=length+2);
}
}
*/


// ------------ END: clasp.scad -----------------
// ------------ START: mesh.scad -----------------
// mesh(side_length=50);
/*mesh(side_length,
hole_diameter,
height,
border,
grid_spacing / 10);
*/

module mesh(side_length,
hole_diameter = undef,
height=3,
border=undef,
border_height=undef,
grid_spacing=0.2) {

hole_diameter = is_undef(hole_diameter) ? side_length / 8 : hole_diameter;
border = is_undef(border) ? side_length *.1 : border;
border_height = is_undef(border_height) ? height : border_height;


echo(str("Building mesh with: "));
echo(str(" Side: ", side_length));
echo(str(" Hole Diameter: ", hole_diameter));
echo(str(" Height: ", height));
echo(str(" Border : ", border));
echo(str(" Border Height : ", border_height));
echo(str(" Grid Spacing: ", grid_spacing));

// Ensure the border is sane
// border = min(border, side_length / 2.5);
size = side_length;

// We can only place holes in the non-border, and
// each hole actually takes a bit of addl. spacing
hole_footprint = hole_diameter * (1 + grid_spacing);
s_avail = size - border*2;
hole_count = ceil(s_avail / hole_footprint);
hole_r = hole_diameter / 2;

// Diagnostic data
/*echo(str("We have ", s_avail, "mm of space for holes"));
echo(str("We will place ", hole_count, " holes"));
echo(str("Each hole has a footprint of ", hole_footprint, "mm-squared"));
*/

union(){
// Build the four border walls
color("gray") {
cube([size,border,border_height]);
cube([border,size,border_height]);

translate([size-border,0,0])
cube([border,size,border_height]);

translate([0,size-border,0])
cube([size,border,border_height]);
}

// Lay out the mesh and cut the circles
// TODO Do we want mesh to be in middle of border_height? Makes printing harder
difference() {
translate([border, border, 0])
cube(size=[size - 2*border, size - 2*border, height]);

translate([border + hole_r, border+hole_r, -1])
for (x = [0:hole_count - 1]) {
translate([x * hole_footprint, 0, 0])
for (y = [0:hole_count - 1]) {
translate([0, y * hole_footprint, 0])
cylinder(r=hole_diameter / 2, h=height*4, $fn=20);
}
}
}
}
}



// ------------ END: mesh.scad -----------------
