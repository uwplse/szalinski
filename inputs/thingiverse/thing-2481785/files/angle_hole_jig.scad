// Parametric angled edge hole jig, created by Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons - attribute - share alike license

fin_thickness = 6.5;
jig_width = 27;
hole_angle = 60;
hole_dia = 0.125*25.4;
thickness = 1.98;
drill_guide_length = 12;

fudge_factor = 0.4;

$fs = 0.2;
$fa = 0.2;

jig_length = tan(hole_angle)*(jig_width+drill_guide_length+thickness*2+hole_dia*2);

rotate([0,-90,0]) difference() {
    union() {
        cube([jig_width+drill_guide_length,jig_length,fin_thickness+thickness*2]);
        translate([0,0,thickness*2+fin_thickness-hole_dia/2-1]) intersection() {
            cube([jig_width+drill_guide_length,jig_length,fin_thickness+thickness*2]);
            translate([0,0,hole_dia/2+1]) rotate([0,0,hole_angle]) rotate([0,90,0]) translate([0,hole_dia/2+thickness,-5]) cylinder((jig_width+drill_guide_length)/cos(hole_angle)+40, d=hole_dia+fudge_factor);
        }
    }
    translate([drill_guide_length,-0.5,thickness]) cube([jig_width+1,jig_length+1,fin_thickness]);
    translate([0,0,thickness+fin_thickness/2]) rotate([0,0,hole_angle]) rotate([0,90,0]) translate([0,hole_dia/2+thickness,-5]) cylinder((jig_width+drill_guide_length)/cos(hole_angle)+40, d=hole_dia+fudge_factor);
}