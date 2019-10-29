// CHIPbag
// by Tom Owad 2015 (CC BY-NC 3.0)
// www.applefritter.com

// The following modules are included, unchanged from their 10/3/15 versions:
// BitBeam by Jason Huggins: http://bitbeam.org/
// Universal brick builder module by Jorg Janssen: http://www.thingiverse.com/thing:178627


//make opening for battery (always true when low profile)
battery = 0; // [0:No, 1:Yes]

//make opening for header on left (always true when low profile)
left_header = 0; // [0:No, 1:Yes]

//make opening for header on right (always true when low profile)
right_header = 0; // [0:No, 1:Yes]

//make opening for reset button
reset = 0; // [0:No, 1:Yes]

//make opening for top screw on PCB
top_screw = 0; // [0:No, 1:Yes]

//make opening for bottom left hole on PCB
left_screw = 0;  // [0:No, 1:Yes]

//make opening for bottom right hole on PCB
right_screw = 0; // [0:No, 1:Yes]

//add screw mounts to sides
screw_mounts = 0; // [0:No, 1:Yes]

//add vesa mount
vesa = 0; // [0:No, 1:Yes]

//add bitbeam to back
back_beams = 0; // [0:No, 1:Yes]

//add bitbeam to sides
side_beams = 1; // [0:No, 1:Yes]

//add brick bottom to back
back_brick = 0; // [0:No, 1:Yes]

//add bricks to sides
side_brick = 0; // [0:No, 1:Yes]

//makes low profile version. You must also change board_width to 7.5
low_profile = 2; // [0:Standard Profile, 1:Low Profile, 2: Snap]

//y - 12.5 for standard; 5.5 for low profile, 10.75 for snap case
board_width = 10.75;

//x 42.25 for tinyboy
board_length = 42;

//z
board_height = 61;

//wall thickness
wall = 1.75;

//header dimensions
header_height = 52;
header_width = 6.5;

//Print bottom?
bottom_on = 1; // [0:No, 1:Yes]

//Print sides?
sides_on = 1; // [0:No, 1:Yes]

//Print front?
front_on = 1; // [0:No, 1:Yes]

//number of bitbeam holes on sides
beam_height_count = 8;

$fn=50;




module bag() {

    //base
    translate([0,0,0])
        cube([board_length+wall*2, board_width+wall*2, wall], center=false);

    //front wall
    translate([0,0,wall])
        cube([board_length+wall*2, wall, board_height], center=false);

    //back wall
    translate([0,board_width+wall,wall])
        cube([board_length+wall*2, wall, board_height], center=false);

    //left wall
    translate([0,wall,wall])
        cube([wall, board_width, board_height], center=false);

    //right wall
    translate([board_length+wall,wall,wall])
        cube([wall, board_width, board_height], center=false);

    //add bumps to support back of board and front
    if (low_profile == 2) {
        //back bumps - tried 1.5 for even fit with no bumps in front; 2 for bumps in front
        translate([wall+6, board_width+wall-2, wall])
            cube([13, 2, 6]);
        translate([wall+27, board_width+wall-2, wall])
            cube([10, 2, 6]);
        //front bumps
        translate([wall, board_width+wall-2, wall+board_height-3])
            cube([board_length, 2, 3]);
    }


}



module subtractions() {

    //left header
    if (left_header == 1 || low_profile >= 1) {
        translate([wall, -1, wall])
            cube([header_width, wall+2, header_height]);
        }

    //right header
    if (right_header == 1 || low_profile >= 1) {
        translate([wall+board_length-header_width, -1, wall])
            cube([header_width, wall+2, header_height]);
        }

    //battery
    if (battery == 1 || low_profile == 1) {
//        translate([30+wall, -1, 40.5+wall]) //Alpha wall
//            cube([7, wall+2, 7.5]);
        
          translate([29+wall, 3+wall, -10])
            cube([7.5, 6, 20]);
        }

    //low profile
    if (low_profile == 1) {
        translate([wall, -1, 45.9+wall])
            cube([board_length, wall+2, board_height+wall*2]);
    }

    //snap case
    if (low_profile == 2) {
        //make room for usb port on top
        translate([wall+7, -1, wall+board_height-1])
            cube([wall+13, wall+2, 2]);
        translate([wall+7.5, wall-.5, wall+board_height-14.5])
            cube([wall+12, 1, 15]);
        //make a gap between the side walls and the front wall
        translate([wall, -1, wall+header_height-1])
            cube([.5, wall+2, board_height-header_height+2]); 
        translate([wall+board_length-.5, -1, wall+header_height-1])
            cube([.5, wall+2, board_height-header_height+2]); 
    }
    
    //reset button
    if (reset == 1) {
        translate([wall+10, -1, wall+3])
            rotate([90,0,0])
                cylinder(h=wall+4, r=1.5, center=true);
    }
    
    //top PCB screw hole
    if (top_screw == 1) {
        translate([wall+10, -1, wall+42])
            rotate([90,0,0])
                cylinder(h=wall+100, r=1.75, center=true);
    }
    
    //left PCB screw hole
    if (left_screw == 1) {
        translate([wall+10, -1, wall+10.5])
            rotate([90,0,0])
                cylinder(h=wall+100, r=1.75, center=true);
    }

    //right PCB screw hole
    if (right_screw == 1) {
        translate([wall+32, -1, wall+10.5])
            rotate([90,0,0])
                cylinder(h=wall+100, r=1.75, center=true);
    }

//9mm edge to hole
//3mm hole diameter
//8mm edge to edge of hole
//9.5mm to center of hole
//9mm bottom edge to edge of hole
}


module screw_mounts() {

    //lower left mount
    difference() {
     translate([-12, board_width+wall, 0])   
        cube([12, wall, 12]);
     translate([-6, board_width+wall-1, 6])
            rotate([90,0,0]){
         cylinder(h=wall+4, r=2.25, center=true);
        }
    }
    
    //lower right mount
    difference() {
     translate([board_length+wall*2, board_width+wall, 0])   
        cube([12, wall, 12]);
     translate([board_length+wall*2+6, board_width+wall-1, 6])
            rotate([90,0,0]){
         cylinder(h=wall+4, r=2.25, center=true);
        }
    }
    
    //upper left mount
    difference() {
     translate([-12, board_width+wall, board_height+wall-12])   
        cube([12, wall, 12]);
     translate([-6, board_width+wall-1, board_height+wall-6])
            rotate([90,0,0]){
         cylinder(h=wall+4, r=2.25, center=true);
        }
    }
    
    //upper right mount
    difference() {
     translate([board_length+wall*2, board_width+wall, board_height+wall-12])   
        cube([12, wall, 12]);
     translate([board_length+wall*2+6, board_width+wall-1, board_height+wall-6])
            rotate([90,0,0]){
         cylinder(h=wall+4, r=2.25, center=true);
        }
    }
    
}

module back_beams() {

    //bottom bitbeam
    translate([((board_length+wall*2)-(beam_width*5))/2, board_width+wall*2, 0])
        beam(5);

    //top bitbeam
    translate([((board_length+wall*2)-(beam_width*5))/2, board_width+wall*2, board_height+wall-beam_width])
        beam(5);

}

module side_beams() {

    difference() {
        union() {

            //left bitbeam
            translate([0-((beam_width*6)-(board_length+wall*2))/2, board_width+wall*2-beam_width,(board_height+wall)-(beam_width*beam_height_count)])
                rotate([0,-90,0])
                    beam(beam_height_count);

            //right bitbeam
           translate([(board_length+wall*2+beam_width)+((beam_width*6)-(board_length+wall*2))/2,board_width+wall*2-beam_width,(board_height+wall)-(beam_width*beam_height_count)])
                rotate([0,-90,0])
                    beam(beam_height_count);
            
            //add extension to connect right bitbeam
            translate([board_length+wall*2-.01, board_width+wall*2-beam_width, (board_height+wall)-(beam_width*8)])
                cube([((beam_width*6)-(board_length+wall*2))/2+.02, beam_width, beam_width*8]);
            //added the .01 due to invalid 2-manifold warning
           
            //add extension to connect left bitbeam
            translate([0-((beam_width*6)-(board_length+wall*2))/2-.01, board_width+wall*2-beam_width, (board_height+wall)-(beam_width*8)])
                cube([((beam_width*6)-(board_length+wall*2))/2+.02, beam_width, beam_width*8]);
            
            //extend base to alight with bitbeam
            translate([0,0,(board_height+wall)-(beam_width*beam_height_count)])
                cube([board_length+wall*2, board_width+wall*2, (beam_width*8)-(board_height+wall)], center=false);
                }
    
    //hack to make battery work
    if (battery == 1 || low_profile == 1) {
        
          translate([29+wall, 3+wall, -10])
            cube([7.5, 6, 20]);
        }
    }

}

module back_brick() {
    
    translate([((board_length+wall*2)-39.8)/2,board_width+wall*2+3.2, 0])
        rotate([90,0,0])
            brick(5,8,1);
    
}

module side_brick() {
    
    translate([1,0,0])
        rotate([0,-90,0])
            brick(8,2,1);
    
    translate([board_length+wall*2+3.2, 0, 0])
            rotate([0,-90,0])
                brick(8,2,1);

}


// Description: "Technic-compatible gridbeam"
// Project home: http://bitbeam.org

// Each bitbeam is 8mm inches wide. 
// Center of each hole is 8mm apart from each other
// Holes are 5.1 mm in diameter.

// Mini
//beam_width     = 4;
//hole_diameter  = 2.2;

// Standard
beam_width     = 8;
hole_diameter  = 5.1;

hole_radius    = hole_diameter / 2;

module beam(number_of_holes) {
    beam_length = number_of_holes * beam_width;
    difference() {
        // Draw the beam...
        cube([beam_length,beam_width,beam_width]);
    
        // Cut the holes...
        for (x=[beam_width/2 : beam_width : beam_length]) {
            translate([x,beam_width/2,-2])
            cylinder(r=hole_radius, h=12, $fn=30);
        }
        for (x=[beam_width/2 : beam_width : beam_length]) {
            rotate([90,0,0])
            translate([x,beam_width/2,-10])
            cylinder(r=hole_radius, h=12, $fn=30);
        }

        // Optional through-hole
        //rotate([0,90,0])
        //translate([-4,beam_width/2,-2])
        //cylinder(r=hole_radius, h=number_of_holes*beam_width+4, $fn=30);
        }
}


/*

 Basic brick builder module for OpenScad by Jorg Janssen 2013 (CC BY-NC 3.0) 
 To use this in your own projects add:

 use <path_to_this_file/brick_builder.scad>
 brick (length, width, height [,smooth]);

 Length and width are in standard brick dimensions. 
 Height is in flat brick heights, so for a normal brick height = 3.
 Add optional smooth = true for a brick without studs. 
 Use height = 0 to just put studs/knobs on top of other things.

 */

 // this is it:

// and this is how it's done:

FLU = 1.6; // Fundamental Unit = 1.6 mm

BRICK_WIDTH = 5*FLU; // basic brick width
BRICK_HEIGHT = 6*FLU; // basic brick height
PLATE_HEIGHT = 2*FLU; // basic plate height
WALL_THICKNESS = FLU; // outer wall of the brick
STUD_RADIUS = 1.5*FLU; // studs are the small cylinders on top of the brick with the logo ('nopje' in Dutch)
STUD_HEIGHT = FLU; 
ANTI_STUD_RADIUS = 0.5*4.07*FLU;  // an anti stud is the hollow cylinder inside bricks that have length > 1 and width > 1
PIN_RADIUS = FLU; // a pin is the small cylinder inside bricks that have length = 1 or width = 1
SUPPORT_THICKNESS = 0.254; // support is the thin surface between anti studs, pins and walls, your printer might not print this thin, try thicker!
EDGE = 0.254; // this is the width and height of the bottom line edge of smooth bricks
CORRECTION = 0.1; // addition to each size, to make sure all parts connect by moving them a little inside each other

module brick(length = 4, width = 2, height = 3, smooth = false){

	// brick shell
	difference(){
		cube(size = [length*BRICK_WIDTH,width*BRICK_WIDTH,height*PLATE_HEIGHT]);
		translate([WALL_THICKNESS,WALL_THICKNESS,-WALL_THICKNESS])
		union(){
			cube(size = [length*BRICK_WIDTH-2*WALL_THICKNESS,width*BRICK_WIDTH-2*WALL_THICKNESS,height*PLATE_HEIGHT]);
			// stud inner holes, radius = pin radius
			if (!smooth) {
				translate([STUD_RADIUS+WALL_THICKNESS,STUD_RADIUS+WALL_THICKNESS,height*PLATE_HEIGHT])
				for (y = [0:width-1]){
					for (x = [0:length-1]){
						translate ([x*BRICK_WIDTH-WALL_THICKNESS,y*BRICK_WIDTH-WALL_THICKNESS,-CORRECTION])
						cylinder(h=WALL_THICKNESS+2*CORRECTION,r=PIN_RADIUS);
					}
				}
			}
			// small bottom line edge for smooth bricks
			else {
				translate([-WALL_THICKNESS-CORRECTION,-WALL_THICKNESS-CORRECTION,FLU-CORRECTION]) 
				difference() {
					cube([length*BRICK_WIDTH+2*CORRECTION,width*BRICK_WIDTH+2*CORRECTION,EDGE+CORRECTION]);
					translate([EDGE+CORRECTION,EDGE+CORRECTION,-CORRECTION])
					cube([length*BRICK_WIDTH-2*EDGE,width*BRICK_WIDTH-2*EDGE,EDGE+3*CORRECTION]); 
				}
			}
		}
	}
	// Studs
	if(!smooth){
		translate([STUD_RADIUS+WALL_THICKNESS,STUD_RADIUS+WALL_THICKNESS,height*PLATE_HEIGHT])
		for (y = [0:width-1]){
			for (x = [0:length-1]){
				translate ([x*BRICK_WIDTH,y*BRICK_WIDTH,-CORRECTION])
				difference(){
					cylinder(h=STUD_HEIGHT+CORRECTION, r=STUD_RADIUS);
					// Stud inner holes
					translate([0,0,-CORRECTION])
					cylinder(h=0.5*STUD_HEIGHT+CORRECTION,r=PIN_RADIUS);
				}
				// tech logo - disable this if your printer isn't capable of printing this small
				if ( length > width){
					translate([x*BRICK_WIDTH+0.8,y*BRICK_WIDTH-1.9,STUD_HEIGHT-CORRECTION])
					resize([1.2*1.7,2.2*1.7,0.254+CORRECTION])
					rotate(a=[0,0,90])
					import("tech.stl");
				}
				else {
					translate([x*BRICK_WIDTH-1.9,y*BRICK_WIDTH-0.8,STUD_HEIGHT-CORRECTION])
					resize([2.2*1.7,1.2*1.7,0.254+CORRECTION])
					import("tech.stl");				
				}				
				/* 
				// Alternative 2-square logo
				translate ([x*BRICK_WIDTH+CORRECTION,y*BRICK_WIDTH-CORRECTION,STUD_HEIGHT-CORRECTION])		
				cube([1,1,2*CORRECTION]);
				translate ([x*BRICK_WIDTH-0.9,y*BRICK_WIDTH-0.9,STUD_HEIGHT-CORRECTION])		
				cube([1,1,0.3]);
				*/				
			}
		}
	}
	// Pins x
	if (width == 1 && length > 1) {	
			for (x = [1:length-1]){
				translate([x*BRICK_WIDTH,0.5*BRICK_WIDTH,0])
				cylinder(h=height*PLATE_HEIGHT-WALL_THICKNESS+CORRECTION,r=PIN_RADIUS);
				// Supports
				if (height > 1) {
				translate([x*BRICK_WIDTH-0.5*SUPPORT_THICKNESS,CORRECTION,STUD_HEIGHT])
				cube(size=[SUPPORT_THICKNESS,BRICK_WIDTH-2*CORRECTION,height*PLATE_HEIGHT-STUD_HEIGHT-WALL_THICKNESS+CORRECTION]);
			}
		}
	}
	// Pins y
	if (length == 1 && width > 1) {	
			for (y = [1:width-1]){
			translate([0.5*BRICK_WIDTH,y*BRICK_WIDTH,0])
			cylinder(h=height*PLATE_HEIGHT-WALL_THICKNESS+CORRECTION,r=PIN_RADIUS);
			// Supports
			if (height > 1) {
			translate([CORRECTION,y*BRICK_WIDTH-0.5*SUPPORT_THICKNESS,STUD_HEIGHT])
			cube(size=[BRICK_WIDTH-2*CORRECTION,SUPPORT_THICKNESS,height*PLATE_HEIGHT-STUD_HEIGHT-WALL_THICKNESS+CORRECTION]);}
			
		}
	}
	// Anti Studs
	if (width > 1 && length > 1){
		difference(){
			union(){
				for(y = [1:width-1]){
					for(x = [1:length-1]){
						// anti studs
						translate([x*BRICK_WIDTH,y*BRICK_WIDTH,0])
						cylinder (h=height*PLATE_HEIGHT-WALL_THICKNESS+CORRECTION, r = ANTI_STUD_RADIUS);
						// Supports
						if (height > 1){
							// Support x
							if (x%2 == 0 && (length%2 == 0 || length%4 == 1 && x<length/2 || length%4 == 3 && x>length/2) || x%2 == 1 && (length%4 == 3 && x<length/2 || length%4 == 1 && x>length/2)) {
								translate([BRICK_WIDTH*x-0.5*SUPPORT_THICKNESS,y*BRICK_WIDTH-BRICK_WIDTH+WALL_THICKNESS-CORRECTION,STUD_HEIGHT])
								cube(size=[SUPPORT_THICKNESS,2*BRICK_WIDTH-2*WALL_THICKNESS,height*PLATE_HEIGHT-STUD_HEIGHT-WALL_THICKNESS+CORRECTION]);
							}
							// Supports y							
							if (y%2 == 0 && (width%2 == 0 || width%4 == 1 && y<width/2 || width%4 == 3 && y>width/2) || y%2 == 1 && (width%4 == 3 && y<width/2 || width%4 == 1 && y>width/2)) {
								translate([x*BRICK_WIDTH-BRICK_WIDTH+WALL_THICKNESS-CORRECTION,BRICK_WIDTH*y-0.5*SUPPORT_THICKNESS,STUD_HEIGHT])
								cube(size=[2*BRICK_WIDTH-2*WALL_THICKNESS,SUPPORT_THICKNESS,height*PLATE_HEIGHT-STUD_HEIGHT-WALL_THICKNESS+CORRECTION]);
							}
						}
					}
				}
			}
			union(){
				for(y = [1:width-1]){
					for(x = [1:length-1]){
						// hollow anti studs
						translate([x*BRICK_WIDTH,y*BRICK_WIDTH,-WALL_THICKNESS])
						cylinder (h=height*PLATE_HEIGHT, r = STUD_RADIUS);				
					}
				}
			}
		}		
	}
}
	


difference() {
    bag();
    subtractions();
}

if (screw_mounts == 1)
    screw_mounts();
if (back_beams == 1)
    back_beams();
if (side_beams == 1)
    side_beams();
if (back_brick == 1)
    back_brick();
if (side_brick == 1)
    side_brick();