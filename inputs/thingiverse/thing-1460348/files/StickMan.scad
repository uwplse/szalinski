// ==================================================
// Stick Man - Customizer
// Created by Daiju Watanbe ( Daizyu ).
// 2 April 2016. 
// =================================================

// preview[view:south, tilt:top]

/* [Angle] */
upper_arm_l = -70;               // [-360:360]
lower_arm_l = 110;               // [-360:360]
hand_l = -30;               // [-360:360]
upper_arm_r = 80;               // [-360:360]
lower_arm_r = 40;               // [-360:360]
hand_r = 30;               // [-360:360]
thigh_l = -40;               // [-360:360]
shin_l = 30;               // [-360:360]
foot_l = 10;               // [-360:360]
thigh_r = 40;               // [-360:360]
shin_r = -30;               // [-360:360]
foot_r = -10;               // [-360:360]
body = 0;               // [-360:360]

/* [Base] */
base_position = 1; // [0:None,1:Left Leg,1:Right Leg,2:Left Arm,3:Right Arm] */
base_type=3;	// [1:Circle,2:Front circle,3:Back circle,4:Cube,5:Front cube,6:Back cube */
base_width = 15;
base_depth = 5;
base_height = 2;
base_rotate = 0;
base_offset_x = 5.5;
base_offset_y = 0;

/* [Basic] */
b_thickness = 2;
thickness = 1.4;

/* [Head] */
fill_head = false;
head_diameter = 10;
head_offset_x = 0;
head_offset_y = 0;

/* [Body] */
body_length = 12;

/* [Left arm] */
arm_l_offset = 2;
upper_arm_l_length = 5;
lower_arm_l_length = 5;
hand_l_length = 2;

/* [Right arm] */
arm_r_offset = 2;
upper_arm_r_length = 5;
lower_arm_r_length = 5;
hand_r_length = 2;

/* [Left Leg] */
thigh_l_length = 7;
shin_l_length = 7;
foot_l_length = 2;

/* [Right Leg] */
thigh_r_length = 7;
shin_r_length = 7;
foot_r_length = 2;

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

module base(){
	if(base_type==0)
	{

	}
	if(base_type==1)
	{
		translate([0,0,b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth,base_height])
		cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
	}
	if(base_type==2)
	{
		translate([0,0,b_thickness])
		//translate([0,0,-base_height-b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth*2,base_height])
		difference() 
		{
			cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
			translate([-1,0 ,-1 ])
			cube([2,2 ,base_height+2 ], center = false);
		}
	}
	if(base_type==3)
	{
		translate([0,0,0])
		//translate([0,0,-base_height-b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth*2,base_height])
		difference() 
		{
			cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
			translate([-1,-2,-1])
			cube([2,2 ,base_height+2 ], center = false);
		}
	}
	if(base_type==4)
	{
		translate([0,0,b_thickness/2])
		//translate([0,0,-base_height-b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth*2,base_height])
		difference() 
		{
			//cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
			//cube([2,2 ,base_height+2 ], center = false);
			translate([-0.5,-0.5 ,0 ])
			cube([1,1 ,1 ], center = false);
		}
	}
	if(base_type==5)
	{
		translate([0,0,b_thickness])
		//translate([0,0,-base_height-b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth*2,base_height])
		difference() 
		{
			//cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
			//cube([2,2 ,base_height+2 ], center = false);
			translate([-0.5,-1.0 ,0 ])
			cube([1,1 ,1 ], center = false);
		}
	}
	if(base_type==6)
	{
		translate([0,0,0])
		//translate([0,0,-base_height-b_thickness/2])
		rotate(90,[1,0,0])
		scale([base_width,base_depth*2,base_height])
		difference() 
		{
			//cylinder(h=base_height, r=1, center=false ,$fn=base_fn);
			//cube([2,2 ,base_height+2 ], center = false);
			translate([-0.5,0 ,0 ])
			cube([1,1 ,1 ], center = false);
		}
	}
}


module branch(
	head_diameter,
	Degrees1,Length1,
	Degrees2,length2,
	Degrees3,length3,
	Degrees4,length4,
	BasePosition)
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
				bone(length4);

				if ( base_position == BasePosition ) 
				{
					translate([0,length4,0])
						rotate(-Degrees2-Degrees3
						-Degrees4-Degrees1+base_rotate,[0,0,1])
						translate([base_offset_x,base_offset_y,0])
						base();
						//cube([1,1,1]);
				}
			}
		}
	}
}

module headBody()
{
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
				cylinder(h=b_thickness+2, r=(head_diameter)/2.0-thickness, center=false ,$fn=head_fn);
		}
	}

	branch(head_diameter,
		body+180,body_length,
		thigh_l,thigh_l_length,
		shin_l,shin_l_length,
		foot_l,foot_l_length,
		1);

	branch(head_diameter,
		body+180,body_length,
		thigh_r,thigh_r_length,
		shin_r,shin_r_length,
		foot_r,foot_r_length,
		2);

	branch(head_diameter,
		body+180,arm_l_offset,
		upper_arm_l,upper_arm_l_length,
		lower_arm_l,lower_arm_l_length,
		hand_l,hand_l_length,
		3);

	branch(head_diameter,
		body+180,arm_r_offset,
		upper_arm_r,upper_arm_r_length,
		lower_arm_r,lower_arm_r_length,
		hand_r,hand_r_length,
		4);
}