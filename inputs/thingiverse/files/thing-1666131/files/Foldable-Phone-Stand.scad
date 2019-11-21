// Height of the stand
Height = 20;
// Length of the stand
Length = 60;
// Thickness of the stand wall..
Thickness = 3;
// You should give at least 1mm to 2mm more than the actual thickness.
PhoneThickness = 9;
// The angle (in degrees) that the holder is tilted at.
Tilt = 70;

/* [Hidden] */
$fa = 6;
$fs = 0.5;

// Plate: Flat portion of the stand. We have two of these, so we'll make it a module.
module Plate() {
    rotate([90,0,0])
        linear_extrude(Thickness)
            union() {
                polygon([
                    [0,0],[0,Height],
                    [Length-2,Height],[Length,Height-2],
                    [Length,2],[Length-2,0]]
                );
                translate([Length-2,Height-2]) circle(r=2);
                translate([Length-2,2]) circle(r=2);
            }
}

// PhoneSlot: Cut slot for phone. We have two of these, so we'll make it a module.
module PhoneSlot() {
    translate([Length-4-PhoneThickness/2*sin(Tilt),50,2+PhoneThickness/2*cos(Tilt)])
        rotate([90,Tilt,0])
            linear_extrude(100)
                translate([-100,-(PhoneThickness-4)/2,0])
                    offset(r=2)
                        square([100-2,PhoneThickness-4]);
}

// Outer Half
difference() {
    union() {
        translate ([0,-0.5,0]) Plate();
        cylinder(h=Height,r=Thickness+0.5);
    }
    cylinder(h=Height+5,r=Thickness/2+0.75); // Cut center hole    
    translate ([0,0,Height/4]) cylinder(h=Height/2,r=Thickness+1); // Slot
    PhoneSlot();
}

// Inner Half
union() {
    difference() {
        union() {
            translate ([0,Thickness+0.5,0]) Plate();
            translate ([0,0,Height/4+0.5]) cylinder(h=Height/2-1,r=Thickness+0.5);
        }
        cylinder(h=Height/4+0.5,r=Thickness+1); // Bottom Slot
        translate ([0,0,Height*3/4-0.5]) cylinder(h=Height/4+0.5,r=Thickness+1); // Top Slot
        PhoneSlot();
    }
    cylinder(h=Height,r=Thickness/2); // Cut center hole    
}
