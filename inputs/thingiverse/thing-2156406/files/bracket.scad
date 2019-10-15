// preview[view:north west, tilt:top diagonal]
// ======= Configuration =======

// Move the fan left/right in relation to the hotend
lateral_offset = 0; 

// Move the fan closer/further away from the hotend
medial_offset = 3.5;

// Modify to compensate for hole shrinkage of your printer
hole_oversize = 0.1;


// ======= Model Generation =========
hole_size = 1.5 + hole_oversize;

difference() {
    union() {
        translate([3 - lateral_offset,13.5,1.6]) cube([7,7.5 + medial_offset,6.4]);
        translate([-11.5,7,0]) cube([23.1,7.8,8]);
        translate([-20.3,4.25,0]) cube([40.8,7.8,8]);
    }
    cylinder(r=12, h=30, center=true);
    translate([16.2,0,3.5]) rotate([90,0,0]) cylinder(r=hole_size, h=30, center=true, $fn=20);
    translate([-16.2,0,3.5]) rotate([90,0,0]) cylinder(r=hole_size, h=30, center=true, $fn=20);
    
    translate([0,18.5 + medial_offset,4.4]) rotate([90,0,90]) cylinder(r=hole_size, h=30, center=true, $fn=20);
}