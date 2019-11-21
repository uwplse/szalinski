radius1 = 19;
radius2 = 16;
separation = 6;
height = 30;
hole1 = 4;
module trampclamp()
{
	
		
	difference() {
		translate([0.25*(radius1-radius2), 0, 0])
		cube([0.8*(radius1 + radius2),2*radius1 , height-1 ], center = true);
		translate([radius1+separation/2, 0, 0])
		cylinder(h = height, r = radius1, center = true);	
		translate([-(radius2+separation/2), 0, 0])
		cylinder(h = height, r = radius2, center = true);	
		rotate([90,0,90])
		cylinder(h = separation*2, r = hole1, center = true);
				
	}
		
}

trampclamp();

