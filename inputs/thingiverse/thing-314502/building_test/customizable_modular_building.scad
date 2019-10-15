//
//
//	Customizable Modular Building
//	Steve Medwin
//	April 21, 2014
//
//
$fn=36*1;
use <MCAD/shapes.scad>
// preview[view:south, tilt:top]

//
// CUSTOMIZING
//
// Number of horizontal windows
horizontal_windows=3; //[1:10]
Ncol=horizontal_windows;
// Number of vertical windows
vertical_windows=2; //[1:5]
Nrow=vertical_windows;

show_door="yes"; //[yes,no]
show_windows="yes"; //[yes,no]
show_bricks="no"; //[yes,no]
show_roof="yes"; //[yes,no]

//
// REMAINING PARAMETERS
//
// windows
Xinit=5*1; // Distance from left edge to first window
Yinit=6*1; //5 Distance from bottom to first window row
Xspace=10*1; // Distance from left edge of window to next left edge of window
Yspace=15.5*1; // Distance from bottom of window row to next row
Zbase=2.0*1; // Thickness of wall
Xwin=6.4*1; // (6.4) Width of window
Ywin=10*1; // Height of window
Zwin=2*1; // Depth of windows
Xmuntin=0.7*1; // Height of window muntin
Ymuntin=Xmuntin;
Zmuntin=0.6*1; // Thickness of window muntin
YwinArc=0.15*1; // Parameter for top of window arc
Xjam=1.0*1; //Width of door jam

Xbase=Xinit*2+Xspace*(Ncol-1)+Xwin; // Width of wall
Ybase=Yinit*2+Yspace*(Nrow-1)+Ywin; // Height of wall without roof
Xdoor=(Xspace+Xwin)/2-Xwin-Xjam/2;

// roof
Xroof=Xbase;
Yroof=4*1; // Height of roof
Zroof=2*1; // Depth of roof in addition to wall thickness
Droof=1*1; // Size of roof crenelation

// bricks
Xbrick=6*1; // Width of bricks
Ybrick=2*1; // Height of bricks (3:1 ratio)
Zbrick=0.205*1; // Height and depth of brick grout below surface (okay at @ .21,.19)

//
//	MODULES
//
// facade
module facade(){
	translate([0,0,-Zbase]) cube([Xbase,Ybase+Yroof,Zbase]);
}

//	bricks
module bricks(){
	for (i=[0:Ybase/Ybrick]){
		translate([0,i*Ybrick-Zbrick,-Zbrick]) cube([Xbase,Zbrick,Zbrick]); // on front
		translate([0,i*Ybrick-Zbrick,-Zbase]) cube([Zbrick,Zbrick,Zbase]); // on left edge
		translate([Xbase-Zbrick,i*Ybrick-Zbrick,-Zbase]) cube([Zbrick,Zbrick,Zbase]); // on right edge	
		// add vertical lines for bricks
		for (j=[0:Xbase/Xbrick]){
			if (i/2==floor(i/2)) {
				translate([0,i*Ybrick,-Zbrick]) translate([j*Xbrick,0,0]) cube([Zbrick,Ybrick,Zbrick]);
				}
			else {
				translate([0,i*Ybrick,-Zbrick]) translate([j*Xbrick+Xbrick/2,0,0]) cube([Zbrick,Ybrick,Zbrick]);
				}
		}
	}
}

//	windows
module window(Xpos,Ypos){
	translate ([Xpos,Ypos,-Zwin-2]) cube([Xwin,Ywin,Zwin+2]); // add extra depth to improve Customizer rendering
	translate ([Xpos+Xwin/2,Ypos+Ywin,-Zwin-2]) ellipticalCylinder(Xwin/2,Ywin*YwinArc,Zwin+2);
}

//	muntins
module muntins(Xpos,Ypos){
	translate ([Xpos,Ypos+Ywin/2-Ymuntin/2,-Zwin]) cube([Xwin,Ymuntin,Zmuntin]);
	translate ([Xpos,Ypos+Ywin,-Zwin]) cube([Xwin,Ywin*YwinArc,Zmuntin]);
}

// roof
module roof(){
	Dcount=((Xbase-Xinit*2)/(Droof*2));
	XbaseP=(Dcount+1)*Droof*2-Droof;
	XinitP=(Xbase-XbaseP)/2;
	difference(){
		translate ([0,Ybase,-Zbase]) cube([Xroof,Yroof,Zbase+Zroof]);
		for (i=[0:Dcount+0]){
			translate([XinitP+i*Droof*2,Ybase,0]) cube([Droof,Yroof*0.6,Zroof]);
		} 
	}
}

// door
module door(){
	translate ([Xinit+Xspace*(floor(Ncol/2)),Yinit,-Zwin-2]) cube([Xwin,Ywin,Zwin+2]);  // add extra depth to improve Customizer rendering
	translate ([Xinit+Xspace*(floor(Ncol/2))+Xwin/2,Yinit+Ywin,-Zwin-2]) ellipticalCylinder(Xwin/2,Ywin*YwinArc,Zwin+2);
	translate ([Xinit+Xspace*(floor(Ncol/2)),0,-Zwin+Zmuntin]) cube([Xwin,Yinit,Zwin]); // bottom of door
	if (Ncol/2==floor(Ncol/2)) {  // then Ncol is even so make a double door
		translate ([Xinit+Xspace*(Ncol/2-1),Yinit,-Zwin-2]) cube([Xwin,Ywin,Zwin+2]);
 		translate ([Xinit+Xspace*(Ncol/2-1),0,-Zwin+Zmuntin]) cube([Xwin+Xspace,Yinit+Ywin+Ymuntin,Zwin]);
		translate ([Xinit+Xspace*(Ncol/2-1)+Xwin+Xdoor,Yinit,-Zwin]) cube([Xjam,Ywin/2-Ymuntin/2,Zwin]);
		translate ([Xinit+Xspace*(Ncol/2-1)+Xwin+Xdoor,Yinit+Ywin/2+Ymuntin/2,-Zwin]) cube([Xjam,Ywin/2-Ymuntin/2,Zwin]);
		translate ([Xinit+Xspace*(Ncol/2)-Xdoor-Xjam/2,Yinit+Ywin+Ymuntin,-Zwin+Zmuntin]) ellipticalCylinder((Xwin+Xspace)/2,Ywin*YwinArc*1.2,Zwin);
		}
	}

// building
module building(){
	difference(){
		facade();
	//	subtract windows
		for (i=[0:Nrow-1]){
			for (j=[0:Ncol-1]){
				if (show_windows=="yes") {
					window(Xinit+j*Xspace,Yinit+i*Yspace,0);
					}
			}
		}
		if (show_bricks=="yes") { 
			bricks(); 
			}
	}
}

//
// ASSEMBLE BUILDING
//
difference(){
	building();
	if (show_door=="yes") {
		door();
		}
	}

if (show_roof=="yes") {
	roof();
	}

// add muntins
	for (i=[0:Nrow-1]){
		for (j=[0:Ncol-1]){
			muntins(Xinit+j*Xspace,Yinit+i*Yspace,0);
		}
	}