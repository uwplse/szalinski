// create outer cylinder


// size of the disk
dishDiameter = 62.5;//[37.5:3in/75mm,50:4in/100mm, 62.5:5in/125mm,75:6in/150mm]

// just in case the stack doesn't fit loosly. please try to keep at 0.3
dishTolarnce = 0.3;

// diametre of the coin. please add 1~2mm so the coin can fall through
coinDiameter = 25;
// the hole distance from the center
coinDistance = 30;
// the amount of holes in the dish
coinAmount = 6;


/* [Hidden] */

$fn = 100;
dishHeight = 40;
dishAngle = 3;
dishThickness = 3;



difference()
{
	union()
	{
		cylinder(h = dishHeight/2,r1 = dishDiameter-dishThickness, r2 = dishDiameter-dishThickness,center = false);
		
		translate([0,0,dishHeight/2])
			cylinder(h = dishAngle,r1 = dishDiameter-dishThickness, r2 = dishDiameter,center = false);

		translate([0,0,dishHeight/2+dishAngle])
			cylinder(h = dishHeight/2,r1 = dishDiameter, r2 = dishDiameter,center = false);
	}

	union()
	{
		translate([0,0,dishThickness])
			cylinder(h = dishHeight/2+1,r1 = dishDiameter-dishThickness*2, r2 = dishDiameter-dishThickness*2,center = false);

		translate([0,0,dishHeight/2+dishThickness])
			cylinder(h = dishHeight/2,r1 = dishDiameter+dishTolarnce-dishThickness, r2 = dishDiameter+dishTolarnce-dishThickness,center = false);

		translate([0,0,dishHeight-0.03])
			cylinder(h = dishAngle+0.06,r1 = dishDiameter-dishThickness, r2 = dishDiameter,center = false);
	}

	union()
	{
		if(coinAmount == 1)
		{
			translate([0,0,-0.11]) 
				cylinder(h = dishThickness+0.2,r1 = coinDiameter/2, r2 = coinDiameter/2,center = false);
		}
		else
		{
			for ( i = [0 : coinAmount])
			{
				echo (360 / coinAmount * i);
			    rotate(360 / coinAmount * i,[0, 0, 1])
			    translate([0, coinDistance, -0.1])
			    cylinder(h = dishThickness+0.2,r1 = coinDiameter/2, r2 = coinDiameter/2,center = false);
			}	
		}
	}
}
