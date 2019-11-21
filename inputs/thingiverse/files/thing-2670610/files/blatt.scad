$fn=60;

cable_diameter=6;
screw_diameter=2.8;
sphere_diameter=18;
around_screw_diameter=14;
hole_pos_x=13;
hole_pos_y=7;
thickness=1.5;

    difference() {
        union() {
    rotate([90,0,0]) translate([0,0,0]) sphere(d=sphere_diameter);
linear_extrude(thickness) difference() {
hull() {
    translate([hole_pos_x,hole_pos_y,0]) circle(d=around_screw_diameter);
    circle(d=sphere_diameter);
}
translate([hole_pos_x,hole_pos_y,0]) circle(d=screw_diameter);
}
}
    rotate([90,0,0]) union()
    {
        translate([0,cable_diameter/2,-sphere_diameter/2-1]) cylinder(d=cable_diameter,h=sphere_diameter+2);
        translate([-cable_diameter/2,-cable_diameter/2,-sphere_diameter]) cube([cable_diameter,cable_diameter,sphere_diameter*2]);
        translate([-sphere_diameter/2-1,-sphere_diameter,-sphere_diameter/2-1]) cube([sphere_diameter+2,sphere_diameter,sphere_diameter+2]);
    } }
