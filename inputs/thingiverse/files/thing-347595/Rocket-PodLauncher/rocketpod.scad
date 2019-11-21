//Enter total height of rocket pod in MM
height = 62;

//Enter total width/diameter of rocket pod in MM
width = 27;

n = height-2;
w = width -2;

difference()
{
	union()
	{
		color("dimgrey") 
		{
			cylinder(r=w/2, h=n);
		
			translate([0,0,n]) difference()
			{
				cylinder(r=w/6, h=1);
				cylinder(r=w/6-1, h=2);
			}
		}
		color("RoyalBlue")
		{
			cylinder(r=w/2+1, h=n/8);
			translate([0,0,n/4]) cylinder(r=w/2+1, h=n/20);
			translate([0,0,n/4+n/15]) cylinder(r=w/2+1, h=n/20);
			translate([0,0,n/4+n*2/15]) cylinder(r=w/2+1, h=n/20);
			translate([0,0,n/4+n*3/15]) cylinder(r=w/2+1, h=n/20);
			difference()
			{
				translate([0,0,n-n/3.5]) cylinder(r=w/2+1, h=n/3.5+2);
				translate([0,0,n-n/3.5]) cylinder(r=w/2, h=n/3.5+3);
			}
		
			for(i = [60:60:360])
			{
				rotate([0,0,i]) translate([0,w/2+1.5,n-n/3.5+2])rotate([90,0,0])cylinder(r=1, h=2);
				rotate([0,0,i]) translate([0,w/2+1.5,n*3/32])rotate([90,0,0])cylinder(r=1, h=2);
			}
		}		
		translate([0,0,n]) for(i = [45:45:360])
		{
			color("dimgrey") rotate([0,0,i]) translate ([w/2-w/8-1,0,-1]) cylinder(r=w/8+0.25, h=2);
		}
	}
	for(i = [45:45:360])
	{
		color("black") rotate([0,0,i]) translate ([w/2-w/8-1,0,-1]) cylinder(r=w/8-0.5, h=n+3);
	}
}






