// number of rows
numerical_slider = 4; // [0:10]
//number of columns
numerical_slider2 = 4; // [0:10]

// number of faces in circle
$fn=48; 

for ( i = [1 : numerical_slider2] )
{
translate([0,i*(22),0])
for ( i = [1 : numerical_slider] )
{
translate([i*(22),0,0])
	difference()
	{
	cube(size = [22,22,8], center = true);
	union()
		{
			translate([0,0,4]) cube(size = [10,23,4], center = true);
			translate([0,0,4])cube(size = [23,10,4], center = true); 
		}
	translate([0,0,-5.99]) cylinder(h = 8, r=9.5);
	}
}
}


