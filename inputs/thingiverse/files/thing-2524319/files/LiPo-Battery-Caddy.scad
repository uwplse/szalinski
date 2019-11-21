//BY DOWNLOADING, OPENING AND/OR USING THIS WORK YOU AGREE TO THE TERMS AND CONDITIONS CONTAINED AT THE END OF THIS FILE.

Resolution=60; //[20:Low, 60:Medium, 120:High]

//Battery size for long edge.
BatteryWidth=51;

//Battery size for short edge.
BatteryDepth=51;

//Battery height.
BatteryHeight=132.5;

//Extra space for each side of the battery.
Tolerance=1;

//Wall thickness.
Thickness=5;

//Major rounding of the long side.
Rounding=4;

//Minor rounding for other contours.
Fillet=1;

//Rope mount diameter.
MountCutout=3.5;

//Rope mount outer diameter.
MountRounding=5;

//Rope mount vertical size.
MountHeight=22;

//Rope mount horizontal size.
MountWidth=12;

//Rope mount vertical spacing.
MountSpacing=50;

//Rope mount horizontal inset.
MountInset=8;

//Cutout rounding.
Cutouts=30;

//Cutout size.
CutoutSpacing=75;

//Math//
XBatt=BatteryWidth+Tolerance*2;
YBatt=BatteryDepth+Tolerance*2;
XSize=XBatt*2+Thickness*3;
YSize=YBatt+Thickness*2;
ZSize=BatteryHeight;
$fn=Resolution;
//Math//


//Upper Cord Mounts//
translate([XSize/2-MountInset,YSize/2,MountSpacing]) {
    MountShape();
}

translate([-XSize/2+MountInset,YSize/2,MountSpacing]) {
    MountShape();
}

translate([XSize/2-MountInset,-YSize/2,MountSpacing]) {
rotate([0,0,180])
    MountShape();
}

translate([-XSize/2+MountInset,-YSize/2,MountSpacing]) {
rotate([0,0,180])
    MountShape();
}

//Lower Cord Mounts//
translate([XSize/2-MountInset,YSize/2,-MountSpacing]) {
    MountShape();
}

translate([-XSize/2+MountInset,YSize/2,-MountSpacing]) {
    MountShape();
}

translate([XSize/2-MountInset,-YSize/2,-MountSpacing]) {
rotate([0,0,180])
    MountShape();
}

translate([-XSize/2+MountInset,-YSize/2,-MountSpacing]) {
rotate([0,0,180])
    MountShape();
}


//Test Shapes//
/*
color("darkblue",1)
translate([0,0,Thickness/2]) {
translate([XBatt/2+Thickness/2,0,0])
cube([51,51,130],true);

translate([-XBatt/2-Thickness/2,0,0])
cube([51,51,130],true);
}

color("Orange")
translate([-3,0,66])
cube(1,true);
*/


//Main Body//
difference() {
hull() {
translate([XSize/2-Fillet/2,YSize/2-Rounding/2-Fillet/2,ZSize/2-Rounding/2-Fillet/2])
Shape();

translate([-XSize/2+Fillet/2,YSize/2-Rounding/2-Fillet/2,ZSize/2-Rounding/2-Fillet/2])
Shape();

translate([XSize/2-Fillet/2,-YSize/2+Rounding/2+Fillet/2,ZSize/2-Rounding/2-Fillet/2])
Shape();

translate([-XSize/2+Fillet/2,-YSize/2+Rounding/2+Fillet/2,ZSize/2-Rounding/2-Fillet/2])
Shape();

translate([XSize/2-Fillet/2,YSize/2-Rounding/2-Fillet/2,-ZSize/2+Rounding/2+Fillet/2])
Shape();

translate([-XSize/2+Fillet/2,YSize/2-Rounding/2-Fillet/2,-ZSize/2+Rounding/2+Fillet/2])
Shape();

translate([XSize/2-Fillet/2,-YSize/2+Rounding/2+Fillet/2,-ZSize/2+Rounding/2+Fillet/2])
Shape();

translate([-XSize/2+Fillet/2,-YSize/2+Rounding/2+Fillet/2,-ZSize/2+Rounding/2+Fillet/2])
Shape();
}

color("DarkBlue",1)
translate([0,0,Thickness/2]) {
translate([XBatt/2+Thickness/2,0,0])
cube([XBatt,YBatt,BatteryHeight],true);

translate([-XBatt/2-Thickness/2,0,0])
cube([XBatt,YBatt,BatteryHeight],true);
}


color("DarkRed")
hull() {
translate([XSize/4-Thickness/4,0,CutoutSpacing/2])
rotate([90,0,0])
cylinder(YSize+1,Cutouts/2,Cutouts/2,true);

color("DarkRed")
translate([XSize/4-Thickness/4,0,-CutoutSpacing/2])
rotate([90,0,0])
cylinder(YSize+1,Cutouts/2,Cutouts/2,true);
}


color("Orange")
hull() {
translate([-XSize/4+Thickness/4,0,CutoutSpacing/2])
rotate([90,0,0])
cylinder(YSize+1,Cutouts/2,Cutouts/2,true);

color("Orange")
translate([-XSize/4+Thickness/4,0,-CutoutSpacing/2])
rotate([90,0,0])
cylinder(YSize+1,Cutouts/2,Cutouts/2,true);
}


color("Green")
hull() {
translate([0,0,CutoutSpacing/2])
rotate([0,90,0])
cylinder(XSize+1,Cutouts/2,Cutouts/2,true);

color("Green")
translate([0,0,-CutoutSpacing/2])
rotate([0,90,0])
cylinder(XSize+1,Cutouts/2,Cutouts/2,true);
}

/*
translate([0,0,-ZSize])
cube([XSize,YSize,ZSize],false);
*/
}


//Modules//
module Shape() {
rotate([0,90,0])
rotate_extrude()
translate([Rounding/2,0,0])
circle(Fillet/2,true,$fn=$fn/4);
}


module MountShape() {
difference() {
hull() {
cube([MountWidth,0.0001,MountHeight],true);
translate([0,MountRounding/2,0])
    cylinder(MountHeight/3,MountRounding/2,MountRounding/2,true);
}

translate([0,MountCutout/2,0])
color("SteelBlue")
    cylinder(MountHeight+1,MountCutout/2,MountCutout/2,true);
}
}


//License Conditions 

//Rights: 
//Save and privately distribute modified copies for the sole purpose of convenience, provided the license remains included and unmodified. 
//Use this design in a commercial setting provided it is on a single case basis. 
//Review the code and values for learning purposes. 
//Display this design in a public setting provided the appropriate attributions are included and clearly visible. 

//Conditions (without prior written permission): 
//Sell, gain profit from or relicense this design in any format or by any means, commercially or otherwise. 
//Directly copy sections of code for any other project or design. 
//Publicly redistribute or host this file. 
//The design owner can revoke all rights at any time, including all use, for any reason. Sorry.