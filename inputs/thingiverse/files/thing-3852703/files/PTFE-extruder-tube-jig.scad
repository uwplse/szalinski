// OpenSCAD file to create custom sized cutting jig for PTFE tubes used in 3D printer extruders.
// Setup for use with Thingiverse.com Customizer.
//
// preview[view:south east, tilt:top diagonal]
//
// Original code created August 23, 2019 by Allan M. Estes
// Posted to Thingiverse September 9, 2019. All rights reserved.

$fn=12*2;

// Customizer values:

tube_length = 46.4;
tube_diameter = 4.125;
middle_retainer = "yes";//[yes,no]
end_retainer = "yes";//[yes,no]

// Derived values:

tube_radius = tube_diameter/2;
hole_radius = tube_radius/cos(180/$fn);    // adjust diamter for holes, see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
mid_support = middle_retainer=="yes";
end_pocket = end_retainer=="yes"?2.5:0;
oa_len = tube_length + 2.5;
oa_wth = tube_radius * 6.5;
oa_hgt = tube_radius * 4.5;


// This is the length jig
difference() {
    cube([oa_len,oa_wth,oa_hgt],true);
    
    // hole for tube
    translate([2.5,0,0]) rotate([0,90,0]) cylinder(r=hole_radius,h=tube_length+2.5,center=true);

    // angled hollow
    translate([end_pocket/2,0,oa_wth*sqrt(2)/2-tube_radius/3]) rotate([45,0,0]) difference() {
        cube([oa_len-5-end_pocket,oa_wth,oa_wth],true);
        if (mid_support) cube([2.5,oa_wth+.01,oa_wth+.01],true);
    }

    // identifying text
    translate([0,0,-tube_radius/3]) rotate([45,0,0]) translate([0,tube_radius*2.5,-.6]) linear_extrude(height=.61) {
        translate([-(oa_len-5)/4,0,0]) text(str(tube_length),size=hole_radius*1.5,valign="center",halign="center");
        translate([(oa_len-5)/4,0,0]) text(str(tube_radius*2),size=hole_radius*1.5,valign="center",halign="center");
    }
    
    // lengthwise top slot
    translate([0,0,oa_hgt/2-1]) cube([oa_len+.01,tube_radius,oa_hgt],true);

    // bottom edge bevels
    for(a=[0,180]) rotate([0,0,a]) {
        translate([oa_len/2-tube_radius/3,-(oa_wth+.01)/2,-oa_hgt/2]) rotate([0,35,0])
            cube([tube_radius,oa_wth+.01,oa_hgt]);
        translate([-(oa_len+.01)/2,oa_wth/2-tube_radius/3,-oa_hgt/2]) rotate([-35,0,0])
            cube([oa_len+.01,tube_radius,oa_hgt]);
    }

    // optional hold down for end of tube
    if (end_pocket>0) translate([-oa_len/2+2.5,-(tube_radius*1.5)/2,0]) cube([end_pocket*2,tube_radius*1.5,oa_hgt]);
}

// this is the end truing jig that gets tacked onto the length jig
translate([-oa_len/2-oa_wth/2+2,0,0]) rotate([0,0,90]) difference() {
    cube([oa_wth,oa_wth,oa_hgt],true);
    
    // hole for tube
    rotate([0,90,0]) cylinder(r=hole_radius,h=oa_wth+.01,center=true);

    // angled hollow
    translate([0,0,oa_wth*sqrt(2)/2-tube_radius/3]) rotate([45,0,0])
        cube([oa_wth-2.5,oa_wth,oa_wth],true);

    // top slots and bottom edge bevels
    for(a=[0:90:270]) {
        // slots
        if (a<91) rotate([0,0,a]) translate([a/90*oa_wth/-2,0,oa_hgt/2-1]) cube([oa_wth+.01,tube_radius,oa_hgt],true);
        // bevels
        rotate([0,0,a]) translate([oa_wth/2-tube_radius/3,-(oa_wth+.01)/2,-oa_hgt/2]) rotate([0,35,0])
            cube([tube_radius,oa_wth+.01,oa_hgt]);
    }
}