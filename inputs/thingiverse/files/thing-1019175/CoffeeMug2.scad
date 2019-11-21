// "Fragments" or fineness. Higher = smoother
$fn = 60;
// Rounding of the bottom, radius in mm.
cornd=10;  // 
// Height of the cup in mm
ovrht = 115; 
// Major radius of the cup in mm.
cupwd = 41; 
// Width of the wall  in mm.
cupwal = 4; 
// Thickness of handle in mm.
handlr = 5.25; 
cornerd = min(cornd,cupwd/2); // Bad things happen if you try to round the bottom too much!
cupht = ovrht - cornerd - cupwal*.5; // cup height adjusted for other features
/* The next functions make a primitive coffee cup from two cylinders and a torus.  */
module cupprim(h1,r1,rc) {
 cylinder(h1,r1,r1); rotate_extrude (convexity=10) translate ([r1-rc,0,-rc/2]) circle (r=rc); translate ([0,0,-rc]) cylinder(rc,r1-rc,r1-rc);
}  
// This makes the top rim rounded.
translate ([0,0,cupht]) rotate_extrude (convexity=10) translate([cupwd-cupwal/2,0,0]) circle (r=cupwal/2);
/* scale([1,1,.5]) sphere(r1);
}*/
/* Next, we use difference() function to subtract a smaller primitive from a bigger one to make a shell.*/
difference () {cupprim(cupht,cupwd,cornerd); translate ([0,0,cupwal]) cupprim(cupht+.1,cupwd-cupwal,cornerd);
    }     
// Let's make the handle a torus
difference () {
     rotate (a=90, v=[1,0,0]) {
    translate 
        ([cupwd,.5*cupht,0]) scale([.75,1,1.75]) rotate_extrude(convexity=12)    translate([.4*cupht,0,0]) circle(r=handlr) ; 
}       translate ([0,0,cupwal]) cupprim(cupht,cupwd-cupwal,cornerd);
}