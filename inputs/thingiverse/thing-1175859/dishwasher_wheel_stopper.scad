height=27.5;

width=10;

wall_thickness=1;

hole_distance=4.5;

hole_diameter=2.5;

$fn=20*1;


difference()
{
	hull()
		{
		cylinder(r=width/2+wall_thickness,h=hole_distance+wall_thickness+hole_diameter);
		translate([height-width,0,0])
		cylinder(r=width/2+wall_thickness,h=hole_distance+wall_thickness+hole_diameter);
		}
	translate([0,0,wall_thickness])	
	hull()
		{
		cylinder(r=width/2,h=hole_distance+hole_diameter+0.1);
		translate([height-width,0,0])
		cylinder(r=width/2,h=hole_distance+hole_diameter+0.1);
		}
	translate([(height-width)/2,-(width+wall_thickness*2+0.2)/2,+wall_thickness])
		cube([1,width+wall_thickness*2+0.2,hole_distance*2+0.1]);
}

translate([-width/2,0,hole_distance+wall_thickness])
sphere(r=hole_diameter/2);
translate([height-width/2,0,hole_distance+wall_thickness])
sphere(r=hole_diameter/2);