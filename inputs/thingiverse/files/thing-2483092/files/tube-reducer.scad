/*** Customizable cellphone holder on bike by Svenny ***
 ***    https://www.thingiverse.com/thing:2483092    ***/

/* [SIDE 1] */
// outer diameter
outer_d_1 = 14.5;
// inner diameter
inner_d_1 = 12;

/* [SIDE 2] */
// outer diameter
outer_d_2 = 5.5;
// inner diameter
inner_d_2 = 4;

/* [COMMON] */
// length of each side
side_length = 12;
// length of the central part
center_length = 16;

/* [TEETH] */
// how much will the tooth add to the outer radius
tooth_thickness = 0.5;
// tooth length
tooth_length = 3;
// count of teeth on each side
teeth_count = 3;

/* [PRECISION] */
// precision (don't touch)
$fn = 80;

module step(d) {
    translate([0,0,0.8])
    cylinder(r1=d/2+tooth_thickness, r2=d/2, h=tooth_length-0.8);
    cylinder(r1=d/2, r2=d/2+tooth_thickness, h=0.8);
}

module side(outer_d, inner_d) {
    difference() {
        union() {
            cylinder(d=outer_d, h=side_length);
            for(i=[1:teeth_count]) {
                echo(i);
                translate([0,0,side_length-i*tooth_length])
                step(outer_d);
            }
        }
        cylinder(d=inner_d, h=3*side_length, center=true);
    }
}

module center() {
    difference() {
        cylinder(r1=outer_d_1/2, r2=outer_d_2/2, h=center_length, center=true);
        cylinder(r1=inner_d_1/2, r2=inner_d_2/2, h=center_length, center=true);
    }
}

module reductor() {
    rotate([180,0,0])
    translate([0,0,center_length/2])
    side(outer_d_1, inner_d_1);
    translate([0,0,center_length/2])
    side(outer_d_2, inner_d_2);
    center();
}


if(outer_d_1 < outer_d_2)
    rotate([180,0,0]) reductor();
else
    reductor();
