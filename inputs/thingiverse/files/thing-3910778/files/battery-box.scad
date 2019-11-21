/* added some info for Thingiverse Customizer */

// Engraving on side
e = "BLN-1";

// Battery Length
l = 51;

// Battery Width
w = 36.5;

// Battery Height
h = 16.0;

// Number of Batteries
n = 3;

// Thickness of Walls
t = 3;

// Finger cutout size
f = 23;

// Size of eject hole (in case they get stuck)
x = 3;

/* [Hidden] */
$fn=40;

difference() {
    minkowski() {
        cube([l,(w+t)*n-t,h]);
        sphere(r=t);
    }

    for (i = [0:n-1]) {
        translate([0,(w+t)*i,0]) {
            cube([l+t*2,w,h]);
        }
        if (x>0) {
            translate([-t,(w+t)*i+w/2,h/2])
            rotate([0,90,0])
                cylinder(d=x,h=t*3,center=true);
        }
        if (w > f) {
            translate([l+t,(w+t)*i+w/2,h/2])
                cylinder(d=f, h=h+t*4, center=true);
        }
    }
    if (h>f) {
        translate([l+t,(w+t)*n/2,h/2]) rotate([90,0,0]) cylinder(d=f, h=(w+t)*n+3*t, center=true);
    }
    if (e) {
        translate([t,t,-t+1]) rotate([180,0,90])
           linear_extrude(t) text(e, font="Comfortaa:style=Regular");
    
    }
}
