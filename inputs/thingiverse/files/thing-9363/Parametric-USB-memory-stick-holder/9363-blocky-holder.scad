
module deviceBlock() 
{
	cols = 1;
	rows = 5;
	
	//Center-to-center
	spacingX = 25; //USB:25
	spacingY = 15; //USB:15

	slotSizeX = 12; //USB:12
	slotSizeY = 4.5; //USB:4.5
	slotSizeZ = 7; //USB:7

	floorThickness = 2;

	blockSizeX = spacingX* (cols); 
	blockSizeY =  spacingY  * (rows);
	blockSizeZ = slotSizeZ + floorThickness;

	difference() {
		cube(size = [blockSizeX, blockSizeY, blockSizeZ]);
		for ( c = [1: cols] ) 
		{
			for ( r = [1: rows] ) 
			{
#				translate( [ spacingX * (c - 0.5) ,spacingY * (r - 0.5), blockSizeZ-(slotSizeZ/2)+.5] ) cube([slotSizeX,slotSizeY,slotSizeZ+1], center = true);
			}
		}
	}
}

deviceBlock();

