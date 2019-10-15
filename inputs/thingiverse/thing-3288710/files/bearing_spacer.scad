/* [Spacer] */

bearing_thickness=7;

bearing_hole_diameter=8;

spacer_outer_diameter=14;

// total space to fill with 2 spacers and bearing
width_to_fill=12;

/* [Shim] */

shim_width=1;

shim_thickness=1;

/* [Optional screw hole] */

screw=1; // [1:yes,-1:no]

screw_hole_diameter=4;

/* [Fine tuning] */

// XY compensation
tolerance=0.1;

definition=100; // [50:low,100:medium,150:high]

/////////////////////
// calculated fields
shim_diameter = bearing_hole_diameter+(shim_width*2);
total_thickness = (width_to_fill/2) - 0.4;
spacer_thickness = ((width_to_fill-bearing_thickness)/2)-shim_thickness;

/////////////////////
$fn=definition;

module spacer() {
    difference() {
        union() {
            cylinder(d=spacer_outer_diameter-(2*tolerance), h=spacer_thickness);
            cylinder(d=shim_diameter-(2*tolerance), h=spacer_thickness+shim_thickness);
            cylinder(d=bearing_hole_diameter-(2*tolerance), h=total_thickness);
        }

        if(screw==1){
            translate([0,0,-1]) cylinder(d=screw_hole_diameter + 2*tolerance, h=total_thickness + bearing_thickness +2);
        }
    }
}

spacer();
