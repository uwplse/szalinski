// -------------------------------------------------------------
// Pegboard screwdriver holder for X pieces
//	By Gilbert Therrien from remix of Jan-Willem
// -------------------------------------------------------------
//   22.11.2015 first version printed
//   02.01.2016 official release on thingiverse

//    25 % infill
//    2 shell (2 x 0.4)
//    Cura and Ultimaker original





/* [tools rack generic parameters] */

// thickness of vertical peg plate
wallY = 3;     // thickness of vertical peg plate

// minimim height for bit hole
toolMinHoleZ = 5;

// space between each screwdrivers
spaceBetweenTools=5;

/* [Parameters for each screwdriver (one value of each screwdriver)] */

// Max diameter for each screwdriver (see diagram)
toolMaxDiam  = [31.22];

// diameter for the up part of the funnel (see diagram)
toolFunnelUpperHoleDiam = [17.82];

// diameter for the bottom part of the funnel (see diagram) 
toolFunnelLowerHoleDiam = [17];

// height of the funnel (see diagram)
toolFunnelZ   = [33.52];

// hole diameter for the screwdriver bit (see diagram)
toolHoleDiam = [12.34];

// to add to holes diameter for loose
loose=2;


/* [hidden] */
inch = 25.4; // distance between peg holes
peghole = 5; // diameter
pegY=7;      // depth of peg pin


// resolution
$fn = 36;
qtTools=len(toolMaxDiam);

holderX=((qtTools + 1) * spaceBetweenTools) + sumv(toolMaxDiam, 0, qtTools - 1);
holderY=max(toolMaxDiam) + wallY + spaceBetweenTools * 2;
holderZ=max(toolFunnelZ) + toolMinHoleZ;
wallZ = holderZ * 1.5 > inch + 7 ? holderZ * 1.5: inch + 7;



/*
// tool set square screwdriver
spaceBetweenTools=10;
toolMaxDiam  = [39, 39, 39, 33];
toolFunnelUpperHoleDiam = [35, 35, 35,29];
toolFunnelLowerHoleDiam = [35, 35, 35, 29];
toolFunnelZ   = [20, 20, 20, 17];
toolHoleDiam = [ 8, 6,5, 8.5, 6.5];
toolMinHoleZ = 5;
*/

// tool set little star
/*
spaceBetweenTools=5;
toolMaxDiam  = [16,33,22];
toolFunnelUpperHoleDiam = [16,30,20];
toolFunnelLowerHoleDiam = [16,30,20];
toolFunnelZ   = [7,15,10];
toolHoleDiam = [3.5,5,6.5];
toolMinHoleZ = 5;
*/


//echo("Number of tools: ", qtTools);
//echo("holderX=", holderX);
//echo("HolderY=", holderY);
//echo("HolderZ=", holderZ);

base();

module base()
{
	// Screwdriver holder
	difference()
	{
		union()
		{
			RoundedBox(holderX, holderY, holderZ, holderY / 16);
			cube([holderX, wallY, wallZ]);
		}

		for (i = [1 : qtTools])
		{
			if(i == 1)
			{
				translate([(toolMaxDiam[i-1]/2) + (i * spaceBetweenTools),
						(holderY - toolFunnelUpperHoleDiam[i-1]) / 2 + (toolFunnelUpperHoleDiam[i-1]/2) + wallY,
						holderZ - toolFunnelZ[i-1]]) 
							cylinder(d1=toolFunnelLowerHoleDiam[i-1] + loose, d2=toolFunnelUpperHoleDiam[i-1] + loose, toolFunnelZ[i-1] + 1);

				translate([(toolMaxDiam[i-1]/2) + (i * spaceBetweenTools) ,
						(holderY - toolFunnelUpperHoleDiam[i-1]) / 2 + (toolFunnelUpperHoleDiam[i-1]/2) + wallY,
						-0.5]) 
							cylinder(d=toolHoleDiam[i-1] + loose, (holderZ - toolFunnelZ[i-1]) + 2);
			}
			else
			{
				translate([(toolMaxDiam[i-1]/2) + (i * spaceBetweenTools) + sumv(toolMaxDiam, 0, i-2) ,
						(holderY - toolFunnelUpperHoleDiam[i-1]) / 2 + (toolFunnelUpperHoleDiam[i-1]/2) + wallY,
						holderZ - toolFunnelZ[i-1]]) 
							cylinder(d1=toolFunnelLowerHoleDiam[i-1] + loose, d2=toolFunnelUpperHoleDiam[i-1] + loose, toolFunnelZ[i-1] + 1);

				translate([(toolMaxDiam[i-1]/2) + (i * spaceBetweenTools) + sumv(toolMaxDiam, 0, i-2),
						(holderY - toolFunnelUpperHoleDiam[i-1]) / 2 + (toolFunnelUpperHoleDiam[i-1]/2) + wallY,
						-0.5]) 
							cylinder(d=toolHoleDiam[i-1] + loose, (holderZ - toolFunnelZ[i-1]) + 2);
			}
		}
	}

	// add Peg pins
	qtPins=floor(holderX / inch);
	widthPins=inch * qtPins + 3;
	firstPinX=(holderX - widthPins) / 2;

	for (x = [firstPinX: inch: holderX])
	{
		echo("x loop:", x);
		pegPins(deltaX=x, deltaZ=wallZ - (inch + 7));
	}
	// bottom
}


module pegPins(delTaX=0, deltaZ=0)
{
	translate([deltaX, -pegY, deltaZ]) cube([3,pegY+wallY,4]);

	// upper pin
	translate([deltaX, -pegY,     deltaZ + inch]) cube([3,pegY+wallY,4]);
	translate([deltaX, -pegY,     deltaZ + inch+2]) rotate([0,90,0]) cylinder(r=4/2, h=3);
	translate([deltaX, -pegY+2.2, deltaZ + inch+2]) rotate([90+15,0,0]) cube([3,pegY,4]);
}


//echo("zeroOrOne(2):", zeroOrOne(2));
// return 1 if value >= 1
function zeroOrOne(value) = (value >= 1 ? 1 : 0);

// return sum v (vector) element from first to last
//echo("sumv([1,2,4])", sumv([1,2,4], 0, 2));
function sumv(v, first=0, last) = (first == last ? v[first] : v[first] + sumv(v, first+1, last));

// -------------------------------------------------------------------
// EmptyBox, JWW, x,y,z,wallY  r=riadius of rounding
// ------------------------------------------------------------------
module EmptyBox(xx,yy,zz,wallY,rr)
{
	difference()
	{
		RoundedBox(xx,yy,zz,rr);
		translate([wallY,wallY,wallY]) RoundedBox(xx-2*wallY,yy-2*wallY,zz,rr-wallY);
	}
}


// ------------------------------------------------------
// Rounded box, JWW, x,y,z  r=riadius of rounding
// ------------------------------------------------------
module RoundedBox(xx,yy,zz,rr)
{
	hull()
	{
		translate([rr,rr,0]) cylinder(r=rr,h=zz);
		translate([rr,yy-rr,0]) cylinder(r=rr,h=zz);
		translate([xx-rr,rr,0]) cylinder(r=rr,h=zz);
		translate([xx-rr,yy-rr,0]) cylinder(r=rr,h=zz);
	}
}

