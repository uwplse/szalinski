// defined with millimeters

// Measure your legs and put in its size (width and length)
// Frame is the upper part that holds the leg inside. You can choose thickness and height of the frame
// Brim is the slightly wider part at the bottom (not the same brim that you define in your slicer)
// Total height of the item will be add_height + frame_height
// Total width of the item will be 
//  at the top:    leg_width + frame_thickness * 2 
//  at the bottom: leg_width + frame_thickness * 2 + brim_width * 2
// Total length of the item will be
//   leg_length + frame_thickness * 2


// Narrow part of the leg
leg_width = 20.4;  // [3:0.1:200]
// Wide part of the leg
leg_length = 32.2; // [3:0.1:200]
// How much height to add
add_height = 22;   // [2:1:150]

frame_thickness = 2; // [1:1:20]
frame_height = 10;   // [3:1:50]

// Brim at the bottom for better stability
brim_width = 2; // [0:1:5]

module brim (bw, bl) {
    rotate([90,30,0]) cylinder(r=bw*1.15,h=bl, $fn=3);
}

module legy(lw, ll, ah, ft, fh, bw) {
    union () {
        difference () {
            cube([lw + ft*2, ll + ft*2, ah+fh],center=true);
            translate ([0,0,ah/2]) cube([lw, ll, fh], center=true);
        }
        translate ([-1 * (lw/2 + ft),ll/2 + ft,((ah+fh)/-2)+bw*0.575]) brim(bw,ll + ft * 2);
        translate ([(lw/2 + ft),ll/2 + ft,((ah+fh)/-2)+bw*0.575]) brim(bw,ll + ft * 2);
    }
}

legy(leg_width, leg_length, add_height, frame_thickness, frame_height, brim_width);

