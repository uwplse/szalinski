/* [Hidden] */
goldenratio = 1.61803399;
joinfactor = 0.125;

/* [Stand Side 1] */
// Angle of Repose (degrees)
gAngleOfRepose = 1;
// Thickness of tablet (include a buffer of ~0.3-0.6mm; wider angles require larger buffers)
gMaterialThickness = 6.4;

/* [Stand Side 2] */
// Angle of Repose (degrees)
g2AngleOfRepose = 11;
// Thickness of tablet (include a buffer of ~0.3-0.6mm; wider angles require larger buffers)
g2MaterialThickness = 6.6;

/* [Global Settings] */
// Thickness (mm) of the walls that hold the tablet
gWallThickness = 7;
// Width (mm) of the rectangular portion of the stand
gBaseWidth = 88.9;
// Thickness (mm) of the rectangular base
gBaseThickness = 8;
// Height (mm) of front block that holds tablet in place
gBaseFrontBlockHeight = 11;


union()
{
rotate([90, 0, 90])
    Bracket(gBaseFrontBlockHeight, gMaterialThickness, gAngleOfRepose, gBaseWidth);

//Calculate Offset to combine
combineOffset = 1.45*(gWallThickness*2+((gMaterialThickness+g2MaterialThickness)/2)+(gBaseFrontBlockHeight*goldenratio));

translate([gBaseWidth,combineOffset,0])
    rotate([90, 0, -90]) 
        Bracket(gBaseFrontBlockHeight, g2MaterialThickness, g2AngleOfRepose, gBaseWidth) ;
}

//================================
// Modules
//================================
module FillWeb(L11,L12,L21,L22, thickness, steps) 
{
	width1 = L12[0]-L11[0];
	height1 = L12[1]-L11[1];
	echo("width1, height1", width1, height1);
	
	width2 = L22[0]-L21[0];
	height2 = L22[1]-L21[1];
	echo("width2, height2", width2, height2);
	
	dwidth1 = width1/steps;
	dwidth2= width2/steps;
	
	dheight1 = height1/steps;
	dheight2 = height2/steps;
	
	m1 = height1/width1;
	m2 = height2/width2;
	
	x1=0;
	y1=0;
	
	x2=0;
	y2=0;
	
	for (step=[0:steps-1])
	{
		linear_extrude(height = thickness, convexity = 10)
		polygon(
			points=[[ width1 - step*dwidth1, L12[1]-step*dheight1],
			[0,0],
			[ L21[0] + step*dwidth2, L21[1] + step*dheight2]], 
			paths=[[0,1,2,0]]
		); 
	}

}

module Bracket(frontBlock, gapsize, repose, width)
{
	backBlock = frontBlock * goldenratio;

	baselength = gWallThickness*2+gapsize+backBlock;

	
	webShortTopHeight = frontBlock * sin(90-repose);
	webShortTopLength = frontBlock * cos(90-repose);

	webTopHeight = backBlock * sin(90-repose);
	webTopLength = backBlock * cos(90-repose);

	webBottomLength = backBlock;
	webShortBottomLength = frontBlock;

	webOffset = [(baselength) -webBottomLength, gBaseThickness, 0];
	webShortOffset = [baselength -webBottomLength, gBaseThickness, -joinfactor];

	// Lay down the base
	cube(size=[baselength, gBaseThickness, width]);

	// Add supporting fillet
	translate(webOffset)
	color([0,1,1]) FillWeb([0,0],[webTopLength,webTopHeight], [0,0], [webBottomLength,0], width, 12);


	// Front block
	translate([0, gBaseThickness-joinfactor, 0])
	rotate([0, 0, -repose])
	cube(size=[gWallThickness, frontBlock, width]);

	// Back block
	translate([gWallThickness+gapsize,  gBaseThickness-joinfactor, 0])
	rotate([0, 0, -repose])
	cube(size=[gWallThickness, backBlock, width]);
    
    //Feet
    scale([1.45,1,1])
        translate([4,0,15])    
            rotate([0, -90, -90]) 
                cylinder (5,17,17,0);
    
    scale([1.45,1,1])
        translate([4,0,(gBaseWidth-15)])    
            rotate([0, -90, -90]) 
                cylinder (5,17,17,0);


}