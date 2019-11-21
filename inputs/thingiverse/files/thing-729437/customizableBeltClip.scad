//width of the belt
beltwidth = 9;
// thickness of belt
thickness = 1.75;

module roundedRect(size, radius) {
 x = size[0];
 y = size[1];
 z = size[2];

 linear_extrude(height=z)
 hull() {
	translate([radius, radius, 0])
	circle(r=radius, $fn=20);
	
	translate([x - radius, radius, 0])
	circle(r=radius, $fn=20);
	
	translate([x - radius, y - radius, 0])
	circle(r=radius, $fn=20);
	
	translate([radius, y - radius, 0])
	circle(r=radius, $fn=20);
 }
}

difference()
{
	roundedRect([27.5,15,1.5],4);
	
	translate([20,7.5,-0.25])
	cylinder(r=2.75, h=2, $fn=20);
	
	translate([4-2.75/2,2.5,-0.25])
	roundedRect([1+thickness,1+beltwidth,2],1);

	translate([12-2.75/2,2.5,-0.25])
	roundedRect([1+thickness,1+beltwidth,2],1);
}
