/* Wheel Hexes for Touring cars, different offsets */

$fn=50;


/* Modules */
include <../Modules/Module_Geometrical_Objects.scad>;


hex(7.5, 0.5, 2.3, 5.3);



module hex(height, nubsi, pin, axle)
{
	difference()
	{
		union()
		{
			hexHub(12, height-nubsi);
			
			translate([0, 0, height-nubsi])
			cylinder(d=axle+2,h=nubsi);
		}
		
		cylinder(d=axle, h=23);
		
		translate([0, 0, pin/2 + height-2.1])
		rotate([0, -90, 0])
		hull()
		{
			cylinder(d=pin, h=10, center=true);
			
			if (1)
			translate([4.2, 0, 0])
			cylinder(d=pin, h=10, center=true);
		}
	}
}