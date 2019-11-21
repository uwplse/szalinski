/* [Global] */

//which parts should be created
part = "closed"; // [both:Bottom and Top,bottom:Bottom only,top:Top Only,closed:Closed case(for display only- not printable)]

/* [Connectors Bottom] */
open_power_input=1; // [1:Open,0:Closed]
open_power_and_reset_button=1; // [1:Open,0:Closed]
open_micro_usb=1; // [1:Open,0:Closed]
open_hdmi=1; // [1:Open,0:Closed]
open_network=1; // [1:Open,0:Closed]
open_usb=1; // [1:Open,0:Closed]
open_audio_in=1; // [1:Open,0:Closed]
open_audio_out=1; // [1:Open,0:Closed]
open_sd_slot=1; // [1:Open,0:Closed]

/* [Connectors Top] */
open_gpio=1; // [1:Open,0:Closed]
open_sata=0; // [1:Open,0:Closed]
open_lvds=0; // [1:Open,0:Closed]
open_camera=0; // [1:Open,0:Closed]
open_dc_in=0; // [1:Open,0:Closed]
open_rtc_batt=0; // [1:Open,0:Closed]
open_additional_usb=0; // [1:Open,0:Closed]
open_spi=1; // [1:Open,0:Closed]

/* [Anti-Warp] */
//add mouse ears around the corners
add_mouse_ears=0; //[1:Yes,0:No]
mouse_ear_radius=12; // [0:20]

//build a wall around the edges
add_heat_wall=0; ////[1:Yes,0:No]
heat_wall_height=25; // [10:30]
heat_wall_width=1; // [1:5]
heat_wall_distance=5; //[1:10]

/* [Advanced] */
circle_accuracy=50; // [25:200]
//base height for ground/top plate
ground_height=2; // [1:5]
wall_width=2; // [1:5]
//gap between board and wall
gap=2; // [0:10]
//additional wall height 
top_height=9; // [5:15]
//height of the four elevator sockets
elevator_width=6; // [1:10]
elevator_height=4; // [0:10]
wall_text="UDOO";

/* [Hidden] */
udoo_board_length=110;
udoo_board_width=86;
udoo_board_height=18;
//additional vertical offset for each hole ("baseline")
hole_vertical_offset=2;

//don't turn top
debug=false;
//ovverride default config above
all_on=false; 

/* derived vars */

total_ground_length=udoo_board_length+2*gap+2*wall_width;
total_ground_width=udoo_board_width+2*gap+2*wall_width;
wall_height=udoo_board_height+top_height;
top_hole=3*ground_height;


/* uncomment block below to override config for development */
/*
	open_power_input=1; 
	open_power_and_reset_button=1; 
	open_micro_usb=1; 
	open_hdmi=1;
	open_network=1; 
	open_usb=1; 
	open_audio_in=1;
	open_audio_out=1;
	open_sd_slot=1; 
	
	open_gpio=1; 
	open_sata=1; 
	open_lvds=1; 
	open_camera=1;
	open_dc_in=1; 
	open_rtc_batt=1;
	open_additional_usb=1;
	open_spi=1; 

	add_mouse_ears=1;
	//add_heat_wall=1;
	heat_wall_width=2;
   mouse_ear_radius=20;
   part="bottom";
*/


include <write/Write.scad>


/* *************BOTTOM****************** */

module ground(){
 cube([total_ground_length,total_ground_width,ground_height]);
}

module long_wall(){
 cube([total_ground_length,wall_width,wall_height]);
}

module short_wall(){
 cube([wall_width,total_ground_width,wall_height]);
}

module all_walls(){
	ground();
	
	//long wall with all the connectors
	translate([0,0,ground_height]){
		long_wall();
	}
	
	
	//long wall wih the power input
	translate([0,total_ground_width-wall_width,ground_height]){
		long_wall();
	}
	
	//short wall with power button
	translate([0,0,ground_height]){
		short_wall();
	}
	
	//short wall with no holes
	translate([total_ground_length-wall_width,0,ground_height]){
    difference(){ 
     short_wall();
       if (wall_text!=""){
			writecube(wall_text,[wall_width-1,total_ground_width/2,wall_height/2],[wall_width,total_ground_width,wall_height],face="right",h=12);
       }
    }
    
	}
}
module hole_in_long_wall_1(offset,width,height,voffset=0,type="cube"){
 translate([wall_width+gap+offset,-1,ground_height+elevator_height+hole_vertical_offset+voffset]){
   if (type=="cube"){
   	  cube([width,wall_width+2,height]);
   } else if (type=="cylinder") {
     translate([width/2,wall_width,height/2])rotate(a=90, v=[1,0,0])cylinder(h=wall_width+2,r=width/2,$fn=circle_accuracy,center=true);
   }
 }
}

module hole_in_long_wall_2(offset,width,height,voffset=0,type="cube"){
 translate([wall_width+gap+offset,total_ground_width-wall_width-1,ground_height+elevator_height+hole_vertical_offset+voffset]){
 if (type=="cube"){
   	  cube([width,wall_width+2,height]);
   } else if (type=="cylinder") {
     translate([width/2,wall_width,height/2])rotate(a=90, v=[1,0,0])cylinder(h=wall_width+2,r=width/2,$fn=circle_accuracy,center=true);
   }
 }
}

module hole_in_short_wall(offset,width,height,voffset=0){
 translate([-1,wall_width+gap+offset,ground_height+elevator_height+hole_vertical_offset+voffset]){
   cube([wall_width+2,width,height]);
 }
}

module hdmi(){
 hole_in_long_wall_1(34,16,7);
}

module micro_usb(){
 hole_in_long_wall_1(8,23,6,-1);
}

module network(){
 hole_in_long_wall_1(51,16,15);
}

module usb(){
 hole_in_long_wall_1(68,17,14.5);
}

module audio_out(){
 hole_in_long_wall_1(86,8.5,9,type="cylinder",voffset=3);
}
module audio_in(){
 hole_in_long_wall_1(95.5,8.5,9,type="cylinder",voffset=3);
}

module power_input(){
 hole_in_long_wall_2(2,10,10,voffset=2,type="cylinder");
}

module power_reset_button(){
 hole_in_short_wall(7,17,9);
}

module sd_slot(){
 hole_in_short_wall(34,13,4);
}

module elevators(){
 translate([wall_width+gap,wall_width+gap,ground_height])cube([elevator_width,elevator_width,elevator_height]);
 translate([total_ground_length-wall_width-gap-elevator_width,wall_width+gap,ground_height])cube([elevator_width,elevator_width,elevator_height]);
 translate([wall_width+gap,total_ground_width-wall_width-gap-elevator_width,ground_height])cube([elevator_width,elevator_width,elevator_height]);
 translate([total_ground_length-wall_width-gap-elevator_width,total_ground_width-wall_width-gap-elevator_width,ground_height])cube([elevator_width,elevator_width,elevator_height]);
}


module mouse_ear_cylinders(){
  for (i = [0,total_ground_length]){
   for (j = [0,total_ground_width]){
		color("grey")translate([i,j,0])cylinder(r=mouse_ear_radius,h=0.5,$fn=circle_accuracy);
   }
  }
}
module mouse_ears(){
	if(add_mouse_ears==1){
		difference(){
			mouse_ear_cylinders();
			translate([0,0,-1])cube([total_ground_length,total_ground_width,3*ground_height]);
	 	}
	}
}

module heat_wall(){
	if(add_heat_wall==1){
		translate([-heat_wall_distance-heat_wall_width,-heat_wall_distance-heat_wall_width,0])difference(){
			cube([total_ground_length+2*(heat_wall_distance+heat_wall_width),total_ground_width+2*(heat_wall_distance+heat_wall_width),heat_wall_height]);
			translate([heat_wall_width,heat_wall_width,-1])cube([total_ground_length+2*heat_wall_distance,total_ground_width+2*heat_wall_distance,heat_wall_height+2]);
		}
	}
}

module udoo_case_bottom(){
 difference(){
	all_walls();

 /* long wall 1 holes */
  if (open_micro_usb==1){
	 micro_usb();
  }

   if (open_hdmi==1){
     hdmi();
   }

  if (open_network==1){
    network();
  }

  if (open_usb==1){
    usb();
  }

  if (open_audio_in==1){
    audio_in();
  }
  if (open_audio_out==1){
    audio_out();
  }

 /* long wall 2 holes */
 if (open_power_input==1){
  power_input();
 }

 /* short wall holes */
 if (open_power_and_reset_button==1){
   power_reset_button();
 }

 if (open_sd_slot==1){
   sd_slot();
 }
 } // end of difference

 elevators();


} // end of module udoo_case_bottom

/* *************TOP****************** */


module top_gpio(){
	//north
	translate([30,87,0])cube([80,4,top_hole]);
	//east
	translate([106,37,0])cube([6,54,top_hole]);
	//south
	 translate([40,37,0])cube([67,4,top_hole]);
}

module top_lvds(){
	translate([88,30,0])cube([26,6,top_hole]);
}
module top_sata(){
	translate([96,24,0])cube([18,7,top_hole]);
}
module top_camera(){
	translate([111,10,0])cube([4,12,top_hole]);
}
module top_dc_in(){
	translate([63,33,0])cube([8,6,top_hole]);
}
module top_rtc_batt(){
	translate([6,30,0])cube([4,7,top_hole]);
}
module top_usb(){
	translate([20,10,0])cube([10,5,top_hole]);
}
module top_spi(){
	translate([73,22,0])cube([12,4,top_hole]);
}

module top_base_frame(){
 //main plate
  translate([0,0,ground_height])cube([total_ground_length,total_ground_width,ground_height]);

  //frame
  translate([wall_width,wall_width,0]) difference(){
  cube([total_ground_length-2*wall_width,total_ground_width-2*wall_width,ground_height]);
  translate([1,1,-1])cube([total_ground_length-2*wall_width-2,total_ground_width-2*wall_width-2,ground_height]);
  }

  //corners
  corner_height=7;
  corner_length=5;
  translate([wall_width,wall_width,ground_height-corner_height])cube([corner_length,wall_width,corner_height]);
  translate([total_ground_length-wall_width-corner_length,wall_width,ground_height-corner_height])cube([corner_length,wall_width,corner_height]);

   translate([wall_width,total_ground_width-2*wall_width,ground_height-corner_height])cube([corner_length,wall_width,corner_height]);

  translate([total_ground_length-2*wall_width,total_ground_width-wall_width-corner_length,ground_height-corner_height])cube([wall_width,corner_length,corner_height]);
}

module udoo_case_top(){
  difference(){
	top_base_frame();

  if (open_gpio==1){
	 top_gpio();
  }

  if (open_sata==1){
	 top_sata();
  }

 if (open_lvds==1){
	 top_lvds();
  }

 if (open_camera==1){
	 top_camera();
  }
 if (open_dc_in==1){
	 top_dc_in();
  }
 if (open_rtc_batt==1){
	 top_rtc_batt();
  }
 if (open_additional_usb==1){
	 top_usb();
  }

if (open_spi==1){
	 top_spi();
  }
 } //end of difference

}



/* ************* "MAIN PROGRAM" ****************** */

if (part=="both"){
 translate([0,-total_ground_width/2,0]){
   udoo_case_bottom();
    //Test holes here
   // hole_in_long_wall_1(87,19,14,type="cylinder");
 }
 translate([-total_ground_length-2,total_ground_width/2,2*ground_height])rotate([180,0,0])udoo_case_top();

} else if (part=="bottom"){
 translate([-total_ground_length/2,-total_ground_width/2,0]){
	udoo_case_bottom();
	mouse_ears();
	heat_wall();
 }
} else if (part=="top") {
  if(debug==true){
  	udoo_case_top();
  } else {
	translate([-total_ground_length/2,total_ground_width/2,2*ground_height])rotate([180,0,0])udoo_case_top();
  translate([-total_ground_length/2,-total_ground_width/2,0]) mouse_ears();
		
  }

} else if (part=="closed"){
  color("Crimson")translate([-total_ground_length/2,-total_ground_width/2,0])udoo_case_bottom();
  color("Khaki")translate([-total_ground_length/2,-total_ground_width/2,0])translate([0,0,wall_height]) udoo_case_top();
} else {
 echo("unknown part");
 //test code here
 
}


//TODO: screw holes (top)

//Nice to have
//TODO: Text on walls / top ?
//TODO: 2.5'' drive case on top?
