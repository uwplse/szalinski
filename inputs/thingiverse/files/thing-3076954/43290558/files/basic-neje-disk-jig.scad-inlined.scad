

cutoutDiameter = 40; // [5:100]

zTranslate = nejeLaserEngraverDiskJig_zLength();

translate([0,0,zTranslate])
rotate([180, 0, 0])
nejeLaserEngraverDiskJig(diameter = cutoutDiameter);



module nejeLaserEngraverDiskJig(diameter = 40)
{
	bed_xLength = nejeDk8KzBed_xLength();
	bed_yLength = nejeDk8KzBed_yLength();
	bed_zLength = nejeDk8KzBed_zLength();

	xyIncrease = 3 * 2;

	xLength = nejeDk8KzBed_xLength() + xyIncrease;
	yLength = nejeDk8KzBed_yLength() + xyIncrease;
	zLength = nejeLaserEngraverDiskJig_zLength();

	difference()
	{
		nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
						 			   xLength, yLength, zLength);

		nejeLaserEngraverDiskJig_cutout(diameter, xLength, yLength, zLength);
	}
}

/** Support functions and modules follow. **/

function nejeLaserEngraverDiskJig_zLength() = nejeDk8KzBed_zLength() * 2;

module nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
				 					  xLength, yLength, zLength)
{
	laserEngraverJig(bed_xLength, bed_yLength, bed_zLength,
					 xLength, yLength, zLength);
}

module nejeLaserEngraverDiskJig_cutout(diameter, xLength, yLength, zLength)
{
	radius = diameter / 2.0;
	xTranslate = xLength / 2.0;
	yTranslate = yLength / 2.0;
	translate([xTranslate, yTranslate, -0.01])
	cylinder(r=radius, h=10);
}

module laserEngraverJig(bed_xLength, bed_yLength, bed_zLength,
						xLength, yLength, zLength)
{
	laserEngraverJig_base(bed_xLength, bed_yLength, bed_zLength,
						  xLength, yLength, zLength);
}

/** Support functions and modules follow. **/

module laserEngraverJig_base(bed_xLength, bed_yLength, bed_zLength,
							 xLength, yLength, zLength)
{
	difference()
	{
		// main block
		cube([xLength, yLength, zLength]);

		// bed cutout
		xTranslate = (xLength - bed_xLength) / 2.0;
		yTranslate = (yLength - bed_yLength) / 2.0;
		color("green")
		translate([xTranslate, yTranslate, -0.01])
		cube([bed_xLength, bed_yLength, bed_zLength + 0.01]);
	}
}

module nejeDk8KzBed()
{
	xLength = nejeDk8KzBed_xLength();
	yLength = nejeDk8KzBed_yLength();
	zLength = nejeDk8KzBed_zLength();

	cube([xLength, yLength, zLength]);
}

/** Support functions and modules follow. **/

function nejeDk8KzBed_xLength() = 78;

function nejeDk8KzBed_yLength() = 90;

function nejeDk8KzBed_zLength() = 3;