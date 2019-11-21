/*▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
///////////////////////////////// Title Block //////////////////////////////////

Title: Parametric Spool Holder
Description: This SCAD file creates a spool holder based on parameters
Creation Date: 06/19/2014
Author: Lee Dabkey

///////////////////////////////// Version Log //////////////////////////////////

Version: 20140619_1.0
Description: Initial version

//«««««««««««««««««««««««««««««««««« Author Notes »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»

1). Constants start with a lowercase 'c'
2). Question parameters begin with a lowercase 'q'
3). Variable names start with a lowercase 'v'
4). Local module names start with 'mod_' and are separated by //■■■■■ 
5). Modules are sorted (A-Z) by name in Modules section below

Modifier Characters for debugging
% Ignore this subtree for the normal rendering process and draw it in transparent gray
# Use this subtree as usual in the rendering process but also draw it unmodified in transparent pink
! Ignore the rest of the design and use this subtree as design root.
* Simply ignore this entire subtree.

▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲*/
//«««««««««««««««««««««««««««««««« Other Files Used »»»»»»»»»»»»»»»»»»»»»»»»»»»»
/*
Attribution Write.scad by HarlanDMii
Attribution OpenSCad Stencil Font for Write library by romankornfeld
Attribution OpenSCAD ruler by jbrown123

File							Source												*/
use <utils/write.scad>;		//http://www.thingiverse.com/thing:16193
f1="orbitron.dxf";			//http://www.thingiverse.com/thing:16193
f2="stencil.dxf";			//http://www.thingiverse.com/thing:100779
use <ruler.scad>;			//http://www.thingiverse.com/thing:30769/#files

//««««««««««««««««««««««««««««««««««« Constants »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
//FYI
//	1 mm = 0.03937008 in
// 1 in = 25.4 mm

$fn=100;
c_mm2in = 0.03937008;
c_in2mm = 25.4;
c_mm2cm = 10;
c_hol_shrink = 0.1;		//Predicted shrinkage of holes i.e. 0.1=10%

//««««««««««««««««««««««««««««««««««« Questions »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»

qEcho=1;					//Show console messages; 0=No; 1=Yes
qShowRuler=0;				//Show xyz Ruler; 0=No; 1=Yes Good for checking design
qDual=2;					//2=No dual extrusion; 1=Top; 3=Bottom
qBearing=0;				//Show bearing; 0=No; 1=Yes;should be used only for rendering; set to No for printing
qNumBearings=1;			//Number of bearings per arm used; normally=1; can be=2

if (qShowRuler==1){
	% xyzruler(75);
}

//««««««««««««««««««««««««««««««««««« Parameters »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
//Bearing Dimensions - EXACT dimensions; working dimensions are calculated using c_hol_shrink above

//Some bearings that I have
//vBearOD_EX=17.5;			//Bearing OD in mm
//vBearID_EX=6.1;			//Bearing ID in mm
//vBearThick_EX=7.9;		//Bearing thickness in mm

//For standard 608zz skate bearings
vBearOD_EX=22;				//Bearing OD in mm
vBearID_EX=8;					//Bearing ID in mm
vBearThick_EX=7;				//Bearing thickness in mm

//Washer Thickness
vWasherThick=1.5;				//This is the washer thickness that is printed between arms

//Bearing flange for 608 skate bearings
vFlangeDia=12;
vFlangeThick=1.0;

//Spool Dimensions		
vSpoolDia=202;			//Spool diameter in mm
vSpoolWidth=67;			//Spool width center to center of "rims" in mm
//NOTE: MakerBot diameter is pretty standard at 202mm but check width; usually either 72mm or 67mm

//Spacing Around Pad
vSp_X=10;					//Spacing around pad x direction REMEMBER: it is split between two ends so /2
vSp_Y=10;					//Spacing around pad y direction REMEMBER: it is split between two ends so /2
vSp_Z=5;					//Thickness of pad, arms, and base in mm

//Color for Rendering - This is only used for the F5 preview as CGAL and STL (F6) do not support color.
vColor01="orange";		//Color of arms and lettering
vColor02="black";		//Color of pad or base
vColor03="LightGrey";	//Color of bearing if qBearing=1

//Display lettering or messages
vMesg01="MakerBot";										//Message on top; I use it for supplier of spool
//Print variable message depending on number of bearings per arm
vMesg02= qNumBearings==1 ? str(vSpoolDia,"mm x ",vSpoolWidth,"mm"):
								str(vSpoolDia,"mm x ",vSpoolWidth,"-",vSpoolWidth+vBearThick_EX,"mm");
vMesg03=str(vSpoolDia);									//Calculated message for stencil through base
vMesg04="2x";												//Message for two bearings per arm
vMesg01_ht=vSpoolWidth/10;								//Height of message
vMesg02_ht=vSpoolWidth/10;								//Height of message
vMesg03_ht=vSpoolWidth/3;								//Height of message
vMesg04_ht=vSpoolWidth/10;								//Height of message		
vMesg01_pos=vSpoolWidth/4;								//y Position of message 01
vMesg02_pos=-vSpoolWidth/4;							//y Position of message 02

//Raised lettering
vRaise=1;					//Height of raised lettering

//Mounting holes
vM_hole=6.5;				//Mounting hole size in mm; 6.5 is good for 1/4-20

//«««««««««««««««««««««««««««««« Calculated Variables »»»»»»»»»»»»»»»»»»»»»»»»»»
//These variables are the working variables and are calculated from the parameters above
vBearOD=vBearOD_EX*(1+c_hol_shrink);
vBearID=vBearID_EX*(1+c_hol_shrink);
vBearThick=qNumBearings*(vBearThick_EX+c_hol_shrink);
vBearOD_Rad=vBearOD/2;
vBearID_Rad=vBearID/2;
vSpoolRad=vSpoolDia/2;
vBearSpacing=vBearOD_Rad+5;
vMountHole=(vM_hole*(1+c_hol_shrink))/2;
vFlangeRad=vFlangeDia/2;
vPad_x=vSpoolRad+(2*vBearSpacing)+vSp_X;
vPad_y=vSpoolWidth+2*vBearThick+vSp_Y;
vPad_z=vSp_Z;

//««««««««««««««««««««««««««««««« Check Dimensions »»»»»»»»»»»»»»»»»»»»»»»»»»»»»
//If qEcho is set to 1, it displays information in compilation or console window
if (qEcho==1)
{
	echo(str("<b>qDual=<b>",qDual,"<i> 2=No dual extrusion; 1=Top; 3=Bottom<i>"));
	if (qBearing==1)
	{
		echo("<b>qBearing is ON.... DO NOT PRINT!<b>,i>; set qBearing=0 to print<i>");
	}
	echo(str("<b>Pad size is: x=<b>",vPad_x,"<b> y=<b>",vPad_y,"<b> z=<b>",vPad_z," in mm"));	
}	//End echo if qEcho=1 [On]

//Begin echo if qEcho=0 [Off]
if (qEcho==0)
{
	echo("qEcho is OFF....To check dimensions, set qEcho=1");
}
	echo();
	echo("<b>The messages below are from write.scad<b>");
//««««««««««««««««««««««««««««««««««« Rendering »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»

if (qDual>=2) 				//if dual extrusion off or rendering bottom only
	{
	translate([0,0,vSp_Z/2])
	mod_pad();
	}

if (qDual<=2) 				//if dual extrusion off or rendering top only
	{
	//Position and create the four pairs of arms for bearing
	translate([vSpoolRad/2,vSpoolWidth/2,vSp_Z/2])
	mod_CenterPairArm();
	translate([-vSpoolRad/2,vSpoolWidth/2,vSp_Z/2])
	mod_CenterPairArm();
	translate([vSpoolRad/2,-vSpoolWidth/2,vSp_Z/2])
	mod_CenterPairArm();
	translate([-vSpoolRad/2,-vSpoolWidth/2,vSp_Z/2])
	mod_CenterPairArm();
	//Add the lettering to top of pad
	mod_lettering();
	}
//«««««««««««««««««««««««««««««««««««« Modules »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Bearing arm module
module mod_BearArm ()
{
	difference()
	{	
		union()
		{
			color(vColor01) cylinder (h = vSp_Z, r = vBearSpacing, center = true);
			translate([0, 0, (vSp_Z)/2])
			mod_washer();
			translate([(vBearSpacing)/2,0,0])
			color(vColor01) cube (size = [vBearSpacing,2*vBearSpacing,vSp_Z], center = true);
		}
		cylinder (h = 3*vBearThick, r = vBearID_Rad, center = true);
	}	
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Center the assembly module
module mod_CenterPairArm()
{

translate([0,-vSp_Z-vFlangeThick-vBearThick/2,-vSp_Z/2])
rotate([0,90,90])

translate([-vBearSpacing-vSp_Z,0,vSp_Z/2])
mod_PairArm();
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Lettering module
module mod_lettering()
{	//Lettering for vMesg01
	translate([0,vMesg01_pos,vSp_Z])
	color(vColor01)writecube(vMesg01,face="top",h=vMesg01_ht,font=f1, t=vRaise, space=1);
	//Lettering for vMesg02
	translate([0,vMesg02_pos,vSp_Z])
	color(vColor01)writecube(vMesg02,face="top",h=vMesg02_ht,font=f1, t=vRaise, space=1);

	if (qNumBearings==2)	//Prints '2x' to let you know you are using 2 bearings per arm
	{
	translate([vSpoolRad/2,vSpoolWidth/2,vSp_Z])
	color(vColor01)writecube(vMesg04,face="top",h=vMesg04_ht,font=f1, t=vRaise, space=1);

	translate([-vSpoolRad/2,vSpoolWidth/2,vSp_Z])
	color(vColor01)writecube(vMesg04,face="top",h=vMesg04_ht,font=f1, t=vRaise, space=1);

	translate([vSpoolRad/2,-vSpoolWidth/2,vSp_Z])
	color(vColor01)writecube(vMesg04,face="top",h=vMesg04_ht,font=f1, t=vRaise, space=1);

	translate([-vSpoolRad/2,-vSpoolWidth/2,vSp_Z])
	color(vColor01)writecube(vMesg04,face="top",h=vMesg04_ht,font=f1, t=vRaise, space=1);
	}
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Create an oval module
module mod_oval(w,h,height)
{
	translate([0,0,-vSp_Z])
	scale([1, h/w, 1]) cylinder(h=height, r=w);
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Pad or base module
module mod_pad()
{
	difference()
	{
		//Create pad
		color(vColor02) cube (size = [vPad_x,vPad_y,vPad_z], center = true);

		//Stencil message through base
		writecube(vMesg03,face="top",h=vMesg03_ht,font=f2, t=vSp_Z+1, space=1);
		
		//Create curves in sides of base
		translate([0,vSpoolWidth-vSp_Y,0])				
		mod_oval(vSpoolDia/6,vSpoolWidth/3,2*vSp_Z);
		
		translate([0,-vSpoolWidth+vSp_Y,0])				
		mod_oval(vSpoolDia/6,vSpoolWidth/3,2*vSp_Z);
		
		//Create mounting holes
		translate([vSpoolRad/2,0,0])
		cylinder (h = 2*vSp_Z, r = vMountHole, center = true);

		translate([-vSpoolRad/2,0,0])
		cylinder (h = 2*vSp_Z, r = vMountHole, center = true);
		
	}

}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Pair of bearing arms module
module mod_PairArm()
{
	translate([0,0,(vSp_Z)+(vFlangeThick)+vBearThick])
	rotate([180,0,0])
	mod_BearArm ();
	mod_BearArm ();

	//Bearing for testing
	if (qBearing==1)
		{	
		//translate([0,0,0.75*vBearThick])
		translate([0,0,vBearThick/2+vFlangeThick+vSp_Z/2])
		color(vColor03) cylinder (h = vBearThick, r = vBearOD_Rad, center = true);
		}
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
// Washer module
module mod_washer()
{
	difference()
	{	//Create the washer housing around bearing
		color(vColor01) cylinder (h = vWasherThick, r1 = vBearSpacing, r2 = vBearOD_Rad+1, center = true);
		color(vColor01) cylinder (h = vWasherThick+0.5, r = vBearOD_Rad, center = true);
	}
	//Add the flange
	color(vColor01) cylinder (h = vFlangeThick, r = vFlangeRad, center = true);
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■