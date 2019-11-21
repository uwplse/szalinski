/* [Led Ring] */
//What is the radius of the outside of the ring
inner_radius = 60;

//What is the width of the ring
ring_width = 10;

//How many leds do you want to place per ring
number_of_leds = 6;

//How many rings do you want?
number_of_rings = 2;

//What is the radius of the led
led_r = 2.5;

//How high is the led (bulb)
led_height = 5;

//How deep is the cable hole
cable_dept = 2;

//how width is the cable hole
cable_width = 3;

//How many ears do you want to add to the right
number_of_mounting_ears = 3;

//What size is the ear
mounting_ear_size = 11;

//What is the radius of the mounting hole in the ear
mounting_ear_mount_r = 1.7;

//How high in the inner edge
inner_edge_height = 5;

//How high in the outer edge
outer_edge_height = 5;

/* [Hidden] */
development = 1; //[0=no, 1=yes]
outer_radius = inner_radius + (ring_width * number_of_rings);
angle_per_led = number_of_leds <= 0 ? 0 : 360 / number_of_leds;
angle_per_ear = number_of_mounting_ears <= 0 ? 0 : 360 / number_of_mounting_ears;
ear_height = outer_edge_height > 0 ? outer_edge_height + led_height : led_height;

module ear()
{
	difference()
	{
		hull()
		{
			translate([mounting_ear_size/2-2,mounting_ear_size/2-2,0])
			cylinder(r=2, h=ear_height, center=true,$fn=24);
			
			translate([mounting_ear_size/2-2,-mounting_ear_size/2+2,0])
			cylinder(r=2, h=ear_height, center=true,$fn=24);

			translate([-1,0,0])
			cube([mounting_ear_size - 1,mounting_ear_size, ear_height], center=true);
		}		
		cylinder(r=mounting_ear_mount_r, h=ear_height*2+1, center=true,$fn=24);
	}
}

translate([0,0,led_height/2])
{
	difference()
	{
		union()
		{
			cylinder(r=outer_radius, h=led_height, center=true,$fn=72);
			
			if(number_of_mounting_ears > 0)
			for(j = [0 : number_of_mounting_ears])
			{
				rotate([0,0,angle_per_led/2 + (angle_per_ear * j)])
				{
					if(outer_edge_height > 0)
					{
						translate([outer_radius + mounting_ear_size/2 - 1,0,outer_edge_height/2]) ear();
					}
					else
					{
						translate([outer_radius + mounting_ear_size/2 - 1,0,0]) ear();
					}
				}
			}
		}
		
		cylinder(r=inner_radius, h=led_height + 1, center=true,$fn=72);

		if(number_of_leds>0)
		{
			for(rn = [1 : number_of_rings])
			{
				if(outer_edge_height < cable_dept)
				{
					translate([0,0,led_height/2])
					{
						difference()
						{
							cylinder(r=((inner_radius + (rn * ring_width) - ring_width/2)) + cable_width/2, h=cable_dept*2, center=true,$fn=72);
							cylinder(r=((inner_radius + (rn * ring_width) - ring_width/2)) - cable_width/2, h=(cable_dept*2)+1, center=true,$fn=72);
						}
					}
				}
				
				for(i = [0 : number_of_leds])
				{
					rotate([0,0,(angle_per_led/2 * rn) + (angle_per_led * i)])
					{
						translate([inner_radius + (rn * ring_width) - ring_width/2,0,0])
						{
							cylinder(r=led_r,h=led_height+1,center=true,$fn=12);
							translate([0,0,led_height/2])
							{
								cylinder(r=led_r + 1,h=led_height/2,center=true,$fn=12);
							}
						}
					}
				}
			}
		}
		
		if(outer_edge_height > 0)
		{
			translate([0,0, led_height + (outer_edge_height) / 2 ])
			{
				cylinder(r=outer_radius, h=outer_edge_height + led_height, center=true,$fn=72);
			}
		}
	}	
}

if(inner_edge_height > 0)
{
	translate([0,0,(inner_edge_height + led_height) / 2])
	{
		difference()
		{
			cylinder(r=inner_radius, h=inner_edge_height + led_height, center=true,$fn=72);
			cylinder(r=inner_radius - 1, h=inner_edge_height + led_height + 1, center=true,$fn=72);
		}
	}
}

if(outer_edge_height > 0)
{
	translate([0,0,(outer_edge_height + led_height) / 2])
	{
		difference()
		{
			cylinder(r=outer_radius + 1, h=outer_edge_height + led_height, center=true,$fn=72);
			cylinder(r=outer_radius, h=outer_edge_height + led_height + 1, center=true,$fn=72);
		}
	}
}