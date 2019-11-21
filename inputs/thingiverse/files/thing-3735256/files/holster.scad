/*
 Simple wall-mountable holster for multi-pattern hose nozzles.
 The defaults fit a common nozzle found in Australia, but you
 can adjust the parameters to suit your nozzle.

 Main parameters are:

 - Front Diameter - diameter at the front of the gun
 - Front Width - Width to where it starts to reduce in size
 - Rear Diameter - diameter that it drops down to
 - Shoulder Width - Width of the sloping section connecting wide to narrow parts
 - Rear width - the width of the final section to hold the narrowed part
 - Length - overall length of the backplate
 - Thickness - minimum wall thickness
 - Cutout Percent - Percentage of top area to cut out to save on plastic

*/

$fa = 1;
$fs = 1;

Thickness = 2;
FrontDiameter = 58;
FrontWidth = 32;
RearDiameter =  32;
ShoulderWidth = 8;
RearWidth = 9;
Thickness = 2;
HangerWidthPercentage = 33;
HangerLength = 45;
HoleRadius = 2.5;

// Derived values
HoleOffset = HoleRadius * 2.5;
FrontRadius = FrontDiameter/2;
RearRadius = RearDiameter/2;
FrontOuterRadius = FrontRadius + Thickness;
RearOuterRadius = RearRadius + Thickness;
BasePlateWidth = FrontDiameter + 2*Thickness;
HangerWidth = HangerWidthPercentage * FrontOuterRadius * 2 / 100;
HangerGap = BasePlateWidth - HangerWidth * 2;


module basePlate() {
    translate([-1*FrontOuterRadius,-1*FrontOuterRadius,0]){
        difference(){
            // Create the rounded bottom top baseplate
            union(){
                cube([FrontOuterRadius,BasePlateWidth,Thickness]);         
                intersection(){
                    translate([FrontOuterRadius,0,0]){
                        cube([FrontOuterRadius,BasePlateWidth,Thickness]);
                    }
                    translate([FrontOuterRadius,FrontOuterRadius,0]){
                        cylinder(r=FrontOuterRadius, h=Thickness);
                    }
                }
            }
            // Cut out a rounded bottom slot to reduce plastic
            translate([0, HangerWidth, 0]){
                cube([BasePlateWidth-HangerWidth*3/2, HangerGap, Thickness]);
                translate([BasePlateWidth-HangerWidth*3/2,HangerGap/2,0]){
                    cylinder(r=HangerGap/2, h=Thickness);
                }
            }
            // Add the mounting holes
            translate([HoleOffset,HoleOffset,0]){
                cylinder(r=HoleRadius, h=Thickness);
            }
            translate([HoleOffset,BasePlateWidth-HoleOffset,0]){
                cylinder(r=HoleRadius, h=Thickness);
            }       
        }

    }
    translate([FrontOuterRadius - Thickness,-1 * HangerWidth / 2,0]){
        difference(){
            cube([HangerLength,HangerWidth,Thickness]);
            translate([HangerLength - HoleOffset,HangerWidth/2,0]){
                cylinder(r=HoleRadius, h=Thickness);
            }
        }
    }
}

module supportStrut() {
    difference(){
        translate([FrontOuterRadius-Thickness/2,-1*Thickness/2,0]){
            intersection() {
                cube([HangerLength/2,Thickness,HangerLength/2]);
                rotate([0,90,90]) {
                    cylinder(r=HangerLength/2, h=Thickness);
                }
            }
        }
        cylinder(r=FrontOuterRadius, h=HangerLength/2);
    }
}

module holster() {
    // Two sidewalls to extend structure to front of conical section
    // with enough front clearance to get to the mounting holes
    translate([-1 * FrontOuterRadius + HoleOffset*2,-1 * FrontOuterRadius,0]){
        cube([FrontOuterRadius-HoleOffset*2,Thickness,FrontWidth]);
    }
    translate([-1 * FrontOuterRadius + HoleOffset*2,FrontRadius,0]){
        cube([FrontOuterRadius-HoleOffset*2,Thickness,FrontWidth]);
    }
    // Bottom half-circle holding the wider part
    difference(){
        cylinder(r=FrontOuterRadius,h=FrontWidth + Thickness/2);
        cylinder(r=FrontRadius,h=FrontWidth + Thickness/2);
        translate([-1 * FrontOuterRadius,-1 * FrontOuterRadius,0]) {
            cube([FrontOuterRadius,BasePlateWidth,FrontWidth + Thickness/2]);
        }
        translate([FrontOuterRadius, 0, 0]){
            rotate([0,-90,0]){
                cylinder(r=HoleRadius*2, h=Thickness*2);
            }
        }
    }
    // Cone connecting wider part with narrow neck
    translate([0,0,FrontWidth]){
        intersection(){
            cylinder(r=FrontOuterRadius,h=ShoulderWidth);
            difference(){
                cylinder(r1=FrontOuterRadius+Thickness, r2=RearOuterRadius, h=ShoulderWidth);
                cylinder(r1=FrontRadius, r2=RearRadius, h=ShoulderWidth-Thickness);
                cylinder(r=RearRadius, h=ShoulderWidth+Thickness/2);
                translate([-1*FrontOuterRadius,-1*FrontOuterRadius,0]) {
                    cube([FrontOuterRadius,BasePlateWidth,ShoulderWidth+Thickness/2]);
                }
            }
        }
    }
    translate([0,0,38]){
        difference(){
            cylinder(r=RearOuterRadius, h=RearWidth);
            cylinder(r=RearRadius, h=RearWidth);
            translate([-1*RearOuterRadius,-1*RearOuterRadius,0]){
                cube([RearOuterRadius,RearOuterRadius*2,RearWidth]);
            }
        }
    }
}

basePlate();
supportStrut();

// Puts the holster above the baseplate
translate([0,0,Thickness]){
    holster();
}
