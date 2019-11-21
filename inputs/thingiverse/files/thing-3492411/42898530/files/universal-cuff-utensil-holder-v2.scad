
// Written by Volksswitch <www.volksswitch.org>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
//
//
// Version History:
//
// Version 2: added support for tapered circular utensils
//
//
//------------------------------------------------------------------
// User Inputs
//------------------------------------------------------------------

/*[Part to Print]*/
part = "palm loop"; // [palm loop,utensil holder,thumb loop,circular grip]

/*[Palm Loop Info]*/
palm_loop_height = 30; // [15:75]
palm_loop_length = 80; // [45:125]
palm_loop_width = 8; // [7:15]
include_lower_utensil_mount = "yes"; // [yes,no]
include_upper_utensil_mount = "no"; // [yes,no]
//cannot be used with thumb loop  mout
include_thumb_rest = "no"; // [yes,no]
//cannot be used with thumb rest or lower utensil mount
include_thumb_loop_mount = "no"; // [yes,no]

/*[Utensil Holder Info]*/
utensil_handle_type = "rectangular"; //[rectangular, circular]
utensil_width_or_diameter = 10; //[2:35]
utensil_height = 3; //[2:35]
utensil_handle_length=80; //[50:150]
utensil_holder_open_on = "thumb end"; //[thumb end, little finger end, both ends]
different_sized_circular_openings="no"; //[yes,no]
specific_thumb_end_diameter=10; //[2:35]
specific_little_finger_end_diameter=10; //[2:35]

/*[Thumb Loop Info]*/
thumb_loop_diameter = 20; //[10:30]
thumb_loop_width=8; // [4:10]

/*[Circular Grip Info]*/
circular_grip_diameter=15; //[10:40]


/*[Hidden]*/

//Customizer Values for Other Implementations
// /*[Part to Print]*/
// part = "palm loop"; // [---Palm Loop---,palm loop,turret,thumb loop,circular grip,--- Stylus---,stylus extender,stylus tip,4-sided turret,6-sided turret,---Sixth Finger/Toe---,stylus ring,single finger ring,---utensil holder---,utensil holder]

// /*[Stylus Info]*/
stylus_width = 10; // [8:15]
conduction_type="bolt and nut"; //[bolt and nut,conductive filament]

// /*[---Conductive Stylus Info]*/
stylus_extender_or_stylus_tip_length = 20; //[10:200]
use_4mm_nut_to_mount_tip="no"; //[yes,no]

// /*[---Bolted Stylus Info]*/
bolt_length = 25; //[20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]
coupling_nut_length = 8; //[8,15]

// /*[Sixth Finger/Toe Ring Info]*/
finger_or_toe_diameter=20; //[10:30]
ring_width=10; //[4:15]
stylus_ring_type = "finger ring opposite stylus"; //[finger ring opposite stylus, finger ring next to stylus, two finger rings]
finger_ring_type = "single finger ring"; //[single finger ring, mount for second finger ring]


//general variables
fudge = 0.005;
chamfer_size=1.5;

//palm loop variables
palm_loop_delta_offset = 3;

//utensil holder variables
max_end_diameter = max(specific_little_finger_end_diameter,specific_thumb_end_diameter);
utensil_handle_width = (utensil_handle_type != "circular") ? utensil_width_or_diameter+4
						: (different_sized_circular_openings=="no") ? utensil_width_or_diameter+4
						: max_end_diameter+4;
utensil_handle_height = (utensil_handle_type != "circular") ? utensil_height+4 
						: (different_sized_circular_openings=="no") ? utensil_width_or_diameter+4
						: max_end_diameter+4;
uhl = (utensil_handle_type != "circular") ? utensil_handle_length : utensil_handle_length;
v_depth = 1;
gap_width = uhl - 44;

//stylus variables
$fn=100;
stylus_tip_thread_diameter = 5; //[4:6]
stylus_tip_hole_scale_factor = 100; //[90:110]
dove_tail_length = stylus_width+2;
stylus_post_delta_offset = 1.5;
stylus_diameter = (stylus_tip_thread_diameter-0.1)*stylus_tip_hole_scale_factor/100;
x_offset = palm_loop_length*(-0.1354) + 13.5;
stylus_mount_width = 15; //******************what's this???***************************
seostl = (conduction_type=="conductive filament") ? stylus_extender_or_stylus_tip_length :
			(conduction_type=="bolt and nut" && coupling_nut_length==8) ? bolt_length + 5 :
			bolt_length + 10;

			

//turret variables
leg = stylus_width*cos(30);

//ring variables
fotd = (part=="stylus ring" && conduction_type=="bolt and nut") ? finger_or_toe_diameter+1 : finger_or_toe_diameter;
ring_thickness = 4;
ring_inner_diameter = (part=="thumb loop") ? thumb_loop_diameter : fotd;
ring_outer_diameter = ring_inner_diameter+ring_thickness;


//-------- Main Program-----------


if(part=="palm loop"){
	palm_loop();
}
else if(part=="4-sided turret"){
   four_sided_turret();
}
else if(part=="6-sided turret"){
    if(stylus_width<9) four_sided_turret(); else six_sided_turret();
}
else if(part=="thumb loop"){
	thumb_loop();
}
else if(part=="circular grip"){
	circular_grip();
}
else if (part=="stylus extender" || part=="stylus tip"){
	stylus_post_and_tip();
}
else if(part=="stylus ring"){
	stylus_ring();
}
else if(part=="finger/toe ring"){
	finger_or_toe_ring();
}
else if(part=="utensil holder"){
	utensil_holder();
}


//--------- Modules --------------

module palm_loop(){
	difference(){
		union(){
			//chamfer outside of palm loop
			outer_chamfered_object("outer palm",palm_loop_width,0,0);//shape_type,shape_height,shape_width,shape_length
			
			//add palm loop mounts		
			if(include_upper_utensil_mount=="yes") pointer_mount();
			
			//only one type of thumb mount allowed at a time but thumb loop mount cannot be used with lower utensil mount
			if(include_thumb_rest=="yes" && include_thumb_loop_mount=="no") thumb_rest_mount();
			if(include_thumb_loop_mount=="yes" && include_thumb_rest=="no" && include_lower_utensil_mount=="no") thumb_loop_mount();	

			//utensil mount cannot be used with thumb loop mount
			if(include_lower_utensil_mount=="yes") utensil_mount();
		}
		//chamfer inside of palm loop
		inner_chamfered_object("inner palm",palm_loop_width,0,0); //shape_type,shape_height,shape_width,shape_length
		
		//add dove tail cuts in pointer mount
		if(include_upper_utensil_mount == "yes") pointer_mount_slots();
		
		//add dove tail cuts in thumb loop mount
		if(include_thumb_loop_mount=="yes" && include_thumb_rest=="no" && include_lower_utensil_mount=="no") thumb_loop_slots();

		//add dove tail cuts in utensil mount
		if(include_lower_utensil_mount=="yes") utensil_mount_slots();
	}
}

module thumb_loop(){
	difference(){
		union(){
			outer_chamfered_object("outer ring",thumb_loop_width,0,0);
			
			translate([-4,thumb_loop_diameter/2,-thumb_loop_width/2])
			cube([8,2,thumb_loop_width]);
			
			translate([0,thumb_loop_diameter/2+2,0])
			rotate([0,0,90])
			dove_tail(0,thumb_loop_width,2);
		}
		inner_chamfered_object("inner ring",thumb_loop_width,0,0);
	}
}

module utensil_holder(){
	hole_offset = (utensil_holder_open_on=="thumb end" || utensil_holder_open_on=="both ends" ) ?-fudge:2+fudge;
	if(utensil_handle_type=="rectangular"){
		difference(){
			base_utensil_holder(utensil_handle_width,utensil_handle_height);
			
			if (utensil_holder_open_on=="thumb end" || utensil_holder_open_on=="little finger end"){
				translate([uhl/2-1+hole_offset,utensil_height/2+2,0])
				cube([uhl-2,utensil_height,utensil_width_or_diameter],true);
			}
			else{
				translate([uhl/2,utensil_height/2+2,0])
				cube([uhl+fudge*2,utensil_height,utensil_width_or_diameter],true);
			}
		}
		
		translate([0,-2+fudge,-utensil_handle_width/2])
		linear_extrude(height=utensil_handle_width)
		polygon([[22,utensil_handle_height],[22+gap_width,utensil_handle_height],[22+gap_width/2,utensil_handle_height-1]]);
	}
	// else if(utensil_handle_type=="rectangular-type B --knife--"){
		// translate([0,utensil_handle_height/2,utensil_handle_width/2])
		// rotate([-90,0,0])
		// union(){
			// difference(){
				// base_utensil_holder(utensil_handle_height,utensil_handle_width);
				
				// if (utensil_holder_open_on=="thumb end" || utensil_holder_open_on=="little finger end"){
					// translate([uhl/2-1+hole_offset,utensil_width_or_diameter/2+2,0])
					// cube([uhl-2,utensil_width_or_diameter,utensil_height],true);
				// }
				// else{
					// translate([uhl/2+fudge+hole_offset,utensil_width_or_diameter/2+2,0])
					// cube([uhl+fudge*2,utensil_width_or_diameter,utensil_height],true);
				// }
			// }
				
			// translate([0,-2+fudge,-utensil_handle_height/2])
			// linear_extrude(height=utensil_handle_height)
			// polygon([[22,utensil_handle_width],[22+gap_width,utensil_handle_width],[22+gap_width/2,utensil_handle_width-1]]);
			
			// translate([15,0,0])
			// difference(){
				// outer_chamfered_object("box",utensil_handle_height,utensil_handle_width,gap_width+10); //shape_type,shape_height,shape_width,shape_length
				// translate([(gap_width+10)/2,utensil_handle_width/2,-2])
				// cube([gap_width+10,utensil_handle_width+fudge,utensil_handle_height+fudge],true);
			// }
		// }
	// }
	else if(utensil_handle_type=="circular"){
		if(different_sized_circular_openings=="no"){
			if (utensil_holder_open_on=="both ends"){
				slot_offset1 = 0;
				slot_offset2 = utensil_handle_length-23;
				difference(){
					base_utensil_holder(utensil_handle_width,utensil_handle_height);
					translate([hole_offset,utensil_width_or_diameter/2+2,0])
					rotate([0,90,0])
					cylinder(h=utensil_handle_length+fudge*2,d=utensil_width_or_diameter);

					translate([slot_offset1-1,utensil_handle_width/2-1,utensil_handle_width/4])
					cube([24,2,utensil_handle_width/2]);
					translate([slot_offset2,utensil_handle_width/2-1,utensil_handle_width/4])
					cube([24,2,utensil_handle_width/2]);
				}
			}
			else{
				slot_offset = (utensil_holder_open_on=="thumb end") ? -1:utensil_handle_length-23;
				difference(){
					base_utensil_holder(utensil_handle_width,utensil_handle_height);
					translate([hole_offset,utensil_width_or_diameter/2+2,0])
					rotate([0,90,0])
					cylinder(h=utensil_handle_length-2,d=utensil_width_or_diameter);

					translate([slot_offset,utensil_handle_width/2-1,utensil_handle_width/4])
					cube([24,2,utensil_handle_width/2]);
				}
			}
		}
		else { //different_sized_circular_openings=="yes"
			//assumes that there will be slots on both boxes
			thumb_end_adjustment = (max_end_diameter-specific_thumb_end_diameter)/2;
			little_finger_end_adjustment = (max_end_diameter-specific_little_finger_end_diameter)/2;
			slot_offset1 = 0;
			slot_offset2 = utensil_handle_length-23;
			difference(){
				base_utensil_holder(utensil_handle_width,utensil_handle_height);
				
				translate([hole_offset,specific_thumb_end_diameter/2+2+thumb_end_adjustment,0])
				rotate([0,90,0])
				cylinder(h=utensil_handle_length/2+fudge*2,d=specific_thumb_end_diameter);

				translate([utensil_handle_length/2+fudge,specific_little_finger_end_diameter/2+2+little_finger_end_adjustment,0])
				rotate([0,90,0])
				cylinder(h=utensil_handle_length/2+fudge*2,d=specific_little_finger_end_diameter);

				// translate([slot_offset1-1,utensil_handle_width/2-1,utensil_handle_width/4])
				translate([slot_offset1-1,utensil_handle_width/2-1,fudge])
				cube([24,2,utensil_handle_width/2]);
				translate([slot_offset2,utensil_handle_width/2-1,fudge])
				cube([24,2,utensil_handle_width/2]);
			}
		}
			
		translate([0,-2+fudge,-utensil_handle_width/2])
		linear_extrude(height=utensil_handle_width)
		polygon([[22,utensil_handle_height],[22+gap_width,utensil_handle_height],[22+gap_width/2,utensil_handle_height-1]]);
	}

	utensil_holder_dove_tails();
}

module base_utensil_holder(utensil_handle_width,utensil_handle_height){
	if(different_sized_circular_openings=="no" || utensil_handle_type=="rectangular"){
		//two pockets for holding untensil with gap in between
		outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,22); //shape_type,shape_height,shape_width,shape_length
		translate([22+gap_width,0,0])
		outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,22); //shape_type,shape_height,shape_width,shape_length
		
		//side cover that will be where the dove tails mount when used for forks and spoons
		translate([15,0,0])
		difference(){
			outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,gap_width+10); //shape_type,shape_height,shape_width,shape_length
			translate([(gap_width+10)/2,utensil_handle_height/2-2,0])
			cube([gap_width+10,utensil_handle_height+fudge,utensil_handle_width+fudge],true);
		}
	}
	else{
		//two pockets for holding untensil with gap in between
		outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,22); //shape_type,shape_height,shape_width,shape_length
		translate([22+gap_width,0,0])
		outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,22); //shape_type,shape_height,shape_width,shape_length
		
		//side cover that will be where the dove tails mount when used for forks and spoons
		translate([15,0,0])
		difference(){
			outer_chamfered_object("box",utensil_handle_width,utensil_handle_height,gap_width+10); //shape_type,shape_height,shape_width,shape_length
			translate([(gap_width+10)/2,utensil_handle_height/2-2,0])
			cube([gap_width+10,utensil_handle_height+fudge,utensil_handle_width+fudge],true);
		}
	}
}

module stylus_post_and_tip(){
	if (conduction_type=="conductive filament"){
		difference(){
			rotate([0,90,0])
			linear_extrude(height=seostl)
			offset(delta=stylus_post_delta_offset,chamfer=true)
			square([stylus_width-stylus_post_delta_offset*2,stylus_width-stylus_post_delta_offset*2],center=true);
		
			if (part=="stylus tip"){
				//drill hole for stylus tip
				stylus_hole();
				
				//add hole for nut if specified and if stylus is wide enough for a nut
				if (use_4mm_nut_to_mount_tip=="yes" && stylus_width>=10){
					translate([4,0,0])
					cube([4,8,stylus_width+fudge],true);
				}
			}
			else{
			//this is a stylus extender so add a female dove tail rather than a stylus hole
			translate([-fudge,0,0])
			dove_tail(0,stylus_width+fudge,2);
			}
		}
		
		//add male dove tail at one end
		dove_tail(seostl,stylus_width,2);
	}
	else if(part=="stylus tip" && conduction_type=="bolt and nut" && stylus_width>=10){
		difference(){
			rotate([0,90,0])
			linear_extrude(height=seostl)
			offset(delta=stylus_post_delta_offset,chamfer=true)
			square([stylus_width-stylus_post_delta_offset*2,stylus_width-stylus_post_delta_offset*2],center=true);
			
			//drill hole along the length of the stylus wide enough that the bolt can spin freely
			translate([-fudge,0,0])
			rotate([0,90,0])
			cylinder(h=seostl+fudge*2,d=5.5);
			
			if(coupling_nut_length==8){
				rotate([90,0,0])
				translate([6,0,0])
				cube([8.5,8,stylus_width+fudge],true);
			}
			else if(coupling_nut_length==15){
				rotate([90,0,0])
				translate([9.5,0,0])
				cube([15,8,stylus_width+fudge],true);
			}
		}
	}
}

module dove_tail(offset,dove_tail_length,dove_tail_width){
    translate([offset,0,-dove_tail_length/2])
    linear_extrude(height=dove_tail_length)
    polygon(points=[[0,-dove_tail_width/2],[2,-dove_tail_width],[2,dove_tail_width],[0,dove_tail_width/2]]);
}

module prism(width,length){
    translate([0,0,-length/2])
    linear_extrude(height=length)
    polygon(points=[[0,0],[0,width],[width,0]]);
}

module stylus_hole(){
    rotate([0,90,0])
    translate([0,0,2.5])
    cylinder(d=stylus_diameter,h = 5.1,center=true);
}

module six_sided_turret(){
    difference(){
        translate([0,0,-stylus_width/2])
        cylinder(h=stylus_width+2,r=stylus_width,$fn=6);
        
        rotate([0,0,30])
        dove_tail(-leg-0.01,stylus_width,2);
        rotate([0,0,90])
        dove_tail(-leg-0.01,stylus_width,2);
        rotate([0,0,150])
        dove_tail(-leg-0.01,stylus_width,2);
        rotate([0,0,210])
        dove_tail(-leg-0.01,stylus_width,2);
        rotate([0,0,270])
        dove_tail(-leg-0.01,stylus_width,2);
        rotate([0,0,330])
        dove_tail(-leg-0.01,stylus_width,2);
    }
    translate([0,0,stylus_width/2+2])
    
    rotate([0,0,90])
    rotate([0,-90,0])
    dove_tail(0,stylus_width,4);
        
}

module four_sided_turret(){
    difference(){
        translate([0,0,-stylus_width/2])
        // cube([stylus_width+2,stylus_width+2,stylus_width+2],center=true);
        linear_extrude(height=stylus_width+2)
		offset(delta=1.5,chamfer=true)
		square([stylus_width-1,stylus_width-1],center=true);
        
        rotate([0,0,0])
        dove_tail(-stylus_width/2-1-fudge,stylus_width+fudge,2);
        rotate([0,0,90])
        dove_tail(-stylus_width/2-1-fudge,stylus_width+fudge,2);
        rotate([0,0,180])
        dove_tail(-stylus_width/2-1-fudge,stylus_width+fudge,2);
        rotate([0,0,270])
        dove_tail(-stylus_width/2-1-fudge,stylus_width+fudge,2);
    }
    translate([0,0,stylus_width/2+2])
    
    rotate([0,0,90])
    rotate([0,-90,0])
    dove_tail(0,stylus_width,4);
        
}

module palm_shape(palm_loop_delta_offset){
	offset(delta=palm_loop_delta_offset)
	resize([palm_loop_length,palm_loop_height,0])
	basic_palm_shape();
}

module pointer_mount(){
	translate([-9,palm_loop_height-3.5,palm_loop_width/2])	
	rotate([-90,0,0])
	outer_chamfered_object("box",15+palm_loop_delta_offset,palm_loop_width,48);
}

module pointer_mount_slots(){
	translate([-2,palm_loop_height+palm_loop_delta_offset+2.5+fudge,-palm_loop_width]) pointer_mount_channel(8,2);
	translate([32,palm_loop_height+palm_loop_delta_offset+2.5+fudge,-palm_loop_width]) pointer_mount_channel(8,2);
}

module pointer_mount_channel(stylus_width,depth){ //8,2
	linear_extrude(palm_loop_width*2)
	polygon(points=[[-stylus_width/2,-depth],[stylus_width/2,-depth],[stylus_width/4,0],[-stylus_width/4,0]]);
}

module utensil_mount(){
	translate([-9,palm_loop_delta_offset+1,palm_loop_width/2])	
	rotate([-90,0,0])
	outer_chamfered_object("box",12+palm_loop_delta_offset,palm_loop_width,48);
}

module utensil_mount_slots(){
	translate([-2,-palm_loop_delta_offset-0.5-fudge,-palm_loop_width]) utensil_mount_channel(8,2);
	translate([32,-palm_loop_delta_offset-0.5-fudge,-palm_loop_width]) utensil_mount_channel(8,2);
}

module utensil_mount_channel(stylus_width,depth){ //8,2
	rotate([0,0,180])
	linear_extrude(palm_loop_width*2)
	polygon(points=[[-stylus_width/2,-depth],[stylus_width/2,-depth],[stylus_width/4,0],[-stylus_width/4,0]]);
}

module utensil_holder_dove_tails(){
	difference(){
		union(){
			translate([6,utensil_handle_height,0]) utensil_holder_dove_tail(8,2);
			translate([40,utensil_handle_height,0]) utensil_holder_dove_tail(8,2);
		}
		translate([uhl/2,utensil_handle_height+2+fudge,-utensil_handle_width/2-fudge])
		rotate([180,0,0])
		rotate([0,90,0])
		prism(2+chamfer_size/2,uhl );
		
		translate([uhl/2,utensil_handle_height+2+fudge,utensil_handle_width/2+fudge])
		rotate([-90,0,0])
		rotate([0,90,0])
		prism(2+chamfer_size/2,uhl );

	}
}

module utensil_holder_dove_tail(stylus_width,depth){ //8,2
	dove_tail_length=utensil_handle_width;
	translate([0,0,-dove_tail_length/2])
	rotate([0,0,180])
	linear_extrude(height=dove_tail_length)
	polygon(points=[[-stylus_width/2,-depth],[stylus_width/2,-depth],[stylus_width/4,0],[-stylus_width/4,0]]);
}

module thumb_loop_mount(){
	translate([x_offset,19,0])
	outer_chamfered_object("thumb loop mount",palm_loop_width,0,0); //shape_type,shape_height,shape_width,shape_length
}

module thumb_rest_mount(){
	translate([-palm_loop_length/2,-palm_loop_delta_offset/2,-palm_loop_width/2])
	rotate([90,0,0])
	outer_chamfered_object("box",palm_loop_delta_offset,palm_loop_width,palm_loop_length/2);

	translate([-palm_loop_length/2+palm_loop_delta_offset-1.175,-palm_loop_delta_offset/2-0.3,-palm_loop_width/2])
	rotate([0,0,105])
	rotate([90,0,0])
	outer_chamfered_object("box",palm_loop_delta_offset,palm_loop_width,palm_loop_height/2);
}

module thumb_loop_slots(){
echo("here");
        //bottom slots
		translate([x_offset-6,-4-fudge,0])
		rotate([0,0,90])
		dove_tail(0,palm_loop_width+fudge*2,2);
		
        translate([x_offset+3,-4-fudge,0])
		rotate([0,0,90])
		dove_tail(0,palm_loop_width+fudge*2,2);
		
        translate([x_offset+12,-4-fudge,0])
		rotate([0,0,90])
		dove_tail(0,palm_loop_width+fudge*2,2);
		
		//angled slots
		translate([x_offset-16.8-fudge,2,0])
		rotate([0,0,30])
		dove_tail(0,palm_loop_width+fudge*2,2);

		translate([x_offset-20.8,9,0])
		rotate([0,0,30])
		dove_tail(0,palm_loop_width+fudge*2,2);

		//corner slot
		translate([x_offset-12.45-fudge,-2.7-fudge,0])
		rotate([0,0,60])
		dove_tail(0,palm_loop_width+fudge*2,2);
}

module circular_grip(){
echo(palm_loop_length=palm_loop_length);
	difference(){
		outer_chamfered_object("rod",palm_loop_length-20,0,0);
		translate([circular_grip_diameter/2-1,0,0])
		cube([6,palm_loop_width+.5,palm_loop_length-20+fudge],true);
	}
}

module stylus_ring(){
	difference(){
		union(){
			outer_chamfered_object("outer ring",ring_width,0,0); 
			
			translate([0,fotd/2-.5+5,0])
			rotate([90,0,0])
			linear_extrude(height=5)
            offset(delta=stylus_post_delta_offset,chamfer=true)
            square([stylus_width-stylus_post_delta_offset*2,ring_width-stylus_post_delta_offset*2],center=true);

			
			if (stylus_ring_type=="finger ring next to stylus" || stylus_ring_type=="two finger rings"){
				translate([fotd/2+3.5,-4,-ring_width/2])
				rotate([0,0,90])
				cube([8,4,ring_width]);
			}
			if (stylus_ring_type=="two finger rings"){
				translate([-fotd/2-3.5,4,-ring_width/2])
				rotate([0,0,-90])
				cube([8,4,ring_width]);
			}
			if (stylus_ring_type=="finger ring opposite stylus"){
				translate([-4,-fotd/2-3.5,-ring_width/2])
				cube([8,4,ring_width]);
			}
			
		}
		inner_chamfered_object("inner ring",ring_width,0,0);
		
		
		if(conduction_type=="bolt and nut" && ring_width>=10 && stylus_width>=10){
			translate([0,1,0])
			rotate([-90,0,0])
			cylinder(r=4/cos(30),h=fotd/2+2,$fn=6);
			
			translate([0,fotd/2+1,0])
			rotate([-90,0,0])
			cylinder(d=5,h=4);
			
			translate([0,fotd/2+1.5,ring_width/2])
			cube([5,7,ring_width],true);
		}
		else{
			translate([0,fotd/2+4.5+fudge,0])
			rotate([0,0,-90])
			dove_tail(0,ring_width+fudge,2);
		}
		
		if (stylus_ring_type=="finger ring next to stylus" || stylus_ring_type=="two finger rings"){
			translate([fotd/2+3.5+fudge,0,0])
			rotate([0,0,180])
			dove_tail(0,ring_width+fudge,2);
		}
		if (stylus_ring_type=="two finger rings"){
			translate([-fotd/2-3.5-fudge,0,0])
			rotate([0,0,0])
			dove_tail(0,ring_width+fudge,2);
		}
		if (stylus_ring_type=="finger ring opposite stylus"){
			translate([0,-fotd/2-3.5-fudge,0])
			rotate([0,0,90])
			dove_tail(0,ring_width+fudge,2);
		}
	}	
}

//-------------------------------------------------------------------------------------------

module inner_chamfered_object(shape_type,shape_height,shape_width,shape_length){
    union(){
        translate([0,0,-shape_height/2])
        linear_extrude(height=shape_height)
        shape(shape_type,0,shape_width,shape_length);
        
        half_inner_chamfer(shape_type,shape_height,shape_width,shape_length);
        mirror([0,0,1]) half_inner_chamfer(shape_type,shape_height,shape_width,shape_length);
    }
}

module half_inner_chamfer(shape_type,shape_height,shape_width,shape_length){
    translate([0,0,shape_height/2-chamfer_size/2+fudge])
	hull(){
		translate([0,0,chamfer_size+fudge])
		linear_extrude(height=fudge)
		offset(delta=chamfer_size)
		shape(shape_type,fudge,shape_width,shape_length);
		
		linear_extrude(height = fudge)
		shape(shape_type,fudge,shape_width,shape_length);
   }
}

module outer_chamfered_object(shape_type,shape_height,shape_width,shape_length){
    difference(){
		translate([0,0,-shape_height/2])
        linear_extrude(height=shape_height)
        shape(shape_type,0,shape_width,shape_length);
        
        half_outer_chamfer(shape_type,shape_height,shape_width,shape_length);
        mirror([0,0,1]) half_outer_chamfer(shape_type,shape_height,shape_width,shape_length);
    }
}

module half_outer_chamfer(shape_type,shape_height,shape_width,shape_length){
    translate([0,0,shape_height/2+fudge])
    difference(){
        translate([0,0,-chamfer_size/2])
        linear_extrude(height=chamfer_size)
        shape(shape_type,fudge,shape_width,shape_length);
        
        translate([0,0,-chamfer_size/2-fudge])
        hull(){
            linear_extrude(height = fudge)
            shape(shape_type,fudge,shape_width,shape_length);
            
            translate([0,0,chamfer_size+fudge])
            linear_extrude(height=fudge)
            offset(delta=-chamfer_size)
            shape(shape_type,fudge,shape_width,shape_length);
        }
    }
}

module shape(shape_type,fudge,shape_width,shape_length){
    if(shape_type == "box"){
        translate([chamfer_size,chamfer_size,0])
        offset(delta=chamfer_size,chamfer=true)
        square([shape_length-chamfer_size*2,shape_width+fudge-chamfer_size*2]);	
    }
    else if(shape_type=="rod"){
		outer_diameter = circular_grip_diameter;
        circle(d=outer_diameter+fudge,$fn=100);   
    }
    else if(shape_type=="outer ring"){
        circle(d=ring_outer_diameter+fudge,$fn=100);   
    }
    else if(shape_type=="inner ring"){
        circle(d=ring_inner_diameter+fudge,$fn=100);   
    }
    else if(shape_type=="inner palm"){
		simple_palm(0);
	}
    else if(shape_type=="outer palm"){
		simple_palm(palm_loop_delta_offset);
	}
    else if(shape_type=="thumb loop mount"){
		thumb_loop_mount_shape();
	}
	else{
	}
}

// module simple_palm(pldo){
	// $fn=100;
	// offset(delta=pldo)
	// resize([palm_loop_length,palm_loop_height,0])
	// hull(){
		// //pointer circle
		// translate([0,17.5,0])
		// circle(17.5);

		// //little finger circle
		// translate([65+17.5/2,15,0])
		// circle(15);

		// //back of the hand radius
		// translate([24,-62,0])
		// difference(){
			// circle(100);
			// translate([0,-10,0])
			// square([210,190],center=true);
			// translate([-56,50,0])
			// square([50,100],center=true);
		// }
	// }
// }

module simple_palm(pldo){
	$fn=100;
	pointer_dia=18;
	little_finger_dia=16;
	palm_back_circle_dia=100;
	
	offset(delta=pldo)
	resize([palm_loop_length,palm_loop_height,0])
	hull(){
		//pointer circle
		translate([0,pointer_dia,0])
		circle(pointer_dia);

		//little finger circle
		translate([65+17/2,little_finger_dia,0])
		circle(little_finger_dia);

		//back of the hand radius
		translate([28,-60,0])
		difference(){
			circle(palm_back_circle_dia);
			translate([0,-10,0])
			square([210,190],center=true);
			translate([-56,50,0])
			square([50,100],center=true);
		}
	}
}

module thumb_loop_mount_shape(){
	union(){
		intersection(){
			offset(delta=10,chamfer=true)
			circle(r=15,$fn=6);
			translate([-7,-14,0])
			square([50,20],center=true);
		}
		translate([0,-23,0])
		square([20,10]);
	}
}

module finger_or_toe_ring(){
	difference(){
		union(){
			outer_chamfered_object("outer ring",ring_width,0,0);
			
			translate([-4,fotd/2,-ring_width/2])
			cube([8,2,ring_width]);
			
			translate([0,fotd/2+2,0])
			rotate([0,0,90])
			dove_tail(0,ring_width,2);
			
			if(finger_ring_type=="mount for second finger ring"){
				translate([-4,-fotd/2-3,-ring_width/2])
				cube([8,4,ring_width]);
			}
		}
		inner_chamfered_object("inner ring",ring_width,0,0);
		
		if(finger_ring_type=="mount for second finger ring"){
			translate([0,-fotd/2-3-fudge,0])
			rotate([0,0,90])
			dove_tail(0,ring_width+fudge,2);
		}
	}
}

