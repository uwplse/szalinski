indiam=32;
glassh=140;

inray=indiam/2;
tol=0.1;
bottom=true;
notch=true;
linkh=10;

$fn=100;
scale([1, 1.3, 1])
if (bottom)
{
	union()
	{
		difference()
		{
			cylinder(h=glassh*2/3+linkh, r=inray+2);
			translate([0, 0, 5]) cylinder(h=glassh*2/3+linkh, r=inray);
			translate([0, 0, glassh*2/3]) difference()
			{
				cylinder(h=11, r=inray+3);
				cylinder(h=11, r=inray+1-tol);
			}
		}
		if (notch)
		{
			translate([inray+1, 0, glassh*2/3+linkh/2]) sphere(r=0.6);
			translate([-inray-1, 0, glassh*2/3+linkh/2]) sphere(r=0.6);
		}
	}
}
else
{
	difference()
	{
		cylinder(h=glassh/3+linkh, r=inray+2);
		translate([0, 0, 5]) cylinder(h=glassh/3+linkh, r=inray);
		translate([0, 0, glassh/3]) cylinder(h=11, r=inray+1+tol);
		if (notch)
		{
			translate([inray+1, 0, glassh/3+linkh/2]) sphere(r=0.7);
			translate([-inray-1, 0, glassh/3+linkh/2]) sphere(r=0.7);
		}
	}
}
