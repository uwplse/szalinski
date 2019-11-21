//Thanks to Jeremie Francois for his OpenSCAD tutorial @ http://www.tridimake.com/2014/09/how-to-use-openscad-tricks-and-tips-to.html

part_d=51; //outside diameter of entire part
prong_height=18;
spool_cylinder_height=18;
spool_cylinder_diameter=31;
bearing_diameter=19;
bearing_thickness=7;
bearing_lip_width=2;
bottom_thickness=3;
prong_thickness=6;
prong_arc_deg=30; //this has to be less than 45

difference()
{
	difference()
	{
		union()
		{
			cylinder(r=part_d/2,h=bottom_thickness);  //base
			cylinder(r=spool_cylinder_diameter/2,h=18);  //what fits inside the spool
		}
		translate([0,0,-.01]) //start a bit below
			cylinder(r=bearing_diameter/2 - bearing_lip_width,h=spool_cylinder_height +.01 +.01); //protrude from both faces
	}
	
	translate([0,0,-.01]) //start a bit below
		cylinder(r=bearing_diameter/2,h=bearing_thickness + .01, center=false); //set the bearing lip
}
	

for(r=[(45 - prong_arc_deg)/2:90:359]) //fit the prong arc evenly within each 45 deg segment of the circle
	rotate([0,0,r])
		intersection()
		{
			rotate_extrude(convexity=10)
				translate([part_d/2 - prong_thickness,0,0])
					square([prong_thickness,prong_height]);
			prong(angle=prong_arc_deg);
		}

 module prong(angle, extent=100, height=100, center=true)
{
	module prong_wall()
	{
		translate([0,0, (center==true ? -height/2: 0)])
			cube([extent, 0.1, height]);
	}
	
	hull()
	{
		prong_wall();
		rotate([0,0,angle])
			prong_wall();
	}
	
	
}