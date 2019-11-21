inch = 25.4*1;

$fn=32*1;

// Minimum number of bits to hold
num_total = 90; // [1:200]

// Maximum height of the holder (usually a bit less than your printer's build cube or your toolbox's drawer depth). Set to around 30 for a single row holder. (mm)
max_h = 145; // [30:450]

// How deep at the holes? (mm)
hole_depth = 13; // [3:30]

// How thick is the bottom floor? (zero for no floor, holes go all the way through)
floor_thickness = 2; // [0:10]

// Horizonal gap (tenths of a millimeter)
hgap_tenths = 8; // [0:100]
hgap = hgap_tenths/10;

// Vertical gap (tenths of a millimeter)
vgap_tenths = 70; // [0:100]
vgap = vgap_tenths/10;

// Margin around the borders (tenths of a millimeter)
margin_tenths = 30; // [0:100]
margin = margin_tenths/10;

// Include an extra gap at the bottom? (good if you're adding labels under each)
bottom_vgap = 1; // [1:Yes, 0:No]

// Extra margin in the hole. Make higher for a looser fit.
hole_tolerance_percent = 5; //[0:30]

// 1/4" flats -> circle diameter, then add tolerance
bore_dia = 1/4*inch * 2/sqrt(3) * (1+hole_tolerance_percent/100);

num_y = floor( (max_h - margin*2 - (bottom_vgap?margin:vgap))/(bore_dia + vgap) );
num_x = ceil(num_total/num_y);

w = margin*2 + (bore_dia+hgap)*num_x - hgap;
h = margin*2 + (bore_dia+vgap)*num_y - (bottom_vgap?margin:vgap);

holder_3d();
//holder_profile();

module holder_3d() {
    linear_extrude(hole_depth) holder_profile();
    translate([0,0,-floor_thickness]) linear_extrude(floor_thickness) hull() holder_profile();
}

module holder_profile() {
    difference() {
        color("red") translate([0,bottom_vgap?-vgap+margin:0]) square([w,h]);

        color("yellow") for (i=[0:num_x-1]) {
            for (j=[0:num_y-1]) {
                x = margin+bore_dia/2+(bore_dia+hgap)*i;
                y = margin+bore_dia/2+(bore_dia+vgap)*j;
                translate([x,y,0]) circle(d=bore_dia);
            }
        }
    }
}

/*
difference() {
    color("red") translate([0,bottom_vgap?-vgap:0,-floor_thickness]) cube([w,h,floor_thickness+hole_depth]);

    color("yellow") for (i=[0:num_x-1]) {
        for (j=[0:num_y-1]) {
            x = margin+bore_dia/2+(bore_dia+hgap)*i;
            y = margin+bore_dia/2+(bore_dia+vgap)*j;
            translate([x,y,0]) cylinder(d=bore_dia,h=hole_depth+1);
        }
    }
}
*/
