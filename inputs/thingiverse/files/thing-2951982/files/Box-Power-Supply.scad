/*
This projects contains the complete code for my power supply box. I bought these power supplie, switches, fans and DC power cables at AlieExpress.

Switches: https://nl.aliexpress.com/item/20pcs-Lot-Ship-Switch-Black-Ac250v3a2-Pin-On-Off-Wholesale-I-O-Black-Feet-Boat-Switch/32806570916.html?spm=2114.13010708.0.0.3a994c4dqwjHc9
PSU: https://nl.aliexpress.com/item/DC12V-1A-2A-3A-5A-8-5A-10A-15A-20A-30A-verlichting-Transformers-LED-Driver-Adapter/32677602188.html?spm=2114.13010708.0.0.3a994c4d92GrXb
Fan: https://nl.aliexpress.com/item/2-PCS-LOT-GDT-DC-12V-2P-Brushless-Fan-Cooler-50mm-50x50x20mm-Mute-5020s-Cooling-Heatsink/1820428319.html?spm=2114.13010708.0.0.3a994c4dqwjHc9
DC out cable: https://nl.aliexpress.com/item/1-2m-DC-Jack-Tip-plug-Connector-Cord-Cable-Laptop-Notebook-Power-Supply-Cable-For-Toshiba/32756025862.html?spm=2114.13010708.0.0.3a994c4dAKAI6V

I designed this box in OpenSCAD. I used heat inserted nuts to screw everything together. This is also the reason why you will find some holes in the 
	bottom plate towers and the mounting block at the top part. I bought a cheap soldering iron and heated it up till 250°C to insert the nut inside the PLA.
https://nl.aliexpress.com/item/100pcs-lot-M3-L-D-4-Through-hole-brass-insert-nut-knurled-nuts-for-injection-moulding/32806163767.html?spm=2114.13010708.0.0.3a994c4dDbx6YD

The complete box is bolted together with M3 screws with a flat head.
https://nl.aliexpress.com/item/250pc-set-M3-Cap-Button-Flat-Head-A2-Stainless-Steel-Hex-Socket-Screws-Bolt-With-Hex/32775208136.html?spm=2114.13010708.0.0.3a994c4dZrD8EY

I made this code generic which means everything is recalculated if you change some parameters. (even the gaps inside the walls). 
Furthermore I used 3D tool to check every important parameter of the compete box.
https://www.3d-tool.com/en_free-viewer-download.htm
*/
/**************************************************************************************************************************************
												Parameters
**************************************************************************************************************************************/
// Parameters Switch
SwitchWidth = 8.7;
SwitchLength = 13;

// Parameters Cable
DiaCable = 7;
OutCableWidth = 7;
OutCableLength = 5.8;

// Parameter power supply
PSULength = 110;//85;//110;
PSUWidth = 79;//58;//77;
PSUHeight = 36;//34;//36;

// Mount
MountWidth = 8;
MountLength = 5;
MountHeight = 8;
DiaBolt = 3;
	
// Parameter fan
FanLength = 50;
FanWidth = 50;
FanHeight = 20;
FanDia = 47;
Space = 2.5;
DiaBoltFan = 4.5;
HolePos = FanLength/2 - Space - DiaBoltFan/2;
LengthInsertNut = 5;

// General
Thickness = 2;
$fn = 50;
ExtraSpace = 25;

/**************************************************************************************************************************************
								Calculated parameters
**************************************************************************************************************************************/
// Parameters Box
BoxLength = PSULength + 2 * Thickness + ExtraSpace;
BoxWidth = PSUWidth + 2 * Thickness + 1;
BoxLengthCap = PSULength + Thickness + ExtraSpace;
BoxWidthCap = PSUWidth + 1;
BoxHeight = PSUHeight + FanHeight + 2 + LengthInsertNut /*Height Heat insert nut*/;
NumberGapsX = floor(BoxLength/10)-3;
NumberGapsY = floor(BoxWidth/10);

/**************************************************************************************************************************************
								Functions
**************************************************************************************************************************************/
/*
This function slices gaps in de walls
*/
module gap(){
	hull(){
		rotate([90,0,0])cylinder(d=5, h=Thickness*2, center=true);
		translate([0,0,BoxHeight-20])rotate([90,0,0])cylinder(d=5, h=Thickness*2, center=true);
	}
}

/*
This function generates the mounting cylinders on the bottom plate based on the chosen bolt in the parameterlist.
*/
module Spacer(){
	NutInnerDia1 = DiaBolt+1;
	CylinderHeight1 = 5.5;
	CylinderDia1 = NutInnerDia1 * 2;

	color("grey")translate([0,0,CylinderHeight1/2])difference(){
		cylinder(d=CylinderDia1, h=CylinderHeight1, center=true);	//Cylinder
		cylinder(d=NutInnerDia1, h=CylinderHeight1*1.2, center=true);	// Bolt
		}
}

/*
This function generates the mounting squares on the top plate based on the chosen bolt in the parameterlist.
*/
module Mounting(){
	DiaOuterNut = DiaBolt + 1;
	translate([0,0,MountHeight/2])difference(){
		cube([MountWidth,MountLength,MountHeight], center=true);// Box
		rotate([90,0,0])cylinder(d=DiaOuterNut, h=MountWidth, center=true);//Bolt
	}
}

/*
This function generates the holes that are needed for the fan to let the air through.
*/
module ProtectionFan(FanDia){
	DiaHole = 10;
	intersection(){
		cylinder(d=FanDia, h=2*Thickness, center=true);
		for(n = [0:1:20]){
			for(m = [0:1:20]){
				translate([-(20*DiaHole)/2+n*(DiaHole+1), -(20*DiaHole)/2+m*(DiaHole+1), 0])cylinder(d=DiaHole, h=3*Thickness, center=true);
			}
		}
	}
}

/**************************************************************************************************************************************
								Code
**************************************************************************************************************************************/
BottomBox();
translate([Thickness, 100, 0])TopBox();


// Bottom box 
module BottomBox(){
    cube([BoxLength, BoxWidth, Thickness]);	//Bottom
    // Nut Stumbs
    translate([Thickness+4,(3.5+Thickness+DiaBolt/2),Thickness])rotate([0,0,-45])Spacer();
	translate([110.5,75,Thickness])rotate([0,0,180])Spacer(); // 12V
	translate([Thickness+4,(BoxWidth-2*Thickness-DiaBolt),Thickness])color("green")rotate([0,0,-45])cylinder(d=DiaBolt*2,h=5.5, center=false);
	translate([110.5,(4.5+Thickness+DiaBolt/2),Thickness])color("green")rotate([0,0,-45])cylinder(d=DiaBolt*2,h=5.5, center=false);
	translate([55,BoxWidth/2,Thickness])color("green")rotate([0,0,-45])cylinder(d=DiaBolt*3,h=5.5, center=false);
    //translate([85,55,Thickness])rotate([0,0,180])Spacer();	//5V
 
    // Wall 1
    color("red")difference(){
        cube([BoxLength, Thickness, BoxHeight]);
        for(n = [0:1:NumberGapsX]){
            translate([10+(n*10),Thickness/2,10])gap();
        }
        //bolt Holes
        translate([MountWidth/2+Thickness,0,-MountHeight*.6+BoxHeight])rotate([90,0,0])cylinder(d=DiaBolt, h=MountWidth, center=true);
        translate([BoxLength-MountWidth/2-Thickness,0,-MountHeight*.6+BoxHeight])rotate([90,0,0])cylinder(d=DiaBolt, h=MountWidth, center=true);
    }
    // Wall 2
    color("green")difference(){
        cube([Thickness, BoxWidth, BoxHeight]);
        for(n = [0:1:NumberGapsY-2]){
            rotate([0,0,90])translate([12+(n*10),-Thickness/2,10])gap();
        }
    }
    // Wall 3
    color("purple")translate([0,BoxWidth-Thickness,0])difference(){
        cube([BoxLength, Thickness, BoxHeight]);
        for(n = [0:1:NumberGapsX]){
            translate([10+(n*10),Thickness/2,10])gap();
        }
        //Bolt Holes
        translate([MountWidth/2+Thickness, 0, -MountHeight*.6+BoxHeight])rotate([90,0,0])cylinder(d=DiaBolt, h=MountWidth, center=true);
        translate([BoxLength-MountWidth/2-Thickness, 0, -MountHeight*.6+BoxHeight])rotate([90,0,0])cylinder(d=DiaBolt, h=MountWidth, center=true);
    }
    // wall 4
    color("orange")translate([BoxLength-Thickness,0,0])difference(){
        cube([Thickness,BoxWidth,BoxHeight/2]);
		// Power Cable In
        #rotate([0,90,0])translate([-BoxHeight/2,BoxWidth/4,Thickness/2])cylinder(d=DiaCable, h=Thickness*2, center=true);
		// Switch
        #translate([Thickness/2,3*BoxWidth/4,BoxHeight/2])cube([2*Thickness,OutCableWidth,OutCableLength], center=true);
		// Power Cable Out
		#translate([2, BoxWidth/2, BoxHeight/2])cube([5, SwitchWidth, SwitchLength], center=true);
    }
}

// Top Box
module TopBox(){
    union(){
        difference(){
			union(){
				cube([BoxLengthCap, BoxWidthCap, Thickness]);	//Bottom
				translate([BoxLengthCap/2,BoxWidthCap/2,Thickness]){
					translate([HolePos,HolePos,0])cylinder(d=DiaBoltFan*2, h=Thickness/2, center=true);
					translate([-HolePos,HolePos,0])cylinder(d=DiaBoltFan*2, h=Thickness/2, center=true);
					translate([HolePos,-HolePos,0])cylinder(d=DiaBoltFan*2, h=Thickness/2, center=true);
					translate([-HolePos,-HolePos,0])cylinder(d=DiaBoltFan*2, h=Thickness/2, center=true);
					}
				}
            // Fan
            translate([BoxLengthCap/2,BoxWidthCap/2,Thickness/2]){
                ProtectionFan(FanDia);
                // Fan holes
                translate([HolePos,HolePos,0])cylinder(d=DiaBoltFan, h=3*Thickness, center=true);
                translate([-HolePos,HolePos,0])cylinder(d=DiaBoltFan, h=3*Thickness, center=true);
                translate([HolePos,-HolePos,0])cylinder(d=DiaBoltFan, h=3*Thickness, center=true);
                translate([-HolePos,-HolePos,0])cylinder(d=DiaBoltFan, h=3*Thickness, center=true);
            }
        }
        // Wall
        translate([BoxLengthCap-Thickness,0,0])difference(){
            cube([Thickness, BoxWidthCap, BoxHeight/2]);
			// Power Cable In
            #translate([Thickness/2, 3*BoxWidth/4-Thickness, BoxHeight/2])rotate([0,90,0])cylinder(d=DiaCable, h=Thickness*2, center=true);
            // Power switch
			#translate([Thickness/2, BoxWidth/4-Thickness, BoxHeight/2])cube([2*Thickness,OutCableWidth,OutCableLength], center=true);
			// Power Cable Out
			#translate([2, BoxWidthCap/2, BoxHeight/2])cube([5, SwitchWidth, SwitchLength], center=true);
        }
        // Mounting squares
        color("red")rotate([0,0,180])translate([-MountWidth/2,-MountLength/2,Thickness/2])Mounting();
        color("green")translate([MountWidth/2,BoxWidthCap-MountLength/2,Thickness/2])Mounting();
        color("purple")rotate([0,0,180])translate([-BoxLengthCap+MountWidth/2+Thickness,-MountLength/2,Thickness/2])Mounting();
        color("orange")translate([BoxLengthCap-MountWidth/2-Thickness,BoxWidthCap-MountLength/2,Thickness/2])Mounting();
    }
}


