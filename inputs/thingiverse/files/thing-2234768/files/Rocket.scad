















difference()
{
	for(i=[0:0])
	rotate([0,120*i,0])
	cylinder(r=10,h=70);

	for(i=[0:0])
	rotate([0,120*i,0])
	translate([0,0,-1])
	cylinder(r=8,h=72);
}

translate([0,0,60]) scale([0.8,0.8,1]) cylinder(10, 10, 10);

translate([0,0,70]) scale([1,1,1]) sphere(10);




b = 60;
h = 10;
w = 4;

//the fins
rotate(a=[90,-90,0])
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
translate([0,9,0]) scale([2,0.2,1])polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);


rotate(a=[90,-90,180])
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
translate([0,9,0]) scale([2,0.2,1])polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);


rotate(a=[180,-90,0])
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
translate([0,9,0]) scale([2,0.2,1])polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);


rotate(a=[180,-90,180])
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
translate([0,9,0]) scale([2,0.2,1])polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
