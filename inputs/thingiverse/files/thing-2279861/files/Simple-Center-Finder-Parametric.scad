/* [Hidden] */
$fn=75;
minimumBarW = 3;
minimumBarH = 2;
minimumBarL = 9;
minimumHoleD = 1;

/* [Configure] */
// Cylinders Diameter
cylinderDiameter = 8; // [3:20]
// Cylinders Height
cylinderHeight = 9; // [3:20]
// Hole Diameter
holeDiameter = 3; // [1:7]
// Tool Length
toolLength = 150; // [40:10:500]

minimumCylinderW = holeDiameter * 2 > minimumBarW ? holeDiameter * 2 : minimumBarW;
minimumCylinderH = minimumCylinderW/2;

barHeight = toolLength / 100;
cylinderD = cylinderDiameter < minimumCylinderW ? minimumCylinderW : cylinderDiameter;
barL = toolLength < minimumBarL ? minimumBarL : toolLength - cylinderD;
barH = barHeight < minimumBarH ? minimumBarH : barHeight;
cylinderH = cylinderHeight < minimumCylinderH ? minimumCylinderH + barH : cylinderHeight + barH;
barW = cylinderD;
holeD = holeDiameter < minimumHoleD ? minimumHoleD : holeDiameter;

translate([0,0,barH/2])
	difference()
	{
		cube([barL,barW,barH],center=true);
		cylinder(d=holeDiameter,h=barH+.01,center=true);
		translate([0,0,-barH/4])
			cylinder(d1=holeDiameter*1.75,d2=holeDiameter,h=barH/2+.01,center=true);
	}
translate([barL/2,0,cylinderH/2])
	cylinder(d=cylinderD,h=cylinderH,center=true);
translate([-barL/2,0,cylinderH/2])
	cylinder(d=cylinderD,h=cylinderH,center=true);

echo(str("Bar Dimensions (L,W,H):  (",barL,",",barW,",",barH,")"));
echo(str("Cylinder Dimensions (D,H):  (",cylinderD,",",cylinderH,")"));