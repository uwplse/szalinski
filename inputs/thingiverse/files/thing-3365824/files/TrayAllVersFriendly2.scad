///////////INCLUDES/////////

include<utils/build_plate.scad>

////////////PARAMETERS////////////

/*[Build Plate Specifications]*/

//Build plate X dimension in mm.
X_Dimension=220;
//Build plate Y dimension in mm.
Y_Dimension=220;

/*[Spool Measurements]*/

//Diameter of the inner wall of the spool, measured in mm.
Inner_Diameter=90;
//Diameter of the whole spool, measured in mm.
Outer_Diameter=180;
//Height of the negative space within the spool in mm.
Spool_Height=53;

/*[Tray Specifications]*/

//Number of Vertical Trays.
Vertical_Trays=1; //[1:1:10]
//Number of Trays around the spool.
Horizontal_Trays=3; //[2:1:15]
//Number of section in depth.
Sections_Deep=2;
//Number of sections in width.
Sections_Wide=3;
//Thickenss of the tray walls in mm.
Wall_Thickness=2;
//Length of the handle that protrudes from the tray.
Handle_Length=7;
//Outer radius of the pivot point. This should give
Pivot_Outer_Radius=4;
//Inner radius of the pivot point in mm. This should be about half the size of the screw that you will use to attach the tray.
Pivot_Inner_Radius=1;

/*[Hidden]*/

Build_Plate=3;
//Calculate height for multiple trays.
H=Spool_Height/Vertical_Trays;
Inner_Radius=Inner_Diameter/2;
Outer_Radius=(Outer_Diameter/2)-Wall_Thickness;
//Tray Width Calculator
TW=360/Horizontal_Trays;
//Tray Length
TL=Outer_Radius-Inner_Radius;
//Resolution
$fn=360;

module curve(){
    square([Wall_Thickness,H]);
}

module side(){
    translate([Inner_Radius,0,0])
        cube([TL,Wall_Thickness,H]);
}

module side2(){
    rotate([0,0,TW])
    translate([Inner_Radius,-Wall_Thickness,0])
        cube([TL+Handle_Length,Wall_Thickness,H]);
}

module depth_seperators(){
    translate([Inner_Radius,0,0]){
        for(s=[0:1:Sections_Deep-1]){
            translate([s*(TL)/Sections_Deep,0,0]){
                curve();
            }
        }
    }
}

module bottom(){
    translate([Inner_Radius,0,0])
        square([TL,Wall_Thickness]);
}

module outer(){
    translate([Outer_Radius-Wall_Thickness,0,0])
        curve();
}

module width_seperators(){
    for(s=[0:1:Sections_Wide-1]){
        rotate([0,0,(s*TW/Sections_Wide)])
            side();
    }
}

module pivot(){
    translate([Outer_Radius-Pivot_Outer_Radius,Pivot_Outer_Radius,0]){
        difference(){
            cylinder(h=H,r=Pivot_Outer_Radius);
            cylinder(h=H,r=Pivot_Inner_Radius);
        }
    }
}

module corner_clip(){
    difference(){
        translate([Outer_Radius-Pivot_Outer_Radius+Pivot_Inner_Radius,-Pivot_Outer_Radius,-.5])
            cube([Pivot_Outer_Radius*2,Pivot_Outer_Radius*2,H+1]);
        pivot();
    }
}

module children(){
    bottom();
    outer();
    depth_seperators();
}

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
module rotate_extrude2(angle=TW, convexity=2, size=Outer_Diameter+1) {

module angle_cut(angle=TW,size=1000) {
x = size*cos(angle/2);
y = size*sin(angle/2);
translate([0,0,-size])
linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
}

// support for angle parameter in rotate_extrude was added after release 2015.03
// Thingiverse customizer is still on 2015.03
angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
// Using angle parameter when possible provides huge speed boost, avoids a difference operation

if (angleSupport) {
rotate_extrude(angle=angle,convexity=convexity)
children();
} else {
rotate([0,0,angle/2]) difference() {
rotate_extrude(convexity=convexity) children();
angle_cut(angle, size);
}
}
}

build_plate(Build_Plate,X_Dimension,Y_Dimension);


    difference(){
        union(){
            rotate_extrude2();
            width_seperators();
            side2();
            pivot();
        }
        corner_clip();
    }
