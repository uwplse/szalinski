//$fn=64;

// Name for Mid-Area
Name = "Test";

// Shifting Text Left or Right
NX_Axis = 70; // [0:1:180]

// Shifting Text Up or Down
NY_Axis = 45; // [0:1:100]

// Font Size
NFontSize = 10; //[5:1:26]

// Text for Top Text
Top = "Mobility Worldwide TX-Austin";

TX_Axis = 5; //[0:1:180]

// Shifting Text Up or Down
TY_Axis = 80; // [0:1:100]

// Font Size
TFontSize = 9; //[5:1:26]

// Text for Bottom Text
Bottom = "RecognizeGood";

BX_Axis = 35; //[0:1:180]

// Shifting Text Up or Down
BY_Axis = 10; // [0:1:100]

// Font Size
BFontSize = 10; //[5:1:26]
// End Parameters for Customizer

// Start Module
LicensePlate();

module LicensePlate(){
    difference(){
        //Create Base
        //cube( [180,100,5]);
        xdim = 180;
        ydim = 100;
        zdim = 5;
        rdim = 5;
        hull(){
            translate([rdim,rdim,0])cylinder(r=rdim,h=zdim);
            translate([xdim-rdim,rdim,0])cylinder(r=rdim,h=zdim);
            
            translate([rdim,ydim-rdim,0])cylinder(r=rdim,h=zdim);
            translate([xdim-rdim,ydim-rdim,0])cylinder(r=rdim,h=zdim);
        }
        
        //Create screw opening
        translate([6,6,-1]){
            cylinder(7, 2.5, 2.5, false);
        }

        translate([6,94,-1]){
            cylinder(7, 2.5, 2.5, false);
        }
                
        translate([174,6,-1]){
            cylinder(7, 2.5, 2.5, false);
        }
                
        translate([174,94,-1]){
            cylinder(7, 2.5, 2.5, false);
        }
    }
    union(){    
        linear_extrude(height=10)translate([TX_Axis,TY_Axis])text("Mobility Worldwide, TX-Austin",font="Century Gothic:style=Regular",size=TFontSize);

        linear_extrude(height=10)translate([NX_Axis,NY_Axis])text(Name,font="Century Gothic:style=Regular",size=NFontSize);

        linear_extrude(height=10)translate([BX_Axis,BY_Axis])text(Bottom,font="Century Gothic:style=Regular",size=BFontSize);
    }
}