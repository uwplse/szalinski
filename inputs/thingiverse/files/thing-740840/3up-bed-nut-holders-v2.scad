// 3up bed nut holders, customizable
// 
// original [1.5.1] 3uP - Metal H-Bot Upgrade for QUBD Two-Up by DDeGonge888
// scad by dieck

// Licensed under the Creative Commons - Attribution-NonCommercial-ShareAlike 4.0 International
// NonCommercial is inherited from [1.5.1] 3uP - Metal H-Bot Upgrade for QUBD Two-Up by DDeGonge888 and will be dropped if the license changes accordingly

// version 2


// Height of bed nut holder from extrusion frame to top. Common values 21 or 23.
height = 21;// [7:99]

// Extrusion frame size
frame_size = 20; // [20:Profile 5 20x20,30: Profile 6 30x30,40: Profile 8 40x40]

// Extrusion frame nut screw size
frame_screw_size = 5; // [3: M3, 4: M4, 5: M5, 6: M6, 8: M8]

// Extrusion frame mount nose width
frame_nose_width = 4; // [3: 3mm, 4: 4mm, 5: 5mm, 6: 6mm, 8: 8mm]

// Bed holder screw size
bed_screw = 3; // [3: M3, 4: M4, 5: M5]


/*
changelog:
v2, 26.03.2015
added cone cutout to nose for easier printing laying on the side
*/



include <MCAD/nuts_and_bolts.scad>

// base plate
difference() {

// structure
union() {
    // base plate
    cube([15, 14, 7]);
    // next layer
    translate([0,4,7]) cube([15, 10, height-7]); // hier sind die 23: oberkante Terasse
    // terrace
    difference() {
        translate([0,4,height-6.5]) cube([15,19,6.5]);
        color([1,0,0]) union() {
            translate([-0.5,14+4,height-7]) cube([16,5.5,4.5]);
            translate([-0.5,14+5.7/2,(height-6.5)-5.7/2]) rotate([45,0,0]) cube([16,5.7,4]);
        }
    }
    // small step opposite to terrace
    translate([0,4,7]) cube([15,1.5,20]);
    // tower
    translate([0,5.5,0]) cube([15,4.5,frame_size+height-2]); // -2 for rounded extrusion frames
    // nose
    translate([7.5,10.75,(frame_size/2)+height]) cube([15,1.5,frame_nose_width], center=true);
}

// removals
color([1,0,0]) union() {
        // mount screw hole
        rdm = (frame_screw_size+0.2)/2;
        translate([7.5,5.5+7,(frame_size/2)+height]) rotate([90,0,0]) cylinder(8, r=rdm, $fn = 360);
        
        // v2: widen for easier printing laying on the side
        rdmout = ((frame_screw_size+1.5+0.2)/2) * 1.1; // let's go for a little more than 45°
        translate([7.5,11.6,(frame_size/2)+height]) rotate([90,90,0]) cylinder(h=1.6, r1=rdmout, r2=rdm, $fn=360);
    
        // screw headroom
        rdmh = (frame_screw_size * 1.7) / 2;
        translate([7.5,5.5,(frame_size/2)+height]) rotate([90,0,0]) cylinder(2, r=rdmh, $fn = 360);

        // nut hole
        translate([7.5,7.5,1.5]) rotate([0,0,30]) nutHole(bed_screw);

        // poor man's solution to get a even sized insert hole 
        // slowing pulling out the nut
        for ( i = [7.5 : -bed_screw/2 : -bed_screw ] ) {
            translate([7.5,i,1.5]) rotate([0,0,30]) nutHole(bed_screw);
        }

        // long bed screw hole
        rdb = (bed_screw+0.2)/2;
        translate([7.5,7.5,-2]) cylinder(2+(height-5), r=rdb, $fn = 360);
    
} // removals union

} // main difference

        rdm = (frame_screw_size+0.2)/2;
        rdmout = ((frame_screw_size+1.5+0.2)/2) * 1.1; // let's go for a little more than 45°

