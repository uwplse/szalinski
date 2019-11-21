/*
	EX5000 Case, Revision 5

	On first print, set test_print to true
*/


// CHANGE ME! Feel free to edit the below values.

test_print = false;

wr = 0; // wiggle room, increase if the fit is too tight

frame_thickness = 1.5;

clip_width = 10;
clip_height = 20;
clip_thickness = 1.5;
clip_clearance = 2; // TOTAL CLEARANCE, not per side
clip_reach = 0.5;
notch_depth = 2;
notch_height = 2.5;
notch_down = 1; // for printers with poor overhang. if this is increased, also increase clip_reach
clip_support_length = 8;
clip_support_height = 1.5;

stand = true;
stand_angle = 10;
stand_front = 25;
stand_back = 15;
stand_thickness = 1.5;
support_base = 5; // the base of the isoceles triangle in the back. set to 8 or less
support_height = 3;
support_base_offset = 0;
support_front_mod = 0;// edit this to fix unclean ends
screen_cross_support = false;








// don't mess with these values
camera_width = 60.5;
camera_height = 42.2;
camera_depth = 25.2;
lens_d = 23;
f = 2*frame_thickness;
$fa=1; //resolution enhancement
$fs=1;



module frame(){
//backplate (screen)
cube([camera_height+f+2*wr, frame_thickness, camera_width+f]);
//right side (two buttons)
cube([camera_height+f+2*wr, camera_depth+f+wr*2, frame_thickness]);
//bottom (battery)
translate([camera_height+frame_thickness+wr*2,0,0])
cube([frame_thickness, camera_depth+f+wr*2, camera_width+f]);
//top (ok button)
cube([frame_thickness, camera_depth+f+wr*2, camera_width+f]);
//front (lens)
translate([0,camera_depth+frame_thickness+wr*2,0])
cube([camera_height+f+wr*2, frame_thickness, camera_width+f]);
}

module interactive_subtractive(){
//lens
color([.1,.1,1])
translate([26+frame_thickness+wr/2,camera_depth+frame_thickness-1+wr*2,44+frame_thickness])
rotate([-90,0,0])
cylinder(2+frame_thickness,d=lens_d+wr*2);
//lens extension
color([.1,.1,1])
translate([26-lens_d/2+frame_thickness-wr/2,camera_depth+frame_thickness-1+wr*2,44+frame_thickness])
cube([lens_d+2*wr, 2+frame_thickness, 15.8+f+1]);

//screen
color([0,0,0])
translate([(camera_height+f-30.8)/2,-1,(camera_width+f-41.5)/2])
cube([30.8+wr*2, 2+frame_thickness, 41.5+30]);

//ok button
// d = 11
//light d = 4.5
color([.2,.2,.2])
translate([camera_height+frame_thickness-1+wr*2,13+frame_thickness+wr,12.5+frame_thickness+wr])
rotate([0,90,0])
cylinder(3+frame_thickness,d=11+wr*2);
//light
color([1,.9,.9])
translate([camera_height+frame_thickness-1+wr*2,18.9+frame_thickness+wr,21+frame_thickness+wr])
rotate([0,90,0])
cylinder(3+frame_thickness,d=4.5+wr*2);

//power button
color([.2,.2,.2])
translate([28+frame_thickness+wr, camera_depth+frame_thickness-1+wr*2, 12+frame_thickness+wr])
rotate([-90,0,0])
cylinder(3+frame_thickness, d=11+2*wr);

//right buttons
color([.2,.2,.2])
translate([8+frame_thickness+wr/2,5.5+frame_thickness+wr/2,-1])
cube([26+wr,6+wr,3+frame_thickness]);
}


module clip_subtractive(){
//clip subtractor, bottom
clip_motion_extra = 0; // extra space for bottom clip to move
color([0,1,0])
translate([-clip_motion_extra-notch_depth,frame_thickness+(camera_depth-clip_width-clip_clearance)/2+wr/2,camera_width+frame_thickness-clip_height])
cube([1+frame_thickness+clip_motion_extra+notch_depth+notch_depth,clip_width + clip_clearance+wr,clip_height+frame_thickness + 1]);
//clip subtractor, top
color([0,1,0])
translate([frame_thickness+camera_height-1+wr*2,frame_thickness+(camera_depth-clip_width-clip_clearance+wr)/2,camera_width+frame_thickness-clip_height])
cube([2+frame_thickness,clip_width + clip_clearance + wr,clip_height+frame_thickness + 1]);
}

module clips(){
//bottom clip
color([0,1,0])
translate([frame_thickness - clip_thickness, 0, 0])
translate([0,frame_thickness+(camera_depth-clip_width)/2+wr,camera_width+frame_thickness-clip_height])
cube([clip_thickness,clip_width,clip_height+clip_reach+notch_height]);

//bottom notch
color([0,1,0])
translate([frame_thickness - clip_thickness, 0, 0])
translate([clip_thickness, clip_width+frame_thickness+(camera_depth-clip_width)/2+wr, camera_width+frame_thickness+clip_reach])
rotate([90,0,0])
linear_extrude(clip_width)
polygon(points=[[0,-notch_down],[notch_depth,0],[0,notch_height]]);

//bottom support
color([0,1,0])
translate([0.1,0,0])
translate([frame_thickness - clip_thickness, 0, 0])
translate([0,frame_thickness+(camera_depth-clip_width)/2+wr,camera_width+frame_thickness-clip_height])
rotate([90,0,180])
linear_extrude(clip_width)
polygon(points=[[0,-clip_support_length/2],[clip_support_height,0],[0,clip_support_length/2]]);


//top clip
color([0,1,0])
translate([clip_thickness+camera_height+frame_thickness, clip_width, 0])
translate([wr*2,frame_thickness+(camera_depth-clip_width)/2 +wr,camera_width+frame_thickness-clip_height])
rotate([0,0,180])
cube([clip_thickness,clip_width,clip_height+clip_reach+notch_height]);

//top notch
color([0,1,0])
translate([0,0,0])
translate([camera_height+frame_thickness+wr*2, frame_thickness+(camera_depth-clip_width)/2+wr, camera_width+frame_thickness+clip_reach])
rotate([90,0,180])
linear_extrude(clip_width)
polygon(points=[[0,-notch_down],[notch_depth,0],[0,notch_height]]);

//top support
color([0,1,0])
translate([-0.1,0,0])
translate([clip_thickness+camera_height+frame_thickness, clip_width, 0])
translate([wr*2,frame_thickness+(camera_depth-clip_width)/2 +wr,camera_width+frame_thickness-clip_height])
rotate([90,0,0])
linear_extrude(clip_width)
polygon(points=[[0,-clip_support_length/2],[clip_support_height,0],[0,clip_support_length/2]]);
}

module camera_subtractive(){
	translate([frame_thickness, frame_thickness, frame_thickness])
	// taller than actual camera by 100
	cube([camera_height+wr*2, camera_depth+wr*2, camera_width+100]);
}

module stand(){
	//baseplate
	rotate([0,0,stand_angle])
	translate([-stand_thickness,-stand_back,0])
	cube([stand_thickness,stand_front+stand_back,camera_width+f]);

	//support
	rotate([0,0,stand_angle-90])
	linear_extrude(camera_width+f)
	translate([support_base_offset,0,0])
	polygon(points=[[0, support_height], [support_base/2, 0], [-support_base/2, 0]]);
}

module base_grids(){
	//back grid
	rotate([0,90,stand_angle])
	translate([-camera_width/2-frame_thickness,-stand_back/2-1,-stand_thickness/2])
	intersection(){
		cube([(camera_width+f)-6,stand_back-3-2-1,1+stand_thickness],center=true);
		cubegrid(30,10,1+stand_thickness,4.5,2,45);
	}

	//front grid
	rotate([0,90,stand_angle])
	translate([-camera_width/2-frame_thickness,stand_front/2+1,-stand_thickness/2])
	intersection(){
		cube([(camera_width+f)-6,stand_front-3-2-1,1+stand_thickness],center=true);
		cubegrid(30,10,1+stand_thickness,4.7,2,45);
	}
}

module front_support(){
	fh = stand_front*tan(stand_angle)+stand_thickness;
	color([0,.2,.5])
	rotate([0,90,stand_angle])
	translate([-camera_width/2-frame_thickness,stand_front-1,fh/2-stand_thickness])
	difference(){
		cube([camera_width+f,stand_thickness,fh],center=true);
		rotate([90,0,0])
		cubegrid(10,10,10,6.5+support_front_mod,1,45);
	}
}

module screen_support(){
    if(screen_cross_support){
        translate([5.5,0,9.5])
        multmatrix(m =[ [1,0,0.61,0],
                        [0,1,0,0],
                        [0,0,1,0],
                        [0,0,0,1]])
        cube([1,frame_thickness,51.1]);
        
        translate([36.4,0,9.5])
        multmatrix(m =[ [1,0,-0.61,0],
                        [0,1,0,0],
                        [0,0,1,0],
                        [0,0,0,1]])
        cube([1,frame_thickness,51.1]);
    }
}

module cubegrid(x, y, z, cube_size, cube_space, cube_angle){

	cf = (cube_size+cube_space);
	//xd = ceil(x/cf/2/cos(cube_angle));
	//yd = ceil(y/cf/2/cos(cube_angle));
	xd = ceil(x/cf/2)*4+1;
	yd = ceil(y/cf/2)*4+1;

	rotate([0,0,cube_angle])
	for(_x = [-xd: xd], _y = [-yd : yd]){
		translate([_x*cf, _y*cf, 0])
		cube([cube_size, cube_size, z],center=true);
	}
}



module main(){
	union(){
	difference(){
		union(){
			frame();
       		if(stand && !test_print){
				front_support();
				difference(){
					stand();
					base_grids();
				}
			}
		}
	
		interactive_subtractive();
		clip_subtractive();
		camera_subtractive();
	}
	
	clips();
	screen_support();
	}
}

if(!test_print) main();
else{
	translate([0,0,-2])
	intersection(){
		translate([-50,-50,2])
		cube([100,100,5]);
		
		main();
	}
}
