/* [Parameters] */

// Height of the Easy Zypper
height=5; // [4:10]

// Radius of the normal zypper
radiusZipper=11/2;

// Finger hole radius
radiusFinger=22/2;

// Length of the Easy Zypper
lengthEasyZypper=27;

// Depth value for the normal zypper hole (the less the deeper)
depthZypper=3; // [2:8]

// Rounded corners radius
radiusCorner=1.5;

/* [Hidden] */
xmZipper=radiusZipper-1;
precission=50;
xTightener=2.5;
yTightener=5;
rTightener=5;
xTooth=6;


module easyZypper(){

difference(){
// Body
minkowski(){
hull(){
cylinder(r=radiusZipper+2-radiusCorner, h=height-2*radiusCorner, center=true, $fn = precission); 
translate([lengthEasyZypper,0,0])
cylinder(r=radiusFinger+3, h=height-2*radiusCorner, center=true, $fn = precission); 
}
sphere(r=radiusCorner, $fn = precission);
}
// DIFF 
// Hole for finger
translate([lengthEasyZypper,0,0])
cylinder(r=radiusFinger, h=2*height, center=true, $fn = precission); 

// Zypper
translate([-8,0,depthZypper])
hull(){
cylinder(r=xmZipper, h=height, center=true, $fn = precission); 
translate([12,0,0])
cylinder(r=radiusZipper, h=height, center=true, $fn = precission); 
}

// Tightener
translate([10,0,-0.4]) rotate([90,0,0])
difference(){
cylinder(r=rTightener, h=yTightener, center=true, $fn = precission); 
cylinder(r=rTightener-xTightener, h=2*yTightener, center=true, $fn = precission); 
}


// Tooth hole
translate([lengthEasyZypper+25,0,2.5])
difference(){
cylinder(r=30, h=height, center=true, $fn = precission); 
cylinder(r=30-xTooth, h=2*height, center=true, $fn = precission); 
}}}

easyZypper();


