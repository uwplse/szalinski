Ri = 74/2; // Internal radius.
Thickness = 6;
Width = 8;
ScrewRadius = 3/2+0.25;   // plus a bit
NutInscribedRadius = 5.5/2 + 0.2;  // plus a bit
NutThickness = 2.5 + 0.2; // plus a bit

// No need to modify those:
NutCircumscribedRadius = NutInscribedRadius/cos(30);
e=2;  // epsilon for subtraction.

$fn = 50;

// rotate([180,0,0])
AnchorRing();

translate([0, 0, -1.5*Width-1])
MobileRing();



module AnchorRing()
{
    Ring();
    translate([Ri+Thickness*1.75,-12,0]) ScrewHolder(true);
    translate([Ri+Thickness*1.75, 12,0]) ScrewHolder(true);
}

module MobileRing()
{
    Ring();
    Peg();
}


module Ring()
{
    difference()
    {
        // rotate_extrude($fn=50)
        //     polygon(
        //         points=[
        //             [Ri+Thickness, -Width/2], [Ri+Thickness, Width/2],
        //             [Ri+1, Width/2], [Ri,Width/2-1], [Ri, -Width/2+1], [Ri+1, -Width/2]
        //         ]
        //     );
        cylinder(r=Ri+Thickness, h=Width, center=true);
        cylinder(r=Ri, h=Width+e, center=true);
        // HexHoles();
        translate([-(Ri+Thickness/2-e), 0, 0])
            cube([Thickness+2*e, 4, Width+2*e], center=true);
    }
    translate([-Ri-1.75*Thickness,-(4+NutThickness/2), 0]) rotate([0,0,180]) ScrewHolder(true);
    translate([-Ri-1.75*Thickness,  4+NutThickness/2, 0]) rotate([0,0,180]) ScrewHolder(false);
}


module HexHoles()
{
    for(i=[0:2])
    {
        rotate([0,0,120*i])
        {
            translate([-Ri-0.5*Thickness,0,0])
            {
                rotate([0,90,0])
                {
                    cylinder(r=ScrewRadius, h=Thickness+2*e, center=true, $fn=30);    // Holding Screw Holes.
                    cylinder(r=NutCircumscribedRadius, h=NutThickness, center=true, $fn=6); // Nut gaps
                }
                translate([0,0,0.25*Width+e])
                    cube([NutThickness, NutInscribedRadius*2, 0.5*Width], center=true); // Nut Entry Hole.
            }
        }
    }
}


module ScrewHolder(withNut)
{
    difference()
    {
        union()
        {
            translate([-Thickness*0.25,0,0])
                cube([NutInscribedRadius*2+3+Thickness*0.5, NutThickness+4, Width], center=true);
        }
        rotate([90,30,0])
        {
            cylinder(r=ScrewRadius, h=Thickness+2*e, center=true, $fn=20);
            if(withNut)
            {
                cylinder(r=NutCircumscribedRadius, h=NutThickness, center=true, $fn=6);
            }
        }
        if(withNut)
        {
            translate([0, 0, 0.25*Width+e])
                cube([NutInscribedRadius*2, NutThickness, Width*0.5+e], center=true);
        }
    }
    if(!withNut)
    {
        translate([0, -NutThickness/2-1, 0])
        difference()
        {
            sphere(r=0.95*Width/2);
            rotate([90,0,0])
                cylinder(r=ScrewRadius, h=Width, center=true)
            translate([0, +NutThickness+2, 0])
                cube([Width+1, Width, Width+1], center=true);
        }
    }
}


module Peg()
{
    translate([Ri+Thickness*1.75, 0,0])
    {
        difference()
        {
            translate([-Thickness*0.25,0,0])
                cube([NutInscribedRadius*2+2+Thickness*0.5, Thickness*0.8, Width], center=true);
            translate([Width/sqrt(2),0,-Width/2]) rotate([0,45,0])
                cube([Width, Thickness+2*e, Width], center=true);
        }
        translate([NutInscribedRadius + 1.5 - Width/2, 0, 1.25*Width+0.5])
            cube([Width-1, Thickness*0.8, 1.5*Width+1], center=true);
    }
}
