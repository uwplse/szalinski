// Created by Tunako - http://www.thingiverse.com/Tunako
// Source http://www.thingiverse.com/thing:26596
// License CC BY-SA 3.0

// This version has been edited to work with thingiverse customizer.
// for more options download the original version, see
// http://www.thingiverse.com/thing:26596


//------------------------------------------------------------------
//general settings: Size of the box.
//------------------------------------------------------------------

/* [General Settings] */


// outer lenght of the box in mm, including left and right thickness.
box_x = 120; 
// outer width of the box in mm, including front and back thickness.
box_y =  80; 
// outer height of the box in mm, including bottom thickness.
box_z =  50;  

//------------------------------------------------------------------
//Optional settings:
//------------------------------------------------------------------

/* [Optional Settings] */

//Frame width
frame        = 10; 
//Frame thickness
thickness    =  3; 
bottom_angle =  45; // [0:180]
sides_angle  =  45; // [0:180]

//set to 0 to remove pads
pad_heigth = 0.5; //  [0, 0.5, 1]
//radius of pads
pad_radius = 10; // [5:15]

/* [Struts Settings] */

//Number of struts in X direction
struts_number_x = 7; // [0:30]

//Number of struts in Y direction
struts_number_y = 7; // [0:30]

//Number of struts in Z direction
struts_number_z = 7; // [0:30]

//With of struts
struts_width    = 3; 


//------------------------------------------------------------------
//Advanced settings: Define individual settings for each side, if you need.
//------------------------------------------------------------------

/* [Hidden] */

//Bottom

bo_thickness       = thickness; 
bo_frame           = frame;
bo_struts_width    = struts_width;

bo_1_struts_number = struts_number_x;
bo_1_struts_width  = bo_struts_width;
bo_1_struts_angle  = bottom_angle;

bo_2_struts_number = struts_number_y;
bo_2_struts_width  = bo_struts_width;
bo_2_struts_angle  = bottom_angle+90;

bo_3_struts_number = 0;
bo_3_struts_width  = bo_struts_width;
bo_3_struts_angle  = 45;

bo_4_struts_number = 0;
bo_4_struts_width  = bo_struts_width;
bo_4_struts_angle  = -45;

//Left

le_thickness       = thickness; //
le_frame           = frame;
le_struts_width    = struts_width;

le_1_struts_number = struts_number_z;
le_1_struts_width  = le_struts_width;
le_1_struts_angle  = sides_angle;

le_2_struts_number = struts_number_y;
le_2_struts_width  = le_struts_width;
le_2_struts_angle  = sides_angle+90;

le_3_struts_number = 0;
le_3_struts_width  = le_struts_width;
le_3_struts_angle  = 45;

le_4_struts_number = 0;
le_4_struts_width  = le_struts_width;
le_4_struts_angle  = -45;

//Right

ri_thickness       = thickness; //
ri_frame           = frame;
ri_struts_width    = struts_width;

ri_1_struts_number = struts_number_z;
ri_1_struts_width  = ri_struts_width;
ri_1_struts_angle  = sides_angle;

ri_2_struts_number = struts_number_y;
ri_2_struts_width  = ri_struts_width;
ri_2_struts_angle  = sides_angle+90;

ri_3_struts_number = 0;
ri_3_struts_width  = ri_struts_width;
ri_3_struts_angle  = 45;

ri_4_struts_number = 0;
ri_4_struts_width  = ri_struts_width;
ri_4_struts_angle  = -45;

//Front

fr_thickness       = thickness; //
fr_frame           = frame;
fr_struts_width    = struts_width;

fr_1_struts_number = struts_number_x;
fr_1_struts_width  = fr_struts_width;
fr_1_struts_angle  = sides_angle;

fr_2_struts_number = struts_number_z;
fr_2_struts_width  = fr_struts_width;
fr_2_struts_angle  = sides_angle+90;

fr_3_struts_number = 0;
fr_3_struts_width  = fr_struts_width;
fr_3_struts_angle  = 45;

fr_4_struts_number = 0;
fr_4_struts_width  = fr_struts_width;
fr_4_struts_angle  = -45;

//Back

ba_thickness       = thickness; //
ba_frame           = frame;
ba_struts_width    = struts_width;

ba_1_struts_number = struts_number_x;
ba_1_struts_width  = ba_struts_width;
ba_1_struts_angle  = sides_angle;

ba_2_struts_number = struts_number_z;
ba_2_struts_width  = ba_struts_width;
ba_2_struts_angle  = sides_angle+90;

ba_3_struts_number = 0;
ba_3_struts_width  = ba_struts_width;
ba_3_struts_angle  = 45;

ba_4_struts_number = 0;
ba_4_struts_width  = ba_struts_width;
ba_4_struts_angle  = -45;

//------------------------------------------------------------------
//                        -------------------
//------------------------------------------------------------------

module padded_cube(coords){ //cube with pads at corners (prevents warping)
	cube(coords);
	
	if (pad_heigth > 0){
		color([0,0,1,1]){
			cylinder(r=pad_radius,h=pad_heigth, $fn=50);
			translate([coords[0],0,0])
				cylinder(r=pad_radius,h=pad_heigth, $fn=50);
			translate([coords[0],coords[1],0])
				cylinder(r=pad_radius,h=pad_heigth, $fn=50);
			translate([0,coords[1],0])
				cylinder(r=pad_radius,h=pad_heigth, $fn=50);
		}
	}
}


module struts (x, y, thickness, number_of_struts, struts_width, angle){

	angle2 = angle % 180;
	hypotenuse = sqrt(pow(x,2)+pow(y,2)); //lenght of the diagonal
	
	//draws the struts along the diagonal with equal spacing.
	
	intersection(){
		cube([x,y,thickness]);
		if (angle2 <= 90 && angle >=0)
			assign (cosa = x/hypotenuse)
				for ( i = [1 : number_of_struts] ) 
					assign ( start = ((hypotenuse - number_of_struts* (struts_width/(cos(angle2-acos(cosa))))) / (number_of_struts + 1))*i + (struts_width/(cos(angle2-acos(cosa))))*(i-1))
						rotate([0,0,acos(cosa)])
							translate([start,0, 0])
								rotate([0,0,angle2-acos(cosa)])
									translate([0,-hypotenuse, 0])
										cube([struts_width,2*hypotenuse,thickness]);
		else 
			assign (cosa = y/hypotenuse)
				translate([x,0])
					for ( i = [1 : number_of_struts] ) 
						assign ( start = ((hypotenuse - number_of_struts* (struts_width/(sin(angle2-acos(cosa))))) / (number_of_struts + 1))*i + (struts_width/(sin(angle2-acos(cosa))))*(i-1))
							rotate([0,0,acos(cosa)])
								translate([0,start,0])
									rotate([0,0,angle2-90-acos(cosa)])
										translate([-hypotenuse,0, 0])
											cube([2*hypotenuse,struts_width,thickness]);
	}
}


module side(x, y, thickness, width, number_of_struts_1, struts_width_1, angle1, number_of_struts_2, struts_width_2, angle2, number_of_struts_3, struts_width_3, angle3, number_of_struts_4, struts_width_4, angle4, pads=false){
	
	difference(){
		if (pads) padded_cube([x,y,thickness]);
		else
			cube([x,y,thickness]);
		translate([width,width,-0.5])
			cube([x-2*width,y-2*width,thickness+1]);
	}
	translate([width,width,0]){
	
		if(number_of_struts_1 >0)
			struts(x-2*width, y-2*width,thickness,number_of_struts_1,struts_width_1,angle1);
		if(number_of_struts_2 >0)
			struts(x-2*width, y-2*width,thickness,number_of_struts_2,struts_width_2,angle2);
		if(number_of_struts_3 >0)
			struts(x-2*width, y-2*width,thickness,number_of_struts_3,struts_width_3,angle3);
		if(number_of_struts_4 >0)
			struts(x-2*width, y-2*width,thickness,number_of_struts_4,struts_width_4,angle4);
	}
}


module box(){
	
	//Bottom
	
	side(box_x,box_y,bo_thickness,bo_frame,
		bo_1_struts_number, bo_1_struts_width , bo_1_struts_angle , 
		bo_2_struts_number, bo_2_struts_width , bo_2_struts_angle , 
		bo_3_struts_number, bo_3_struts_width , bo_3_struts_angle , 
		bo_4_struts_number, bo_4_struts_width , bo_4_struts_angle , true);
	
	//Front
	translate([0,fr_thickness,0])
		rotate([90,0,0])
			side(box_x,box_z,fr_thickness,fr_frame,
				fr_1_struts_number, fr_1_struts_width , fr_1_struts_angle , 
				fr_2_struts_number, fr_2_struts_width , fr_2_struts_angle , 
				fr_3_struts_number, fr_3_struts_width , fr_3_struts_angle , 
				fr_4_struts_number, fr_4_struts_width , fr_4_struts_angle );
			
	//Back
	translate([0,box_y,0])
		rotate([90,0,0])
			side(box_x,box_z,ba_thickness,ba_frame,
				ba_1_struts_number, ba_1_struts_width , ba_1_struts_angle , 
				ba_2_struts_number, ba_2_struts_width , ba_2_struts_angle , 
				ba_3_struts_number, ba_3_struts_width , ba_3_struts_angle , 
				ba_4_struts_number, ba_4_struts_width , ba_4_struts_angle );
			
	//Right
	translate([box_x,0,0])
		rotate([0,-90,0])
			side(box_z,box_y,ri_thickness,ri_frame,
				ri_1_struts_number, ri_1_struts_width , ri_1_struts_angle , 
				ri_2_struts_number, ri_2_struts_width , ri_2_struts_angle , 
				ri_3_struts_number, ri_3_struts_width , ri_3_struts_angle , 
				ri_4_struts_number, ri_4_struts_width , ri_4_struts_angle );
				
	//Left
	translate([le_thickness,0,0])
		rotate([0,-90,0])
			side(box_z,box_y,le_thickness,le_frame,
				le_1_struts_number, le_1_struts_width , le_1_struts_angle , 
				le_2_struts_number, le_2_struts_width , le_2_struts_angle , 
				le_3_struts_number, le_3_struts_width , le_3_struts_angle , 
				le_4_struts_number, le_4_struts_width , le_4_struts_angle );
}
translate([-box_x/2,-box_y/2,0])
	box();
