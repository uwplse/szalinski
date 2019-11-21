// signal for Finger Lakes Live Steamers 1.5" to the foot model railway

// customizer
// http://customizer.makerbot.com/docs

// How many aspects?
aspect_count = 0.5; // [0.5: two aspects, 0:three aspects]


thickness_of_backplate = 3 * 1;
width_of_backplate = 70 * 1;
diameter_of_signal = 3 / 8 * 25.4 + .7;
diameter_of_ring = 3 / 4 * 25.4;
shroud_thickness = 1.5 * 1;
buffer = diameter_of_ring / 2 - shroud_thickness;
shroud_height = 1.25 * 25.4;
spacing = (1 + 5 / 8) * 25.4;
screw_spacing = (5 + 5/16) * 25.4;
screw_radius = 3 * 1;

spacing1 = spacing * (0 + aspect_count);
spacing2 = spacing * (1 + aspect_count);
spacing3 = spacing * (2 + aspect_count);

if (spacing * 2 + width_of_backplate *2 < screw_spacing) { echo("no good"); }

difference() {
    union() {
        cylinder(r = width_of_backplate / 2, h = thickness_of_backplate);
        translate([0, -width_of_backplate/2, 0])
            cube([spacing *2, width_of_backplate, thickness_of_backplate]);
        translate([spacing*2, 0, 0])
            cylinder(r = width_of_backplate / 2, h = thickness_of_backplate);
    }        
    translate([0,0,-0.01]) {
        translate([spacing1, 0, 0])
            cylinder(r = diameter_of_signal/2, h = thickness_of_backplate + .02);
        translate([spacing2, 0, 0])
            cylinder(r = diameter_of_signal/2, h = thickness_of_backplate + .02);
        if (! aspect_count) {
            translate([spacing3, 0, 0])
                cylinder(r = diameter_of_signal/2, h = thickness_of_backplate + .02);
        }
        translate([-( screw_spacing / 2 - spacing),0,0])
            cylinder(r = screw_radius, h = thickness_of_backplate + .02);
        translate([spacing*2 + ( screw_spacing / 2 - spacing),0,0])
            cylinder(r = screw_radius, h = thickness_of_backplate + .02);
    }
}

// shrouds


module shroud() {
    difference() {
        cylinder(r = diameter_of_signal/2 + buffer + shroud_thickness, h=shroud_height);
        translate([0,0,-0.01]) {
            cylinder(r = diameter_of_signal/2 + buffer, h=shroud_height + .02);
            *translate([0,-(diameter_of_signal/2 + buffer + shroud_thickness),0])
                cube([diameter_of_signal + buffer*2 + shroud_thickness*2, diameter_of_signal + buffer*2 + shroud_thickness*2, shroud_height + .02]);
        translate([-(diameter_of_signal/2 + buffer + shroud_thickness),diameter_of_signal/2 + buffer + shroud_thickness,shroud_height])
            rotate([90,45,0])
                cube([shroud_height*1.5,shroud_height,shroud_height]);
        }
    }
}

translate([spacing1, 0, thickness_of_backplate]) shroud();
translate([spacing2, 0, thickness_of_backplate]) shroud();
if (! aspect_count) {
    translate([spacing3, 0, thickness_of_backplate]) shroud();
}

