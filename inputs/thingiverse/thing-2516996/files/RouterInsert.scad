// Router Plate Insert
// Gary Liming Summer 2017
BitDiameter = 12.7;        // zero = no hole
LipDepth = 2.286;           // 
OuterDiameter = 57.15;      // overall diameter
RimDiameter = 50.8;
OverallThickness = 7.62;   // how deep of an insert

if (BitDiameter == 0) {
  union() {
    cylinder(h=LipDepth, r=OuterDiameter, $fn=250);
    cylinder(h=OverallThickness, r=RimDiameter, $fn=250);
  }
} else {
 difference() {   
   union() {
     cylinder(h=LipDepth, r=OuterDiameter, $fn=250);
     cylinder(h=OverallThickness, r=RimDiameter, $fn=250);
   }
  cylinder (h=OverallThickness, r= BitDiameter, $fn=250);    
  }
 }