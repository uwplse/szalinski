// Bottle Cap Laser Jig (Customizable)
// Jörg Pressel, 03/10/2018
// Values should work for 26mm bottle caps

$fn=80;

// number of holders across
_columns = 3; // [1:10]

// number of holders deep
_rows = 3; // [1:10]

// distance between centers of holders
_spacing = 33;

// junctions between holders
_junction_width = 6; // [3:20]
_junction_thickness = 0.6; // [0.3:2.0]

// inner and outer diameter of the uper edge; you may have to tweak those depending on your printer and/or bottle caps
_inner_diameter = 11.8;
_outer_diameter = 12.6;

module holder() {
union() {
    difference() {
        cylinder(6, _outer_diameter+1.4, _outer_diameter);
        translate([0, 0, 1]) cylinder(10, _inner_diameter, _inner_diameter);
        translate([0, 0, 1]) sphere(0.5, $fn=20); //center marker
    }
}   
}


for (j = [0:_rows-1]) translate([j*_spacing, 0, 0]) {
    translate([-_junction_width/2, 0, 0]) cube([_junction_width, (_columns-1)*_spacing, _junction_thickness]);
for (i = [0:_columns-1]) {
    translate([0,i*_spacing,0]) holder();
    if (j == 0) {
        translate([0, i*_spacing-_junction_width/2, 0]) cube([(_rows-1)*_spacing, _junction_width, _junction_thickness]);
    }
}
}