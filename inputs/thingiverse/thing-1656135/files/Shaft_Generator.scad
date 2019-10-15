/*[Basic Shaft dimensions]*/

//Type of shaft:
ShaftType = "Hex"; //[Hex, Round]
//Total length of the shaft:
TotalLength = 10;
//The size of the shaft:
ShaftSize = 0.5;

/*[Snap Rings]*/

//Turns snap ring grooves on or off:
Snapring = "On"; //[On, Off]
//Distance between inside edges of both snap rings (Same as total length if you do not want snap rings):
InsideLength = 9.875;


/*[Encoders]*/

//Turns Encoder holes on or off:
EncoderHoles = "On"; //[On, Off]
//Toggle between encoder holes on both sides, or only on one:
BothSides = "On"; //[On, Off]
//Depth of the hole for your encoder:
EncoderHoleDepth = .375;
//Diameter of the shaft of your encoder:
EncoderShaftDiameter = .25;

/*[hidden]*/
GrooveDepth = ShaftSize/31.25;
GrooveWidth = ShaftSize/12.075;
SnapRingOffset = (TotalLength - InsideLength);

module Shaft() {
    if (ShaftType == "Hex") {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4])
            cylinder(h=TotalLength, d=ShaftSize, $fa=60, center = true);
        }
    else if (ShaftType == "Round") {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4])
            cylinder(h=TotalLength, d=ShaftSize, $fn = 60, center = true);
        }
    }
module EncoderHole() {
    if(EncoderHoles == "On") {
        difference() {
            Shaft();
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, TotalLength/2])
                cylinder(h = EncoderHoleDepth, d = EncoderShaftDiameter, $fn = 60, center = true);
            if(BothSides == "On") {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, -TotalLength/2])
                cylinder(h = EncoderHoleDepth, d = EncoderShaftDiameter, $fn = 60, center = true);
        }
        }  
    }
}

module  Grooves(){
    if (Snapring == "On"){
        difference() {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, TotalLength/2-SnapRingOffset])
                cylinder(h = GrooveWidth, d = ShaftSize, $fn = 60, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, TotalLength/2-SnapRingOffset])
                cylinder(h = GrooveWidth, d = ShaftSize-GrooveDepth, $fn = 60, center = true);
        }
        difference() {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, -TotalLength/2+SnapRingOffset])
                cylinder(h = GrooveWidth, d = ShaftSize, $fn = 60, center = true);            
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0, -TotalLength/2+SnapRingOffset])
                cylinder(h = GrooveWidth, d = ShaftSize-GrooveDepth, $fn = 60, center = true);
        }
}
}
    difference() {
    EncoderHole();
    Grooves();
        }