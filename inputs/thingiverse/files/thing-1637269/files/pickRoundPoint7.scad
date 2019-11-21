/* [Pick Dimensions in mm] */
// Length
pickLength=82;
// Width
pickWidth=8;
// Depth
pickDepth=.7;
// Rotation
pickRotation = 10;

/* [Handle Dimensions in mm] */
// Length
length=85;
// Width
width=15;
// Depth
depth=4.5;
// Top scale. 0-100. The percent  of handle width at the pick end of the tool.
topScalePercent=75;
// The middle focal percent. 0-100. The pick is generated with the midle point at 100% of pick width, but where this takes place is controllable. 
middleFocalPercent=12.5;
// Bottom scale. 0-100. The percent of handle width at the butt.
bottomScalePercent=75;
// Number of sides. 3 is triangular, 4 square, and so on. Try 200 for "smooth". Make sure your handle contains the picks!
sides=6;

// Smoothing.
minkowski=true;
// Smoothing radius. This is additive to the outside dimensions of your pick, you can subtract off of your handle to compensate, but your base pick cannot be less than zero an any dimension.
minkowskiSize=2;
// Smoothing "roundness". 4-15 suggested, more is probably overkill...
minkowskiRoundness=15;

/* [Hidden] */
topScale=topScalePercent * .01;
middleFocal=length * (middleFocalPercent * .01);
bottomScale=bottomScalePercent * .01;

module rawPick() {
  rotate_extrude($fn=sides) {
    rotate([180, 0, 90]){ 
      polygon(points=[
        [0,0],
        [0, width/2*topScale],
        [middleFocal, width/2],
        [length, width/2 * bottomScale],
        [length, 0]
      ]);
    }
  }  
}

module softPick() {
  translate([minkowskiSize, 0,0]) {
    difference() {
      $fn=minkowskiRoundness;
      minkowski(){      
        rotate([90, 0, 90]){
          rawPick();
        }
        sphere(r=minkowskiSize);
      }
      
      translate([-minkowskiSize,-pickDepth/2,-pickWidth/2]) {
        cube([pickLength + minkowskiSize, pickDepth, pickWidth], false);
      }
    }
  }
}

module hardPick() {
  difference() {
    rotate([90, 0, 90]){
      rawPick();
    }
   
    translate([-minkowskiSize,-pickDepth/2,-pickWidth/2]) {
      cube([pickLength + minkowskiSize, pickDepth, pickWidth], false);
    }
  }
}

rotate([90,270,0]) {
  if(minkowski==true){
    softPick();
  } else {
    hardPick();
  }
}