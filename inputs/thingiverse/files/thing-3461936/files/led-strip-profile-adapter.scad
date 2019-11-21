// led_strip_profile_adapter.scad
// Adapter for led strips with mount for Aluminum Profile
// Author: Dor Yosef, Beer sheva (Israel) 
// last update: March 2019

use <utils/build_plate.scad>


// Print Led Strip Board
print_board = 1; //[1:YES,0:NO]

// Print Mounts
print_profile_mounts = 1; //[1:YES,0:NO]

/* [Led Strip dimension] */

// Led Strip Width
led_width = 9;

//Led Strip height 
led_height = 2.5;

/* [Board] */

// Number Of Led Strips
led_strips = 3; //[1:100]

// Board X axis Long
board_long = 180;

// Board Z Height
board_height = 5; //[3:15]

/* [Aluminum Profile Mount] */

// Aluminum Profile Dimension
profile_size = 30;

// Mount Z Height
holder_height = 30; //[10:50]

// Mount Offset (Angle)
mount_angle_offset = 25;

/* [hidden] */
ROUND_CUBE_REDIUS = 0.9;
MOUNT_HOLES_REDIUS = 2;
led_border_width=2;

build_plate(3,400,400);

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
    // Higher definition curves
    $fs = 0.5;
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

module ledBoard( ledStrips=3, 
                  boardLong=300, 
                  ledWidth=9, 
                  ledheight=2.5, 
                  ledBorderWidth=2, 
                  boardHeight=5 ) {
            
    //boaed
    roundedcube([boardLong, 
        (ledWidth*ledStrips)+(ledBorderWidth*(ledStrips+1)), boardHeight], radius=ROUND_CUBE_REDIUS);
            
            
    
    SIDE_OFFSET = 20;
    for(i=[0: ledWidth+ledBorderWidth: (ledWidth+ledBorderWidth)*(ledStrips)]){
        translate([SIDE_OFFSET/2, i, boardHeight]) {
            cube([boardLong-SIDE_OFFSET, ledBorderWidth, ledheight]);
            $fn=10;
                translate([0, ledBorderWidth/2, ledheight]) {
                rotate([0,90,0])
                    
                    cylinder(r=(ledBorderWidth/2)*1.3, 
                    h=boardLong-SIDE_OFFSET);
            }
        }
    }
    
    // sides
    {
        $fn=10;
        SIDE_CYLINDER_HEIGHT = 10;
        //left
        translate([0,(ledWidth+ledBorderWidth)*(ledStrips) /2,boardHeight/2])
        rotate([0,-90,0])
            cylinder(r=MOUNT_HOLES_REDIUS, h=SIDE_CYLINDER_HEIGHT);
        
        //right
        translate([boardLong,(ledWidth+ledBorderWidth)*(ledStrips) /2,boardHeight/2])
        rotate([0,90,0])
            cylinder(r=MOUNT_HOLES_REDIUS, h=SIDE_CYLINDER_HEIGHT);
    }
}

module aluminumProfileBoardMount( profileSize=30, 
                                  holderHeight=30,
                                  mountAngleOffset = 25) { 
    $fn=10;
    MOUNT_WIDTH = 15;
    MOUNT_HEIGHT = 6;
                                      
    difference() {
        roundedcube([profileSize, MOUNT_WIDTH, MOUNT_HEIGHT], 
        redius= ROUND_CUBE_REDIUS);
        translate([profileSize/2, MOUNT_WIDTH/2, -0.5])
            cylinder(d=5, h=MOUNT_HEIGHT+1);
    }
    HOLDER_WIDTH = 4;
    OFFSET_FROM_PROFILE_HOLE = 5;
    OFFSET_FROM_BOARD_EDGE = 0.5;
    // HLODER
    difference(){
        hull() {
            translate([OFFSET_FROM_BOARD_EDGE,
                      ( MOUNT_WIDTH/2 - HOLDER_WIDTH/2) , 
                        MOUNT_HEIGHT])
                cube([profileSize/2 - OFFSET_FROM_PROFILE_HOLE, 
                      HOLDER_WIDTH, 
                      OFFSET_FROM_BOARD_EDGE] );
            
            translate([-mountAngleOffset,  
                       MOUNT_WIDTH/2,
                       MOUNT_HEIGHT+holderHeight])
                rotate([0,90,0])
                    difference(){
                        cylinder(d=HOLDER_WIDTH,
                             h=profileSize/2 - OFFSET_FROM_PROFILE_HOLE);
                            translate([-HOLDER_WIDTH*0.25,-HOLDER_WIDTH/2,0]){
                                cube([HOLDER_WIDTH,
                                      HOLDER_WIDTH,
                                      profileSize/2 - OFFSET_FROM_PROFILE_HOLE]);
                        }
                    }
        }
        OFFSET_HOLDER_HOLE_FROM_TOP = 3;
        // HOLDER HOLE
        translate([-mountAngleOffset + HOLDER_WIDTH + MOUNT_HOLES_REDIUS*2 ,  
           MOUNT_WIDTH/2 + MOUNT_HOLES_REDIUS,
           MOUNT_HEIGHT+holderHeight - OFFSET_HOLDER_HOLE_FROM_TOP ])
           rotate([90,0,0])
            cylinder(d=MOUNT_HOLES_REDIUS+1, h=HOLDER_WIDTH);
    }
}

translate([-board_long/2,0,0]) {
    if(print_board)
        ledBoard(led_strips, board_long, led_width, led_height, led_border_width, board_height);
    if(print_profile_mounts)
    for (i = [1:2]) {
        translate([(profile_size+20)*i,-30,0]) 
        aluminumProfileBoardMount(profile_size,
                                    holder_height,
                                    mount_angle_offset);
    }
}
