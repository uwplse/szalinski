// Width of the phone when held in landscape (mm)
iPhoneWidth = 128;	
// Height of the phone when held in landscape (mm)	
iPhoneHeight = 63;
// Thickness of the phone (mm)
iPhoneDepth = 11.5; 
// Slots on Side (pick 2 for iphones)
slots = 2; // [1,2]	

/* [Hidden] */
mountThickness = 2; // How thick to make the base of the mount.

difference() {

// Main Box
	cube([iPhoneWidth+2*mountThickness,iPhoneDepth+2*mountThickness,3/4*(iPhoneHeight+mountThickness)]);
	translate([mountThickness,mountThickness,mountThickness]) cube([iPhoneWidth,iPhoneDepth,iPhoneHeight+mountThickness]);
	
// Front Cutout
	translate([(iPhoneWidth+2*mountThickness)/2,iPhoneDepth+mountThickness-1,(iPhoneHeight+mountThickness)/2])rotate([-90,0,0])cylinder(r=iPhoneWidth/2-4,h=mountThickness+2);

// Dual Slot Logic
    if (slots==2) { 
		// Lightning Adpators
        hull (){
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2, (iPhoneHeight+mountThickness)/2-5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2, (iPhoneHeight+mountThickness)/2+5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }

        hull () {
            translate([iPhoneWidth+mountThickness*1.5,(iPhoneDepth+2*mountThickness)/2, (iPhoneHeight+mountThickness)/2-5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([iPhoneWidth+1.5*mountThickness,(iPhoneDepth+2*mountThickness)/2, (iPhoneHeight+mountThickness)/2+5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }

		// Power Buttons
        hull () {
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2, mountThickness+4]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2,mountThickness+14]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }

        hull () {
            translate([iPhoneWidth+mountThickness*1.5,(iPhoneDepth+2*mountThickness)/2, mountThickness+4]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([iPhoneWidth+1.5*mountThickness,(iPhoneDepth+2*mountThickness)/2, mountThickness+14]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }
    }

// Single Slot Logic
    if (slots==1) {
    hull () {
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2, mountThickness+4]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([mountThickness/2,(iPhoneDepth+2*mountThickness)/2,iPhoneHeight*3/4-5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }

        hull () {
            translate([iPhoneWidth+mountThickness*1.5,(iPhoneDepth+2*mountThickness)/2, mountThickness+4]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
            translate([iPhoneWidth+1.5*mountThickness,(iPhoneDepth+2*mountThickness)/2, iPhoneHeight*3/4-5]) rotate ([0,90,0]) cylinder(r=3,h=mountThickness+2, center=true);
        }
    }

// Expansion Slots
for (z = [.1,.2,.3,.4,.5,.6,.7,.8,.9]) {
	hull () {
	translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.30]) rotate ([90,0,0]) cylinder(r=1,h=mountThickness+2, center=true);
		translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.20]) rotate ([90,0,0]) cylinder(r=3,h=mountThickness+2, center=true);
		translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.10]) rotate ([90,0,0]) cylinder(r=1,h=mountThickness+2, center=true);
	}
}

for (z = [.05,.15,.25,.35,.45,.55,.65,.75,.85,.95]) {
	hull () {
		translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.6]) rotate ([90,0,0]) cylinder(r=1,h=mountThickness+2, center=true);
		translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.5]) rotate ([90,0,0]) cylinder(r=3,h=mountThickness+2, center=true);
		translate([(iPhoneWidth+2*mountThickness)*z,mountThickness/2, (iPhoneHeight+mountThickness)*.4]) rotate ([90,0,0]) cylinder(r=1,h=mountThickness+2, center=true);
	}
}


}

// Repair Base
difference() {
		cube([iPhoneWidth+2*mountThickness-4,iPhoneDepth+2*mountThickness-4,iPhoneHeight+mountThickness-4]);
	translate([-2,-2,mountThickness]) cube([iPhoneWidth+2*mountThickness+4,iPhoneDepth+2*mountThickness+4,iPhoneHeight+mountThickness+4]);
}

// Mount Attachement
difference() {
	translate([(iPhoneWidth+2*mountThickness)/2-15,-6,iPhoneHeight/2-3]) cube([30,6+mountThickness,17]);
	translate([(iPhoneWidth+2*mountThickness)/2-13,-4,iPhoneHeight/2-4]) cube([26,4,15]);
	translate([(iPhoneWidth+2*mountThickness)/2-16,0,iPhoneHeight/2-10]) rotate([45,0,0]) cube([32,5,15]);
}