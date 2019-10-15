// printer-specific fudge setting to allow enough clearance
diameter_fudge = 0.4;

// cell dimensions, measured to 32860 cell in-hand
cell_diameter = 33 + diameter_fudge;
cell_height = 70;

// configured for Keystone "209" clip:
clip_gap = 3.5; // gap between wall of holder and battery where spring clip sits, compressed size
clip_wall = 1.78; // width of printed wall onto which clip clips
clip_top_wall_to_hook = 4.6; // minimum distance between edge of clip wall and hook on clip
clip_width = 8.15;
clip_height = 11.5;

// holder dimensions
wall_thickness = 2.0;

// calculated dimensions
box_width = cell_diameter + wall_thickness*2;
box_height = cell_height + clip_gap*2 + wall_thickness*2;
box_depth = cell_diameter + wall_thickness*2;
hole_width = cell_diameter;
hole_height = cell_height + clip_gap*2;
hole_depth = cell_diameter;

// transparent battery image
module battery(cell_height, cell_diameter) {
    cylinder(h=cell_height, d=cell_diameter, center=true, $fn=100);
}
//%battery(cell_height, cell_diameter);


difference(){
    // positive shapes
    union(){
        // main box shape
        difference(){
            cube([box_width, box_depth, box_height], center=true); // box outside
            cube([hole_width, hole_depth, hole_height], center=true); // box cutout
            translate([0,box_depth/2+clip_top_wall_to_hook,0]){cube([box_width+1, box_depth, box_height+1], center=true);} // box top cut off
        }
        // mid supports
        translate([0,-box_depth/4,cell_height/3]){cube([box_width, box_depth/2, wall_thickness],center=true);}
        translate([0,-box_depth/4,-cell_height/3]){cube([box_width, box_depth/2, wall_thickness],center=true);}
    }
    // negative shapes
    union(){
        battery(cell_height, cell_diameter);
        // clip hook hole
        translate([0,-3/2,0]){cube([clip_width, 3, box_height+1], center=true);}
        // clip indentations
        notch_depth = wall_thickness-clip_wall;
        translate([0,-(clip_height/2)+clip_top_wall_to_hook,box_height/2-notch_depth/2]){cube([clip_width,clip_height,notch_depth],center=true);}
        translate([0,-(clip_height/2)+clip_top_wall_to_hook,-box_height/2+notch_depth/2]){cube([clip_width,clip_height,notch_depth],center=true);}
        // speed holes
        rotate([90,0,0]){cylinder(h=box_width+1, d=hole_width-4,center=true);}
    }
}