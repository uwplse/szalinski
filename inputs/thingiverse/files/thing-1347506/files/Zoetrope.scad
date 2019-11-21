// Zoetrope animation device by Michael S. Scherotter

// picture strip length in mm
pictureStripLength = 281; //[250:431]

// picture strip height in mm
pictureHeight = 30; // [10:100]

// number of slits
slitCount = 10; // [6:20]

// slit width in mm
slitWidth = 7; // [2:10]

// ignore
coneHeight = 5;

createZoetrope();

module hub(hubHeight)
{
	union()
	{
		cylinder(h= hubHeight - coneHeight, r= 7);
		translate([0,0,hubHeight - coneHeight])
		{
			cylinder(r1=7, r2=0, h=5);
		};
	}
}

module insideHub(pictureHeight) {
    height = pictureHeight - 2;
    innerConeHeight = coneHeight - 1;

    union()
	{
		cylinder(r= 5, h= height - coneHeight);
		translate([0,0,height-coneHeight])
		{
			cylinder(r1= 5, r2= 0, h= coneHeight);
		};
	}
}

module slits(outerRadius, pictureHeight, slitHeight, slitWidth, slitCount) 
{
    arc = 360 / slitCount;
	translate([0,0,pictureHeight])
	{
		union()
		{
			for (a=[0:arc:360])
			{
				translate([0, slitWidth / 2, 0])
				{
					rotate([0,0,a])
					{
						cube([outerRadius * 2, slitWidth / 2, slitHeight]);
					}
				}
			}
		}
	}
}


module createZoetrope () {
	innerRadius = pictureStripLength / (2 * 3.1415927);
    outerRadius = innerRadius + 2;
    slitHeight = pictureHeight;
    hubHeight = pictureHeight *0.65;

    totalHeight = pictureHeight + slitHeight;

	difference()
	{
		union()	
		{
			difference()
			{
				cylinder(r= outerRadius, h= totalHeight );
				translate([0,0,2]){
					cylinder(r= innerRadius, h= totalHeight );
				};
			};
			hub(hubHeight);
		};
		insideHub(hubHeight);
		slits(outerRadius, pictureHeight, slitHeight - 4, slitWidth, slitCount);
	}
}