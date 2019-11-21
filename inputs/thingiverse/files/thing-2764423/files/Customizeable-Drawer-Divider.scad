//!OpenSCAD

//The length of the divider
Divider_Length = 140;
//Wether to create a linear connector on the left/top end
Left_Top_Connector = true;
//Wether to invert the left/top connector
Left_Top_Connector_Inverted = false;
//Wether to create a linear connector on the right/bottom end
Right_Bottom_Connector = true;
//Wether to invert the right/bottom connector
Right_Bottom_Connector_Inverted = true;
//The positions to create a slit of Divider_Thickness width for perpendicular connections at
Positions_Connectors = [35, 70, 105];

//The height of the divider
Divider_Height = 50;
//The thickness of the divider (Should give an even number if diveded by layer height)
Divider_Thickness = 1.2;
//The length of overlap regions for connecting
Overlap_Length = 20;
//The diameter of the holes and knobs for connecting (Sould be smaller than Overlap_Length
Diameter_Connectors = 10;
//The amount of connectors per overlap region (Must be smaller than Divider_Height divided by Diameter_Connectors
Amount_Connectors = 2;
//Wether to ignore problems that could result in a failing print
Ignore_Problems = false;

//Circle Resolution
$fn = 32;

//Internal Calculations
Reduced_Divider_Length = Divider_Length - (Left_Top_Connector ? Overlap_Length / 2 : 0) - (Right_Bottom_Connector ? Overlap_Length / 2 : 0);
Left_Top_Offset = Left_Top_Connector ? Overlap_Length / 2 : 0;

if (!Ignore_Problems
    && (   (Overlap_Length < Diameter_Connectors)
        || ((Divider_Height / Diameter_Connectors) < Amount_Connectors)
        )
    )
    translate([0, Divider_Height, 0])
        text("Warning! Print might not give a good result", halign="center", valign="center");
difference() {
    cube([Reduced_Divider_Length, Divider_Height, Divider_Thickness], center=true);
    
    for (x = Positions_Connectors)
        translate([-Reduced_Divider_Length/2+x-Left_Top_Offset, Divider_Height/4, 0])
            cube([Divider_Thickness, Divider_Height/2, Divider_Thickness], center=true);
}

if (Left_Top_Connector) {
    translate([-(Reduced_Divider_Length+Overlap_Length)/2, 0, 0]) {
        if (Left_Top_Connector_Inverted)
            mirror([0,0,1])
                Connector();
        else
            Connector();
    }
}

if (Right_Bottom_Connector) {
    translate([(Reduced_Divider_Length+Overlap_Length)/2, 0, 0]) {
        rotate([180,0,0]) {
            if (Right_Bottom_Connector_Inverted)
                mirror([0,0,1])
                    Connector();
            else
                Connector();
        }
    }
}

module Connector() {
    union(){
        difference(){
            translate([0, 0, -Divider_Thickness/4])
                cube([Overlap_Length, Divider_Height, Divider_Thickness/2], center=true);
            
            for (i = [0 : 2 : Amount_Connectors - 1])
                translate([0, -Divider_Height/2 + ((i+0.5)*Divider_Height/Amount_Connectors), -Divider_Thickness/4])
                    cylinder(h=Divider_Thickness/2, r1=(Diameter_Connectors-Divider_Thickness/2)/2, r2=(Diameter_Connectors+Divider_Thickness/2)/2, center=true);
        }
        
        for (i = [1 : 2 : Amount_Connectors - 1])
                translate([0, -Divider_Height/2 + ((i+0.5)*Divider_Height/Amount_Connectors), Divider_Thickness/4])
                    cylinder(h=Divider_Thickness/2, r1=(Diameter_Connectors+Divider_Thickness/2)/2, r2=(Diameter_Connectors-Divider_Thickness/2)/2, center=true);
    }
}