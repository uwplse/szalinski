// Joe Stubbs
// February 24 2012
// http://www.thingiverse.com/thing:53816


use <utils/build_plate.scad>

$fn = 50*1;

//Select the style of vase you would like to create.  Embossed & plain vases may hold liquids.  If your loops are not touching you will need to select an emboss style.
Vase_Style = 6; // [0:Plain,1:Single Loops,2:Double Loops,3:Triple Loops, 4:Single Emboss,5:Double Emboss,6:Triple Emboss]

//The Line Style controls the angles on the lines in your vase.  Pick a style you like.
Line_Style = 1*1; //[1:Angled Out,2:Angled In]

//Line style 2 isn't working correctly

//Width of the vase in mm.  Other dimensions will be based on this value such as stretching or shrinking the height and depth:
Vase_Width = 60; //[30:200]

//Make your vase wide or narrow by selecting from the list of ratios:
Vase_Depth_Ratio= 0.7; //[0.6:60%,0.7:70%,0.8:80%,0.9:90%,1.0:100%,1.1:110%,1.2:120%,1.3:130%,1.4:140%,1.5:150%,1.6:160%,1.7:170%,1.8:180%,1.9:190%,2.0:200%]

//Make your vase short or tall by selecting from the list of ratios:
Vase_Height_Ratio= 1.2; //[0.5:50%,0.6:60%,0.7:70%,0.8:80%,0.9:90%,1.0:100%,1.1:110%,1.2:120%,1.3:130%,1.4:140%,1.5:150%,1.6:160%,1.7:170%,1.8:180%,1.9:190%,2.0:200%]

//Select the wall thickness of your vase.  Note: When making a larger vase do not use a thin wall.  When making an embossed vase, a thicker wall is better.  If you are shrinking the height or depth additional thinkness is also required.
Vase_Wall_Thickness = 2; // [1:1 mm (Thin),2:2 mm (Normal),3:3 mm,4:4 mm (Thick),5:5 mm (Very Thick)]

//This is the ratio between the Vase Width and the opening at the top.  Example: Selecting 50% will make the hole at the top half as wide as the vase.
Top_Hole_Opening_Ratio = 0.5; //[0.1:10%,0.2:20%,0.3:30%,0.4:40%,0.5:50%,0.6:60%,0.7:70%,0.8:80%,0.9:90%]

//This is the ratio between the Vase Width and the base at the bottom.  Example: Selecting 25% will make the the base at the bottom a quarter as wide as the vase.
Bottom_Base_Ratio = 0.2; //[0.1:10%,0.2:20%,0.3:30%,0.4:40%,0.5:50%,0.6:60%,0.7:70%,0.8:80%,0.9:90%]


//Select the basic shape to apply to your vase design
Basic_Shapes = 50; //[50:Ovals,4:Diamonds,6:Emeralds]

//Select the ratio between the thickness of the wall and the thickness of the base and top ring.  Selecting 200% for example will give you a ring twice as thick as the wall of the vase.
Ring_And_Base_Ratio = 1; // [1:100%,1.25:125%,1.5:150%,1.75:175%,2:200%,3:300%,4:400%]

//You may include or omit the ring at the top of the vase.  Depending on the design you might need the ring to provide structural integrity.
Include_Ring_At_Top = 1; // [1:Yes,0:No]

//Number of loops around your vase:
Loops = 9; // [1:40]

//How wide do you want each loop to be?
Loop_Width = 0.5; // [0.1:Very Narrow,0.2:Narrow,0.3:Medium,0.4:Wide,0.5:Very Wide]

//How much do you want each loop to overlap vertically. Note: This only applies to double or triple Vase Styles.
Loop_Overlap = 0.375; // [0.0:None,0.125:Very Little,0.25:Half,0.375:Most,0.5:Full]

//This setting allows you to offset the loops for some interesting effects
Loop_Angle_Offset = 0.25; // [0:In line,0.5:Staggered,0.25:Split Staggered]

//This setting only applies to triple Vase Styles. It sets the ratio between the middle loop and the other two loops.
Middle_Loop_Ratio =  3; //[0.1:10%,0.2:20%,0.3:30%,0.4:40%,0.5:50%,0.6:60%,0.7:70%,0.8:80%,0.9:90%,1.0:100%,1.1:110%,1.2:120%,1.3:130%,1.4:140%,1.5:150%,1.6:160%,1.7:170%,1.8:180%,1.9:190%,2.0:200%]

//You can create some interesting effects with this setting.  In the triple Vase Styles the top and bottom loops skip, in the double vase only the top skips.
Skip_Loops = 0; //[1:Yes,0:No]

//Applies to emboss Vase Styles only, fill the wall of your base so it may carry liquid or create a unique look.  Set the value to 100% if you want the walls of your vase to be filled in all the way to the top.
Emboss_Perentage = 0.3; //[0.2:20%,0.3:30%,0.4:40%,0.5:50%,0.6:60%,0.7:70%,0.8:80%,0.9:90%,1.0:100%]

//Applies to emboss Vase Styles with less than 100% embossing.  You can adjust the angle of the partial emboss.  This can create some interesting loops especially if you tilt the emboss beyond 90 degrees.
Emboss_Angle = 30; //[10:10 degrees,20:20 degrees,30:30 degrees,45:45 degrees,60:60 degrees,70:70 degrees,80:80 degrees,90:90 degrees,120:120 degrees,135:135 degrees,180:180 degrees]




//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);






sphere_outside_d = Vase_Width;
sphere_outside_r = sphere_outside_d/2;

sphere_wall = Vase_Wall_Thickness;

sphere_inside_d = sphere_outside_d-sphere_wall*2;
sphere_inside_r = sphere_inside_d/2;

sphere_middle_d = (sphere_outside_d+sphere_inside_d)/2;
sphere_middle_r = sphere_middle_d/2;

sphere_ring_ratio = Ring_And_Base_Ratio; // ratio between the wall and the rings

sphere_top_hole_d = sphere_outside_d*Top_Hole_Opening_Ratio;
sphere_top_hole_r = sphere_top_hole_d/2;
sphere_top_z = trig_b_for_a_c(sphere_top_hole_r,sphere_outside_r); // use pythagorus to determine the location of the top ring

sphere_top_z_mid = sphere_top_z-sphere_wall/2;

sphere_top_ring_d = sphere_wall*sphere_ring_ratio; // size of the ring at the top
sphere_top_ring_r = sphere_top_ring_d/2;

sphere_top_ring_include = Include_Ring_At_Top;


sphere_base_d = sphere_outside_d*Bottom_Base_Ratio;
sphere_base_r = sphere_base_d/2;
sphere_base_z = -trig_b_for_a_c(sphere_base_r,sphere_outside_r); // use pythagorus to determine the location of thebase ring

sphere_base_z_mid = sphere_base_z+sphere_wall/2;


sphere_base_ring_d = sphere_wall*sphere_ring_ratio;
sphere_base_ring_r = sphere_base_ring_d/2;


holy_vase_count = Loops;
holy_vase_hole_ratio = Loop_Width;
holy_vase_overlap_ratio = Loop_Overlap;
holy_vase_spin_offset_ratio = Loop_Angle_Offset;
holy_vase_skip_loops = Skip_Loops;



holy_vase_triple_middle_hole_ratio = Middle_Loop_Ratio ;


scale_z = Vase_Height_Ratio;
scale_y = Vase_Depth_Ratio;

style= Vase_Style;
style_line = Line_Style;


emboss_ratio = Emboss_Perentage;
emboss_tilt = Emboss_Angle;

holy_fn = Basic_Shapes ;

fudge = 0.05*1;

create_vase();



module create_vase() {
	move_up_z = (sphere_base_z-(sphere_base_ring_r-sphere_wall/2))*scale_z;

	translate([0,0,-move_up_z]) {
		scale ([1,scale_y,scale_z]) {

			if (style==0)
				create_sphere_vase();
	
			if(style==1||style==4)  // single or embossed single
				create_single_holy_vase();

			if(style==2||style==5)  // double or embossed double
				create_double_holy_vase ();

			if(style==3||style==6) 
				create_tripple_holy_vase ();

			if (style==4||style==5||style==6)
				basic_sphere_emboss ();
		}
	}
}


module create_tripple_holy_vase () {  


	intersection() {
		basic_sphere ();
		union() {
			for (i=[1:holy_vase_count]) {
				if (holy_vase_skip_loops==0 || round ((i+1)/2)*2 == i+1) 
					tripple_top_holy_sphere (i,holy_vase_count);
			}
			for (i=[1:holy_vase_count]) {
				//if (holy_vase_skip_loops==0 || round ((i)/2)*2 == i) 
					tripple_middle_holy_sphere (i,holy_vase_count);
			}
			for (i=[1:holy_vase_count]) {
				if (holy_vase_skip_loops==0 || round ((i+1)/2)*2 == i+1) 
					tripple_bottom_holy_sphere (i,holy_vase_count);
			}
		}

	}     
	if(sphere_top_ring_include==1)
		top_ring();
	bottom_base() ;



	//tripple_bottom_holy_sphere (1,holy_vase_count);
}                                                                          



module tripple_top_holy_sphere (x,of) {



	delta_y = abs(sphere_top_z-sphere_base_z); // distance between top and bottom
	middle_hole_y = delta_y/3*holy_vase_triple_middle_hole_ratio/2/2;
	middle_hole_y_with_top_overlap = middle_hole_y + (sphere_top_z-middle_hole_y)*holy_vase_overlap_ratio;
	middle_hole_y_with_bottom_overlap = -middle_hole_y + (sphere_base_z+middle_hole_y)*holy_vase_overlap_ratio;

	top_hole_y_with_overlap = middle_hole_y - (middle_hole_y*2)*holy_vase_overlap_ratio;
	bottom_hole_y_with_overlap = -middle_hole_y + (middle_hole_y*2)*holy_vase_overlap_ratio;


	top_x = sphere_top_hole_r;
	top_y = sphere_top_z;

	bottom_y = top_hole_y_with_overlap;
	bottom_x = trig_b_for_a_c(bottom_y,sphere_outside_r);
	
	basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,0);



}


module tripple_bottom_holy_sphere (x,of) {

	delta_y = abs(sphere_top_z-sphere_base_z); // distance between top and bottom
	middle_hole_y = delta_y/3*holy_vase_triple_middle_hole_ratio/2/2;
	
	middle_hole_y_with_top_overlap = middle_hole_y + (sphere_top_z-middle_hole_y)*holy_vase_overlap_ratio;
	middle_hole_y_with_bottom_overlap = -middle_hole_y + (sphere_base_z+middle_hole_y)*holy_vase_overlap_ratio;

	top_hole_y_with_overlap = middle_hole_y - (middle_hole_y*2)*holy_vase_overlap_ratio;
	bottom_hole_y_with_overlap = -middle_hole_y + (middle_hole_y*2)*holy_vase_overlap_ratio;


	top_y = bottom_hole_y_with_overlap;
	top_x = trig_b_for_a_c(top_y,sphere_outside_r);

	bottom_x =sphere_base_r;
	bottom_y = sphere_base_z;

	
	if (holy_vase_spin_offset_ratio==0.25) {
		basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,0.5);
	} else {
		basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,0);
	}

}





module tripple_middle_holy_sphere (x,of) {

	delta_y = abs(sphere_top_z-sphere_base_z); // distance between top and bottom
	middle_hole_y = delta_y/3*holy_vase_triple_middle_hole_ratio/2/2;
	middle_hole_y_with_top_overlap = middle_hole_y + (sphere_top_z-middle_hole_y)*holy_vase_overlap_ratio;
	middle_hole_y_with_bottom_overlap = -middle_hole_y + (sphere_base_z+middle_hole_y)*holy_vase_overlap_ratio;

	top_hole_y_with_overlap = middle_hole_y - (middle_hole_y*2)*holy_vase_overlap_ratio;
	bottom_hole_y_with_overlap = -middle_hole_y + (middle_hole_y*2)*holy_vase_overlap_ratio;


	top_y = middle_hole_y_with_top_overlap;
	top_x = trig_b_for_a_c(top_y,sphere_outside_r);

	bottom_y = middle_hole_y_with_bottom_overlap;
	bottom_x = trig_b_for_a_c(bottom_y,sphere_outside_r);

	
	basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,holy_vase_spin_offset_ratio);

}



module create_double_holy_vase () {  

	intersection() {
		basic_sphere ();
		union() {
			for (i=[1:holy_vase_count]) {
				if (holy_vase_skip_loops==0 || round ((i+1)/2)*2 == i+1) 
					double_top_holy_sphere (i,holy_vase_count,0);
			}
			for (i=[1:holy_vase_count]) {
				double_bottom_holy_sphere (i,holy_vase_count);
			}
		}

	}     
	if(sphere_top_ring_include==1)
		top_ring();
	bottom_base() ;
}                                                                          






module double_top_holy_sphere (x,of) {


	top_x = sphere_top_hole_r;
	top_y = sphere_top_z;

	bottom_y = sphere_base_z*holy_vase_overlap_ratio;
	bottom_x = trig_b_for_a_c(bottom_y,sphere_outside_r);
	
	basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,0);

}


module double_bottom_holy_sphere (x,of) {


	top_y = sphere_top_z*holy_vase_overlap_ratio;
	top_x = trig_b_for_a_c(top_y,sphere_outside_r);


	bottom_x =sphere_base_r;
	bottom_y = sphere_base_z;


	basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,holy_vase_spin_offset_ratio);
	
}





module angled_out_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,spin_offset_ratio=0) {


	holy_wall = sphere_wall;
	holy_outside_d = distance (top_x,top_y,bottom_x,bottom_y);
	holy_outside_r = holy_outside_d/2;

	holy_inside_d=holy_outside_d-holy_wall*2;
	holy_inside_r=holy_inside_d/2;

	hole_outside_h = sphere_outside_r+fudge;

	tilt_angle = angle_to_midpoint (top_x,top_y,bottom_x,bottom_y);
	
	spin_angle = 360/of;	

	holy_inside_ratio = ((holy_outside_r*holy_vase_hole_ratio)-(sphere_wall/2))/holy_inside_r;



	rotate(spin_angle*(x-1)+(spin_angle*spin_offset_ratio),[0,0,1])
		if (top_y+bottom_y>=0) {
			rotate(tilt_angle,[0,1,0])

				translate([0,0,hole_outside_h/2])
					difference() {
						scale([1,holy_vase_hole_ratio,1]) 
							cylinder(r=holy_outside_r,h=hole_outside_h ,center=true,$fn=holy_fn); 
						scale([1,holy_inside_ratio,1]) 
							cylinder(r=holy_inside_r,h=hole_outside_h+fudge,center=true,$fn=holy_fn); 

					}
		} else {
			rotate(tilt_angle+180,[0,1,0])

				translate([0,0,hole_outside_h/2])
					difference() {
						scale([1,holy_vase_hole_ratio,1]) 
							cylinder(r=holy_outside_r,h=hole_outside_h ,center=true,$fn=holy_fn); 
						scale([1,holy_inside_ratio,1]) 
							cylinder(r=holy_inside_r,h=hole_outside_h+fudge,center=true,$fn=holy_fn); 

					}
		}


}










module create_sphere_vase () {
	basic_sphere ();
	if (sphere_top_ring_include==1)
		top_ring();
	bottom_base() ;
}


  

module basic_sphere () {
	difference() {
   		sphere(r = sphere_outside_r);
		sphere(r = sphere_inside_r);
		top_cutout();   
		bottom_cutout();
	}
}

module basic_sphere_emboss () {



	difference() {
   		sphere(r = sphere_middle_r);
		sphere(r = sphere_inside_r-2);
		top_cutout();   
		bottom_cutout();
		
		if (emboss_ratio < 1) 
			rotate(emboss_tilt,[0,1,0])
				translate([0,0,sphere_outside_r-(sphere_outside_d*(1-emboss_ratio))/2])
					cube([sphere_outside_d+fudge,sphere_outside_d+fudge,sphere_outside_d*(1-emboss_ratio)+fudge],center=true);


	}

}


	
module top_cutout() {
	translate ([0,0,(sphere_outside_r+fudge)/2])
		cylinder (r=sphere_top_hole_r,h=sphere_outside_r+fudge,center=true);
}

module bottom_cutout() {
	translate ([0,0,-(sphere_outside_r-fudge)/2])
		cylinder (r=sphere_base_r,h=(sphere_outside_r+fudge),center=true);
}


module top_ring() {

	rotate_extrude(convexity = 10, $fn = 100)
		translate([sphere_top_hole_r,  sphere_top_z_mid,0])
			circle(r = sphere_top_ring_r, $fn = 100);
}

module bottom_base() {

	rotate_extrude(convexity = 10, $fn = 100)
		translate([sphere_base_r,  sphere_base_z_mid,0])
			circle(r = sphere_base_ring_r, $fn = 100);

	translate([0,0,sphere_base_z_mid])
		cylinder(r=sphere_base_r,h=sphere_base_ring_d,center=true);

}








           


module basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,spin_offset_ratio=0) {
	if(style_line==1)
		angled_out_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,spin_offset_ratio);
	
	if(style_line==2)
		angled_in_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,spin_offset_ratio);
}



module angled_in_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,spin_offset_ratio=0) {
// this module is not working correctly.  It needs some work before this style of line can be used
	hole_outside_h = sphere_outside_r+fudge;

	new_top_x = hole_outside_h;
	new_top_y = new_top_x/top_x*top_y;
	


	new_bottom_x =  hole_outside_h;
	new_bottom_y = new_bottom_x/bottom_x*bottom_y;

	holy_wall = sphere_wall;
	holy_outside_d = new_top_y-new_bottom_y;
	holy_outside_r = holy_outside_d/2;

	holy_inside_d=holy_outside_d-holy_wall*2;
	holy_inside_r=holy_inside_d/2;



	tilt_angle = angle_to_midpoint (top_x,top_y,bottom_x,bottom_y);

	spin_angle = 360/of;	

	holy_inside_ratio = ((holy_outside_r*holy_vase_hole_ratio)-(sphere_wall/2))/holy_inside_r;

/* 
//TESTING 
	
	echo("top_y:",top_y);
	echo("new_top_y:",new_top_y);
	echo("new_bottom_y:",new_bottom_y);
	echo("holy_outside_d:",holy_outside_d);



		//echo("tilt angle basic:",tilt_angle);
		translate([new_top_x,0,new_top_y])
			cube([2,2,2]);
	
		translate([new_bottom_x,0,new_bottom_y])
			cube([2,2,2]);

		translate([(new_top_x+new_bottom_x)/2,0,(new_top_y+new_bottom_y)/2])
			cube([2,2,2]);

		rotate(tilt_angle+180,[0,1,0])  {
			translate([0,0,hole_outside_h/2])
					cylinder(r=2,h=hole_outside_h ,center=true); 


			translate([0,0,hole_outside_h/2])
					difference() {
						scale([1,holy_vase_hole_ratio,1]) 
							cylinder(r1=holy_wall*4,r2=holy_outside_r,h=hole_outside_h ,center=true); 
						scale([1,holy_inside_ratio,1]) 
							cylinder(r1=0,r2=holy_inside_r,h=hole_outside_h+fudge,center=true);					
					}
		}	

// TESTING
*/


	#rotate(spin_angle*(x-1)+(spin_angle*spin_offset_ratio),[0,0,1])
		if (top_y+bottom_y>=0) {

			rotate(tilt_angle,[0,1,0]) {

				translate([0,0,hole_outside_h/2])
					difference() {
						scale([1,holy_vase_hole_ratio,1]) 
							cylinder(r1=holy_wall*2,r2=holy_outside_r,h=hole_outside_h ,center=true); 
						scale([1,holy_inside_ratio,1]) 
							cylinder(r1=0,r2=holy_inside_r,h=hole_outside_h+fudge,center=true);					
					}

			
			}


				
		} else {
			rotate(tilt_angle+180,[0,1,0])

				translate([0,0,hole_outside_h/2])
					difference() {
						scale([1,holy_vase_hole_ratio,1]) 
							cylinder(r1=holy_wall*2,r2=holy_outside_r,h=hole_outside_h ,center=true); 
						scale([1,holy_inside_ratio,1]) 
							cylinder(r1=0,r2=holy_inside_r,h=hole_outside_h+fudge,center=true); 

					}
		}


}


module single_holy_sphere (x,of) {

	top_x = sphere_top_hole_r;
	top_y = sphere_top_z;
	bottom_x =sphere_base_r;
	bottom_y = sphere_base_z;

	basic_holy_sphere (top_x,top_y,bottom_x,bottom_y,x,of,0);

}



module create_single_holy_vase () {  

	intersection() {
		basic_sphere ();
		union() {
			for (i=[1:holy_vase_count]) {
				single_holy_sphere (i,holy_vase_count);


			}
		}

	}    


 
	if(sphere_top_ring_include==1)
		top_ring();
	bottom_base() ;
}                                                                          




function trig_b_for_a_c(a,c) = sqrt((c*c)-(a*a));
function distance(x1,y1,x2,y2) = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
function angle_to_midpoint(x1,y1,x2,y2) = atan(((x1+x2)/2)/((y1+y2)/2)); 

