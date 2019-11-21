Height = 14.4;
Cone_Radius = 6;
Brim_Radius=9;
Brim_Thickness=1;
Hole_Radius=5;

difference()
{
	union()
	{
	translate([0,0,0]) scale([1,1,Brim_Thickness]) cylinder(r=Brim_Radius);
	translate([0,0,0]) scale([1.2,1.2,1.2]) cylinder(r1=Cone_Radius/1.2, r2=0, h=Height/1.2);
	}
	union()
	{
	translate([0,0,0]) scale([1,1,1]) cylinder(r1=Hole_Radius, r2=0, h=Height/1.2);
	}
}