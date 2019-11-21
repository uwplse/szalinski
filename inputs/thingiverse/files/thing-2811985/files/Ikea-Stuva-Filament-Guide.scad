guide_height = 60;
guide_radius = 8/2;
cap_height = 3;
cap_radius = 20/2;
hole_radius = 4/2;
//$fa = 0.01; $fs = 0.01;
$fn = 100;

translate([0, 0, guide_height+cap_height]) rotate(a=[180,0,0]) difference() {
    union() { // Cap
        cylinder(h=guide_height, r=guide_radius);
        translate([0,0,guide_height]) cylinder(h=cap_height, r=cap_radius);
    }
    union() { // Hole
        translate([0,0,guide_height+1]) cylinder(10, hole_radius, hole_radius*3);
        translate([0,0,-1]) cylinder(h=guide_height+cap_height+2, r=hole_radius);
        translate([0,0,-1]) cylinder(10, min(hole_radius*2, guide_radius-1), hole_radius);
    }
}
