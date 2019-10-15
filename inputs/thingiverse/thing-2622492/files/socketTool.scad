/* This is the hex size in mm */
size = 13.8;

/* This is the total height of the tool */
height = 15;

/* No need to touch this stuff... */
$fn = 90;
d = 2*1.03*size/sqrt(3);
handle_total_l = d+2+4*2;
handleh = 8;
handle_thick = 4;

difference(){
    union(){
        translate([-handle_total_l/2,-handle_thick/2,0])cube([handle_total_l,handle_thick,handleh]);
        cylinder(h = height, d=d+2);
        translate([-handle_total_l/2,0,0])cylinder(d = handle_thick, h = handleh);
        translate([handle_total_l/2,0,0])cylinder(d = handle_thick, h = handleh);
    }
    cylinder($fn = 6, h = height, d=d);
}
