//!OpenSCAD
// title      : Customizable  Table Hook
// version    : v1.0.1
// author     : Pau Drudis
// license    : MIT License
// description: A tiny customizable table hook
// file       : customizable-table-hook.scad

/******************
 *** Properties ***
 ******************/
 /*[ global properties ]*/

// Resolution of the piece
Resolution = 100;

// Thickness of hook
Thickness = 2;

/*[ properties of Pin ]*/
// Width of the pin
Pin_Width = 20;

// Height of the table skirt
Table_Height = 20.5;

// Length of the pin's top arm
Length_Top_Arm = 15;

// Length of the pin's bottom arm
Length_Bottom_Arm = 30;

// Angle of the pin's top arm
Pin_Angle = 5; // [0:0.1:10]

/*[ properties of Hook ]*/
// Width of the hook
Hook_Width = 10;

// Length of the hook
Hook_Length = 12.5;

// Height of the hook
Hook_Height = 15;

// Curvature of the hook's base
Hook_Curvature = 0.5; //[0:0.1:1]

// How curved is the hook's tongue
Tongue = 1; //[0:0.1:1]

/******************
 ***  Instance  ***
 ******************/
tableHook(thickness=Thickness, pinWidth=Pin_Width, tableHeight=Table_Height, lengthTop=Length_Top_Arm, lengthBottom=Length_Bottom_Arm, pinAngle=Pin_Angle, hookWidth=Hook_Width, hookLength=Hook_Length, hookHeight=Hook_Height, hookCurvature=Hook_Curvature, tongue=Tongue, $fn=Resolution);

/******************
 ***    Code    ***
 ******************/
module pin(width = 20, height = 21, lengthBottom = 34, lengthTop = 20, angle=0, thickness = 2) {
    difference() {
        union() {
            cube([thickness, width, height+(2*thickness)]);
            cube([thickness+lengthBottom, width, thickness]);
            translate([0, 0, height+thickness])
                rotate([0, angle, 0])
                    cube([thickness+lengthTop, width, thickness]);
        }
        translate([0, 0, height+(2*thickness)])
            rotate([0, angle, 0])
                cube([thickness+lengthTop, width, thickness]);
    }
}

module tube(height=1, diameterOut=2, diameterIn=1, center=false) {
    difference() {
        cylinder(h=height, d=diameterOut, center=center);
        translate([0, 0, -0.1])
            cylinder(h=height + 0.2, d=diameterIn, center=center);
    }
}

module tongueMold(width=20, eccentricity=0) {
    translate([0, 0, width*(1-eccentricity)/2])
        difference() {
            translate([-0.1,-0.1,0])
                cube([width+0.2, width+0.2, (width/2)+0.1]);
            rotate([0, 90, 0])
                translate([0, width/2, 0])
                    scale([1,1/eccentricity,1])
                        cylinder(h=width, d=width*eccentricity);
        }
}

module baseHook(width=20, length=20, height=15, curvature=0, thickness=2) {
    if (curvature <= 0) union() {
        cube([length+thickness, width, thickness]);
        cube([thickness, width, height+thickness]);
    }
    else {
        pipe = (min(length, height)+thickness)*2*min(1, curvature);
        union() {
            translate([pipe/2, 0, pipe/2])
                intersection() {
                    rotate([-90, 0, 0])
                        tube(height=width, diameterOut=pipe, diameterIn=pipe-(2*thickness));
                    translate([-pipe/2, 0, -pipe/2])
                        cube([pipe/2, width, pipe/2]);
                }
            translate([pipe/2, 0, 0])
                cube([length+thickness-(pipe/2), width, thickness]);
            translate([0, 0, pipe/2])
                cube([thickness, width, height+thickness-(pipe/2)]);
        }
    }
}

module hook(width=18, length=12.5, height=15, curvature=0.3, thickness=2, tongue=1) {
    difference() {
        baseHook(width=width, length=length, height=height, curvature=curvature, thickness=thickness);
        translate([-width/2, 0, height+thickness+(-width/2)])
            tongueMold(width=width, eccentricity=tongue);
    }
}

module tableHook(thickness=2, pinWidth=20, tableHeight=21, lengthTop=20, lengthBottom=34, pinAngle=0, hookWidth=18, hookLength=12.5, hookHeight=15, hookCurvature=0.3, tongue=1) {
    
    translate([0, (pinWidth-hookWidth)/2, 0])
        hook(width=hookWidth, length=hookLength, height=hookHeight, curvature=hookCurvature, thickness=thickness, tongue=tongue);
    translate([hookLength, 0, 0])
        pin(width=pinWidth, height=tableHeight, lengthBottom=lengthBottom, lengthTop=lengthTop, angle=pinAngle, thickness=thickness);
}
