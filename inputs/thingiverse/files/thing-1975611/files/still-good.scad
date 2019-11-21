$fa = 1;
$fs = 0.5;
$fn = 0;

wall = 1.5;
dims = [23, 36, 15];
cutout = [15.5, 14.5, 2*wall];
corner_r = 3;
offset = 1;
lip = 1;
dist = 10;

latch = [wall, 7, dims[2]-wall];

button = [6.5,6.5,2*wall];
offset_button = 3;

module skin(debug=false, thickness=5, box=400) {
    if (!debug) intersection() { 
        children(); 
        minkowski() {
            cube(2*thickness,center=true);
            difference() { 
                cube(box,center=true); 
                children(); 
            } 
        } 
    }
    
    if (debug) children();
}

module enclosure(thickness=10) {
    difference() {
        skin(thickness=thickness) {
            hull() {
                translate([0,0,0]) cylinder(h=dims[2], r=corner_r, center=true);
                translate([dims[0],0,0]) cylinder(h=dims[2], r=corner_r, center=true);
                translate([0,dims[1],0]) cylinder(h=dims[2], r=corner_r, center=true);
                translate([dims[0],dims[1],0]) cylinder(h=dims[2], r=corner_r, center=true);
            }
        }
        translate([dims[0]/2-cutout[0]/2, dims[1]-cutout[1]-offset, dims[2]/2-cutout[2]/2]) 
            cube(cutout);
        translate([dims[0]/2-button[0]/2, offset_button, dims[2]/2-button[2]/2])
            cube(button);
    }
}

module latch__(addition=0) {
    latch_(addition);
    translate([dims[0],0,0]) mirror([1,0,0]) latch_(addition);
}

module latch_(addition=0) {
    translate([-corner_r+1, dims[1]/2-latch[1]/2-addition/2, -dims[2]/2+wall]) 
        cube([latch[0],latch[1]+addition,latch[2]]);
    translate([-corner_r-1, dims[1]/2-latch[1]/2-addition/2, -dims[2]/2+wall]) 
        cube([latch[0]+2+addition, latch[1]+addition, wall+1+addition]);
}

module bottom() {
    difference() {
        enclosure(thickness=wall);
        translate([-dims[0], -dims[1], 0]) cube([4*dims[0], 4*dims[1], dims[2]]);
        latch__(0.75);
    }
}

module top() {
    difference() {
        enclosure(thickness=wall);
        translate([-dims[0], -dims[1], -dims[2]]) cube([4*dims[0], 4*dims[1], dims[2]]);
    }
    latch__();
}

translate([-dims[0]/2-dist, -dims[1]/2, 0]) bottom();
translate([dims[0]/2+dist, dims[1]/2, 0]) rotate([180,0,0]) top();
