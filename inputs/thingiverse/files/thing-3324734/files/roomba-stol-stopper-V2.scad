/* [Dimensions] */
// The width of the table leg this is going around
width = 52; //[40:100]
// The height of the table leg this is going around
height = 23; // [20:60]
// How thick you want the bumper to be
depth = 10; //[5:20]
// how much bigger to make the bumper than the leg
wallthickness = 8; //[5:22]

/* [Hidden] */
// used to make sure that cutouts do not exactly line up with the surface
// that they are removing. 
// To see the effect changing this to 1.01 should have no effect on the final product
small=0.01;

module ben() {
    cube([width, depth+2*small, height]);
}

//!ben();


module stopper() {
    cube([width + 2*wallthickness, depth, height + 2 * wallthickness]);
}
//!stopper();

difference() {
    stopper();
    translate([wallthickness, -small, wallthickness]) ben();
    translate([wallthickness+width/2-width/3/2, -small, -small]) cube([width/3, depth+2*small, wallthickness+2*small]);
}