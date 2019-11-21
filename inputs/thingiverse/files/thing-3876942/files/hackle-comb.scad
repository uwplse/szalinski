head_height = 20;
head_width = 150;

bottom_margin = 7;
top_margin = 8;
side_margins = 5;

tine_diameter = 2;

tine_pitch = 6.35;
tine_angle = 15; //from vertical
tine_length = 100;

rows = 2;

$fn= $preview ? $fn : 16;
handle_length = 150;
handle_diameter = 10;

/* [Advanced] */
mount_depth = 0;
head_depth = 0;
tines_offset = 0;
row_delta = 0; // change in tine length per row. 10 is probably a good value if desired; -1 for automatic calulation based on the tine angle. NOTE: This part is intended for display/demo purposes and should not actually be printed.
delta_multiplier = 1;

inter_row = sqrt(3)*tine_pitch/2; 
head_d = head_depth == 0 ? inter_row*(rows-1)+bottom_margin+top_margin+tine_diameter : head_depth;
tines_o = tines_offset == 0 ? bottom_margin + tine_diameter/2 : tines_offset;

module body(width, depth, height, diameter, length) {
    cube([width, depth, height]);
    translate([width/2, 0, height/2]) handle(length, diameter, height);
}

module handle(length, diameter, fillet) {
    if (length != 0 && diameter != 0) {
        rotate([90,0,0]) {
            cylinder(d1=fillet, d2=0, h=fillet);
            cylinder(d=diameter, h=length);
        }
    }

}

module tines(width, length, pitch, diameter, rows, angle, mount_length, delta) {
    inter_row = sqrt(3)*pitch/2; 
    tinec = floor(width/pitch);
    offset = (width - tinec * pitch)/2;
    d = delta ? (delta == -1 ? delta_multiplier * inter_row / sin(angle) : delta) : 0;
    translate([offset,0,mount_length]) {
        for (j = [0:rows-1]) {
            translate([j % 2 != 0 ? pitch/2 : 0,0,0]) {
                for (i = [0:(j%2) ? tinec-1 : tinec]) {
                    translate([i*pitch, j*inter_row,0]) tine((length+d*j), pitch, diameter, rows, angle, mount_length);
                }
            }
        }
    }
}

module tine(length, pitch, diameter, rows, angle, mount_length) {
    total = length + mount_length;
    rotate([angle,0,0]) union() {
        translate([0,0,-mount_length]) cylinder(d=diameter, h=mount_length + length*2/3);
        translate([0,0,length*2/3]) cylinder(d2=0, d1=diameter,h=length/3);
    }
}

difference() {
    body(head_width, head_d, head_height, handle_diameter, handle_length);
    translate([side_margins,tines_o,0]) tines(head_width - 2*side_margins, tine_length, tine_pitch, tine_diameter, rows, tine_angle, mount_depth ? mount_depth : head_d, row_delta);
}

if ($preview) {
    color("grey") translate([side_margins,tines_o,0]) tines(head_width - 2*side_margins, tine_length, tine_pitch, tine_diameter, rows, tine_angle,  mount_depth ? mount_depth : head_d, row_delta);
}