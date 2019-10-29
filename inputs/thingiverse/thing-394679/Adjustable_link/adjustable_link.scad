//Adjustable link
//By Johan Bengtsson qwerty_42@hotmail.com


//(in mm)
HoleSize=3;

//(in mm)
Distance1=30;

//(in mm)
Distance2=50;

//(in mm)
Thickness=2;


//(in percent of hole size)
WallWidth=100;

/* [Hidden] */

Width=HoleSize*(1+WallWidth/50);
MinDistance=min(Distance1,Distance2);
MaxDistance=max(Distance1,Distance2);

$fn=50;

difference()
{
	union()
	{
		cylinder(h=Thickness,r=Width/2);
		translate([MaxDistance,0,0]) cylinder(h=Thickness,r=Width/2);
		translate([0,-Width/2,0]) cube([MaxDistance,Width,Thickness]);
	}
	union()
	{
		translate([MinDistance,0,-1]) cylinder(h=Thickness+2,r=HoleSize/2);
		translate([MaxDistance,0,-1]) cylinder(h=Thickness+2,r=HoleSize/2);
		translate([0,0,-1]) cylinder(h=Thickness+2,r=HoleSize/2);
		translate([MinDistance,-HoleSize/2,-1]) cube([MaxDistance-MinDistance,HoleSize,Thickness+2]);
	}
}


