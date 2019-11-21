//4 Row Parametric Tool Tray
//Created by Jon Hollander, 3/1/2013

use <MCAD/regular_shapes.scad>

//Tool Row 1

number_of_tools_in_row_1 = 3;
row_1_hole_diameter = 26;
row_1_hole_shape = 0; //[0:Round,1:Square, 2: Hex]

//Tool Row 2

number_of_tools_in_row_2 = 4;
row_2_hole_diameter = 15;
row_2_hole_shape = 1; //[0:Round,1:Square, 2: Hex]

//Tool Row 3

number_of_tools_in_row_3 = 5; 
row_3_hole_diameter = 10;
row_3_hole_shape = 0; //[0:Round,1:Square, 2: Hex]

//Tool Row 4

number_of_tools_in_row_4 = 5; 
row_4_hole_diameter = 10;
row_4_hole_shape = 2; //[0:Round,1:Square, 2: Hex]

// Other User Options

tray_height = 25;

hole_taper = 4;

turn_upside_down_for_printing = 0; //[0:No, 180:Yes]   

//Constant Parameters

tray_thickness = 5+0; //Add zero to parameter so Thingiverse customizer excludes this from user form.

leg_thickness = 2+0;

y_margin = 5+0;
				
//Global Derived Variables

//Set hole_dia to 0 if row is empty.
	r1_temp = (number_of_tools_in_row_1 == 0 ? 0:row_1_hole_diameter);

	r2_temp = (number_of_tools_in_row_2 == 0 ? 0:row_2_hole_diameter);

	r3_temp = (number_of_tools_in_row_3 == 0 ? 0:row_3_hole_diameter);

	r4_temp = (number_of_tools_in_row_4 == 0 ? 0:row_4_hole_diameter);
	
	
	tray_width = max(
			r1_temp*(1.5*number_of_tools_in_row_1+1),
			max(r2_temp*(1.5*number_of_tools_in_row_2+1),
				max(	r3_temp*(1.5*number_of_tools_in_row_3+1), 
					r4_temp*(1.5*number_of_tools_in_row_4+1))));
	
	tray_depth = 1.5*(r1_temp+r2_temp+r3_temp+r4_temp)+2*y_margin;
	

	max_hole = max(r1_temp,
					max(r2_temp,
						max(r3_temp,r4_temp)));

	corner_width = .1*tray_width;
	corner_depth = .1*tray_depth;
	corner_taper = .1+0;

	

	


//Draw stuff!
generate_tool_tray();

module generate_tool_tray(){	
	translate([0,0,tray_thickness/2])
	rotate([turn_upside_down_for_printing, 0,0])

	union(){
		
		// Draw legs first so operations don't cut into the top tray
		tray_legs();

		//Top tray
		
		tray_top();
		
	}
		
}

module tray_top(){
	union(){
		difference(){
					cube(size=[tray_width,tray_depth,tray_thickness], center = true);
					tool_hole_row_1();
					tool_hole_row_2();
					tool_hole_row_3();
					tool_hole_row_4();
				}
		tool_finger_row_1();
		tool_finger_row_2();
		tool_finger_row_3();		
		tool_finger_row_4();
	}
}


module tool_hole_row_1(){
	tool_space_1 = tray_width/(2*number_of_tools_in_row_1+1);
	tool_y_1 = tray_depth/2-.5*r1_temp-y_margin;
	
	if(number_of_tools_in_row_1 != 0){
		tool_holes_row(-tray_width/2+1.5*tool_space_1,
						tool_y_1,
						tray_thickness,
						row_1_hole_diameter,
						tool_space_1,
				 		number_of_tools_in_row_1,
						row_1_hole_shape);
	}
}

module tool_finger_row_1(){
	tool_space_1 = tray_width/(2*number_of_tools_in_row_1+1);
	tool_y_1 = tray_depth/2-.5*r1_temp-y_margin;
	
	if(number_of_tools_in_row_1 != 0){
		tool_fingers_row(-tray_width/2+1.5*tool_space_1,
						tool_y_1,
						tray_thickness,
						row_1_hole_diameter,
						tool_space_1,
				 		number_of_tools_in_row_1,
						row_1_hole_shape);
	}
}
		


module tool_hole_row_2(){
	tool_space_2 = tray_width/(2*number_of_tools_in_row_2+1);
	tool_y_2 = tray_depth/2-1.5*r1_temp-.5*r2_temp-y_margin;
	
	if(number_of_tools_in_row_2 != 0){
		tool_holes_row(-tray_width/2+1.5*tool_space_2,
						tool_y_2,
						tray_thickness,
						row_2_hole_diameter,
						tool_space_2,
				 		number_of_tools_in_row_2,
						row_2_hole_shape);
	}
}

module tool_finger_row_2(){
	tool_space_2 = tray_width/(2*number_of_tools_in_row_2+1);
	tool_y_2 = tray_depth/2-1.5*r1_temp-.5*r2_temp-y_margin;
	
	if(number_of_tools_in_row_2 != 0){
		tool_fingers_row(-tray_width/2+1.5*tool_space_2,
						tool_y_2,
						tray_thickness,
						row_2_hole_diameter,
						tool_space_2,
				 		number_of_tools_in_row_2,
						row_2_hole_shape);
	}
}

module tool_hole_row_3(){
	tool_space_3 = tray_width/(2*number_of_tools_in_row_3+1);
	tool_y_3 = tray_depth/2-1.5*r1_temp-1.5*r2_temp-.5*r3_temp-y_margin;
	
	if(number_of_tools_in_row_3 != 0){	
		tool_holes_row(-tray_width/2+1.5*tool_space_3,
					tool_y_3,
					tray_thickness,
					row_3_hole_diameter,
					tool_space_3,
			 		number_of_tools_in_row_3,
					row_3_hole_shape);
	}
}

module tool_finger_row_3(){
	tool_space_3 = tray_width/(2*number_of_tools_in_row_3+1);
	tool_y_3 = tray_depth/2-1.5*r1_temp-1.5*r2_temp-.5*r3_temp-y_margin;
	
	if(number_of_tools_in_row_3 != 0){	
		tool_fingers_row(-tray_width/2+1.5*tool_space_3,
					tool_y_3,
					tray_thickness,
					row_3_hole_diameter,
					tool_space_3,
			 		number_of_tools_in_row_3,
					row_3_hole_shape);
	}
}

module tool_hole_row_4(){
	tool_space_4 = tray_width/(2*number_of_tools_in_row_4+1);
	tool_y_4 = tray_depth/2-1.5*r1_temp-1.5*r2_temp-1.5*r3_temp-.5*r4_temp-y_margin;
	
	if(number_of_tools_in_row_4 != 0){	
		tool_holes_row(-tray_width/2+1.5*tool_space_4,
					tool_y_4,
					tray_thickness,
					row_4_hole_diameter,
					tool_space_4,
			 		number_of_tools_in_row_4,
					row_4_hole_shape);
	}
}

module tool_finger_row_4(){
	tool_space_4 = tray_width/(2*number_of_tools_in_row_4+1);
	tool_y_4 = tray_depth/2-1.5*r1_temp-1.5*r2_temp-1.5*r3_temp-.5*r4_temp-y_margin;
	
	if(number_of_tools_in_row_4 != 0){	
		tool_fingers_row(-tray_width/2+1.5*tool_space_4,
					tool_y_4,
					tray_thickness,
					row_4_hole_diameter,
					tool_space_4,
			 		number_of_tools_in_row_4,
					row_4_hole_shape);
	}
}


module tool_holes_row(row_x_start, row_y, tray_thk, hole_dia, hole_space, num_holes, hole_type = 0 ){
	
	//h1 = tray_thk/(hole_taper/2)*hole_dia/2;
//	h2 = h1 + 1;
//	dia2 = h2*hole_dia/h1;	
	
	for (tool_index = [0:num_holes-1]){
		if(hole_type == 0){
			translate([row_x_start+tool_index*2*hole_space,row_y,-tray_thk/2-10]) 
				cylinder(h=tray_thk+20, r=hole_dia/2,$fs=.1);
		}
		
		if(hole_type == 1){
			translate([row_x_start+tool_index*2*hole_space,row_y,0]) 
				cube(center=true, size = [hole_dia, hole_dia, tray_thk+2]);				
		}

		if(hole_type == 2){
			translate([row_x_start+tool_index*2*hole_space,row_y,-tray_thk/2-1]) 
			hexagon_prism(tray_thk+2, hole_dia/2);
		}
	}
}

module tool_fingers_row(row_x_start, row_y, tray_thk, hole_dia, hole_space, num_holes, hole_type = 0,finger_thk=2){
		
	for (tool_index = [0:num_holes-1]){
		translate([row_x_start+tool_index*2*hole_space,row_y,-tray_thk/2]) rotate([180, 0, 0]) tool_finger(hole_type, hole_dia, hole_taper, tray_thk, finger_thk);
	}
}

module tool_finger(hole_type=2, hole_dia = 4, hole_taper = 2, tray_thk=5, finger_thk=2){

	if (hole_type == 0){
			//Round Holes
			//Pyramid height = tray_thk*(dia/2+finger_thk)/(hole_taper)
			//This ensures that pyramid has width of dia-hole_taper at height of tray_thk
	
			difference(){
				cylinder(r1=hole_dia/2+finger_thk, r2=hole_dia/2+finger_thk-hole_taper/2,h=tray_thk,$fs=.1);			
				translate([0,0,-.1]) cylinder(r1=hole_dia/2, r2=hole_dia/2-hole_taper/2,h=tray_thk+.2,$fs=.1);
				translate([hole_dia/2+finger_thk,0,-.1]) cube([1.5*(2*finger_thk+hole_taper),.4*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 			
				translate([-hole_dia/2-finger_thk,0,-.1]) cube([1.5*(2*finger_thk+hole_taper),.4*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		
				translate([0, hole_dia/2+finger_thk,-.1]) cube([.4*(2*finger_thk+hole_taper),1.5*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		
				translate([0, -hole_dia/2-finger_thk,-.1]) cube([.4*(2*finger_thk+hole_taper),1.5*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 			
			}	
 	}

	if (hole_type == 1){
		//Square Holes
		//Pyramid height = tray_thk*(dia/2+finger_thk)/(hole_taper)
		//This ensures that pyramid has width of dia-hole_taper at height of tray_thk

		difference(){
			square_pyramid((hole_dia+2*finger_thk), (hole_dia+2*finger_thk),tray_thk*(hole_dia/2+finger_thk)/(hole_taper/2));
			translate([0,0,-.1]) square_pyramid(hole_dia, hole_dia, tray_thk*(hole_dia/2+finger_thk)/(hole_taper/2)+.1);
			translate([0,0,tray_thk+.5*tray_thk*(hole_dia/2+finger_thk)]) cube([hole_dia+2*finger_thk,hole_dia+2*finger_thk,tray_thk*(hole_dia/2+finger_thk)], center=true);
			translate([hole_dia/2+finger_thk,0,-.1]) cube([2*(2*finger_thk+hole_taper),.3*(hole_dia/2+finger_thk),2*tray_thk+.4], center=true); 			
			translate([-hole_dia/2-finger_thk,0,-.1]) cube([2*(2*finger_thk+hole_taper),.3*(hole_dia/2+finger_thk),2*tray_thk+.4], center=true);
			translate([0, hole_dia/2+finger_thk,-.1]) cube([.3*(hole_dia/2+finger_thk),2*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		
			translate([0, -hole_dia/2-finger_thk,-.1]) cube([.3*(hole_dia/2+finger_thk),2*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		

		}
	
	}	
	
	if (hole_type == 2){
		difference(){
			cylinder(r1=hole_dia/2+finger_thk, r2=hole_dia/2+finger_thk-hole_taper/2,h=tray_thk,$fs=.1);			
			translate([0,0,-.1]) cylinder(r1=hole_dia/2, r2=hole_dia/2-hole_taper/2,h=tray_thk+.2,$fs=.1);
			translate([hole_dia/2+finger_thk,0,-.1]) cube([2*(2*finger_thk+hole_taper),.3*(hole_dia/2+finger_thk),2*tray_thk+.4], center=true); 			
			translate([-hole_dia/2-finger_thk,0,-.1]) cube([2*(2*finger_thk+hole_taper),.3*(hole_dia/2+finger_thk),2*tray_thk+.4], center=true);
			translate([0, hole_dia/2+finger_thk,-.1]) cube([.3*(hole_dia/2+finger_thk),2*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		
			translate([0, -hole_dia/2-finger_thk,-.1]) cube([.3*(hole_dia/2+finger_thk),2*(2*finger_thk+hole_taper),2*tray_thk+.4], center=true); 		
		
			//hull(){
//				hexagon_prism(.1,hole_dia/2+finger_thk);					
//				translate([0,0,tray_thk-.1]) hexagon_prism(.1, hole_dia/2+finger_thk-hole_taper/2);}
//			translate([0,0,-.2]) 
//				hull(){
//					hexagon_prism(.1,hole_dia/2);			
//					translate([0,0,tray_thk]) hexagon_prism(.3, .9*(hole_dia/2-hole_taper/2));}
	
		}
	
	}

}


module tray_legs(){
	difference(){
		translate([0,0,-tray_height/2-tray_thickness/2])
			cube(size=[tray_width,tray_depth,tray_height], center = true);
		
		//Center Cutouts
		translate([0,0,-tray_height/2-tray_thickness/2])
			cube(size=[tray_width-2*leg_thickness,tray_depth-2*leg_thickness,tray_height+2], center = true);

		//Leg Cutouts
		translate([0, tray_depth/2+1,-tray_height-tray_thickness/2-1]) rotate([90,0,0])	linear_extrude(height = tray_depth+2) trapezoid(tray_width-2*corner_width, tray_height+2, corner_taper);

		translate([-tray_width/2-1,0,-tray_height-tray_thickness/2-1]) rotate([90,0,90])	linear_extrude(height = tray_width+2) trapezoid(tray_depth-2*corner_depth, tray_height+2, corner_taper);
		
		
	}

	

}

module trapezoid(twidth, theight, taper){
	polygon(points = [ 	[-twidth/2,0],
						[twidth/2,0],
						[(1-taper)*(twidth/2),theight],
						[(1-taper)*(-twidth/2),theight]],
						
			paths =	[	[0,1,2,3]]
		); 
}




	



	

	

	