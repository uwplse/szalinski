/* [Spacer] */
inner_diameter = 22.3;
outer_diameter = 26.5;
// (not including lip thickness)
height = 6;
/* [Lip] */
lip_thickness = 1;
// (will be added to outer diameter)
lip_width = 2;
/* [Hidden] */
fn = 100;

// Spacer
translate([0, 0, lip_thickness])
    difference() {
        cylinder(r=outer_diameter/2, h=height, $fn=fn);
        cylinder(r=inner_diameter/2, h=height, $fn=fn);
    }

// Lip
difference() {
    cylinder(r=(outer_diameter/2)+lip_width, h=lip_thickness, $fn=fn);
    cylinder(r=inner_diameter/2, h=lip_thickness, $fn=fn);
}