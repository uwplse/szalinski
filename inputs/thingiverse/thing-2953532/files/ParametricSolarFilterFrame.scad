// Parametric Solar filter frame for Baader's Astrosolar film.
// Author: Fabrice Fleurot

// DISCLAIMER: solar observation contains a real element of risk if the filter is not correctly built or fitted.
// I obviously take no responsibility: The frame I designed works for me and it's all I can say.
// If you take the risk and responsibility to print it for yourself, you're on your own! So:
// 1- read carefully Baader's instructions.
// 2- make sure the film is properly glued or taped.
// 3- make sure that the filter is fitted securely on the scope. It should not be loose.
// 4- Don't elbow it, tell the "funny" ones among your friends to not take it off as a prank, keep children, teenagers and as a general rule anyone under 30 away, use common sense. Accidents can and do happen.
// 5- double check every time you use it that the whole structure is sound, that the glue/tape is still strong and that there are not gaps or hole.
// 5a- double check again.
// 6- good luck.

// The file contains four objects: The main tube (black in photo), the front ring (white) and two caps.
// Choose which object to print below and modify the parameters to fit your telescope or finder.

// object = "tube";
object = "front ring";
// object = "small cap";
// object = "large cap";

R = 57.5/2;  // Scope external radius.
r = 50/2; // Half the scope aperture.
H = 30;   // Frame height.
lip = 20; // "lip" size around the tube.

th = 3;   // Thickness of the frame.
ribWidth = 1;   // Size of the "ribs" inside the tube.
glueGap=0.5;   // Gap between the main body and and the front ring, it needs enough for glue.
gap=0.1;     // Gap between Scope and frame.
thw = 2;     // Thickness of each of the two parts of the lip.
tapeTh = 1;   // Thickness of double-sided tape. I used 0 with glue, it was good enough.


// Epsilon for subtraction operation, no need to change:
e = 1;


if(object == "tube")
{
    //Main tube (black in photo):
    translate([0,0,thw])
        difference()  // Lip
        {
            cylinder(r=R+lip, h=thw);
            translate([0,0,-e])
                cylinder(r=r, h=thw+2*e);
        }
    translate([0,0,2*thw])
        union()
        {
            difference()
            {
                cylinder(r=R+gap+ribWidth+th, h=H);
                translate([0,0,-e])
                    cylinder(r=R+gap+ribWidth, h=H+2*e);
            }
            translate([R+gap,-ribWidth/2,0]) cube([ribWidth+e, ribWidth, H]);
            rotate([0,0,90])
                translate([R+gap,-ribWidth/2,0]) cube([ribWidth+e, ribWidth, H]);
            rotate([0,0,180])
                translate([R+gap,-ribWidth/2,0]) cube([ribWidth+e, ribWidth, H]);
            rotate([0,0,270])
                translate([R+gap,-ribWidth/2,0]) cube([ribWidth+e, ribWidth, H]);
    }
}

if(object == "front ring")
{
    difference()
    {
        cylinder(r=R+lip+th+glueGap, h=2*thw+tapeTh);
        translate([0,0,-e])
            cylinder(r=r, h=thw+2*e);
        translate([0,0,thw])
            cylinder(r=R+lip+glueGap, h=thw+tapeTh+e);
    }
}


// Large cap
if(object == "large cap")
{
    $fn=100;
    RC = R+lip+th+glueGap+ribWidth;
    translate([0,0,-thw])
    union()
    {
        difference()
        {
            cylinder(r=RC+thw, h=3*thw);
            translate([0,0,thw])
                cylinder(r=RC, h=2*thw+e);
        }
        translate([RC-ribWidth,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,90])
            translate([RC-ribWidth,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,180])
            translate([RC-ribWidth,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,270])
            translate([RC-ribWidth,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
    }
}


Rc = R+gap+ribWidth+th;
if(object == "small cap")
{
    //translate([0,0,H+3*thw]) rotate([180,0,0])
    union()
    {
        difference()
        {
            cylinder(r=Rc+ribWidth+thw, h=3*thw);
            translate([0,0,thw])
                cylinder(r=Rc+ribWidth, h=2*thw+e);
        }
        translate([Rc,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,90])
            translate([Rc,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,180])
            translate([Rc,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
        rotate([0,0,270])
            translate([Rc,-ribWidth/2,thw]) cube([ribWidth+e, ribWidth, 2*thw]);
    }
}
