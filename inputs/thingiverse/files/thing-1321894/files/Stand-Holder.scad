height = 40;
radius = 10;
rad_ext = radius+4;

union(){
	translate([0, 8+2, 0]) cube([75,8,10]);
	translate([0, 62-5, 0]) cube([75,8,10]);
	translate([(75-56)/2, 7, 0]) cube([56,62,10]);
	difference(){
		translate([75/2, 62/2+7, 10]) cylinder(height,rad_ext+5,rad_ext);
		translate([75/2, 62/2+7, 10]) cylinder(height+1,radius,radius);
	}	
}