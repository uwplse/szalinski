/*
Created by Kevin Gravier
https://www.thingiverse.com/mrkmg/about

My take on a top and bottom fillet for a 3d shape.

Available Modules:

topBottomFillet(b, t, r, s, e)
b = z of bottom of 3d object
t = z of top of 3d object
r = radius of fillet
s = steps of filler (smaller is smoother)
e = enabled (pass e = 0 to disable fillet for faster preview)

topFillet(t, r, s, e)
t = z of top of 3d object
r = radius of fillet
s = steps of filler (smaller is smoother)
e = enabled (pass e = 0 to disable fillet for faster preview)

bottomFillet(b, r, s, e)
b = z of bottom of 3d object
r = radius of fillet
s = steps of filler (smaller is smoother)
e = enabled (pass e = 0 to disable fillet for faster preview)

*/

enable = 1;

// Example, hard edges
translate([0, 20, 0])
topBottomFillet(b = 0, t = 10, r = 2, s = 20, e = enable)
linear_extrude(10, scale = 1.2)
difference() {
    union() {
        square([10, 10], true);
        translate([-15, 0]) circle(15);
    }
    translate([-15, 0]) circle(8);
    translate([-15, 0]) square([13, 13], center = true);
}

// Example, soft edges
use <fillets2d.scad>;
translate([0, -20, 0])
topBottomFillet(b = 0, t = 10, r = 1, s = 10, e = enable)
linear_extrude(10)
rounding2d(1)
fillet2d(1)
difference() {
    union() {
        square([10, 10], true);
        translate([-15, 0]) circle(15);
    }
    translate([-15, 0]) circle(8);
    translate([-15, 0]) square([13, 13], center = true);
}


// Example, text
translate([-60, 40])
rotate([0, 0, -90])
topBottomFillet(b = 0, t = 3, r = .5, s = 5, e = enable)
linear_extrude(3)
text("Fillets!", size = 20);


// Library

function filletDepth(r, d, i) = r * cos(asin(d * i / r));

module topBottomFillet(b = 0, t = 2, r = 1, s = 4, e = 1) {
    if (e == 1) {        
        topFilletPeice(t = t, r = r, s = s) children(0);
        bottomFilletPeice(b = b, r = r, s = s) children(0);
        
        render()
        difference() {
            children(0);
            
            translate([0, 0, t - r])
            linear_extrude(r + 1)
            offset(delta = 1e5)
            projection()
            children(0);
            
            translate([0, 0, b - 1])
            linear_extrude(r + 1)
            offset(delta = 1e5)
            projection()
            children(0);
            
        }
    }
    if (e == 0) children(0);
}

module topFillet(t = 2, r = 1, s = 4, e = 1) {
    if (e == 1) {
        topFilletPeice(t = t, r = r, s = s) children(0);
        
        render()
        difference() {
            children(0);
            translate([0, 0, t-r])
            linear_extrude(r + 1)
            offset(delta = 1e5)
            projection()
            children(0);
        }
    }
    if (e == 0) children(0);
}

module bottomFillet(b = 0, r = 1, s = 4, e = 1) {
    if (e == 1) {
        bottomFilletPeice(b = b, r = r, s = s) children(0);
        
        render()
        difference() {
            children(0);
            translate([0, 0, b - r - 1])
            linear_extrude(r + 1)
            offset(delta = 1e5)
            projection()
            children(0);
        }
    }
    if (e == 0) children(0);
}

module topFilletPeice(t = 2, r = 1, s = 4) {
    d = r/s;
        
    for (i = [0:s]) {
        x = filletDepth(r, d, i);
        z = d * (s - i + 1);                  
        translate([0, 0, t - z]) 
        linear_extrude(d) 
        offset(delta = -r + x) 
        projection(true) 
        translate([0, 0, -t + z])
        children(0);
    }
}

module bottomFilletPeice(b = 0, r =1, s = 4) {
    d = r/s;
        
    for (i = [0:s]) {
        x = filletDepth(r, d, i);
        z = d * (s - i);
        translate([0, 0, b + z]) 
        linear_extrude(d) 
        offset(delta = -r + x) 
        projection(true)
        translate([0, 0, b - z])
        children(0);
    }
}