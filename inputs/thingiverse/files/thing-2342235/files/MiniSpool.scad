//  Mini Filament spool for small filament samples

// Number of fragments in render = slow but pretty
//$fn=150; 

// Variables
// Spool outer radius
SpoolRadius = 25;
// Height of inner hub
HubHeight = SpoolRadius / 1.5;
// Radius of hole through spool
HubInnerRadius = 4;
// Thickness of inner hub wall
HubWallThickness = 2;
// Radius of outer edge of hub
HubOuterRadius = HubInnerRadius + HubWallThickness;
// Thickness of cone wall
ConeWallThickness = 2;
// Offset of cone from origin (Z axis)
OuterConeOffset = SpoolRadius / 20;
// Offset of inner cone (inner cone is subtracted from outer cone)
InnerConeOffset = OuterConeOffset + ConeWallThickness;
// Offset of large holes
LargeHoleOffset = HubOuterRadius + (SpoolRadius - HubOuterRadius) / 2;
// Radius of large holes
LargeHoleRadius = (SpoolRadius - HubOuterRadius)/3;
// Percentage of spool radius at which to place the anchor holes
FilamentAnchorHoleOffsetPercent = .825;
// Offset of filament anchor holes
FilamentAnchorHoleOffset = HubOuterRadius + (SpoolRadius - HubOuterRadius) * FilamentAnchorHoleOffsetPercent;
// Filament anchor hole radius
FilamentAnchorHoleRadius = 1.55;
// Thickness of  bottom flat plate
BottomPlateHeight = 2;

// Central hub
difference(){
    cylinder(h=HubHeight, r=HubOuterRadius);
    cylinder(h=HubHeight, r=HubInnerRadius);
};

// Top cone
difference() {
    // Outer cone
    translate(v=[0,0,OuterConeOffset]) { 
        cylinder(h=SpoolRadius, r1=1, r2=SpoolRadius); 
    };
    // Inner cone
    translate(v=[0,0,InnerConeOffset]) { 
        cylinder(h=SpoolRadius, r1=1, r2=SpoolRadius); 
    };
    // Hub hole throught cone
    cylinder(h=SpoolRadius, r=HubInnerRadius);
}
    
// Bottom plate
difference(){
    // Bottom plate
    cylinder(h=2,r=SpoolRadius);
    // Large holes
    for(i=[0:3]) {
        rotate(i * 90) {
            translate([LargeHoleOffset,0,0]) {
                cylinder(h=BottomPlateHeight,r=LargeHoleRadius);
            };
        };
    };
    // Filament anchor holes
    for(i=[0:3]) {
        rotate(i * 90 + 45) {
            translate([FilamentAnchorHoleOffset,0,0]) {
                cylinder(h=BottomPlateHeight,r=FilamentAnchorHoleRadius);
            };
        };
    };
    // Inner filament anchor hole
    rotate(45) {
        translate(v=[HubOuterRadius + FilamentAnchorHoleRadius,0,0]) {
            cylinder(h=BottomPlateHeight,r=FilamentAnchorHoleRadius);
        };
    };
    // Hub hole throught bottom plate
    cylinder(h=SpoolRadius, r=HubInnerRadius);   
};