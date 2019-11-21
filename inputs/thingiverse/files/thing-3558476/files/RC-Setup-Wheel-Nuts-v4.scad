/* Setup Nuts for 1/10 Touring Cars */

$fn=23;
gMS=2.0;
someSize=10; // base
moreSize=14; //20; // d2
evenMoreSize=15; // z
sizeDoesNotMatterAnywaySaysMyWife=23;
nutHeight=3.0;
nutWidth=7.0+0.5-0.5;
space=0.5-0.4;

/* Nut */
difference()
{
	union()
	{
		translate([0, 0, +2])
		for (a=[0:10:360])
		{
			rotate([0, 0, a])
			translate([0, 0, evenMoreSize/2])
			cube([someSize, someSize, evenMoreSize], center=true);
		}
	
		cylinder(d1=someSize, d2=moreSize, h=2); 
	}
	
	/* Make room for the axle */
	cylinder(d=4.2, h=42); 
	
	/* Make room for the M4 nut */
	translate([0, 0, gMS])
	hexHub(nutWidth, 42);
/*
	translate([0, 0, gMS])
	for (a=[0:60:360])
	{
		rotate([0, 0, a])
		cube([7.5, 7.5/2, 42], center=true);
	} */
}

/* Cap */
translate([0, 42, 0])
difference()
{
	for (a=[0:60:360])
	{
		rotate([0, 0, a])
		//cube([7.5, 7.5/2, 42], center=true);
		hexHub(nutWidth-space, evenMoreSize-nutHeight);
	}

	/* Make room for the axle */
	cylinder(d=4.2, h=42); 
}

module hexHub(width, thickness)
{
	angle = 360/6;		// 6 surfaces
	cote = width * cot(angle);
	//echo(angle, cot(angle), cote);
	//echo(acos(.6));

		/* The hexagon */
		translate([0, 0, thickness/2]) // center is doof, so heb ichs wenigstens wieder an...
		union()
		{
			// Rechtecke, um 1/6 Kreis verdreht
			rotate([0, 0, 0]) 		cube([width, cote, thickness], center=true);
			rotate([0, 0, angle])	cube([width, cote, thickness], center=true);
			rotate([0, 0, 2*angle])	cube([width, cote, thickness], center=true);
		}
}

//------------------------------------------------------------
// Fonction cotangente
// Permet d'avoir les bones dimensions
// utiliser $fn n'est pas bon
//------------------------------------------------------------
function cot(x)=1/tan(x);

