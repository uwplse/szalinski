/* [Frame and Mounting Bracket Dimensions] */

//Not the width of the picture, but the with of the frame slats. (In millimeters)
frame_width = 35; // max: [100]

//Distance from the top edge of the frame to where you want the hanger nails to be. (In millimeters)
hanger_to_top = 60; // max: [1000]

//Distance from the hanger nail to the upper hole of the mounting bracket. (Measured center to center in millimeters) If the nail hole has a slot, measure from the upper end of the slot, where the center of the nail would ultimatly be.
nail_to_upper = 10; // max: [100]

//Distance between the upper and lower mounting bracket holes. (Measured center to center in millimeters)
mount_size = 25; //max: [200]


/* [Printing Options] */

//Layer height that you will be printing at.  Entering this info will make the support membrane match so that it prints correctly.
layer = 0.15; //[.1, .15, .2, .3]

//turning this on will cut away some of the excess material.  Good your dimensions are large. If your jig is small, leave this off.
filament_saver = false; //[true,false]


/* [Thumb Tack Dimensions] */

//tack head diameter (the default is 7/16 inch)
tack_head_d = 11.176; //max: [25]


/* [Hidden] */
	rim_height = 14;  //height of rim around the edge
    rim_thickness = 3.25; //width of rim around the edge
    tack_head_h = 1.09; //tack head height
	tack_tip_d = 2; // tack tip diameter (with clearance)
    base_thickness = 5.9; //thickness of the base (where the tacks go)
    
    upper_mount = hanger_to_top - nail_to_upper;
    lower_mount = upper_mount + mount_size;


mirror_copy([1,0,0])
Wall_Frame_Jig(frame_width,hanger_to_top,nail_to_upper,mount_size,layer,filament_saver,tack_head_d);


//custom mirror module that retains the original
    module mirror_copy(v=[0,1,0]){
        children();
        mirror(v) children();
    }

module Wall_Frame_Jig(frame_width,hanger_to_top,nail_to_upper,mount_size,layer,filament_saver,tack_head_d)
{
	

    
    //lower_mount = distance from dop of frame to the lower of the mount bracket mounts
    
    	
    
	
  translate([-2.5*frame_width,0,0]) 
    //the jig
	difference() {
        //outer edges
		cube([(2*frame_width)+rim_thickness,rim_thickness+lower_mount+10,rim_height],false);
		
        //frame socket
        translate([rim_thickness,rim_thickness,base_thickness]) 	
			cube([(2*frame_width)+rim_thickness,(2*frame_width)+lower_mount+10,rim_height],false);
        
        //cut out the interior of the L
        translate([frame_width,frame_width*0.75,-1]) 	
			cube([2*frame_width,(2*frame_width)+lower_mount+10,rim_height+1],false);
        
        //head of tack for wall nail location
        translate([rim_thickness+frame_width/2,rim_thickness+hanger_to_top,base_thickness-tack_head_h]) 
            cylinder(  h=tack_head_h, d=tack_head_d, $fn=20, center=false);
        
        //clearance hole for tip
        translate([rim_thickness+frame_width/2,rim_thickness+hanger_to_top,0]) 
            cylinder(  h=rim_height, d=tack_tip_d, $fn=20, center=false);
        
         //head of tack for upper bracket mount
        translate([rim_thickness+frame_width/2,rim_thickness+upper_mount,0]) 
            cylinder(  h=tack_head_h, d=tack_head_d, $fn=20, center=false);
            
            //clearance hole for tip of upper bracket
        translate([rim_thickness+frame_width/2,rim_thickness+upper_mount,tack_head_h+layer+.01]) 
             cylinder(  h=rim_height, d=tack_tip_d, $fn=20, center=false);
        
               //head of tack for lower bracket mount
        translate([rim_thickness+frame_width/2,rim_thickness+lower_mount,0]) 
            cylinder(  h=tack_head_h, d=tack_head_d, $fn=20, center=false);
            
            //clearance hole for tip of lower bracket
        translate([rim_thickness+frame_width/2,rim_thickness+lower_mount,tack_head_h+layer+.01]) 
             cylinder(  h=rim_height, d=tack_tip_d, $fn=20, center=false);
    }

}


