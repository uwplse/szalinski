/* [Base Dimensions] */
//Base Diameter
base_diameter = 40; // [15:1:100]
//Base thickness
base_thickness = 1.5; // [0.5:0.25:3]
//Base cutout diameter (0=none)
base_cutout_diameter = 2; // [0:0.1:1]

/* [Hole Dimensions] */
//Hole diameter
hole_diameter = 31.5; // [15:1:100]
//Hole depth/height
hole_height = 5; // [0.5:0.25:10]

/* [Tab Dimensions] */
//Number of retaining tabs
number_of_tabs = 4; // [2:1:20]
//Retaining tab width (each)
tab_width = 5; // [0.5:0.5:8]
//Tab leg height (needs to be long enough to allow some flexing, 4 recommended)
tab_height = 4; // [1:0.5:10]

/* [Miscellaneous] */
// Smoothness
smoothness=50; // [25:5:100]

//-------------------------------------------
$fn=smoothness;
nozzle_diameter = 0.4;
wall_thickness = 4 * nozzle_diameter;
base_radius = base_diameter / 2;
hole_radius = hole_diameter / 2;

module cutout_tab_sides() {
    for (i = [0:360/number_of_tabs:360]) {
        rotate([0,0,i])
        translate([hole_radius - 0.6,0,hole_height/2 - tab_height/2 + 0.1]) {
            translate([0,-tab_width/2 - 0.4,0])
            cube([wall_thickness * 2, 0.8, tab_height], center=true);
            translate([0,tab_width/2 + 0.4,0])
            cube([wall_thickness * 2, 0.8, tab_height], center=true);
        }
    }
}

module tab_top() {
    difference() {
        cube([wall_thickness * 3,tab_width,2], center=true);
        
        translate([1,0,1.1])
        rotate([0,20,0])
        cube([wall_thickness * 4,tab_width+0.2,2.5], center=true);
    }
}

module tab_tops() {
    for (i = [0:360/number_of_tabs:360]) {
        rotate([0,0,i])
        translate([hole_radius+0.7,0,hole_height+1])
        tab_top();
    }
}

module inner() {
    translate([0,0,hole_height/2]) {
        difference() {
            cylinder(r=hole_radius, h=hole_height + 0.1, center=true);
            cylinder(r=hole_radius - wall_thickness, h=hole_height + 0.2, center=true);
            cutout_tab_sides();
        }
    }
    
    tab_tops();
}

module base() {
    if (base_cutout_diameter > 0) {
        difference() {
            cylinder(r=base_radius, h=base_thickness, center=true);
            cylinder(r=base_cutout_diameter/2, h=base_thickness+0.2, center=true);
        }
    } else {
        cylinder(r=base_radius, h=base_thickness, center=true);
    }
}

base();

translate([0,0,base_thickness/2])
    inner();