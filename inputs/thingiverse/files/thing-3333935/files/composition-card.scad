// Width of aspect ratio, 16 for 16x9.
asp_width = 4;

// Height of aspect ratio, 9 for 16x9.
asp_height = 3;

// Width of viewport in mm.
abs_width = 100;

// Thickness of frame in mm.
frame_thick = 10;

// Thickness of model along the z axis.
z_thick = 2.5;

// Calculated aspect ratio for calculating the height.
asp_ratio = asp_height/asp_width;
// Calculated outer width in mm
out_width = abs_width + (frame_thick * 2);
//Calculated outer height in mm
out_height = (abs_width*asp_ratio) + (frame_thick * 2);
//Calculated inner height in mm
in_height = abs_width*asp_ratio;

difference() {
    cube([out_width, out_height, z_thick]);
    
    translate([frame_thick,frame_thick,0])
        cube([abs_width, in_height, z_thick]);
}

translate([out_width/2,frame_thick/2,z_thick])
    linear_extrude(1)
    text(str(asp_width, ":", asp_height), valign="center", halign="center", size=frame_thick*.75);

translate([0,(in_height*.333)+frame_thick,0])
    cube([out_width,1,1]);

translate([0,(in_height*.666)+frame_thick,0])
    cube([out_width,1,1]);

translate([(abs_width*.333)+frame_thick,0,0])
    cube([1,out_height,1]);

translate([(abs_width*.666)+frame_thick,0,0])
    cube([1,out_height,1]);
