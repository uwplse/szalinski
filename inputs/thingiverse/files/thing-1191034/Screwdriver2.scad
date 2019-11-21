$fn = 60;
// Overall radius (half the diameter) of the screwdriver.
bodywidth = 14;
// Spacing of the scalloped cutouts.  Smaller for a deeper cut.
scalspc = 15;
// Face-face diameter of the hex bit; 1/4" is 6.35mm.  Give it a little extra if your printer prints holes tight.
shaftWidth = 6.7;
// Face-face diameter of the hex bit.
bitwidth = 6.7;
bitheight = 32;
hexwidth = bitwidth / pow(3,.5);
hexShaft = shaftWidth / pow(3,.5); 
//module mainbody(scalspc) {
module bits(bitwd,bitht) {
    for (numb = [0:5]) {
    // Makes the hex bit cutouts
    rotate([0,0,60*numb])
    translate([9.5,0,0]) rotate([0,0,30]) cylinder (bitht, bitwd, bitwd, $fn=6); 
    // makes the holes for bit-retaining magnets.    
    rotate([0,0,60*numb]) translate([9,0,0]) rotate([0,0,30]) cylinder (33,1.59,1.59); } 
}
    
difference() {
// Main screwdriver body.
cylinder(95, bodywidth,bodywidth);
    // Chuck storage cutout.
    cylinder(40,5.25,5.25);
    // Chuck retaining magnet cutout.
    cylinder (95,2.38,2.38);
    // next part makes the six scalloped cutouts in the handle
    for (numb = [0:5]) {
     rotate([0,0,60*numb])    
    translate([scalspc,0,0]) cylinder (95,4,4); }
    // Hex cutout for the main drive
    translate([0,0,70]) cylinder(25,hexShaft, hexShaft, $fn=6);
    // Hex cutout for storage in the handle; note it's a little looser.
    translate([0,0,40]) cylinder(25,hexShaft*1.05, hexShaft*1.05, $fn=6);   
    // Ring cutout towards the business end of the handle. 
    translate([0,0,84.5]) rotate_extrude(convexity=12) translate([14,0,0]) circle(r=6.25);
    // This calls the bits module
    bits(hexwidth,bitheight);   
    // This makes the rounded butt-end. 
    difference() {
        cube (size = [30,30,12], center = true);
        translate([0,0,32]) sphere (32);        
        }
}
