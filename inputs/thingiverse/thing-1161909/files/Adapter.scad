FlangeHeight = 7;
FlangeRadius = 15;
SleeveHeight = 15;
TubingSize = 6.35;
TubingRadius = TubingSize / 2;
SleeveRadius = TubingRadius + 4;
OuterRadius = FlangeRadius + 3.5;
MoldHeight = FlangeHeight + SleeveHeight + 5;
difference() {
cylinder(MoldHeight,OuterRadius,OuterRadius,0);
union() {
translate([0,0,MoldHeight - SleeveHeight - FlangeHeight]){
difference() {
cylinder(SleeveHeight,SleeveRadius,SleeveRadius,0);
    cylinder(SleeveHeight,TubingRadius,TubingRadius,0);
}
}
difference() {
translate([0,0,MoldHeight - FlangeHeight]){
cylinder(FlangeHeight,FlangeRadius,FlangeRadius,0);
}
cylinder(90,TubingRadius,TubingRadius,0);
}
}
}