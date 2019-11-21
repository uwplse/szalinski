// number of faces in circle
$fn=24; 

// number of rows
numerical_slider = 1; // [0:10]



for ( i = [1 : numerical_slider] )
{
translate([i*(34/3*2),0,0])
union()
	{
		cube([(34/3*2),35.25,1.6]);
		translate([4,-1.4,0])cube([9.8,38.05,1.6]);
		translate([8.9,-1.4,0])cylinder(h = 1.6, r=4.9);
		translate([8.9,36.65,0])cylinder(h = 1.6, r=4.9);

		translate([8.9,-1.4,0])cylinder(h = 8.1, r1=3, r2=2.8);
		translate([8.9,36.65,0])cylinder(h = 8.1, r1=3, r2=2.8);
		translate([8.9,17.625,0])cylinder(h = 8.1, r1=3, r2=2.8);

		difference() {
		union() {
		translate([2.5,0,0])cube([1.5,35.25,10.9]);
		translate([13.8,0,0])cube([1.5,35.25,10.9]);
		}
		translate([0,16.025,5.3])cube([35.25,3.75,5.7]);
		}
	}
	
}