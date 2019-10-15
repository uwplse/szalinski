rows = 4; // [1:1:20]
columns = 2; // [1:1:20]

rollDiameter = 31; // [1:1:60]
rollHeight = 52; // [1:1:100]

wallThickness = 2.4; // [0.1:0.1:4]
maxBridge = 15; // [0:1:40]

/* [Hidden] */
holderDiameter = rollDiameter*0.9;
rackWidth = rollDiameter+4+wallThickness;
rackDepth = rollHeight-12;

module rack(wallThickness,rollDiameter,rackDepth,maxBridge,holderDiameter,rackWidth)
{
	/* STRUCTURE */
	difference()
	{
		difference()
		{
			cube([rackWidth+2*wallThickness,rackDepth,rackWidth+2*wallThickness], center=true);
			cube([rackWidth,rackDepth+wallThickness,rackWidth], center=true);
		}

		hull()
		{
			cube([rackWidth+4*wallThickness,maxBridge,rackWidth], center=true);
			cube([rackWidth+4*wallThickness,rackDepth-2*wallThickness,maxBridge], center=true);
		}
	}
	
	/* HOLDER */
	translate([0,0,holderDiameter/2-rackWidth/2])
		rotate([90,0,0])
		difference()
		{
			difference()
			{
				cylinder(h=rackDepth, d=holderDiameter+wallThickness, center=true);
				cylinder(h=rackDepth+wallThickness, d=holderDiameter, center=true);
			}

			union()
			{
				rotate([0,0,10])
					translate([0,0,-(rackDepth+4*wallThickness)/2])
					cube([rollDiameter,rollDiameter,rollHeight+4*wallThickness]);

				rotate([0,0,80])
					translate([0,0,-(rackDepth+4*wallThickness)/2])
					cube([rollDiameter,rollDiameter,rollHeight+4*wallThickness]);
			}
		}
}

rotate([-90,0,0])
{
	for(z = [0:1:(rows-1)], x = [0:1:(columns-1)])
	{
		translate([x*(rackWidth+wallThickness),0,z*(rackWidth+wallThickness)])
		rack(wallThickness,rollDiameter,rackDepth,maxBridge,holderDiameter,rackWidth);
	}
}