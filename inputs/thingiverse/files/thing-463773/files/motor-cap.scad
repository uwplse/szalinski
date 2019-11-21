// Screw dust/water proof cover for scooter
//
// This work is licensed under a Creative Commons
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// Visit: http://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Clarence Lee
// clarence@nehs.tw

// Note: Test on PTE material


$fn = 360/4;

Cap_radius = 12.0;
Cap_radius_lips = 0.5;

Cap_Cover_radius = 15.0;
Cap_height = 11.0;

Cap_radius_wider = Cap_radius + Cap_radius_lips;

module lips(z_off, r_a, r_b, height_l)
{
	difference()
	{		
		translate([0,0,z_off]){
			# cylinder(r1=r_a, r2=r_b,h=height_l);}
		translate([0,0,z_off]) {
			# cylinder(r=min(r_a,r_b) ,h=height_l); }

	}
}

union()
{
	cylinder(r1=Cap_Cover_radius-1,r2=Cap_Cover_radius, h=2);

	difference()
	{
		
		translate([0,0,2])
			cylinder(r=Cap_radius,h=Cap_height-2);
		translate([0,0,2])
			cylinder(r=Cap_radius-2.2,h=Cap_height-2);	
	}


	lips(3.5, Cap_radius, Cap_radius_wider, 1.5);
	translate([0,0,10]) mirror([0,0,1]) lips(3.5, Cap_radius, Cap_radius_wider, 1.5);
	lips(Cap_height-2, Cap_radius, Cap_radius_wider, 0.5);
	lips(Cap_height-1.5, Cap_radius_wider, Cap_radius, 1.5);

}