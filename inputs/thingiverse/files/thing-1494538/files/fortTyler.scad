/* [Global] */

circularTowerHeight=30;
squareTowerHeight=30;//[20:50]
triangleTowerHeight=30;//[20:50]
pentagonTowerHeight=30;//[20:50]

/* [Hidden] */

//wall
cube([2,50,20]);

translate([50,5,0])
	cube([2,47,20]);

translate([5,50,0])
	cube([47,2,20]);

//door
difference()
{
cube([50,2,20]);
	translate([20,0,0])
		cube([10,2,10]);


	translate([25,2.5,10])
		rotate([90,0,0])
			cylinder(r1=5,r2=5,h=4,$fn=0);
}

//circle tower
translate([50,2.5,0])
{
	cylinder(r1=5,r2=5,h=circularTowerHeight,$fn=0);
	translate([0,0,circularTowerHeight])
		cylinder(r1=5,r2=0,h=15,$fn=0);
}

// triangleTower
translate([2.5,50,0])
{
	rotate([0,0,10])
	cylinder(r1=5,r2=5,h=triangleTowerHeight,$fn=3);

	rotate([0,0,10])
	translate([0,0,triangleTowerHeight])
	cylinder(r1=5,r2=0,h=15,$fn=3);
}
	

//pentagontower
translate([50,50,0])
{
	cylinder(r1=5,r2=5,h=pentagonTowerHeight,$fn=5);
	translate([0,0,pentagonTowerHeight])
		cylinder(r1=5,r2=0,h=15,$fn=5);
}

//square tower
{
cube([10,10,squareTowerHeight]);

translate([5,5,squareTowerHeight])
	rotate([0,0,45])
		cylinder(r1=7,r2=0,h=15,$fn=4);
}