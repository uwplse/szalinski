// Router Plate Insert
// Gary Liming Summer 2017
InchBitDiameter = .500;        // zero = no hole
InchLipDepth = .090;           // 
InchOuterDiameter = 2.25;      // overall diameter
InchRimDiameter = 2.00;
InchOverallThickness = .300;   // how deep of an insert

BitDiameter = 25.4 * InchBitDiameter;  // convert imperial to metric
LipDepth = 25.4 * InchLipDepth;
OuterDiameter = 25.4 * InchOuterDiameter;
RimDiameter = 25.4 * InchRimDiameter;
OverallThickness = 25.4 * InchOverallThickness;

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