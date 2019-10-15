use <nutsnbolts/cyl_head_bolt.scad>;


// open beam is 15mmx15mm
frame_size = 15;

// width of main section of this block, this block is now invisible due to the cylinder design, but it remain as a part of the design framework
block_width = 8;

// height of frame
block_height = frame_size;

// width beyond block for the mounting holes
flange_width = 10;

// how thick do we make the flanges with the mounting hole
flange_thickness = 5;

// how thick do we make the raised section supporting the rod
block_thickness = 5;

// what rod diameter do you want to use for the cross bracing (before tapping)
// M5 hardware has a drill diameter of 5mm
rod_diameter = 5;

// what wall thickness do you want beyond the rod size
wall_thickness = 3;

// mounting hole into the frame
// openbeam uses M3 hardware, which is 2.5mm (so you can tap them) and 6.5 fits the head
mount_hole_inner_diameter = 2.5;
mount_hole_outer_diameter = 6.5;
mount_countersink_depth = 3;

// height = distance between center track of top frame and bottom frame
frame_raw_height = 600;
frame_height = frame_raw_height - frame_size/2*2;

// width = length of base of triangle
frame_raw_length = 240;
frame_base_length = frame_raw_length - (block_width+flange_width*2)/2;

// the angle for the rod
angle = atan2(frame_height, frame_base_length);
echo(str("Rod angle: ", angle, " deg"));

rod_length = sqrt(pow(frame_raw_height,2)+pow(frame_raw_length,2));
echo(str("Est. rod length: ", rod_length, "mm"));

// how many sides would you like to render the cylinders with
sides = 64;

difference() {
    union() {
        // flange
        cube([block_width+flange_width*2, block_height, flange_thickness]);

        intersection() {
            // imaginary block that causes flush bottoms and tops
            translate([0,0,flange_thickness])
            cube([block_width+flange_width*2, block_height, block_thickness+flange_thickness]);
            
            // rod hole wall
            translate([flange_width+block_width/2, block_height/2, (block_thickness+flange_thickness)/2])
            rotate([90, 0, 90-angle])
            cylinder(d = rod_diameter+wall_thickness*2, h = block_height * 2, center = true, $fn = sides);
        }
    }
    
    // left mount hole
    translate([flange_width/2, block_height/2, flange_thickness/2])
    cylinder(d = mount_hole_inner_diameter, h = flange_thickness*2, center = true, $fn = sides);
    
    // left mount countersink
    translate([flange_width/2, block_height/2, flange_thickness-mount_countersink_depth])
    cylinder(d = mount_hole_outer_diameter, h = mount_countersink_depth*2, center = false, $fn = sides);
    
    // right mount hold
    translate([flange_width*1.5+block_width, block_height/2, flange_thickness/2])
    cylinder(d = mount_hole_inner_diameter, h = flange_thickness*2, center = true, $fn = sides);
    
    // right mount countersink
    translate([flange_width*1.5+block_width, block_height/2, flange_thickness-mount_countersink_depth])
    cylinder(d = mount_hole_outer_diameter, h = mount_countersink_depth*2, center = false, $fn = sides);
    
    // rod hole
    translate([flange_width+block_width/2, block_height/2, (block_thickness+flange_thickness)/2])
    rotate([90, 0, 90-angle])
    cylinder(d = rod_diameter, h = block_height * 2, center = true, $fn = sides);
}

