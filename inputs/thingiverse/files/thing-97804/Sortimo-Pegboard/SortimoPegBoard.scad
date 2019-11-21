

/* [Pegboard Options] */
// What do you want to render out?
what = "board"; // [board:Pegboard Only,wall:Pegboard and Wall]

// How many units wide?
x = 2; // [1:8]

// How many units deep?
y = 1; // [1:6]

// How high do you want the block to be? (Note, this is excluding the height of the pegboard itself. For a Sortimo L-Boxx 136, this should be 26.8.
height = 26.8;


// How high (if rendered) do you want the wall to be?
wallHeight = 87;

// How thick (if rendered) do you want the wall to be?
wallThickness = 2;

// How much do you want to cut off the edges of the board? (This helps compensate for differences in printers, 0.8 seemed to be good for me)
slack = 0.8;

intersection()
{
translate([slack/2,slack/2,-1]) cube([(PegDistance + PegDistanceSmall+0.1) * x-slack,(PegDistance + PegDistanceSmall) * y-slack,height*2]);
union()
{
cube([(PegDistance + PegDistanceSmall+0.1) * x,(PegDistance + PegDistanceSmall) * y,height]);
translate([0.85,0.75,height]) SortimoPegBoard(x,y);
}
}

if (what == "wall")
{
	translate([-wallThickness + slack/2,slack/2,0]) cube([wallThickness,(PegDistance + PegDistanceSmall) * y - slack,wallHeight]);
}

/* [Hidden] */

$fn = 50;

// hopefully dont need to go down here no more!

PegInsideDia = 8.2 + 0.4; //7.8
PegOutsideDia = 11.4;
PegHeight = 2;

PegDistance = 39.5;
PegDistanceSmall = 13;

Spacing = (PegOutsideDia - PegInsideDia);

module pegCircle()
{
	difference()
	{
		cylinder(PegHeight, PegOutsideDia / 2, PegOutsideDia / 2);
		translate([0,0,-PegHeight/2]) cylinder(PegHeight*2, PegInsideDia / 2, PegInsideDia / 2);
	}
}

module pegOuterCircle()
{
	difference()
	{
		cylinder(PegHeight, (PegOutsideDia + (Spacing * 2)) / 2, (PegOutsideDia + (Spacing * 2)) / 2);
		translate([0,0,-PegHeight/2]) cylinder(PegHeight * 2, (PegOutsideDia + Spacing) / 2, (PegOutsideDia + Spacing) / 2);
	}
}

module pegRoundedRect()
{
	intersection()
	{
		pegOuterCircle();
		cube(50);
	}
	translate([PegOutsideDia/2+Spacing/2,-PegDistanceSmall/2-0.05,0]) cube([Spacing / 2, PegDistanceSmall/2+0.05, PegHeight]);
	rotate([0,0,90]) translate([PegOutsideDia/2+Spacing/2,0,0]) cube([Spacing / 2, PegDistanceSmall/2+0.05, PegHeight]);
}

module block()
{
	union()
{
	pegCircle();
	translate([0,PegDistance,0]) pegCircle();
	translate([PegDistance, 0, 0]) pegCircle();
	translate([PegDistance,PegDistance, 0]) pegCircle();

	pegRoundedRect();
	translate([0,PegDistance,0]) rotate([0,0,-90]) pegRoundedRect();
	translate([PegDistance, 0, 0]) rotate([0,0,90]) pegRoundedRect();
	translate([PegDistance,PegDistance, 0]) rotate([0,0,180]) pegRoundedRect();

	translate([-Spacing/4,PegOutsideDia/2+Spacing-Spacing/4,0]) cube([Spacing/2, PegDistance-(PegOutsideDia+Spacing*2)+Spacing/2, PegHeight]);
	translate([-Spacing/4 + PegDistance,PegOutsideDia/2+Spacing-Spacing/4,0]) cube([Spacing/2, PegDistance-(PegOutsideDia+Spacing*2)+Spacing/2, PegHeight]);
	rotate([0,0,-90]) translate([-Spacing/4,PegOutsideDia/2+Spacing-Spacing/4,0]) cube([Spacing/2, PegDistance-(PegOutsideDia+Spacing*2)+Spacing/2, PegHeight]);
	rotate([0,0,-90]) translate([-Spacing/4 - PegDistance,PegOutsideDia/2+Spacing-Spacing/4,0]) cube([Spacing/2, PegDistance-(PegOutsideDia+Spacing*2)+Spacing/2, PegHeight]);
}
}

module SortimoPegBoard(x, y)
{
	union()
	{
	for (i = [0 : x - 1])
	{
		for (j = [0 : y - 1])
		{
			translate([i * (PegDistance + PegDistanceSmall) + 0.1, j * (PegDistance + PegDistanceSmall) + 0.1, 0]) translate([Spacing*2,Spacing*2,0]) block();
		}
	}
	}
}

//SortimoPegBoard(1,2);