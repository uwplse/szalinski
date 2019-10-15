//Thrustmaster T16000 Throttle mounting plate

//Used to mount a T16000 Throttle to a wire shelving rack used as a lap-basd HOTAS setup

// (C) CC BY-SA 2017 by Vincent S. Chernesky under a Creative Commons - Attribution - Sharealike License

StartPosition =4; // Adjust where the first wire is relative to the Y axis
HoleStartPosition=16;//Adjust where the screw holes are relative to the Y axis
wireSpacing=203/8;//Adjust to the distance between your wires, mine was a little more than 25mm between wires
PlateLength=160;//Length of Plate
PlateWidth=185;//Width of Plate
PlateHeight=5;//Height of Plate
WireDiameter=3.5;//Diameter of your wire, I added 1mm to the width of the wire (2.5mm) to add some 'give' to the fitment
HoleDiameter=6; //M6 screw diameter

union(){
    difference(){
        //Baseplate
        cube(size=[PlateWidth,PlateLength,PlateHeight],center=false);
        //First rod cutout
        rotate([90,0,90])
        translate([StartPosition,0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Second rod cutout
        rotate([90,0,90])
        translate([StartPosition+wireSpacing,0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Third rod cutout
        rotate([90,0,90])
        translate([StartPosition+(2*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Fourth rod cutout
        rotate([90,0,90])
        translate([StartPosition+(3*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Fifth rod cutout
        rotate([90,0,90])
        translate([StartPosition+(4*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Sixth rod cutout
        rotate([90,0,90])
        translate([StartPosition+(5*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Seventh rod cutout
        rotate([90,0,90])
        translate([StartPosition+(6*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //Eigth rod cutout
        rotate([90,0,90])
        translate([StartPosition+(7*wireSpacing),0,PlateWidth/2])
        cylinder(h=PlateWidth,d=WireDiameter,center=true);
        //First Screw Hole
        translate([HoleStartPosition+150,10,0])
        cylinder(h=PlateHeight,d=HoleDiameter,center=false);
        //Second Screw Hole
        translate([HoleStartPosition,10+130,0])
        cylinder(h=PlateHeight,d=HoleDiameter,center=false);
        
    }
}
