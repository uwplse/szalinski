//Which part to generate
part="cutside";// [cutside,cuttop,full,only_house,only_house_cutside,only_house_cutsidetop]

//House size
house_w=50;
//House size
house_l=80;
//House height
house_h=40;
//All walls thickness
house_wall=1;
//Thickness of the vacuum insulation 
house_insulation=2;
//Inner house floor depth from the middle of the room
house_floor=25;

//Gap so that hatch doors can be printed and later be freed up (so they can move)
port_gap=.3;

//Entry tube diameter
entry_h=17;

//Port to the next module (front)
frontport=1;//[0,1]
//Port to the next module (back)
backport=1;//[0,1]

//Inhabitants count
man_number=2;//[0,1,2]
//Inhabitants body height
man_height=18;

//hill
hill_thickness=20;

//Rough Number of machines inside the residence
machine_count=36;//[0,16,20,24,36,40,48]

//vertical pillar distance under the floor
inner_pillar_dist=8;

//horizontal pillar distance around the exit tube
outer_pillar_dist=8;


/* [Switches] */

//Do you like solar cells on top?
solar_cell=1;//[0,1]

//Do you want a floor? If not, better dont select inhabitants... :-)
floor_construction=1;//[0,1]

//Do you want pillars? They are needed to reinforce the structure
pillar=1;//[0,1]

//Do you want to be able to climb out?
Ladder=1;//[0,1]
//A door to seal the outer compartment off?
hatchdoor=1;//[0,1]

//Do you want the outer wall?
Outer_Wall=1;//[0,1]
//Do you want the inner wall?
Inner_Wall=1;//[0,1]

//Top hatch hinge
Top_hinge=1;//[0,1]

// preview[view:north west, tilt:top diagonal]

/* [Hidden] */

/*
MarsCosy - A minimal mars residence.
Version 12, June 2014
Written by MC Geisler (mcgenki at gmail dot com)

The model should print without any support. The hinges will work!

Irradiation: The thick layer of material on top protects the inhabitants.
Low outside temperature: The double walls contain superinsulation. It isolates the inner space and the inhabitants together with the equipment generate enough heat to keep the room warm. This saves on energy.
Air: The spherical shape holds pressure easiest (lowest material strain, less material needed)
Dust/Storms: The structure is underground and protected.
Energy: Sun following solar cells generate power.

Many aspects are customizable! Have a try...

The scale is: 10mm = 1m

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/


// // for debugging
//part="only_house_cutfront";// [cutside,cuttop,full,only_house,only_house_cutside]
//man_number=0;//[0,1,2]
//machine_count=0;//[0,16,20,24,36,40,48]
//solar_cell=0;//[0,1]
//floor_construction=0;//[0,1]
//pillar=0;//[0,1]
//Outer_Wall=1;//[0,1]
//Inner_Wall=1;//[0,1]

$fs=1;

//inner pillars
inner_pillar_r=house_wall;
//outer pillars
outer_pillar_r=inner_pillar_r*1;

//entry
entry_l=entry_h*2.2;
entrytop_h=house_h;
portbulge=entry_h*.05;
port_r=entry_h/2+portbulge;
//Size of the top hatch hinge
Top_hinge_size=port_r*1.6;

//size
house_size=max(house_w,house_l+entry_l);
//Inner Hatchdoor
hatch_distance=port_gap; //.4
Doorthick=house_wall*2+house_insulation;
Hatchdoor_hinge_size=Top_hinge_size;
//ladder
ladder_r=house_wall*.7;
ladder_step_r=0.5;
ladder_w=5;//entry_h/2;
ladder_stepdist=3;
//inhabitants
man_head=man_height/7.5; //8 heads hight
man_body=man_height-man_head;
man_width=2.33*man_head;
man_depth=1.2*man_head;
man_shoulder_r=man_depth/2;

//Hill
hill_factor=sqrt(2);
hill_size=house_size*hill_factor;
hill_height=house_h*sqrt(2);
walls_adder=4*house_wall+2*house_insulation;
hill_adder=hill_thickness;

//machines
machine_dist=.92;
machine_angle=360/machine_count;
machine_width=2*3.14*house_w/machine_count*.7; //house_l/10
door_angle_small=15;
door_angle_big=30;

//solar cells
solar_cell_m_w=house_l/4;
solar_cell_m_l=house_l/4;
solar_cell_height=solar_cell_m_w/2;
solar_cell_mount_smaller=.25;
solar_cell_mount_r=2;
curvature_r=house_h+walls_adder+hill_adder;

//stand for presentation if no hill is selected
footheight=5;

//----------------------------------------------------------------------------
//hinge stuff
// Choose a stacking clearance factor, in mm (controls distance between cubes)
stacking_clearance = .3;
// Choose a hinge radius, in mm
hinge_radius = 1.5; 
// Choose a hinge clearance factor, in mm (controls distance around hinge parts)
hinge_clearance = .45;
// Other variables that people don't get to choose
hinge_fn=24*1;
fudge = .01*1;
corner_radius = 3;//.1*30cube_height;
cone_height = 1.4*hinge_radius; 
//cut out above and below the hinge
longercutoff=0;

function outside_height2(Height) = .3*(Height-2*stacking_clearance);
function inside_height2(Height) = (Height-2*stacking_clearance)-2*outside_height2(Height);

module outsideHolder(outside_height2,inside_height2)
{
	// attacher for outside hinge cylinders
	//translate([0,0,stacking_clearance+outside_height2+inside_height2+hinge_clearance])
		rotate(-45,[0,0,1])
			translate([-.8*hinge_radius,0,0])
				cube([1.6*hinge_radius,2*hinge_radius,outside_height2-hinge_clearance-corner_radius/2]);	
}

module HingeUD_add(size,doHolder)
{
	outside_height2 = outside_height2(size);
	inside_height2 = inside_height2(size);

	difference()
	{
		union()
		{
			// top cylinder on outside hinge
			translate([0,0,stacking_clearance+outside_height2+inside_height2+hinge_clearance])
			{
				cylinder(	h=outside_height2-hinge_clearance-corner_radius/2, 
								r1=hinge_radius, 
								r2=hinge_radius, 
								$fn=hinge_fn);
				if (doHolder==1)
					outsideHolder(outside_height2,inside_height2);
			}
		
			// bottom cylinder on outside hinge
			translate([0,0,stacking_clearance+corner_radius/2])
			{
				cylinder(	h=outside_height2-hinge_clearance-corner_radius/2,
								r1=hinge_radius,
								r2=hinge_radius, 
								$fn=hinge_fn);
				if (doHolder==1)
					outsideHolder(outside_height2,inside_height2);
			}
		}
		HingeUD_sub(size,0); //cut it completely
	}
}

module HingeUD_sub(size,halfcut)
{
	outside_height2 = outside_height2(size);
	inside_height2 = inside_height2(size);

	difference()
	{
		translate([0,0,stacking_clearance+outside_height2])
		{
			// take away middle cylinder with clearance
			translate([0,0,-hinge_clearance-fudge])
				cylinder(	h=inside_height2+2*hinge_clearance+2*fudge, 
								r1=hinge_radius+fudge+hinge_clearance, 
								r2=hinge_radius+fudge+hinge_clearance, 
								$fn=hinge_fn);
	
			// take away top cone with clearance
			translate([0,0,inside_height2+hinge_clearance-fudge])
				cylinder(h=cone_height, r1=hinge_radius, r2=0, $fn=hinge_fn);
	
			// take away bottom cone with clearance
			translate([0,0,-cone_height-hinge_clearance+fudge])
				cylinder(h=cone_height, r1=0, r2=hinge_radius, $fn=hinge_fn);
		}
		
		//only cut into one side!
		if(halfcut>0)
		{
			translate([size/2,-size/2,size/2])
				cube([size,size,size],center=true);
		}
	}
}

module HingeM_add(size)
{
	outside_height2 = outside_height2(size);
	inside_height2 = inside_height2(size); 
	
	translate([0,0,stacking_clearance+outside_height2])
	{
		// inside hinge cylinder
		cylinder(	h=inside_height2, 
						r1=hinge_radius, 
						r2=hinge_radius, 
						$fn=hinge_fn);

		// attacher for inside hinge cylinder
		rotate(45+180,[0,0,1])
			translate([-.8*hinge_radius,0,0])
				cube([1.6*hinge_radius,2*hinge_radius,inside_height2]);	

		// inside hinge top cone 
		translate([0,0,inside_height2])
			cylinder(	h=cone_height, 
							r1=hinge_radius, 
							r2=0, 
							$fn=hinge_fn);

		// inside hinge bottom cone 
		translate([0,0,-cone_height])
			cylinder(	h=cone_height, 
							r1=0, 
							r2=hinge_radius, 
							$fn=hinge_fn);
	}
}
module HingeM_sub(size,longercutoff)
{
	outside_height2 = outside_height2(size);
	inside_height2 = inside_height2(size); 
		
	rotate([0,0,180])
		difference()
		{
		
			translate([0,0,stacking_clearance])
			{
				// take away inside top cylinder with clearance
				translate([0,0,outside_height2+inside_height2])
					cylinder(	h=outside_height2+fudge+longercutoff, 
									r1=hinge_radius+fudge+hinge_clearance, 
									r2=hinge_radius+fudge+hinge_clearance, 
									$fn=hinge_fn);
	
				// take away inside bottom cylinder with clearance
				translate([0,0,-fudge-longercutoff])
					cylinder(	h=outside_height2+fudge+longercutoff, 
									r1=hinge_radius+fudge+hinge_clearance, 
									r2=hinge_radius+fudge+hinge_clearance, 
									$fn=hinge_fn);
			}

			//only cut into one side!
			translate([0,-size/2,size/2])
				cube([size,size,size],center=true);
			translate([size/2,size/2,size/2])
				cube([size,size,size],center=true);
		}
}

module Hinge_add(size,DoHolder)
{
	HingeM_add(size);
	HingeUD_add(size,DoHolder);
}
module Hinge_sub(size,longercutoff)
{
	HingeM_sub(size,longercutoff);
	HingeUD_sub(size,1);//cut only half side (only the wall, not the door)
}

module hinge_test(Width,Thick)
{
	difference()
	{
		union()
		{
			//main
			translate([Width/2,Width/2,Width/2])
				cube([Width,Width-corner_radius/4-stacking_clearance/2,Width], center=true); 
			//door
			translate([Width/2,-Thick/2,Width/2])
			cube([Width,Thick-corner_radius/4-stacking_clearance/2,Width], center=true); 
		}		
		Hinge_sub(Width);
	}
	Hinge_add(Width,0);
}

DoorWidth=20;
DoorThick=6;
//hinge_test(DoorWidth,DoorThick);
//----------------------------------------------------------------------------

module ellipsoid(dw,dl,dh)
{
	w=dw/2;
	l=dl/2;
	h=dh/2;
	scale([1,l/w,h/w])
		sphere(r=w);
}

module inner_space(adder)
{	
	ellipsoid(house_w+adder*2,house_l+adder*2,house_h+adder*2);
}

module inner_space_and_entry(adder,DoPortGap)
{	
	inner_space(adder);

	//entry tube horizontal
	translate([0,-house_l/2,0])
		rotate([90,0,0])
			cylinder(r=entry_h/2+adder,h=entry_l,center=true);

	translate([0,-house_l/2-entry_l/2,entrytop_h-entry_h/2])
		difference()
		{
			union()
			{
				//entry tube vertical
				translate([0,0,-entrytop_h/2-adder/2])
					cylinder(r=entry_h/2+adder,h=entrytop_h+adder,center=true);
		
				//entry lid
				scale([1,1,1])
					sphere(r=port_r+adder,center=true);
			}
			
			if(DoPortGap==1)
			{
				cube([4*port_r,4*port_r,port_gap],center=true);
			}
			else
			{
				//cut out a ring from the inner cut out
				difference()
				{
					cylinder(r=port_r+adder,h=port_gap+4*house_wall,center=true);
					cylinder(r=(port_r+adder)-adder,h=port_gap+4*house_wall+1,center=true);
				}
			}
		}

	if (backport==1)
	{
		//Connecting tube back
		translate([-house_w/2,0,0])
			rotate([0,90,0])
				cylinder(r=entry_h/2+adder,h=entry_l,center=true);
	}

	if (frontport==1)
	{
		//Connecting tube front
		translate([house_w/2,0,0])
			rotate([0,90,0])
				cylinder(r=entry_h/2+adder,h=entry_l,center=true);
	}
}

module single_house_wall(adder2,thick)
{
	difference()
	{
		inner_space_and_entry(adder2+thick,1);
		inner_space_and_entry(adder2,0);
	}
}

module OnlyInBetweenWalls_object(relevantpart)
{
	//in between walls
	difference()	
	{
		single_house_wall(house_wall,house_insulation);

		if (relevantpart=="room")
		{
			translate([0,-house_size/2-house_l/2*1.1,0])
				cube([house_size,house_size,house_size],center=true);
		}
	}
} 

module pillars(width,length,height,dist,radius)
{
	//vertical pillars 
	for (x=[floor(-width/2/dist):floor(width/2/dist)])
		for (y=[floor((-length/2-width/4)/dist):floor((length/2+width/4)/dist)])
			translate([x*dist,(y+x/2)*dist,-height/2])
				cylinder(r=radius,h=height,center=true);
}

module OnlyInsideRoom_object()
{
	//inner space
	inner_space_and_entry(house_wall/2,0);
} 

module floor_construction()
{
	//floor
	intersection()
	{
		union()
		{
			translate([0,0,-house_floor/2])
				cube([house_size,house_size,house_wall],center=true);

			//pillars for the floor
			if(pillar==1)
				translate([0,0,-house_floor/2])
					pillars(house_w,house_l,house_h,inner_pillar_dist,inner_pillar_r);
		}

		OnlyInsideRoom_object();
	}
}

module pillars_square(width,length,height,dist,radius)
{
	//vertical pillars 
	for (x=[floor(-width/2/dist):floor(width/2/dist)])
		for (y=[floor((-length/2)/dist):floor((length/2)/dist)])
			translate([x*dist,y*dist,-height/2])
				cylinder(r=radius,h=height,center=true);
}

module solar_cell_joint(height)
{
		translate([0,0,height*.25])
			sphere(r=solar_cell_mount_r);
}
module solar_cell_module(height)
{
	//module
	hull()
	{
		translate([0,0,height])
			rotate([30,0,0])
				cube([solar_cell_m_l,solar_cell_m_w,house_wall],center=true);

		//joint
		solar_cell_joint(height);
	}
	
	//foot
	hull()
	{
		solar_cell_joint(height);
		translate([0,0,-height])
			cube([solar_cell_mount_r*1.8,solar_cell_mount_r*1.8,house_wall],center=true);
	}
}

module solar_cell()
{
	for (y=[-1:1])
		for (x=[-1:1])
			 assign (dx=(solar_cell_m_l+3)*x, dy=(solar_cell_m_w+3)*y)
				translate([dx,dy,house_h/2+hill_adder])
					translate([0,0,solar_cell_height-(curvature_r-sqrt(curvature_r*curvature_r-dx*dx-dy*dy))])
					solar_cell_module(solar_cell_height);

}

module in_between_pillars()
{
	intersection()
	{
		//spherical pillars
		//scale([1,house_l/house_w,house_h/house_w])	
		for (theta=[0:180/9:180-1])
			for (phi=[0:180/8:180-1])
				rotate([theta,0,phi])
					cylinder(r=outer_pillar_r,h=house_size,center=true);

		OnlyInBetweenWalls_object("room");
	}

	intersection()
	{
		union()
		{
			//pillars entry tube horizontal
			for (theta=[0:180/6:180-1])
				translate([0,-entry_l/2/4-house_l/2,0])
					rotate([0,theta,0])
						cylinder(r=outer_pillar_r,h=house_size,center=true);

			//pillars entry tube vertical
			for (theta=[0:180/6:180-1])
				for (z=[-entrytop_h/2-.3:outer_pillar_dist:entrytop_h/2*1.5])
					if(abs(z-entrytop_h/2)>outer_pillar_dist/2)
						translate([0,-house_l/2-entry_l/2,entrytop_h/2-entry_h/2+z])
							rotate([90,0,theta])
								cylinder(r=outer_pillar_r,h=house_insulation*2+entry_h+house_wall*6,center=true);

			//pillars entry tube bottom of vertical
			translate([0,-house_l/2-entry_l/2,-entry_h/2-house_insulation])
				intersection()
				{
					translate([0,0,house_insulation])
						pillars(entry_h/2,entry_h/2,house_insulation*2,entry_h/3,outer_pillar_r);
					cylinder(r=entry_h/2,h=house_insulation*2,center=true);
				}
		}
		OnlyInBetweenWalls_object();
	}
}

module hatchdoor()
{
	translate([0,-house_l/2+2*house_wall,0])
		{
			rotate([90,0,0])
				difference()
				{
					union()
					{
						//door
						cylinder(r=entry_h/2-hatch_distance,h=Doorthick,center=true);

						//handle
						rotate([0,90,0])
						difference()
							{
								cylinder(r=Doorthick/2+house_wall*2,h=house_wall*2,center=true);
								cylinder(r=Doorthick/2+house_wall*2-house_wall,h=house_wall*2+1,center=true);
							}
					}
					//insulation 
					intersection()
					{
						cylinder(r=entry_h/2-hatch_distance-house_wall,h=house_insulation,center=true);
						//make the insulation a bit shorter to strengthen the door hinge
						cube([entry_h*.6,entry_h,entry_h],center=true);
					}
				}
		}
				
}



module ladder()
{
	module ladder_leg(shift)
	{
		translate([0,shift,0])
			cylinder(r=ladder_r,h=entrytop_h,center=true);
	}

	intersection()
	{
		translate([-entry_h/3,-house_l/2-entry_l/2, entrytop_h/2-entry_h/2 ])
			rotate([0,0,0])
			{
		
				//entry tube vertical
				//translate([0,-house_l/2-entry_l/2,entrytop_h/2-entry_h/2-adder/2])
				//	cylinder(r=entry_h/2+adder,h=entrytop_h+adder,center=true);
			
				//legs
				ladder_leg(-ladder_w/2);
				ladder_leg(ladder_w/2);
	
				//steps
				for (z=[0:ladder_stepdist:entrytop_h])
					translate([0,0,z-entrytop_h/2])
						rotate([90,0,0])
							cylinder(r=ladder_step_r,h=ladder_w,center=true);
	
				//holder
				for (z=[0:ladder_stepdist*3:entrytop_h])
					for (y=[-ladder_w/2,ladder_w/2])
						translate([-ladder_w,y,z-entrytop_h/2])
							rotate([0,90,0])
								cylinder(r=ladder_step_r,h=ladder_w*2,center=true);
			}

		OnlyInsideRoom_object();
	}
}

module man()
{
	//body
	hull()
	{
		translate([0,0,man_body-man_shoulder_r])
			rotate([90,0,0])
				cylinder(r=man_shoulder_r,h=man_width,center=true,$fn=16);

		cylinder(r=man_head*.7,h=man_head,$fn=16);
	}

	//head and neck
	translate([0,0,man_height-man_head/2])
	{
		sphere(r=man_head/2,$fn=16);
		translate([0,0,-man_head/2])
			cylinder(r=man_head/4,h=man_head,$fn=16,center=true);
	}
}

module inhabitants()
{
	if(man_number>0)
		translate([-man_width,-man_width,-house_floor/2])
			rotate([0,0,30])
				man();

	if(man_number>1)
		translate([-man_width,man_width,-house_floor/2])
			rotate([0,0,-30])
				man();
}

module machine(width,height)
{
	translate([0,0,-house_floor/2+height/2])
	{
		difference()
		{
			union()
			{
				cube([house_w/8,width,height],center=true);
				for (i=[1:5])
					translate([0,width/5*rands(-2,2,1)[0],height/10*rands(-4,4,1)[0]])
						cube([house_w/8+1.2,width/5*rands(.5,1,1)[0],height/10*rands(.5,1,1)[0]],center=true);
			}
				for (i=[1:rands(0,3,1)[0]])
				{
					translate([-house_w/8/2-2+.6,0,height*rands(-.5,.5,1)[0]])
						cube([4,width,.6],center=true);
					translate([-(-house_w/8/2-2+.6) ,0,height*rands(-.5,.5,1)[0]])
						cube([4,width,.6],center=true);
				}
		}
	}
}

module machines()
{ 
	intersection()
	{
		for (i=[0:machine_angle:360])
			translate([house_w/2*cos(i)*machine_dist,house_l/2*sin(i)*machine_dist,0])
				rotate([0,0,atan(tan(i)*house_w/house_l)])
					if( abs(i-270)>door_angle_big 
							&& abs(360-i)>door_angle_small && abs(i)>door_angle_small
							&& abs(180-i)>door_angle_small )
						machine(machine_width,(man_height*rands(.9,1.2,1)[0]));
		
		OnlyInsideRoom_object();
	}
}

//All functions for the top hatch hinge
function translate_Top_Hinge() = [ -(port_r+1.5*house_wall+house_insulation) , 
						-house_l/2-entry_l/2-Top_hinge_size/2 , 
						entrytop_h-entry_h/2 ];
module Top_Hinge_add()
{
	translate(translate_Top_Hinge()) 
		rotate([-90,0,0])
			Hinge_add(Top_hinge_size,1);
}
module Top_Hinge_sub()
{
	translate(translate_Top_Hinge()) 
		rotate([-90,0,0])
			Hinge_sub(Top_hinge_size,0);
}

Hatchdoor_hinge_size=entry_h*.85;
//All functions for the inner hatch door hinge
function translate_Hatchdoor_Hinge() = [-(entry_h/2-hatch_distance)+.3, 
						-house_l/2+2*house_wall+house_wall*2 +.1, 
						-Hatchdoor_hinge_size/2];
module Hatchdoor_Hinge_add()
{
		translate(translate_Hatchdoor_Hinge()) 
			Hinge_add(Hatchdoor_hinge_size,0);
}
module Hatchdoor_Hinge_sub(LessCutoff)
{
		translate(translate_Hatchdoor_Hinge()) 
			Hinge_sub(Hatchdoor_hinge_size,LessCutoff);
}


module house()
{
	difference()
	{
		union()
		{
			//outer wall
			if(Outer_Wall==1)
				single_house_wall(house_wall+house_insulation,house_wall);
		
			//inner wall
			if(Inner_Wall==1)
				single_house_wall(0,house_wall);

			//hatch
			if(hatchdoor==1)
			difference()
			{
				hatchdoor();
				Hatchdoor_Hinge_sub(0);
			}
		}
		//top hatch
		if(Top_hinge==1)
			Top_Hinge_sub();

		//hatchdoor 
		if(hatchdoor==1)
			Hatchdoor_Hinge_sub(-4);
	}

	//top hatch
	if(Top_hinge==1)
		Top_Hinge_add();

	//hatchdoor 
	if(hatchdoor==1)
		Hatchdoor_Hinge_add();



	//floor
	if(floor_construction==1)
	floor_construction();

	//pillars in between walls
	if(pillar==1)
		in_between_pillars();

	//ladder
	if(Ladder==1)
		ladder();

	//inhabitants
	inhabitants();

	//machines
	if(machine_count>0)
		machines();
}	

module fullhill()
{
		hull()
		{
			//house bump
			inner_space(hill_thickness+house_insulation);
	
			//terrain
			translate([0,0,-hill_height/2])
				cube([hill_size,hill_size,hill_height],center=true);
		}
}

module hill_surface()
{
	difference()
	{
		fullhill();

		translate([0,0,-house_wall])
			fullhill();

		inner_space_and_entry(0,0);
	}
}


module hill()
{
	difference()
	{
		fullhill();
		inner_space_and_entry(house_wall+house_insulation,0);
	}
}

module cut_to_size_object()
{
		//cut away for better printing
		translate([0,0,hill_adder/2-7.5+50/2])
				cube([house_w+walls_adder,house_l+entry_l*2+walls_adder,house_h+walls_adder+hill_adder+50],center=true);	
}

module hill_and_house()
{
	intersection()
	{
		union()
		{
			house();
			hill();
			if (solar_cell==1)
				solar_cell();
		}
		cut_to_size_object();
	}
}

//----------------------------
// choices

if (part=="cutside")
{
	rotate([0,0,180])
	difference()
	{
		hill_and_house();
		translate([house_size,0,0])
			cube(house_size*2,center=true);
	}
}	
	
if (part=="full")
{
	hill_and_house();
}	
	
if (part=="cuttop")
{
	difference()
	{
		hill_and_house();
		translate([0,0,house_size])
			cube(house_size*2,center=true);
	}

	//inhabitants
	inhabitants();

	//machines
	if(machine_count>0)
		machines();
}	

if (part=="only_house" || part=="only_house_cutside" || part=="only_house_cutsidetop" || part=="only_house_cutfront")
{
	rotate([0,0,180])
		difference()
		{			
			intersection()
			{
				union()
				{
					house();

					//stand for printing and to put it on your desk
					difference()
					{
						translate([0,0,-(house_h+walls_adder-footheight)/2])
							cylinder(r=house_w/2/2,h=footheight,center=true);
						inner_space_and_entry(house_wall+house_insulation+house_wall-house_wall/2,0);
					}
				}
				cut_to_size_object();
			}

			if (part=="only_house_cutside"||part=="only_house_cutsidetop")
			{
				translate([house_size,0,0])
					cube(house_size*2,center=true);
			}

			if (part=="only_house_cutfront")
			{
				translate([0,-house_size-house_size/2,0])
					cube(house_size*2,center=true);
			}

			if (part=="only_house_cutsidetop")
			{
				translate([0,0,house_size+31.5])
					cube(house_size*2,center=true);
			}
		}
}	