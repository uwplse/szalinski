standoff_distance = 32;
height = 8;
min_thickness = 1;
strut_thickness = 3;

$fn=100;
difference() {
    linear_extrude(height)
        union() {
            translate([standoff_distance/2, 0, 0]) circle(r=2.5+min_thickness);
            translate([-standoff_distance/2, 0, 0]) circle(r=2.5+min_thickness);
            translate([0, 2.5+min_thickness-strut_thickness/2, 0]) square([standoff_distance, strut_thickness], center=true);
        }
    translate([0, 2.5+min_thickness-strut_thickness, height/2]) cube([16, (strut_thickness-2)*2, 5.5], center=true);
    translate([0, 0, height/2]) rotate([90, 0, 0]) cylinder(r=3.1, h=10, center=true);
    translate([standoff_distance/2, 0, -1]) cylinder(r=2.5, h=height+2);
    translate([-standoff_distance/2, 0, -1]) cylinder(r=2.5, h=height+2);
    translate([12.5/2, 0, height/2]) rotate([90, 0, 0]) cylinder(r=3.15/2, h=10, center=true);
    translate([-12.5/2, 0, height/2]) rotate([90, 0, 0]) cylinder(r=3.15/2, h=10, center=true);
}