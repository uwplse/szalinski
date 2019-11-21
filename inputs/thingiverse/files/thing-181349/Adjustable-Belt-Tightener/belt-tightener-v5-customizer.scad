// belt tightener
// (c) cahorton, 2013:  CC attribution non-commercial

// Description: adujstable belt tensioner with removable clips
// Ok to change these

// (default is sized for GT2)
belt_width = 6;		

// (default is sized for GT2)
belt_height = 1.6;	

// (height of belt when doubled so teeth interlock)
belt_doubled_height = 2.8;	

// Minimum Wall Width
wall = 1.6; 

// extra space in slits, etc
gap = 1; 

// (default sized for a #6 screw)
screw_radius = 2;	

// (default sized for a #6 nut)
nut_radius = 4.2;  	

// (how deep the block slots are)
box_depth = 8;		

// extra space between clip and block, when snapped together
clip_space = .8; 

// extra clearance for belt in the clip slot
clip_gap = .5;

// NOTE: more variables down in the clamp module

// calculated values, don't change these
swall = nut_radius-screw_radius+wall; // wall between screw and slots

box_x = (belt_height  * 2) + (wall * 3)+gap;
box_y = belt_width + gap +  (4*nut_radius)+4*wall;

slot_y = 2*swall+2*screw_radius;

echo("box_x = ", box_x);
echo("box_y = ", box_y);
echo("box_depth = ", box_depth);

module body(){
	difference(){
		
		// body cube
		cube(size=[box_x, box_y, box_depth]);
	
		// slot 1
		translate([wall,slot_y,-1])
		cube(size=[belt_height+gap/2, belt_width+gap, box_depth+2]);
	
		// slot 2
		translate([wall*2+belt_height+gap/2,slot_y,-1])
		cube(size=[belt_height+gap/2, belt_width+gap, box_depth+2]);
	
	
		// screw hole 1
		translate([box_x/2,swall+screw_radius,-1])
		cylinder(r=screw_radius, h=box_x+2, $fn=32);
	
	
		// screw hole 2
		translate([box_x/2,(box_y-(swall+screw_radius)),-1])
		cylinder(r=screw_radius, h=box_x+2, $fn=32);
	
		// nut hole 1
		translate([-1,wall,box_depth-2])
		cube(size=[box_x+2,nut_radius*2, 3]);
	
		// nut hole 2
		translate([-1,box_y-(wall+nut_radius*2),box_depth-2])
		cube(size=[box_x+2,nut_radius*2, 3]);
	
	}
}

body();

translate([-20,0,0])
body();


translate([20,0,0])
clamp();

translate([20,20,0])
clamp();


module clamp(){

	// OK to change these
	clip_gap = .5;
	width = 4;

	// Calculated values, don't change these
	bw = belt_width;
	bx=bw+clip_gap+4*wall;
	by = width;
	bz= box_x+2*wall;

	difference(){
		union(){
			//clamp body
			cube(size=[bx,by,bz]);

			// hook bridge
			cube(size=[bx,clip_space+box_depth+wall+width, 2*wall]);
			
			// hook
			translate([0,clip_space+box_depth+width,wall])
			cube(size=[bx,wall,3]);

		}
	//hole for belt
	translate([2*wall,-1,box_x/2+2*wall-belt_doubled_height/2])
	cube(size=[bw+clip_gap,width+2,belt_doubled_height+clip_gap]);

	}
}
