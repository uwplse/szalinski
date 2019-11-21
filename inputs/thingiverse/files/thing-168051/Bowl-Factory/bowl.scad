/*
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/

author: Eric Romano (@gelstudios on twitter)
title: Bowl Factory
about: these modules generate a bowl from a spherical section, with lots of parameters for customization.
version: 1.1

-------------------
module: bowl
description: generates a bowl, parameters are optional.
parameters: radius of bowl, wall thickness, wall spin, wall tilt, percent of bowl to retain after trimming the lip, angle of trim, z-angle of trim, resolution.
ex: bowl(60,3,.50,15,0,16);
note: higher resolutions look nice (32+), lower resolutions have a cool polygon look (try 5-16).

-------------------
module: prettycut
description: uses a cylinder to cut a rounded profile into the bowl. 
parameters: radius of cut, position of trim relative to center, angle of trim, z-angle of trim, resolution.
ex: prettycut(200,10,15,0,30)bowl(60,3,1,0,0,16);
note: prettycut is performed after the lip of the bowl is cut, so use 1 for bowl trim parameter if using it (see prettycut example). It looks best when the radius parameter is greater than the bowl's.
*/

BowlSize=50; //[10:300]
WallThickness=2; //[1:30]
//Higher values are "Smoother", Lower res has a cool polygon look.
BowlResolution=16; //[3:128]

CutType=1; //[0:Straight,1:Pretty]
CutAngle=5; //[0:90]
CutSpin=45; //[0:180]

//Percentage used by straight cut only
BowlTrim=50; //[0:100]
Trim=BowlTrim/100;

//Pretty cut only, zero is half way up the bowl.
PrettyCutOffset=0; //[-50:50]
PrettyCutResolution=100; //[3:128]
PrettyCutRadius=200; //[50:300]

/* [Shape] */
//Percentage
VerticalSquashOrStretch=75; //[25:300]
ZSquash=VerticalSquashOrStretch/100;
//Percentage
HorizontalSquashOrStretch=100; //[25:300]
YSquash=HorizontalSquashOrStretch/100;
//Percentage
DepthSquashOrStretch=100; //[25:300]
XSquash=DepthSquashOrStretch/100;

/* [Advanced] */
//Degrees
BowlWallSpin=15; //[0:180]
BowlWallXTilt=0; //[-90:90]
BowlWallYTilt=15; //[-90:90]


if (CutType==1){
	scale([XSquash,YSquash,ZSquash])
	prettycut(PrettyCutRadius,PrettyCutOffset,CutAngle,CutSpin,PrettyCutResolution)
	bowl(BowlSize,WallThickness,1,BowlWallSpin,BowlWallXTilt,BowlWallYTilt,0,0,BowlResolution);
} else {
	scale([XSquash,YSquash,ZSquash])
	bowl(BowlSize,WallThickness,Trim,BowlWallSpin,BowlWallXTilt,BowlWallYTilt,CutAngle,CutSpin,BowlResolution);
}

module bowl(size=50,wall=2,percenttrim=.60,spin=0,tilt=0,tilt2=0,cutangle=0,cutangle2=0,bowlres=50){
$fn=bowlres;
trimvol=2*size;
trimposition=trimvol*percenttrim;
trimbottom=size*.2;
bottomcut=size/2;
insphere=1-wall/size;

difference(){
	difference(){
		difference(){
			//outer wall
			intersection(){
				rotate([tilt,tilt2,spin])sphere(size);
				translate([0,0,trimbottom])
				cube([trimvol,trimvol,trimvol],center=true);
				}
			//inner wall
			intersection(){
				rotate([tilt,tilt2,spin])sphere(size*insphere);//rotate for face angle, need parameter
				translate([0,0,trimbottom*1.3])
				cube([trimvol,trimvol,trimvol],center=true);
				}
			}
		rotate([cutangle,0,cutangle2])
		translate([0,0,trimposition])
		cube([4*trimvol,4*trimvol,trimvol],center=true);
		}
	translate([0,0,-1.28*size])
	cylinder(bottomcut,bottomcut,bottomcut);
	}
}

module prettycut(pcutsize=200,offset=0,pcutangle=0,pcutangle2=0,pcutres=100){
$fn=pcutres;
radius=pcutsize;

difference(){
	child(0);

	translate([0,0,offset])
	rotate([pcutangle,0,pcutangle2])
	translate([0,0,radius])
	rotate([90,0,0])
	cylinder(4*radius,radius,radius,center=true);
	}
}
