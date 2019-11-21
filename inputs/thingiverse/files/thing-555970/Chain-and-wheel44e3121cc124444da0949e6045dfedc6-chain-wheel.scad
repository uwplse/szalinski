
link_size = 15; // link step size
link_grip_thickness = 1.5;
chain_links = 20;
wheel_teeth = 10; // number of wheel teeth
axis_diameter = 5;

$fn=20;
W = link_size;
WL_NB = wheel_teeth;

// wheel radius from nb of links
WL_R = W*cos(180/WL_NB)/(2*sin(180/WL_NB))-W/4;

// grip thickness
G = link_grip_thickness;

margin_Rrod = 0.5;
margin_slot = 0.5;
margin_Rlink = 0.5;

// link rods are spaced by a distance of W
module link()
{
	// mid part : rod hole
	// 0.05*W margin = a bit smaller than slot it should fit in
	color("orange")
	difference()
	{
		translate([0,0,W/4])
			hull()
			{
				translate([W/4,0,0])
					cube([W/2,W/2,W/2]);
				translate([0,W/4,0])
					cylinder(r=W/4-margin_Rlink, h=W/2);
			}
		// hole : a bit larger than rod
		translate([0,W/4,0])
			cylinder(r=W/10+margin_Rrod, h=W);
	}	
	
	// side parts : rod attachments
	color("yellow")
	translate([W/4,0,0])
	difference()
	{
		hull()
		{
			cube([W/2,W/2,W]);
			translate([3*W/4,W/4,0])
				cylinder(r=W/10,h=W);
		}
		translate([W/2,0,W/4-margin_slot])
			cube([W/2,W/2,W/2+2*margin_slot]);
	}

	// rod
	color("red")
	translate([W,W/4,0])		cylinder(r=W/10, h=W);
}

module tooth()
{
	cylinder(r1=W/5, r2=0, h=W/5);
	translate([0,0,-W/10]) cylinder(r=W/5, h=W/10);
}

module teeth()
{
	tooth();
	translate([0,W/2,0]) tooth();
}

module link_teeth()
{
	difference()
	{
		link();
		// holes
		translate([W/2,0,3*W/4])
			rotate([-90,0,0])
				teeth();
	}
	// grip "V"
	translate([W/4,W/2+G,0])
	rotate([90,0,0])
		linear_extrude(G+1)
		{
			hull()
			{
				translate([G/2,G/2])	circle(G/2);
				translate([W/2-G/2,W/2])	circle(G/2);
			}
			hull()
			{
				translate([G/2,W-G/2])	circle(G/2);
				translate([W/2-G/2,W/2])	circle(G/2);
			}
		}
}

module test_Nlinks(nb_link)
{
	for(i=[0:nb_link-1])
	{
		translate([i*W,0,0]) link_teeth();
	}
}

module chain_Nlinks(nb_link)
{
	echo("Number of links",nb_link);
	assign(R=W*cos(180/nb_link)/(2*sin(180/nb_link)))
	{
		echo("estimated chain print space (diameter)",2*(R+W/4));
		for (i=[0:nb_link-1])
		{
			rotate([0,0,360*i/nb_link])
				translate([-W/2, R-W/4, 0])
					link_teeth();
		}
	}
}

module wheel(nb_link=WL_NB)
{
	// inner
	linear_extrude(W)
	{
		difference()
		{
			circle(r=WL_R, $fn=180);

			for (i=[0:4])
				rotate(360*i/5)
				{
					translate([0.6*WL_R,0])
						circle(r=0.25*WL_R);
					rotate(360/10)
					{
						translate([0.75*WL_R,0])
							circle(r=0.12*WL_R);
						translate([0.3*WL_R,0])
							circle(r=0.09*WL_R);
					}
				}

			circle(r=axis_diameter/2, $fn=180);
		}
	}

	// teeth
	for (i=[0:nb_link-1])
	{
		rotate([0,0,360*i/nb_link])
			translate([0, WL_R, 3*W/4])
				rotate([-90,0,0])
					teeth();
	}
}


//test_Nlinks(2);
chain_Nlinks(chain_links);
wheel();


