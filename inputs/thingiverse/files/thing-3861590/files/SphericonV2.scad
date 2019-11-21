/*==============================================================================*\
	Welcome to my sphericon generator.
	
	I made this because I got tired of drawing sphericons after the second one.
	I'm a programmer, so in my mind it was impossible to not think about
	automating the drawing of this sort of shape.
	
	All units are meant to be in mm but I guess you can choose to use imperials
	if you want to keep suffering.
	
	Hit F6 to generate the half sphericon, and use the settings below to modify
	its properties.
\*==============================================================================*/

//========================Main settings========================
/* [ Main settings ] */

//Size of the sphericon
diameter = 50;

//Number of sides
sidecount = 8;

//Generation complexity (how smooth you want it to be. High values take longer to render)
smoothness = 300;

//========================Settings for fixture pin========================
/* [ Fixture pin ] */

//Set to true to generate sphericon, set to false to generate fixture pin
genSphericon = "yes"; // [yes,no]

//Set to true for cylinder pin, allowing rotation while assembled. Set to false for key pin, requiring desassembly to change face orientations
genCylinder = "no"; // [yes,no]

//clearance of fixture pin on its diameter
clearance = 0.2;

//clearance of fixture pin on its depth (aka the distance to the overhangs)
depthDiff = 2;

//========================Settings for full sphericon========================
/* [ Full sphericon ] */

//set to true to draw full sphericon (not half), useful to visualize the final result or if you have soluble support filament or a resin printer, you could print it in one piece.
drawFull = "yes"; // [yes,no]

//steps of rotation of second half (keep at 1 for "true" sphericon) note: not all step counts allign both half correctly, it depends on how many sides the base polygon has. (I was too lazy to understand it, so just play around with it until it looks right.)
rotationSteps = 1;

/*==============================================================================*\
	Code begins after this point, don't judge, it's my first attempt at openSCAD,
	so yes it's some very ugly code, but it works. I will most likely rework it
	in the future to add some generation features or simply to make it less
	disgusting.
	
	Read at your own risks, might burn your eyes.
\*==============================================================================*/

/* [ Hidden ] */

//main logic
if (genSphericon == "yes")
{
	if (drawFull == "no")
	{
		difference()
		{
			rotate(a = [-90,0,-90]) drawHalfSphericon();

			if (genCylinder == "yes")
			{
				drawCylinderPin();				
			}
			else
			{
				drawKeyPin();
			}
		}
	}
	else
	{
		union()
		{
			rotate(a = [-90, 0, 0]) drawHalfSphericon();
			rotate(a = [90, 0, getPolygonAngle(sidecount) * rotationSteps])drawHalfSphericon();
		}
	}
}
else
{
	if (genCylinder == "yes")
	{
		drawCylinderPin(clearance, depthDiff);
	}
	else
	{
		drawKeyPin(clearance, depthDiff);
	}
}

//Modified from suggested code on openSCAD's wiki to allow half polygons
module regularPolygon(order, r=1, half=false)
{
 	angles=[ for (i = [0:order-1]) i*(360/order) ];
 	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
	
	if (half == true)
	{
		coords2=[ for (i = [0:getCoordCount(order) - 1]) coords[i]];
		coords3=concat([for (i=[0:len(coords2)-2]) coords[i]], [[coords2[len(coords2)-1][0], 0]]);
        
		polygon(coords3);
	}
	else
	{
		polygon(coords);
	}
 }
 
 //Gets how many vertices should be kept to draw half polygon
 function getCoordCount(count) = (floor(0.5*count) + (count%2) + 1);
 
 //Gets the angle between edges of the polygon
 function getPolygonAngle(sideCount) = (((sideCount - 2)*180)/sideCount);
 
 //Draws the half polygon using global variables and centers it
 module drawHalfSphericon()
 {
	translate([ 0, 0,diameter/2]) rotate_extrude(angle = 180, $fn = smoothness)
	{
		rotate(a=[0,0,90]) translate([-diameter/2, 0, 0]) regularPolygon(sidecount,
																		 diameter/2, 
																		 true);
	}
 }
 
 //Draws the cylinder pin
 module drawCylinderPin(pClearance = 0, pDepthDiff = 0)
 {
	cylinder(h = diameter/3 - pDepthDiff, 
			r = diameter/10 - pClearance, 
			center = true, 
			$fn = smoothness); 
}

//Draws the key pin
module drawKeyPin(pClearance = 0, pDepthDiff = 0)
{
	linear_extrude(height = diameter/3 - pDepthDiff, center = true) regularPolygon(sidecount, diameter/5 - pClearance);
}