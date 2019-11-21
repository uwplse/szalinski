//Hang tab dimensions
tab_height = 40;
tab_width = 34;
tab_thickness = 0.4;

hole_diameter = 12;
hole_offset = 10;

rounding_radius = 6;

add_slot = 1; // [1,0]

// number of fragments (how round)
$fn=50;

height = tab_height - 2*rounding_radius;
width = tab_width - 2*rounding_radius;
difference(){
    minkowski(){
        cube([width, height, tab_thickness/2],center = true);
        cylinder(r=rounding_radius, tab_thickness/2,center=true);
    }
    translate([0,hole_offset,0]) {
        cylinder(d=hole_diameter,h=tab_thickness*2,center = true);
        if(add_slot) {
            translate([width/2,0,0])
                cube(center=true,size=[width,hole_diameter/2,tab_thickness*2]);
        }
    }
}