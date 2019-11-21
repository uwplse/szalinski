/*
The internet is full of 3d printed raspberry enclosures.
The most of them minimize volume.

This was not good enough for me.

In my case, my case have a plenty free volume. And I need usb+ethernet out.
So I made this panel installation kit.

Please customize for your needs. If using large hat, leave back lobes out. 
Or if prefering nut instead of  insert, adjust hole diameters

Warning. Mask might require adjustments depending on installation target

*/
$fn=100;


part= "all"; // [all:All,left:Left side part,right:Right side part,mask:Front mask]


sideThickness=10;
underThickness=3;
backThickness=4;

pi_dPad=5.6; //Pad diameter on raspberry
pi_dHole=3.2; //Hole going thru raspberry. I drilled mine 2.5M to 3M

/*0
[Panel Holes]
*/
dInsertHole=4; //Center hole on block
dInsertHoleTap=5.8; //countersink radius
hInsertHoleTap=1; //countersink depth


dScrewHole=3; //front panel screw or insert
dScrewHoleTap=6; //front panel screw or insert
hScrewHoleTap=2.5;

dLobeHole=4; //Screw hole or insert hole

dRaspberryScrewInsert=0;//Set zero if just hole under
spacingInsertHoles=70; //vertical spacing on panel
zOffsetInserHoles=3; //Center hole up/down adjustement
//Front panel and lobe screw hole diameter (mm)

spacingHorizScrewHoles=68; //Horizontal spacing of front
spacingVerticalScrewHolesFrontUp=15;
spacingVerticalScrewHolesFrontDown=10;
spacingVerticalScrewHolesBackUp=15;
spacingVerticalScrewHolesBackDown=10;

/*
[Side lobes]
*/
LobeFrontUp=10;
LobeFrontDown=10;
LobeBackUp=0;
LobeBackDown=12;

lobeThickness=6; //Insert is 6mm thick adjust to smaller nut
lobeTriangleFrontLen=15; //Was 20
lobeTriangleBackLen=10;

lobeTriangleThick=2;
lobeGap=5; //Shield or cape has thru hole components?

/*
Raspberry tolerances
*/
//pcb thickness with printer tolerance
pi_pcb=1.8; //pcb thickness of raspberry

//connector spike height on thru hole 40pin connector
pi_spikesUnder=2.3; //How much space is reserved for raspberry pi thruhole component legs
pcbGap=10.5; //How tall connector is used on hat. distance in mm

/*
[Hidden]
*/
//Dimensions from PI
pi_y=56+2.5; //Some tolerances
pi_x=85+2.5;
pi_xHole=24;
pi_yHole=49/2;
pi_xHoleGap=58;



/*
[Front Mask]
*/
maskHeightOffset=2;
maskWidth=80;
maskHeight=40;
maskThickness=2.5;
panelThick=2;
panelHoleWall=2;

panelHoleWidth=pi_y-2*panelHoleWall;
panelHoleHeight=20;


module roundedEdges(x,y,z){
	difference(){
		union(){
			translate([0,y,z])
			sphere(r=x);
			translate([0,y,0])
			sphere(r=x);
			translate([0,0,z])
			sphere(r=x);
			translate([0,0,0])
			sphere(r=x);
			cylinder(r=x,h=z);
			translate([0,y,0])
			cylinder(r=x,h=z);
			rotate([-90,0,0])
			cylinder(r=x,h=y);
			translate([0,0,z])
			rotate([-90,0,0])
			cylinder(r=x,h=y);
		}
		translate([-x,-y,-z])
		cube([x,y*3,z*3]);
	}
	cube([x,y,z]);
}


//Actual mask part
module mask(){
	difference(){
		union(){
			translate([panelThick,-maskWidth/2,maskHeightOffset-maskHeight/2])
			roundedEdges(maskThickness,maskWidth,maskHeight);
			difference(){
				//Edges
				translate([panelThick/2+maskThickness/2,0,panelHoleHeight/2])
				cube([panelThick+maskThickness,panelHoleWidth+panelHoleWall*2,panelHoleHeight+panelHoleWall*2],center=true);
				//Hole
				translate([panelThick,0,panelHoleHeight/2])
				cube([panelThick*5,panelHoleWidth,panelHoleHeight],center=true);
			}
		}
		panelDrill();
		scale([1,-1,1])
		panelDrill();
		
		//Relative from ethernet edge
		translate([0,-56/2+2.3,0])
		union(){
			//Ethernet hole
			translate([-50,0,0])
			cube([100,16,16]);
			//Left USB
			translate([-50,15.9+4.2,0])
			cube([100,13.2,19]);
			//Right USB
			translate([-50,15.9+4.2+13.1+4.9,0])
			cube([100,13.2,19]);
		}
	}
}





//Keepaway parts (simpler than 3d model of pi3) Non-symmetric
module keepAway(){
	translate([-pi_x*1.5,-pi_y/2,0])
	cube([pi_x*2,pi_y,pi_pcb]);
	translate([-pi_xHole-pi_xHoleGap+pi_dPad/2,pi_y/2-100,-pi_spikesUnder])
	cube([pi_xHoleGap-pi_dPad,100,pcbGap+pi_pcb+pi_spikesUnder+0.1]);

	translate([-pi_xHole+pi_dPad/2+0.1,-pi_y/2,-pi_spikesUnder])
	cube([pi_xHole-pi_dPad/2,pi_y,pcbGap+pi_pcb+pi_spikesUnder+0.1]);


	//Usb power connector
	translate([-pi_xHole-pi_xHoleGap,-pi_y/2-100+0.1,-pi_spikesUnder])
	cube([12,100,100]);
	
	translate([-pi_xHole,pi_yHole,0])
	cylinder(r=pi_dHole/2,h=100,center=true);
	translate([-pi_xHole-pi_xHoleGap,pi_yHole,0])
	cylinder(r=pi_dHole/2,h=100,center=true);
	translate([-pi_xHole,-pi_yHole,0])
	cylinder(r=pi_dHole/2,h=100,center=true);
	translate([-pi_xHole-pi_xHoleGap,-pi_yHole,0])
	cylinder(r=pi_dHole/2,h=100,center=true);

	translate([-pi_xHole-pi_xHoleGap,-pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	cylinder(r=dRaspberryScrewInsert/2,h=100);

	translate([-pi_xHole-pi_xHoleGap,pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	cylinder(r=dRaspberryScrewInsert/2,h=100);

	translate([-pi_xHole-pi_xHoleGap,-pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	cylinder(r=dRaspberryScrewInsert/2,h=100);

	translate([-pi_xHole,pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	cylinder(r=dRaspberryScrewInsert/2,h=100);


	translate([-pi_xHole,-pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	cylinder(r=dRaspberryScrewInsert/2,h=100);

	/*
	translate([pi_xHole,-pi_yHole,pi_pcb/2])
	rotate([180,0,0])
	#cylinder(r=dRaspberryScrewInsert/2,h=100);
	*/
}

module panelDrill(){
	//center drill
	translate([0.1,spacingInsertHoles/2,zOffsetInserHoles])
	rotate([180,90,0])
	cylinder(r=dInsertHole/2,h=pi_x*3);

	translate([0,spacingInsertHoles/2,zOffsetInserHoles])
	rotate([0,90,0])
	cylinder(r=dScrewHole/2,h=pi_x*3);

	//center drill tap
	translate([panelThick+maskThickness-hInsertHoleTap,spacingInsertHoles/2,zOffsetInserHoles])
	rotate([0,90,0])
	cylinder(r1=dScrewHole/2,r2=dScrewHoleTap/2,h=hInsertHoleTap+0.1);


	//upper drill
	translate([0.1,spacingHorizScrewHoles/2,spacingVerticalScrewHolesFrontUp])
	rotate([180,90,0])
	cylinder(r=dLobeHole/2,h=lobeThickness*10);

	translate([0,spacingHorizScrewHoles/2,spacingVerticalScrewHolesFrontUp])
	rotate([0,90,0])
	cylinder(r=dScrewHole/2,h=lobeThickness*10);


	translate([panelThick+maskThickness-hInsertHoleTap,spacingHorizScrewHoles/2,spacingVerticalScrewHolesFrontUp])
	rotate([0,90,0])
	cylinder(r1=dScrewHole/2,r2=dScrewHoleTap/2,h=hInsertHoleTap+0.1);


	//Bottom front
	translate([0.1,spacingHorizScrewHoles/2,-spacingVerticalScrewHolesFrontDown])
	rotate([180,90,0])
	cylinder(r=dLobeHole/2,h=lobeThickness*10);

	translate([0,spacingHorizScrewHoles/2,-spacingVerticalScrewHolesFrontDown])
	rotate([0,90,0])
	cylinder(r=dScrewHole/2,h=lobeThickness*10);


	translate([panelThick+maskThickness-hInsertHoleTap,spacingHorizScrewHoles/2,-spacingVerticalScrewHolesFrontDown])
	rotate([0,90,0])
	cylinder(r1=dInsertHole/2,r2=dInsertHoleTap/2,h=hInsertHoleTap+0.1);

	//Back upper
	translate([-pi_x,spacingHorizScrewHoles/2,spacingVerticalScrewHolesBackUp])
	rotate([0,90,0])
	cylinder(r=dLobeHole/2,h=lobeThickness*10,center=true);
	//Back lower
	translate([-pi_x,spacingHorizScrewHoles/2,-spacingVerticalScrewHolesBackDown])
	rotate([0,90,0])
	cylinder(r=dLobeHole/2,h=lobeThickness*10,center=true);
}


module twoSideCorner(dimX,dimY,middleZ,downZ,upZ,frontThick,sideThick){
	/*
	scale([1,1,sideThick])
	translate([0,0,0.5])
	polygon([
	[frontThick-0.1,middleZ/2+upZ],
	[dimX,middleZ/2],
	[dimX,-middleZ/2],
	[frontThick-0.1,-middleZ/2-downZ]]);
	*/
	
	rotate([90,0,0])
	translate([0,0,-upZ-middleZ/2])
	cube([dimX,sideThick,middleZ+downZ+upZ]);

	translate([0,-middleZ/2-downZ,0])
	cube([frontThick,middleZ+upZ+downZ,dimY]);
}



module sideBlock(){
	middleZ=pcbGap+pi_pcb+underThickness+pi_spikesUnder;
	/*
	translate([-(pi_x+backThickness),pi_y/2-pi_dPad,-pi_spikesUnder-underThickness])
	cube([pi_x+backThickness,pi_dPad+sideThickness,middleZ]);
	*/
	translate([-(pi_x+backThickness),pi_y/2,-pi_spikesUnder-underThickness])
	cube([pi_x+backThickness,sideThickness,middleZ-lobeGap]);
	
	aaa=pcbGap+pi_pcb+underThickness+pi_spikesUnder;
	
	translate([0,pi_y/2+sideThickness,aaa/2-pi_pcb-underThickness-pi_pcb/2])
	rotate([90,180,0])
	twoSideCorner(lobeTriangleFrontLen,sideThickness,middleZ,LobeFrontUp,LobeFrontDown,lobeThickness,lobeTriangleThick);
	
	//translate([-(pi_x+backThickness)+0.1,pi_y/2+sideThickness,aaa/2-pi_pcb-underThickness-pi_pcb/2-lobeGap/2])
	translate([-(pi_x+backThickness)+0.1,pi_y/2+sideThickness,aaa/2-pi_pcb-underThickness-pi_pcb/2-lobeGap/2])
	scale([1,-1,1])
	rotate([90,180,180])
	twoSideCorner(lobeTriangleBackLen,sideThickness,middleZ-lobeGap,LobeBackUp,LobeBackDown-lobeGap/2,lobeThickness,lobeTriangleThick);
	
	translate([-pi_xHole,pi_yHole,-pi_spikesUnder-underThickness])
	union(){
		cylinder(r=pi_dPad/2,h=middleZ);
		translate([-pi_dPad/2,0,0])
		cube([pi_dPad,pi_dPad+1,middleZ-lobeGap]);
	}
	translate([-pi_xHole-pi_xHoleGap,pi_yHole,-pi_spikesUnder-underThickness])
	union(){
		cylinder(r=pi_dPad/2,h=middleZ);
		translate([-pi_dPad/2-1,0,0])
		cube([pi_dPad+1,pi_dPad+1,middleZ-lobeGap]);
		
		translate([-pi_dPad/2-backThickness,-pi_dPad/2,0])
		cube([pi_dPad/2+backThickness,pi_dPad*2,middleZ-lobeGap]);
	}
}


module rightPart(){
	difference(){
		sideBlock();
		panelDrill();
		keepAway();
	}
}

module leftPart(){
	difference(){
		scale([1,-1,1])
		sideBlock();
		scale([1,-1,1])
		panelDrill();
		keepAway();
	}
}




if (part == "all") {
	translate([10,0,0])
	mask();
	leftPart();
	rightPart();
} else if (part == "left") {
	leftPart();
} else if (part == "right") {
	rightPart();
} else if (part == "mask") {
	mask();
}

