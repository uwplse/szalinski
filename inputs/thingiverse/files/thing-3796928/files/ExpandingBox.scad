/////////////////////////////////////////////
// Expanding Box puzzle
// --------------------
//
// This is a coordinate motion puzzle with 6 identical pieces.
// The original idea is from Steward Coffin: https://johnrausch.com/PuzzlingWorld/chap12.htm#p1
// In his words: "it is more of an amusement than a puzzle".
//
//
// Very easy to print (no support, 0.2mm, a = 40 and g = 0.25 works nicely for me).
//
// Designed by David Gontier ( davidgontier@gmail.com )
// 
/////////////////////////////////////////////


a = 40;
g = 0.25; // the gap

//////////////////////////////////////////////
R = a/4;

module prism() { 
    difference() {
        translate([-R-g, -R, 0]) cube([2*R+2*g, 2*R, R]); // main cube
        translate([-R-1, R, -g]) rotate([45, 0, 0]) cube(R*[4,4,4]) ; //first cut
        translate([-R-1, -R, -g]) rotate([45, 0, 0]) cube(R*[4,4,4]) ; //second cut
        
    }
}

module tip() { 
    intersection() {
        cube((R-g)*[1,1,1]);
        rotate([0, 45, 0]) cube(R*[2, 2, 2]);
        rotate([-45,0, 0]) cube(R*[2, 2, 2]);
    }
}

module rhomboid_prism() {
    union() {
        // the main prism
        intersection() {
            translate([0, -R+g, -R]) cube([R-g, 2*R-2*g, 2*R-g]);
            rotate([0, 45, 0]) translate([-2*R, -R, 0]) cube(R*[4, 4, 4]);
        }
        // the tips
        translate([0, -R+g, 0]) rotate([90, 0, 0] ) tip();
        translate([0, R-g, 0]) rotate([0, -90, 0] ) rotate([-90, 0, 0] ) tip();
    }
        
}

module piece() { render() 
    union() {
        prism();
        translate([R+g, 0, 0]) rhomboid_prism();
        rotate([0, 0, 180]) translate([R+g, 0, 0]) rhomboid_prism();
    }
}

// For the STL file
//! translate([0, 0, R]) rotate([180, 0, 0]) piece();


// For the animation
//x = $t;
x = 0;
translate(R*[0, 0, 1+x]) piece(); //yellow
color([0, 0, 1]) translate(R*[0, 0, -1-x]) rotate([0, 180, 0]) piece(); //blue
color([1, 0, 0]) translate(R*[0, -1-x, 0]) rotate([90, 0, 0]) rotate([0, 0, 90]) piece(); //red
color([0, 1, 0]) translate(R*[0, 1+x, 0]) rotate([-90, 0, 0]) rotate([0, 0, 90]) piece(); //green
color([0, 1, 1]) translate(R*[1+x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 90]) piece(); //cyan
color([1, 1, 1]) translate(R*[-1-x, 0, 0]) rotate([0, -90, 0]) rotate([0, 0, 90]) piece(); //white