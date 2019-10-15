// Internal diameter of holes
internal_diameter = 3.5;

// External diameter of pillar
external_diameter = 8;

// Minimum wall thickness of pillars
minimum_wall_thickness = 1;

// Distance between holes on X axis
width = 45;

// Distance between holes on Y axis
length = 50;

// Height of pillars
height = 5;

// Number of cylinder segments
hole_segments = 40;

// Height of connecting strips
strip_height = 2;

// Internal radius of holes
internal_radius = internal_diameter / 2;

// External radius of pillars is limited by the minimum wall thickness
external_radius = max(external_diameter / 2, internal_radius + minimum_wall_thickness);

// Width of the connecting strips
strip_width = external_radius;

// prevents the connecting strips from encroaching on the holes
clearance = internal_diameter + 0.05;

module hide_parameters_below_this_point() {}

// prevents coplanar polygons on cylinder subtraction
fudge = 0.05;

union() {
    for (y=[-1:2:1]) {
        for (x=[-1:2:1]) {
            // subtract two cylinders to make a pillar
            difference() {
                // outside of cylinder
                translate([x*width/2,y*length/2,0]) {
                    cylinder(r=external_radius, height, $fn=hole_segments); 
                }
                // inside of cylinder
                translate([x*width/2,y*length/2,-fudge/2]) {
                    cylinder(r=internal_radius, height+fudge, $fn=hole_segments); 
                }
            }
            // connect along Y axis
            translate([x*width/2,0,strip_height/2]) {
                cube([strip_width,length-clearance,strip_height],center=true);
            }
        }
        // connect along X axis
        translate([0,y*length/2,strip_height/2]) {
             cube([width-clearance,strip_width,strip_height],center=true);
        }
    }
}


