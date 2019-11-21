/* 
 * Sharp Edge Cover of a Can (v0.2)
 * by https://www.thingiverse.com/3DBobCZ
 * 08/2017
 * This work is licensed under a Creative Commons Attribution 4.0 International License
 */

//--- Setting constants. All units are [mm].

innerDiameter = 93; // Nominal value, measured by a caliper without any gap.  
outerDiameter = 101.3; // Nominal value, must be higher than innerDiameter, measured by a caliper without any gap.
heightWithoutRadius = 12; // Upper radius is automatically generated and added to this value.
wallThickness = 0.8; // Wall thickness of the cover. Your g-code wall thickness could be half of this value. If you have 0.4 mm nozzle, 0.8 mm is a good choice.
dimensionalClearance = 0.25; // Adds clearance to the measured nominal values. This value will be applied to half of nominal diameters => a gap between the printed part and the can on the inner and outer side.

//--- Definition of the profile.

module theOuterProfile(){
    translate([innerDiameter/2-wallThickness-dimensionalClearance,0,0])square([outerDiameter/2-innerDiameter/2+2*wallThickness+2*dimensionalClearance,heightWithoutRadius]);
    translate([innerDiameter/2+((outerDiameter/2-innerDiameter/2)/2),heightWithoutRadius,0])circle(d=outerDiameter/2-innerDiameter/2+2*wallThickness+2*dimensionalClearance,$fn=100);    
}

module theInnerProfile(){
    translate([innerDiameter/2-dimensionalClearance,0,0])square([outerDiameter/2-innerDiameter/2+2*dimensionalClearance,heightWithoutRadius]);
    translate([innerDiameter/2+((outerDiameter/2-innerDiameter/2)/2),heightWithoutRadius,0])circle(d=outerDiameter/2-innerDiameter/2+2*dimensionalClearance,$fn=100);
}

//--- Do it.

rotate_extrude($fn = 100)difference(){theOuterProfile();theInnerProfile();}
