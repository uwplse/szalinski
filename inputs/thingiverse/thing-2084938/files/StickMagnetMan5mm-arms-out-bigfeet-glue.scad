// ==================================================
// Stick Man - Customizer
// Created by Daiju Watanbe ( Daizyu ).
// 2 April 2016. 
// =================================================

/* MODIFIED VERSION BY Daniel K. Schneider
   January 2017
   - removed base
   - changed default parameters
   - added holes in feet and hands to insert 5x5mm cylindrical magnets
   
   Tips: 
   - The sum of each arm or foot limb angles should be 180.
   - Magnet diameter should be a bit smaller than the magnet if printed with TPE
   - magnet_entry_extra_width = -0.6; and magnet_entry_extra_height = 1; // add a bottle neck
   - Set the magnet_entry_extra_* values to zero if you plan to glue the magnet.
*/

// preview[view:south, tilt:top]

/* [Angle] */
upper_arm_l = -85;               // [-360:360]
lower_arm_l = -5;               // [-360:360]
hand_l = -0;               // [-360:360]
upper_arm_r = 85;               // [-360:360]
lower_arm_r = 5;               // [-360:360]
hand_r = 0;               // [-360:360]
thigh_l = -45;               // [-360:360]
shin_l = 40;               // [-360:360]
foot_l = 5;               // [-360:360]
thigh_r = 45;               // [-360:360]
shin_r = -40;               // [-360:360]
foot_r = -5;               // [-360:360]
body = 0;               // [-360:360]


/* [Basic] */
b_thickness = 5;
thickness = 5;

/* [Magnet holes] */
magnet_diameter = 4.4;
magnet_entry_extra_width = -0.6; // [-1:0]
magnet_entry_extra_height = 1; // [0:1]
magnet_height = 4; // [1:5]

/* [Head] */
fill_head = false;
head_diameter = 12;
head_offset_x = 0;
head_offset_y = -2;
head_hole_diameter = 4.5;

/* [Body] */
body_length = 36;

/* [Left arm] */
arm_l_offset = 12;
upper_arm_l_length = 24;
lower_arm_l_length = 18;
hand_l_length = 6;

/* [Right arm] */
arm_r_offset = 12;
upper_arm_r_length = 24;
lower_arm_r_length = 18;
hand_r_length = 6;

/* [Left Leg] */
thigh_l_length = 24;
shin_l_length = 18;
foot_l_length = 6;

/* [Right Leg] */
thigh_r_length = 24;
shin_r_length = 18;
foot_r_length = 6;

/* [Legs and hands] */
paw_extra_width = 2;
paw_extra_height = 2;

/* [resolution] */
base_fn = 120;
head_fn = 100;

module bone(length){
     {
	  translate([-thickness/2,0,0])
	       cube(size = [thickness,length,b_thickness], center = false);
     }
     cylinder(h=b_thickness, r=thickness/2, center=false ,$fn=20);
}

module handFootBone(length){
     {
	  difference () {
	       union () {
		    translate([-(thickness+paw_extra_width)/2,0,0])
			 cube(size = [thickness+paw_extra_width,length,b_thickness+paw_extra_width], center = false);
		    cylinder(h=b_thickness+paw_extra_width, r=(thickness+paw_extra_width)/2, center=false ,$fn=20);
	       }
	       // magnet hole
	       translate ([0,length-magnet_entry_extra_height+0.05,(b_thickness+paw_extra_width)/2])
		    rotate ([90,0,0])
		    cylinder(h=magnet_height+0.5, r=magnet_diameter/2, center=false ,$fn=20);
               // bottleneck at entry
	       translate ([0,length+0.05,(b_thickness+paw_extra_width)/2])
		    rotate ([90,0,0])
		    cylinder(h=magnet_entry_extra_height+0.05, r=(magnet_diameter + magnet_entry_extra_width)/2, center=false ,$fn=30);
	  }
     }
}

module branch(
     head_diameter,
     Degrees1,Length1,
     Degrees2,length2,
     Degrees3,length3,
     Degrees4,length4,
     )
{
     rotate(Degrees1,[0,0,1])
	  translate([0,Length1+head_diameter/2,0])
	  rotate(Degrees2,[0,0,1])
     {
	  bone(length2);

	  translate([0,length2,0])
	       rotate(Degrees3,[0,0,1])
	  {
	       bone(length3);

	       translate([0,length3,0])
		    rotate(Degrees4,[0,0,1])
	       {
		    handFootBone(length4);
	       }
	  }
     }
}

module headBody() {
     union(){
	  translate([head_offset_x,head_offset_y,0])
	       cylinder(h=b_thickness, r=head_diameter/2.0, center=false ,$fn=head_fn);
	  rotate(body+180,[0,0,1])
	       bone(body_length+head_diameter/2);	
     }
}

union()
{
     if ( fill_head ) 
     {
	  headBody();
     }else{
	  difference()
	  {
	       headBody();
	       translate([head_offset_x,head_offset_y,-1])
		    cylinder(h=b_thickness+2, r=head_hole_diameter/2, center=false ,$fn=head_fn);
	  }
     }
     
     branch(head_diameter,
	    body+180,body_length,
	    thigh_l,thigh_l_length,
	    shin_l,shin_l_length,
	    foot_l,foot_l_length
	  );
     
     branch(head_diameter,
	    body+180,body_length,
	    thigh_r,thigh_r_length,
	    shin_r,shin_r_length,
	    foot_r,foot_r_length
	  );

     branch(head_diameter,
	    body+180,arm_l_offset,
	    upper_arm_l,upper_arm_l_length,
	    lower_arm_l,lower_arm_l_length,
	    hand_l,hand_l_length
	  );

     branch(head_diameter,
	    body+180,arm_r_offset,
	    upper_arm_r,upper_arm_r_length,
	    lower_arm_r,lower_arm_r_length,
	    hand_r,hand_r_length
	  );
}
