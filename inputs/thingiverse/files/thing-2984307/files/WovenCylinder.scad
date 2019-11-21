/**
WovenCylinder.scad

This scad model creates a cylinder in a mat weave shape, suitable for rings, napkin holders, etc.
Typically, you would not use this shape as-is, but you would remix it with other shapes to create a 
decorative embossing on a cylinder form.

The weave is a sine wave, not a true mat weave.

*/

/* [Overall Size] */

// height of the weave pattern, measured from the center of the weave shape. The actual height will be this plus the vertical diameter of the weave 
height = 10;

// diameter of the cylinder, measured from the middle of the weave. The actual inner and outer diamters  will include the horizontal diameter of the weave and the weave depth
diameter = 20; 

/* [Weave] */

// Number of times the weave turns around the cylinder
weaveTurns = 4;
// Number of times the weave goes up and down. Should be relatively prime to weaveTurns
weaveOscillations = 7;
// The vertical thickness of the weave strand
weaveVthickness = 3;
// the horizontal depth of the weave strand
weaveDthickness = 2;
// number of faces on the weaveStrand - square, triangular, lots cicular
weaveStrandFn = 9;
// number of times the strand twists in total
weaveStrandTwist = 0; 
// initial rotation of the strand section - useful when the strand twist is zero
weaveStrandTwistInit = 0; 

// the amount by which the weave wiggles in and out as it goes around. If this is not zero, 
weaveDWiggle = 1;
// an amount by which the wiggle dips and rises earlier - it's difficult to describe. 180 will give you a weave with opposite sense
weaveWiggleOffset = 0;
// total number of steps in the weave. Raising this gives a smoother shape that takes longer to compute
weavePrecision = 120;

/* [Supporting Ring] */

// add a cylinder to support the weave shape. Use 'no' if you want to just get the weave itself for remixing.
addSupportingRing = 0; // [1:Yes, 0:No] 
supportingRingDiameter = 20;
supportingRingHeight = 15;
// supporting ring and central hole face number
supportingRingFn = 60; // number of faces for the supporting ring

// add a hole in the center, clipping the weave and supporting ring.
addCentralHole = 1; // [1:Yes, 0:No] 
// diameter of the hole. If there is a supporing ring, this will leave a 2mm ring thickness, otherwise it will cut through the center of the weave
centralHoleDiameter = 18;

/* [Hidden] */
crossings = weaveOscillations * (weaveTurns-1);

difference() {
  union() {
    weave();
    if(addSupportingRing==1) {
      cylinder(d = supportingRingDiameter, h = supportingRingHeight, center = true, $fn = supportingRingFn);
    }
  }
  if(addCentralHole==1) {
    cylinder(d = centralHoleDiameter, h=max(height, supportingRingHeight)*2,  center = true, $fn = supportingRingFn);
  }
}

module weave() {
  for(th=[0:360/weavePrecision:360-1e-6]) {
    hull() {
      weaveAt(th);
      weaveAt(th + 360/weavePrecision);
    }
  }  
}

module weaveAt(th) {
    rotate(th*weaveTurns, [0,0,1])
    translate([
      0, 
      weaveDWiggle*sin(th*crossings+weaveWiggleOffset),
      sin(90+th*weaveOscillations)*height/2])
    translate([0,diameter/2,0])
    rotate(90, [0,1,0])
    linear_extrude(height=.1)
    scale([weaveVthickness,weaveDthickness, 1])
    rotate(weaveStrandTwistInit + weaveStrandTwist * th, [0,0,1])
    circle(d=1, $fn = weaveStrandFn);
    
}
