// Air vent mount for my Samsung Galaxy S / Nexus 4 holders
// by Len Trigg <lenbok@gmail.com>

// Mount for air vent grill. Adust these as needed


// Outer height of two horizontal vent slats. Total height will be this plus two prong thicknesses
VentSlatsHeight = 25.8;  

// Thickness of prongs holding onto slats (higher = stronger)
VentProngThickness = 2.6;  

// Depth of prongs into air vent slats
VentProngDepth = 18;      

// Width of each of the prongs protruding into air vent
VentProngWidth = 12;   

// How much the hook end of the prong sticks out, i.e. grippiness
VentProngHookRad = 3;  

// Thickness of the plate that bolts to phone mount
MountPlateThickness = 9;     

// Extra rebate for clearing the vent direction adjustment thingy
MountPlateExtraThickness = 7.5;  

// Total width of the mount
TotalMountWidth = 43;

// Include support
Support = "no";  // [yes,no]

module bolthole(r1=2, r2=4, h1=10, h2=10) {
    sinkheight = r2 - r1;
    cylinder(r = r1, h = h1 + 0.01);
    translate([0, 0, h1]) cylinder(r = r2, h = h2);
}

// Mounting point characteristics
// Must match the phone holder parts, so probably don't mess with them
screwSeparation = 10;
screwRad = 3.5/2;
screwDepth = 10;
screwHeadRad = 6.6/2;
screwHeadDepth = 3.5;

sthick=0.3; // Thickness of support layer. This should be set to the printed layer thickness


fudge = 0.01;
module wedge(r = 7, a = 225) {
    if (a <= 180) {
        difference() {
            circle(r = r);
            translate([-fudge, -r-fudge]) square([r*2+0.1, r*2+0.1], center=true);
            rotate([0,0,a]) translate([-fudge, r+fudge]) square([r*2+0.1, r*2+0.1], center=true);
        }
    }
    if (a > 180) {
        difference() {
            circle(r = r);
            rotate([0,0,a]) wedge(r = r +0.1, a = 360 - a);
        }
    }
}


ventmountw=VentSlatsHeight+2*VentProngThickness;  // Outer width of mount (i.e. height when attached to vent)
ventmounth=VentProngDepth+MountPlateThickness+MountPlateExtraThickness; // Total front to back of mount
module ventmountprofile() {
    difference() {
        union() {
            square([ventmountw,ventmounth]);
            //translate([VentProngThickness,ventmounth]) rotate([0,0,45]) square([VentProngHookRad*2,VentProngHookRad*2],center=true);
            //translate([ventmountw-VentProngThickness,ventmounth]) rotate([0,0,-45]) square([VentProngHookRad*2,VentProngHookRad*2],center=true);
        }
        translate([VentProngThickness+5, MountPlateThickness]) square([ventmountw-2*VentProngThickness-10,ventmounth-MountPlateThickness]);
        translate([VentProngThickness, MountPlateThickness+MountPlateExtraThickness]) square([ventmountw-2*VentProngThickness,ventmounth-(MountPlateThickness+MountPlateExtraThickness)+0.1]);
        translate([0,0]) rotate([0,0,45]) square([VentProngHookRad*2,VentProngHookRad*2],center=true);
        translate([ventmountw,0]) rotate([0,0,45]) square([VentProngHookRad*2,VentProngHookRad*2],center=true);

    }
    translate([VentProngHookRad,ventmounth]) rotate([0,0,-15]) wedge(r=VentProngHookRad,center=true,$fn=12,a=195);
    translate([ventmountw-VentProngHookRad,ventmounth]) rotate([0,0,0]) wedge(r=VentProngHookRad,center=true,$fn=12,a=195);
}

supporth=MountPlateExtraThickness+VentProngDepth+VentProngHookRad;
module ventmount() {
    sw=2;
    sf=5;
    translate([-ventmountw/2,0,0]) {
        difference() {
            linear_extrude(height=TotalMountWidth) ventmountprofile();
            // Nut holes
            translate([ventmountw/2, MountPlateThickness+0.01, TotalMountWidth/2 + screwSeparation/2]) rotate([90,0,0]) bolthole(r2=screwRad,r1=screwHeadRad, h2=screwDepth,h1=screwHeadDepth,$fn=6);
            translate([ventmountw/2, MountPlateThickness+0.01, TotalMountWidth/2 - screwSeparation/2]) rotate([90,0,0]) bolthole(r2=screwRad,r1=screwHeadRad, h2=screwDepth,h1=screwHeadDepth,$fn=6);
            translate([-ventmountw/2, MountPlateThickness+0.01, VentProngWidth]) cube([ventmountw*2, ventmounth, TotalMountWidth-2*VentProngWidth]);
        }
    }
    if (Support == "yes") {
        for (m = [0,1]) {
            mirror([m,0,0]) {
                translate([ventmountw/2-12-sf, MountPlateThickness+1, 0]) cube([sf, supporth, 0.5]);
                translate([ventmountw/2-12, MountPlateThickness+1, 0]) cube([sw, supporth, TotalMountWidth-VentProngWidth]);
                translate([ventmountw/2-12, MountPlateThickness+1, TotalMountWidth-VentProngWidth-sthick]) cube([15, supporth, sthick]);
                translate([ventmountw/2+1, MountPlateThickness+1, 0]) cube([sw, supporth, TotalMountWidth-VentProngWidth]);
                translate([ventmountw/2+1, MountPlateThickness+1, 0]) cube([sw+sf, supporth, 0.5]);
            }
        }
   }
}

translate([0,ventmounth/2,0]) rotate([0,0,180]) ventmount();
