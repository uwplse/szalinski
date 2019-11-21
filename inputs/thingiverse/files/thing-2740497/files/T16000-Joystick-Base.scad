//Thrustmaster T16000 Joystick mounting plate

//Used to mount a T16000 Joystick to a wire shelving rack used as a lap-basd HOTAS setup

// (C) CC BY-SA 2017 by Vincent S. Chernesky under a Creative Commons - Attribution - Sharealike License

StartPosition =11;// Adjust where the first wire is relative to the Y axis
wireSpacing=203/8;//Adjust to the distance between your wires, mine was a little more than 25mm between wires
PlateLength=180;//Length of Plate
PlateWidth=100;//Width of Plate
PlateHeight=5;//Height of Plate
WireDiameter=3.5;//Diameter of your wire, I added 1mm to the width of the wire (2.5mm) to add some 'give' to the fitment
HoleDiameter=6;//M6 screw diameter
union(){
    difference(){
        //Baseplate
        cube(size=[PlateWidth,PlateLength,PlateHeight],center=false);
        //First rod cutout
        rotate([90,0,0])
        translate([StartPosition,0,-PlateLength/2])
        cylinder(h=180,d=WireDiameter,center=true);
        //second rod cutout
        rotate([90,0,0])
        translate([StartPosition+wireSpacing,0,-PlateLength/2])
        cylinder(h=PlateLength,d=WireDiameter,center=true);
        //Third rod cutout
        rotate([90,0,0])
        translate([StartPosition+(2*wireSpacing),0,-PlateLength/2])
        cylinder(h=PlateLength,d=WireDiameter,center=true);
        //Fourth rod cutout
        rotate([90,0,0])
        translate([StartPosition+(3*wireSpacing),0,-PlateLength/2])
        cylinder(h=PlateLength,d=WireDiameter,center=true);
        //First Screw Hole
        translate([25,10,0])
        cylinder(h=PlateHeight,d=HoleDiameter,center=false);
        //Second Screw Hole
        translate([25+50,10+156.6,0])
        cylinder(h=PlateHeight,d=HoleDiameter,center=false);
        
    }
}
