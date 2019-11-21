//===================================================//
// Simplified, FDM 3D printable ATLAS model
// Based on the ATLAS TDR:s from mid 1990:s
//
// Written by Henrik Åkerstedt (Stockholm University)
// with invaluable assistance from Sam Silverstein
//
// This documentation describes Open Hardware and is licensed under the CERN OHL v. 1.2.
// You may redistribute and modify this documentation under the terms of the
// CERN OHL v.1.2. (http://ohwr.org/cernohl). This documentation is distributed
// WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY,
// SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE.
// Please see the CERN OHL v.1.2 for applicable conditions
//
//
// Version history
//
// 1.0 - Feature complete. Made outer muon barrel extractable (via flag), added colors, fixed MirrorDupCut-bug
// 0.12 - Modified global variables for thingiverse customizer, removed endcap dxf dependancy
// 0.11 - Increased tolerences of the feet assembly and outer spectrometer
// 0.10 - Made part settings more modular and implemented arbitrary cut angle to MirrDupCut
// 0.9 - All parts are exportable as STLfree. Added 
// 0.8 - Removed muon tiles (inner barrel) intersecting with tile rails. Added rail support for endcap magnet.
// 0.7 - Changed MirrorDupCut to mirror along Z instead of rotate Y-axis. Added Tile rail support and muon system options
// 0.6 - Improved TRT, LAr, EndCap and FCal
// 0.5 - Added fingers and rendering options for Tile to render LongBarrel or ExtendedBarrel
// 0.4 - Added defaultRes option to limit number of faces
// 0.3 - Added rendering options for feet (CERNFeet("RTB") is used to render Rail, Top and Feet respectively)
// 0.2 - Added holes in muon part BO and BI to allow for feet
// 0.1 - Initial release
//===================================================//

/* [Global] */
// preview[view:north east, tilt:top diagonal]
/* [General settings] */
// Scale parameter, set to 1 for full scale, 200 fits Ultimaker 3D printer
modelScale = 200;

// Enables wedge cutout
Cut = 1; // [-1:Off,1:On]

//Enable to output printable parts
Print_Flag = 0; // [0:Off,1:On]

Inner_Detector = 1; // [0:Off,1:On]
Calorimeters = 1; // [0:Off,1:On]
Magnets = 1; // [0:Off,1:On]
Muon_Spectrometer = 1; // [0:Off,1:On]
Feet = 1; // [0:Off,1:On]

/* [Inner Detector] */
Beam_Pipe = 1; // [0:Off,1:On]
Pixel = 1; // [0:Off,1:On]
SCT = 1; // [0:Off,1:On]
//Only TRT is printable, other parts are disabled if "Print Flag" is on.
TRT = 1; // [0:Off,1:On]

/* [Calorimeters] */
LAr = 1; // [0:Off,1:On]
HEC = 1; // [0:Off,1:On]
FCal = 1; // [0:Off,1:On]
Tile_Barrel = 1; // [0:Off,1:On]
Extended_Barrel = 1; // [0:Off,1:On]
Tile_Rails = 1; // [0:Off,1:On]

/* [Magnets] */
Central_Solenoid = 1; // [0:Off,1:On]
Barrel_Toroid = 1; // [0:Off,1:On]
End_Cap = 1; // [0:Off,1:On]

/* [Muon Spectrometer] */
Inner_Barrel = 1; // [0:Off,1:On]
Outer_Barrel = 1; // [0:Off,1:On]
Fixed_Barrel = 1; // [0:Off,1:On]
Middle_Wheel = 1; // [0:Off,1:On]
Small_Outer_Wheel = 1; // [0:Off,1:On]
Large_Outer_Wheel = 1; // [0:Off,1:On]
Forward_Shield = 1; // [0:Off,1:On]

// Available parts:
//BeamPipe
//InnerDetector		"PST"		Pixel Sct Trt
//Calorimeters		"LHFTER"		Lar Hadronic-endcap Forward Tile Extended-tile Rail(only)
//MagnetSystem		"CBE"		Central Barrel Endcap
//MuonDetector		"IOMSLF"		Inner-barrel Outer-barrel Middle-wheel Small-outer-wheel Large-outer-wheel Forward-shield
//CERNFeet			"RTB"		Rail Top Bottom

/* [Hidden] */
idStr = (str((Pixel==1 && Print_Flag==0) ? "P" : "",(SCT==1 && Print_Flag==0) ? "S" : "",TRT==1 ? "T" : ""));
emCalStr = (str(LAr==1 ? "L" : "",HEC==1 ? "H" : "",FCal==1 ? "F" : ""));
hadCalStr = (str(Tile_Barrel==1 ? "T" : "",Extended_Barrel==1 ? "E" : "",(Tile_Rails==1 && Print_Flag==0) ? "R" : ""));
//magStr = (str(Central_Solenoid==1 ? "C" : "",Barrel_Toroid==1 ? "B" : "",End_Cap==1 ? "E" : ""));
muonWheels = (str(Middle_Wheel==1 ? "M" : "",Small_Outer_Wheel==1 ? "S" : "",Large_Outer_Wheel==1 ? "L" : ""));

feetPos=[0,-(2825+600),2825+600,-(6150+600),6150+600,-(8940+600),8940+600,-(11480+600),11480+600];
{
	scale([1,1,1]/modelScale){
		if(Inner_Detector){
			if(Beam_Pipe && Print_Flag==0) MirrDupCut() color("Black") BeamPipe();
			MirrDupCut(Cut,30,-30)	InnerDetector(idStr);
		};
		if(Calorimeters){
			if(emCalStr!="") MirrDupCut(Cut*700,35,-35,Print_Flag) Calorimeters(emCalStr);
			if(hadCalStr!="") MirrDupCut(Cut*1500,45,-45,Print_Flag) Calorimeters(hadCalStr);
		};
		if(Magnets && Central_Solenoid) MirrDupCut(Cut*5400,60,-60) color("DarkGrey")	MagnetSystem("C");
		if(Magnets && Barrel_Toroid) MirrDupCut(Cut*5400,61,-61) color("DarkGrey")	MagnetSystem("B");
		if(Magnets && End_Cap) MirrDupCut(Cut*5400,60,-60,Print_Flag) color("DarkGrey")	MagnetSystem("E");
		if(Muon_Spectrometer){
			if(Inner_Barrel) MirrDupCut(Cut*3000,50,-50) color("Olive") MuonSpectrometer("I");
			if(Outer_Barrel) MirrDupCut(Cut*7000,80,-80) color("Olive") MuonSpectrometer("O");
			if(muonWheels!="") MirrDupCut(Cut*8000,80,-80,Print_Flag) color("Olive") MuonSpectrometer(muonWheels);
			if(Forward_Shield) MirrDupCut(Cut*8000,80,-80,Print_Flag) color("Gray") MuonSpectrometer("F");
		}
		if(Feet && Print_Flag==0) color("Silver") CERNFeet("RTB");
		if(Feet && Print_Flag==1) color("Silver") {
				for(i=[-3:3]){
					translate([3500*i,10000,750]) rotate([112.5,0,0]) rotate([-22.5,0,0]) translate([0,0,11670]) rotate([22.5,0,0]) CERNFeetT();
					translate([3500*i,0,1250]) rotate([-22.5,0,0]) translate([0,0,11670]) rotate([22.5,0,0]) CERNFeetB();
				}
				translate([0,0,-2784]) rotate([-90,0,0]) Rail();};
	}
//	rotate([0,90,0]) cylinder(h=50000/modelScale, r=1, center=true, $fn=8);
}


// Mirrors a part about the origin and inserts cut with start at "origin" with cut angles "angle1" and "angle2" from y-axis and  extending "length" from "origin"
module MirrDupCut(origin=-1,angle1=45, angle2=-45, mirrorFlag=0, length=40000){
	difference(){
		for (i = [0 : $children-1]){
			union(){
				children(i);
				if(mirrorFlag==0) mirror([1,0,0]) children(i);
			}
		}
		if (origin>=0) translate([-origin,0,0]) mirror([1,0,0]) rotate([0,-90,0]) linear_extrude(height=length, convexity=10, $fn=100){
			polygon(points=[[0,0],25000*[sin(angle1),cos(angle1)],25000*[sin(angle1),1],25000*[sin(angle2),1],25000*[sin(angle2),cos(angle2)],[0,0]]);
		}
	}
}

module BeamPipe(){
	rotate([0,90,0]) difference(){
		cylinder(h=3512*2, r=36, center=true);
		cylinder(h=3520*2, r=29, center=true);
	}
}

module InnerDetector(str){
	if (search("P",str,1)!=[]) Pixel();
	if (search("S",str,1)!=[]) SCT();
	if (search("T",str,1)!=[]) TRT();
}

module Calorimeters(str){
	if (search("L",str,1)!=[]) LAr();
	if (search("H",str,1)!=[]) LArEC();
	if (search("F",str,1)!=[]) FCal();
	if (search("T",str,1)!=[]) Tile("T");
	if (search("E",str,1)!=[]) Tile("E");
	if (search("R",str,1)!=[]) Tile("R");
}

module MagnetSystem(str){
	if (search("C",str,1)!=[]) CentralSolenoid();
	if (search("B",str,1)!=[]) BarrelToroid();
	if (search("E",str,1)!=[]) EndCap();
}

module MuonSpectrometer(str){
	if (search("I",str,1)!=[]) difference(){
		BI();
		MuonSpectrometerFeet();
	}
	if (search("O",str,1)!=[]) difference(){
		BO();
		MuonSpectrometerFeet();
	}
	if (search("M",str,1)!=[]) EM();
	if (search("S",str,1)!=[]) EOS();
	if (search("L",str,1)!=[]) FOL();
	if (search("F",str,1)!=[]) ForwardShield();
}

module Pixel(){
	rotate([0,90,0]) color("lightgray") difference(){
		cylinder(h=400.5*2, r=122.5, center=true);
		cylinder(h=500.5*2, r=50.5, center=true);
	}
	rotate([0,90,0]) color("lightgray") difference(){
		cylinder(h=650, r=149.6);
		cylinder(h=595, r=149.6);
		cylinder(h=550, r=88.8);
	}
}

module SCT(){
	rotate([0,90,0]) color("white") difference(){
		cylinder(h=749*2, r=514, center=true);
		cylinder(h=849*2, r=299, center=true);
	}
	rotate([0,90,0]) color("white") difference(){
		cylinder(h=2735, r=560);
		cylinder(h=839, r=560);
		cylinder(h=2735, r=275);
	}
}

module TRT(){
	rotate([0,90,0]) color("DarkGray") difference(){
		cylinder(h=790*2, r=1070, center=true, $fn=16);
		cylinder(h=890*2, r=550, center=true, $fn=16);
	}

	rotate([0,90,0]) translate([0,0,790]) color("darkgray") difference(){
		cylinder(h=2800-790, r=1050, $fn=16);
		cylinder(h=2900-790, r=620, $fn=16);
	}

	rotate([0,90,0]) translate([0,0,2800]) color("darkgray") difference(){
		cylinder(h=3400-2800, r=1050, $fn=16);
		cylinder(h=3500-2800, r=480, $fn=16);
	}
}

module LAr(){
	rotate([0,90,0]) color("Chocolate") difference(){
		union(){
			cylinder(h=2950*2, r=2200, center=true);
			translate([0,0,2950]) cylinder(h=3390-2950, r=2775);
			translate([0,0,-3390]) cylinder(h=3390-2950, r=2775);
		}
		cylinder(h=3400*2, r=1150, center=true);
		translate([0,0,3390-1400]) cylinder(h=1500, r1=0, r2=1500);
		rotate([0,180,0]) translate([0,0,3390-1400]) cylinder(h=1500, r1=0, r2=1500);
	}
}

module LArEC() color("Chocolate"){
	rotate([0,90,0]) difference(){
		translate([0,0,3500]) cylinder(h=760, r=2010);
		cylinder(h=3500+760, r1=0, r2=370);
	}
	rotate([0,90,0]) difference(){
		union(){
			translate([0,0,3500+760]) cylinder(h=1908, r=2200);
			translate([0,0,3500+3165-535]) cylinder(h=535, r=2475);
		}
		translate([0,0,3500+760]) union(){
			cylinder(h=1908, r=366);
			translate([0,0,500]) cylinder(h=1908-500, r=474);
			translate([0,0,804.5]) cylinder(h=1908-804.5, r=517);
			translate([0,0,804.5+600]) cylinder(h=1908-804.5, r=548);
		}
	}
}

module FCal(){
	rotate([0,90,0]) translate([0,0,3623+630+20+500+40]) color("SaddleBrown") difference(){
		union(){
			cylinder(h=1908-500, r=474-20);
			translate([0,0,450])cylinder(h=1908-500-450, r=517-20);
			translate([0,0,450+450])cylinder(h=1908-500-450-50, r=548-20);
		}
		union(){
			cylinder(h=1908, r=70);
			translate([0,0,450]) cylinder(h=1908-500, r=80);
			translate([0,0,450+450]) cylinder(h=1908-500, r=86);
			translate([0,0,450+450+450]) cylinder(h=1908-500, r=95);
			translate([0,0,450+450+450+460-150]) cylinder(h=150, r=190);
		}
	}
}

module Tile(str) color("Gray"){
	if (search("T",str,1)!=[] || search("E",str,1)!=[]) difference(){
		rotate([0.5/64*360,0,0]) union(){
			if (search("T",str,1)!=[]){
				rotate([0,90,0]) difference(){
					cylinder(h=2820*2, r=4250, $fn=64, center=true);
					cylinder(h=2920*2, r=2350, $fn=64, center=true);
				}
			}
			if (search("E",str,1)!=[]){
				rotate([0,90,0]) difference(){
					cylinder(h=6110, r=4250, $fn=64);
					cylinder(h=3200, r=4250, $fn=64);
					cylinder(h=6110, r=2350, $fn=64);
					cylinder(h=3424, r=3424, $fn=64);
					cylinder(h=3520, r=2974, $fn=64);
				}
			}
		}
		for (i=[0:63]){
			rotate([(i+0.5)/64*360]) translate([0,0,4250-25]) cube([2*(6120),150,50], center=true);
		}
	}
	if (search("E",str,1)!=[]){
		for (i=[0:63]){
			rotate([(i)/64*360]) translate([3010,0,4250-150]) cube([380,300,300], center=true);
		}
	}
	if (search("R",str,1)!=[]) color("Silver") {
		TileLongRail();
		mirror([0,1,0]) TileLongRail();
		TileExtendedRail();
		mirror([0,1,0]) TileExtendedRail();
	}
}

module TileLongRail(){ //rail size 430x530, origin at top center of rail
	translate([0,-3000,-(9400/2*cos(22.5))-385+530]){
		difference(){
			for(i = [0:3]){
				translate([-2610+1740*i,500,1100]) rotate([10,0,0]) cube([400,2000,2000], center=true);
			}
			translate([0,0,-50]) cube([2900*2,430+2*20,100+2*20], center=true);
			translate([0,0,-350]) rotate([30,0,0]) cube([2820*2,4000,400], center=true);
			translate([-2820,3000,(9400/2*cos(22.5))+385-530]) rotate([0,90,0]) cylinder(h=2820*2, r=4250+30, $fn=64);
			
		}
		difference(){
			translate([0,0,250-50]) cube([2900*2,600,500+100],center=true);
			translate([0,0,-50]) cube([2900*2,430+2*20,100+2*20], center=true);
		}
	}
}

module TileExtendedRail(){ //rail size 430x530, origin at top center of rail
	translate([3200,-3000,-(9400/2*cos(22.5))-385+530]){
		difference(){
			for(i = [-1,1]){
				translate([2910/2+i*1250,500,1100]) rotate([10,0,0]) cube([400,2000,2000], center=true);
			}
			translate([3000/2,0,-50]) cube([3000,430+2*20,100+2*20], center=true);
			translate([3000/2,0,-350]) rotate([30,0,0]) cube([3000,4000,400], center=true);
			translate([0,3000,(9400/2*cos(22.5))+385-530]) rotate([0,90,0]) cylinder(h=3000, r=4250+30, $fn=64);
		}
		difference(){
			translate([2910/2,0,250-50]) cube([3000,600,500+100],center=true);
			translate([2910/2,0,-50]) cube([3000,430+2*20,100+2*20], center=true);
		}
	}
}

module CentralSolenoid(){
	rotate([0,90,0]) color("gold") difference(){
		cylinder(h=2650, r=1292);
		cylinder(h=2650, r=1267);
	}
}

module EndCap(){
	translate([10130,0,0]) rotate([0,90,0]) difference(){
		union(){
			for(i=[0:3]){
				hull(){
					rotate([0,0,i*360/8]) cube([10730,1240,5000], center=true);
					for(j=[-1:2:1]){
						rotate([0,0,360/16+i*360/8]) translate([j*8660/4,-j*610,0]) cube([8660/2,0.01,5000], center=true);
						rotate([0,0,-360/16+i*360/8]) translate([j*8660/4,j*610,0]) cube([8660/2,0.01,5000], center=true);
					}
				}
				rotate([0,0,360/16+i*360/8]) cube([8660,1220,5000], center=true);
			}
		}
		cylinder(h=5200, r=1650/2, center=true);
	}
	for(i=[-1,1]) translate([10130,i*-3000,-(9400/2*cos(22.5))-385+530]) difference(){
		translate([0,0,250-50]) cube([5000,600,500+100],center=true);
		translate([0,0,-50]) cube([5000,430+2*20,100+2*20], center=true);
	}
}

module BarrelToroid(){
	strutPos = [1712.5,5137.5,8245.5,10845];
	for(i = [0:7]){
		rotate([22.5+45*i,0,0]) union(){
			BarrelToroidHalf();
			translate([0,0,9400/2+1100/2+5320-1100]) rotate([180,0,0]) translate([0,0,-9400/2-1100/2]) BarrelToroidHalf();
			for(j=[0:3]){
				rotate([-22.5,0,0]) translate([strutPos[j],0,8650]) cube([400,7700,600], center=true);
			}
		}
	}
}

module BarrelToroidHalf(){
	difference(){
		union(){
			translate([12630-1100/2,0,9400/2]) cylinder(h=5320/2, r=1100/2);
			translate([0,0,9400/2+1100/2]) rotate([0,90,0]) cylinder(h=12630, r=1100/2);
			translate([12630-1100/2-1100/4,0,9400/2+1100/2+1100/4]) rotate([0,45,0]) cylinder(h=4000, r=1100/2, center=true);
		}
		difference(){
			translate([12630-1100/2-1100/4,0,9400/2+1100/2+1100/4]) rotate([0,45,0]) translate([1000,0,1000]) cube([2000,2000,4000], center=true);
			translate([12630-1100/2-1100/4,0,9400/2+1100/2+1100/4]) rotate([0,45,0]) cylinder(h=4000, r=1100/2, center=true);
		}
		difference(){
			translate([12630-1100/2+1000,0,9400/2]) cube([2000,2000,6000], center=true);
			translate([12630-1100/2,0,9400/2]) cylinder(h=5320, r=1100/2);
		}
		difference(){
			translate([12630,0,9400/2+1100/2-1000]) rotate([0,90,0]) cube([2000,2000,6000], center=true);
			translate([0,0,9400/2+1100/2]) rotate([0,90,0]) cylinder(h=12630, r=1100/2);
		}
	}
}

module BI(){
	for(i=[0:7]){
		rotate([45*i,0,0]) translate([6550/2,0,4800]){
			difference(){
				cube([6550,2700,400],center=true);
				translate([-6550/2,0,200]) rotate([0,45,0]) cube([100,6000,100], center=true);
				translate([-6550/2,0,-200]) rotate([0,45,0]) cube([100,6000,100], center=true);
				for(j=[0:4]){
					translate([-6550/2+900+1080*j,0,400/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
					translate([-6550/2+900+1080*j,0,-400/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
				}
			}
		}
		rotate([22.5+45*i,0,0]) translate([6550/2,0,4525]){
			difference(){
				cube([6550,1700,300],center=true);
				for(j=[0:6]){
					translate([-6550/2+900*j,0,300/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
					translate([-6550/2+900*j,0,-300/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
				}
			}
		}
	}
}

module BO(){
	for(i=[0:7]){
		if(Fixed_Barrel || i!=4) rotate([45*i,0,0]) translate([12000/2,0,9477]){
			difference(){
				cube([12000,5900,600],center=true);
				translate([-12000/2,0,300]) rotate([0,45,0]) cube([200,6000,200], center=true);
				translate([-12000/2,0,-300]) rotate([0,45,0]) cube([200,6000,200], center=true);
				for(j=[0:4]){
					translate([-12000/2+1680+2160*j,0,600/2]) rotate([0,45,0]) cube([200,6000,200], center=true);
					translate([-12000/2+1680+2160*j,0,-600/2]) rotate([0,45,0]) cube([200,6000,200], center=true);
				}
			}
		}
		if(Fixed_Barrel || (i!=3 && i!=4)) rotate([22.5+45*i,0,0]) translate([12000/2,0,10350]){
			difference(){
				cube([12000,3800,511],center=true);
				for(j=[0:5]){
					translate([-12000/2+2160*j,0,511/2]) rotate([0,45,0]) cube([200,6000,200], center=true);
					translate([-12000/2+2160*j,0,-511/2]) rotate([0,45,0]) cube([200,6000,200], center=true);
				}
			}
		}
	}
}


module EM(){
	for(i=[0:7]){
		rotate([45*i,0,0]) translate([13842,0,0]){
//			difference(){
				rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
					polygon(points=[[1108/2,1735],[5946/2,11190],[-5946/2,11190],[-1108/2,1735]]);
				}
//				rotate([90,0,90]) for(j=[0:3]){
//					translate([1735+1680+1920*j,0,400/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
//					translate([1735+1680+1920*j,0,-400/2]) rotate([0,45,0]) cube([100,6000,100], center=true);
//				}
//			}
		}
		rotate([22.5+45*i,0,0]) translate([13448,0,0]){
			rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
				polygon(points=[[754/2,1735],[3761/2,11430],[-3761/2,11430],[-754/2,1735]]);
			}
		}
	}
}

module EOS(){
	for(i=[0:7]){
		rotate([45*i,0,0]) translate([21000-600,0,0]){ //22498
			rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
				polygon(points=[[1932/2,2985],[4119/2,7335],[-4119/2,7335],[-1932/2,2985]]);
			}
		}
		rotate([22.5+45*i,0,0]) translate([21000-200,0,0]){ //22838
			rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
				polygon(points=[[1319/2,2935],[2630/2,7285],[-2630/2,7285],[-1319/2,2935]]);
			}
		}
	}
}

module FOL(){
	for(i=[0:7]){
		rotate([45*i,0,0]) translate([21000-1400,0,0]){ //20832
			rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
				polygon(points=[[3699/2,6520],[5946/2,11590],[-5946/2,11590],[-3699/2,6520]]);
			}
		}
		rotate([22.5+45*i,0,0]) translate([21000-1000,0,0]){ //21200
			rotate([90,0,90]) linear_extrude(height=400, center=true, convexity=10, $fn=100){
				polygon(points=[[2460/2,6760],[4058/2,12070],[-4058/2,12070],[-2460/2,6760]]);
			}
		}
	}
} //21400

module ForwardShield(){
	difference(){
		union(){
			translate([7700,0,0]) rotate([0,90,0]) cylinder(r=1600/2, h=5200);
			translate([7700+5200,0,0]) rotate([0,90,0]) cylinder(r=1735, h=1400);
			translate([14300,0,0]) rotate([0,90,0]) cylinder(r=2500, h=17000-14300);
			translate([17000,0,0]) rotate([0,90,0]) cylinder(r=2800, h=19000-17000);
			translate([19000,0,0]) rotate([0,90,0]) cylinder(r=2935, h=21000-19000);
			translate([21000,0,0]) rotate([0,90,0]) cylinder(r=4000, h=22000-21000);
		}
		translate([16000,0,0]) rotate([0,90,0]) cylinder(r=200, h=18000, center=true);	
	}
}

module MuonSpectrometerFeet(){
	for (i=[-1,1]){
		rotate([45*(4+i),0,0]) translate([0,i*1600/2,4800]) cube([6600*2,2700-1580,500],center=true);
		translate([0,i*(-50-3000),1100-(9400/2*cos(22.5))-385+530]) rotate([i*10,0,0]) cube([15000,1000,2000], center=true);
		translate([0,i*-3000,50-(9400/2*cos(22.5))-385+530]) rotate([i*30,0,0]) cube([15000,4000,400], center=true);
		rotate([i*22.5,0,0]) translate([0,-i*200,-2200-4220/2-(9400/2+1100/2)]) cube([25000,1550,1000], center=true);
	}
	for (i=[0:6]){
		translate([feetPos[i],0,0]) rotate([-22.5,0,0]) translate([0,1100/2+100,-2200-4220-(9400/2+1100/2)]) rotate([22.5,0,0]){
			translate([0,0,3000/2-500]) cube([1200,1900,1000], center=true);
			rotate([-22.5,0,0]) translate([0,-1100/2-100,4220/2]) cube([1200,1550,3000], center=true);
		}
		translate([feetPos[i],0,0]) rotate([-22.5,0,180]) translate([0,1100/2+100,-2200-4220-(9400/2+1100/2)])rotate([22.5,0,0]){
			translate([0,-100,3000/2-500]) cube([1200,1900,1000], center=true);
			rotate([-22.5,0,0]) translate([0,-1100/2-100,4220/2]) cube([1200,1550,2000], center=true);
		}
	}
}

module CERNFeet(str){
	if (search("R",str,1)!=[]){
		Rail();
		rotate([0,0,180]) Rail();
	}
	for (i=[0:6]) {
		translate([feetPos[i],0,0]) {
			if (search("T",str,1)!=[]){
				CERNFeetT();
				rotate([0,0,180]) CERNFeetT();
			}
			if (search("B",str,1)!=[]){
				CERNFeetB();
				rotate([0,0,180]) CERNFeetB();
			}
		}
	}
}

module Rail(){
	translate([0,-3000,-(9400/2*cos(22.5))-385]) rotate([90,0,90]) translate([-430/2,0,0]) linear_extrude(height=2*12630, center=true, convexity=10, $fn=100){
				polygon(points=[[0,0],[430,0],[430,130],[430-130,130],[430-130,130+270],[430,130+270],[430,2*130+270],[0,2*130+270],[0,130+270],[130,130+270],[130,130],[0,130],[0,0]]);
	}
	for (i=[0:6]) {
		translate([feetPos[i],0,0]) {
			translate([0,-3000,-(9400/2*cos(22.5))-385-1200/2]) cube([600,430,1200], center=true);
		}
	}
}

module CERNFeetT(){
	difference(){
		rotate([-22.5,0,0]) translate([0,1100/2+100,-2200-4220-(9400/2+1100/2)]) rotate([22.5,0,0]){
			rotate([-22.5,0,0]) translate([0,-1100-200,5140/2+1400+150]) cube([1200,200,5140-300], center=true);
			difference(){
				union(){
					rotate([-22.5,0,0]) translate([0,-1100/2-100,2200+4220/2]) cube([1000,1100,4220], center=true);
//					rotate([-22.5,0,0]) translate([0,-1100/2-100-250,2200]) cube([500,600,600], center=true);
					rotate([-22.5,0,0]) translate([0,-1100-100,1900]) cube([500,400,400], center=true);
				}
				rotate([-22.5,0,0]) translate([0,-1100/2-100,2200+4220]) rotate([0,90,0]) cylinder(r=1200/2, h=2000, center=true);
				rotate([-22.5,0,0]) translate([0,-1100/2-100,2200]) rotate([0,90,0]) cylinder(r=1200/2, h=2000, center=true);
				rotate([-22.5,0,0]) translate([0,-250,5900+50+250]) cube([1200,300,500], center=true);
				rotate([-22.5,0,0]) translate([0,-200,4000]) cube([300,600,2200], center=true);
			}
		}
		translate([0,-3000,-(9400/2*cos(22.5))-385-1200/2]) cube([700,430+20+50,1250], center=true);
	}
}

module CERNFeetB(){
	rotate([-22.5,0,0]) translate([0,1100/2+100,-2200-4220-(9400/2+1100/2)]) rotate([22.5,0,0]){
	rotate([-22.5,0,0]) translate([0,0,5900/2+50-500]) cube([1200,200,6900], center=true);
	rotate([-22.5,0,0]) translate([0,-200,4000]) cube([200,500,2000], center=true);
	translate([0,-100,100-1000]) cube([2000,2000,200], center=true);
	difference(){
		union(){
			translate([400,-100,3000/2-500]) cube([200,1800,4000], center=true);
			translate([-400,-100,3000/2-500]) cube([200,1800,4000], center=true);
		}
		rotate([-22.5,0,0]) translate([0,-1100-200-500,0]) cube([1200,800,6000], center=true);
		rotate([-22.5,0,0]) translate([0,-1100/2-100,2200]) rotate([0,90,0]) cylinder(r=1200/2, h=2000, center=true);
		rotate([-22.5,0,0]) translate([0,-1100/2-100,2200+2000/2]) cube([2000,1100,2000], center=true);
		rotate([-22.5,0,0]) translate([0,-1100-200,5140/2+1400+150]) cube([1200,250,5140-300], center=true);
	}}
}

module Pillar(){
	rotate([90,0,0]) difference(){
		linear_extrude(height=900, center=true, convexity=10, $fn=100){
			polygon(
				points=[[0,0],[1900,0],[900,2500],[900,5568+150],[900,5568+150]+(904+1700)*[cos(22.5),sin(22.5)],[0,5568+200+1695]+(1030+1700)*[cos(22.5),sin(22.5)],[0,5568+200+1695]]);
		}
		translate([0,5568+200+1695]) rotate([0,0,22.5]) translate([1030+1700-(1088-550),-1868/2]) cylinder(r=550, h=1000, center=true);
		translate([0,5568+200+1695]) rotate([0,0,22.5]) translate([1030+1700,-1868/2]) cube([1100,1100,1000], center=true);
	}
}