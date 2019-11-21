/* Basic Cylindrical Knob Generator */

/* It is crude and does no sanity checks - use sensible dimentions */

mainDia = 25; // Diameter of the Knob excluding any Dome - at least 2mm > than Shaft diameter
mainHeight = 20; // Height of the Knob excluding any Dome

shaftLength = 18; // Length of Shaft cutout - should be < mainHeight
shaftDia = 6; // Shaft Diameter
shaftFlat = true; // Flat on the shaft [true:false]
shaftFLength = 9; // Length of the flat - should be <= shaftLength

topDome = true; // Flat or Domed top [true:false]
domeHeight = 2.4; // Height of the Dome centre above the main Knob body

IRef = true; // Indcator Slot [true:false]

// Advanced
allowance = 0.3; // allowance to make hole fit due to printer

// Hidden
$fn=120;


difference(){
  if(topDome == true) {
    union(){
      MainBody(mainHeight,mainDia,shaftLength,shaftDia,shaftFLength,allowance,shaftFlat);
      translate([0,0,mainHeight]){ resize([mainDia,mainDia, domeHeight]) sphere(3); }
    }
  } else {
      MainBody(mainHeight,mainDia,shaftLength,shaftDia,shaftFLength,allowance,shaftFlat);
  }
 // Indicator Slot
  if(IRef == true){
    translate([mainDia/2-6,0,mainHeight-0.6]){ minkowski(){ cube([mainDia/5,.4,domeHeight*.67]); cylinder(.8,d=1); }
    }
  }
}

 
module MainBody(mHeight,mDia,sLength,sDia,sFLength,allowance,sFlat) {
  difference(){
// Main Body
    cylinder(mHeight, d=mDia);
// Shaft cuttout
    if(sFlat == true) {
       difference() {
         cylinder(sLength,d=sDia+allowance);
         translate([sDia/4+allowance,-sDia/2+allowance,sLength-sFLength]) {
           cube([sDia,sDia,sLength-sFLength]); }
       }
    } else {
      cylinder(sLength,d=sDia+allowance/2);
      translate([-sDia/2-1.5,0,0]) cube([sDia+3,0.4,sLength]);
    }
// Hollow the bulk of the Knob out
    difference(){
      cylinder(sLength,d=mDia-2.4);
      cylinder(sLength,d=sDia+allowance+2.4);
    }
  }
}