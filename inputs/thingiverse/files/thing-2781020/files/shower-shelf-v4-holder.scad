t = 3;
w = 150;
h = 70;
l = 1;
// Radius of bead along joints
bead = l * t;
// Radius of front bead along joints
bead2 = t/4 * t;
// epsilon to prevent problems with coincident planes
eps = 0.01;
 union() {
     translate([0,w/2,0]) rotate([90,0,0]) cylinder(h=w-eps,r=bead,center=true); 
    // translate([t/2,w/2,h]) rotate([90,0,0]) cylinder(h=w-eps,r=bead2,center=true); 
cube([t,w,h]);
 }