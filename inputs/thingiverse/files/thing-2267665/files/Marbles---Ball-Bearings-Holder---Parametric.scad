/* [Hidden] */
$fn=30;

/* [ 1 - Object] */
// Select Object To Print Or Display
object = 0; // [0:Display, 1:Shelf, 2:Holder]

/* [ 2 - Shelf Configuration] */
// Marble Count - X Axis
countRows = 5; // [2:30]
// Marble Count - Y Axis
countColumns = 5;  // [2:30]
// Diameter Of Marbles
marbleDiameter = 12.7; // [4:30]
// % Of Marble To Sink Into Shelf
marbleSinkPct = 20; // [10:45]
// Gap Between Marbles
xyGap = 2; // [1:15]

/* [ 3 - Holder Configuration] */
// Thickness Of Walls
wallThickness = 2; // [1:5]
// Gap Between Shelf & Wall.
tolerance = 2; // [1:3]
// Number Of Shelves
countShelves = 4;  // [1:10]
// Angle Of Uprights
angle = 65; // [60:85]

zGap = marbleDiameter / 8 < 2 ? 2 : marbleDiameter / 8;
marbleRadius = marbleDiameter / 2;
marblesPerShelf = countRows * countColumns;
marblesTotal = marblesPerShelf * countShelves;
shelfX = (marbleDiameter * countRows) + (xyGap * (countRows + 1));
shelfY = (marbleDiameter * countColumns) + (xyGap * (countColumns + 1));
shelfZ = (marbleDiameter * (marbleSinkPct / 100)) + zGap;
shelfClearanceZ = marbleDiameter + zGap / 2;
xySpacing = marbleDiameter + xyGap;
xyOffset = marbleRadius + xyGap;
zTopOffset = marbleRadius + zGap;
zBottomOffset = -(marbleRadius - (zGap / 2));
holderX = shelfX + ((wallThickness + tolerance) * 2);
holderY = shelfY + ((wallThickness + tolerance) * 2);
holderZ = shelfClearanceZ * countShelves + shelfZ;

echo(str("Marbles per Shelf:  ", marblesPerShelf));
echo(str("Total Marbles:  ", marblesTotal));

if(!object)
	display();
else
	if(object==1)
		shelf();
	else
		holder();
	
module display()
{
	holder();
	for(i=[0:countShelves-1])
	{
			translate([0,0,(i*shelfClearanceZ)+shelfZ])
					shelf();
			translate([-holderX/2+(tolerance*2),-holderY/2+(tolerance*2),0])
					marbles(i*shelfClearanceZ+shelfZ+marbleRadius+zGap);
	} // End for()
} // End display()

module shelf()
{
	totalHeight = 0;
	translate([-shelfX/2,-shelfY/2,0])
		difference()
		{
			cube([shelfX,shelfY,shelfZ]);
			marbles(zTopOffset);		
			marbles(zBottomOffset);		
		} // End difference()
} // End shelf()

module marbles(z)
{
	for (x = [0:countRows-1])
		for (y = [0:countColumns-1])
		{
			translate([x*xySpacing+xyOffset,y*xySpacing+xyOffset,z])
				sphere(marbleRadius, center=true);
		} // End for()
} // End marbles()

module holder()
{
	uprightHeight = holderZ - shelfZ;
	uprightShelfXYOffset = (uprightHeight / tan(angle)) + wallThickness;

	uprightPoints = [
		[0,0,0],
		[0,0,uprightHeight],
		[wallThickness,0,uprightHeight],
		[uprightShelfXYOffset,0,0],
		[0,uprightShelfXYOffset,0],
		[0,wallThickness,uprightHeight], // 5
		[0,0,uprightHeight],
		[wallThickness,uprightShelfXYOffset,0],
		[wallThickness,wallThickness,uprightHeight],
		[wallThickness,wallThickness,0],
		[uprightShelfXYOffset,wallThickness,0], // 10
		];
	
	uprightFaces = [
		[0,1,2,3], // Front Right Truncated Triangle
		[0,4,5,6], // Front Left Truncated Triangle
		[4,7,8,5], // Left Incline Rectangle
		[9,8,7], // Rear Left Triangle
		[9,10,8], //Rear Right Triangle
		[3,2,8,10], // Right Incline Rectagle
		[1,5,8,2], // Top Square
		[0,3,10,9], // Bottom Right Polygon
		[0,4,7,9] // Bottom Left Polygon
		];

	translate([0,0,shelfZ/2])
		cube([holderX,holderY,shelfZ], center=true);

	for(i=[0:3])
	{
		y = i < 2 ? -holderY/2 : holderY/2; // 0 & 1
		x = i % 3 ? holderX/2 : -holderX/2; // 0 & 3

		translate([x,y,shelfZ])
			rotate([0,0,i*90])
				polyhedron(uprightPoints,uprightFaces,10);
	} // End for()
} // End holder()
