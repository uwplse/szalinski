// Width of holder interior
a=40;
// Length of holder interior
b=100;
// Height of holder interior
c=50;
// Half wall width
d=3;
// Lid lip depth
l=4;
// Width of the symbol
size=a/1.5;
// Thickness of the symbol
T=l+5;

//calls
translate([0,0,(c+l)/2])box();
translate([a+l,0,0])lid();

module box(){
difference(){
cube([a+d,b+d,c+l], center=true); // box
translate([0,0,2*d])cube([a-d,b-d,c+l], center=true); // cut out interior
translate([0,0,c/2])cube([a,b,l+1], center=true); // cut out lip
translate([0,0,c/2+c/6])rotate([-90,0,0])cylinder(r=a/4,h=b+d*2, center=true); //cut out thumb translate([a/2,-d,c+d*5])
}
}

module lid(){
difference(){
lid2();
translate([0,0,-1])recycle2();
}}

module lid2(){
//Box lid
union(){
translate([0,0,l])cube([a-1,b-1,l], center=true);
translate([0,0,d/2])cube([a+d,b+d,d], center=true);
}
}



module recycle2(){
	color("SteelBlue") recycling_symbol(size, T, $fn=40);


module recycling_symbol(size=10, h=1, pos=[], rot=[],$fn=40)
{
	translate(pos) rotate(rot)
	scale([size/10,size/10,h])
	union()
	{
		for(i=[0,120,240])
			rotate(a=[0,0,i])
			__r_s_arrow();
		translate([0,0,0.5])
			write(code, t=1, h=4, center=true);
		translate([0.5,-7,0.5])
			write(type, t=1, h=4, space=1.2, center=true);
	}
}

module __r_s_arrow()
{
	width=0.8;
	y=sqrt(3)/3*6;
	arr_y=-y/2-2+width/2;
	linear_extrude(height=1)
	union()
	{
		difference()
		{
			__r_s_rounded_triangle(y,2,1);
			__r_s_rounded_triangle(y,2-width);
			translate([0,-5,0])
				square([6,12]);
			rotate([0,0,60])
			translate([-1.5,0,0])
				square([6,7]);
		}
		polygon(points=[[0.5,arr_y],[1.8,arr_y-1.1],[1.8,arr_y+1.1]]);
	}
}

module __r_s_rounded_triangle(y,r)
{
	hull()
	for(i=[0,120,240])
		rotate(a=[0,0,i])
		translate([0,y,0])
			circle(r=r);
}
}