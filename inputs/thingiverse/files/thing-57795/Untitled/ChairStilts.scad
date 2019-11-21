// Chair Stilts
// Paul Murrin - Feb 2013


// Raise required (mm)
raise = 60; // [0:200]

// Overall height - includes the part the leg inserts into (mm)
height = 100; // [0:200]

//  (mm)
wallThickness = 3; // [1:10]

//  - left to right (mm)
legWidth = 35;

//  - front to back (mm)
legDepth = 38;

// of leg (degrees from vertical)
angle = 5;

// Margin over the size of the leg specified
insetOversize = 0.6;

// Bulge to grip the leg - bulge width on each side (mm)
gripperBulge = 1.2;

// Bulge wall thickness;
gripperWall = 0.6;



module gripper(width, bulge)
{
	echo(width, bulge);
	radius = bulge*10;
	translate([-(radius-bulge),0,0]) rotate([90,0,0])
		difference() 	
		{
			cylinder(h=width, r=radius, center=true, $fn=180);
			union() {
				cylinder(h=width, r=radius-gripperWall, center=true, $fn=180);
				translate([-bulge, , 0]) cube([radius*2, radius*2, width], center=true); 
			}
		}
}


/* Generate coordinates of key points
 * x1,x2,y1,y2 = corners of bottom of cutout (where base of existing legs will go)
 * topOffset = offset at top of stilt in y axis due to angle of legs
 * baseOffset = offset at base of stilt in y axis due to angle of legs
 */
assign(		/* Points on base of cutout */
	x1= -(legWidth/2 + insetOversize),
	x2= +(legWidth/2 + insetOversize),
	y1= -(legDepth/2 + insetOversize),
	y2= +(legWidth/2 + insetOversize),
	topOffset = tan(angle)*(height-raise),
	baseOffset = -tan(angle)*raise
)
union()
{
	difference() 
	{
		/* Generate the outside shell */
		polyhedron(	
			points = [
				[x1-wallThickness,y1-wallThickness+baseOffset,0], 
				[x1-wallThickness,y2+wallThickness+baseOffset,0], 
				[x2+wallThickness,y2+wallThickness+baseOffset,0], 
				[x2+wallThickness,y1-wallThickness+baseOffset,0],
				[x1-wallThickness,y1-wallThickness+topOffset,height], 
				[x1-wallThickness,y2+wallThickness+topOffset,height], 
				[x2+wallThickness,y2+wallThickness+topOffset,height], 
				[x2+wallThickness,y1-wallThickness+topOffset,height]],
 			triangles = [
				[0,3,2],[0,2,1],	/* Base */
				[4,5,6],[4,6,7], /* Top */
				[0,1,4],[4,1,5],	
				[3,7,2],[2,7,6],
				[0,4,7],[7,3,0],
				[1,2,6],[1,6,5]],
			convexity = 2);


		/*Generate the cutout */
		polyhedron(	
			points = [
				[x1,y1,raise], [x1,y2,raise], 
				[x2,y2,raise], [x2,y1,raise],
				[x1,y1+topOffset,height+0.1], [x1,y2+topOffset,height+0.1], 
				[x2,y2+topOffset,height+0.1], [x2,y1+topOffset,height+0.1]],
 			triangles = [
				[0,3,2],[0,2,1],	/* Base */
				[4,5,6],[4,6,7], /* Top */
				[0,1,4],[4,1,5],	
				[3,7,2],[2,7,6],
				[0,4,7],[7,3,0],
				[1,2,6],[1,6,5]],
			convexity = 2);
	}

	/* Add bulges to grip the legs */
	translate([-legWidth/2 + insetOversize, 0, height - (height-raise)/2]) 
		gripper(legDepth/2, gripperBulge);
	translate([legWidth/2 + insetOversize, 0, height - (height-raise)/2]) 
		rotate([0,0,180]) 
			gripper(legDepth/2, gripperBulge);
}