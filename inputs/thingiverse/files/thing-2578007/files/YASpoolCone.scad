$fn=120;
Height = 24; // Height of the tappered section (less than 1/2 your spool width
maxDia = 60; 
minDia = 24;
rodDia = 8;  // Mounting rod dia
nCutouts=6; 

nBearings = 0; //0,1,2
BearingOD = 22; 
BearingDepth = 7;

//Avanced
fudge = 0.2; // Allowance for underside holes

// Hidden
// These value are calculated from the user input
stepAngle = 360/nCutouts;
innerCutDia = minDia/nCutouts;
outerCutDia = maxDia/nCutouts;

// Make the Cone
difference(){
  union(){
    cylinder(1,d=maxDia);
    translate([0,0,1]){ cylinder(Height,d1=maxDia,d2=minDia); }
  }
  // Centre rod
  cylinder(Height+1,d=rodDia+fudge);
  // Cutouts for the main cone (if any)
    if(nCutouts > 0){
      for(i=[0:stepAngle:360]){
        rotate(i){
          translate([minDia/2+innerCutDia/2,0,0]){
            hull() {
              translate([maxDia/2-minDia/2,0,0]) cylinder(Height+1,d=outerCutDia);
              cylinder(Height+1,d=innerCutDia);
            }
          }
        }
     }
  }
  // Cutouts for Bearing/s (if any)
  if(nBearings > 0){
    cylinder(BearingDepth,d=BearingOD+fudge);
    if(nBearings == 2) {
      translate([0,0,Height+1-BearingDepth]){ cylinder(BearingDepth,d=BearingOD+fudge); }
    }
  }
}