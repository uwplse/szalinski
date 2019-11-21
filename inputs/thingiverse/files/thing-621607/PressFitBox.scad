length = 102;
width = 92;
height = 62;

// wall thickness
thickness = 2.5;

// height of the locking part
lockHeight = 10.0;

// tolerance for the interlocking pieces
tolerance = 0.4;

// What part should be visualized / exported
part = "box_"; //"box_"; // [box_:The assembled box,top_:Top side,bottom_:Bottom side,sideX1_:One side on the X axis,sideX2_:Other side on the X axis,sideY1_:One side on the Y axis,sideY2_:Other side on the Y axis]

module dovetail(thick, height, tolerance)
{
	translate([-tolerance/2,-tolerance/2,0])
	{
		cube([thick+tolerance, 3*thick+tolerance, height], center = false );
		cube([2*thick+tolerance, thick+tolerance, height], center = false );
	}
}

module cornerpiece(thick, height, tolerance)
{
	difference()
	{
		translate([0,0,height/2])
		{
			cube(size = [thick * 8, thick * 8, height], center = true);
		}
		union()
		{
			translate([3*thick, thick, thick])
			{
				mirror([1,0,0])
				{
					dovetail(thick, height, tolerance);
				}
			}
			translate([-thick, -3*thick, thick])
			{
				rotate([0,0,90])
				{
					dovetail(thick, height, tolerance);
				}
			}
			translate([-thick*4-1,0,-0.5]) {	cube( size = [thick*4+1, thick*4+1, height+1]); }
		}
	}
}

module baseplane()
{
	cube([length, width, thickness], center = false);
	translate([thickness*3, thickness*3, 0]) { rotate([0,0,-90]){ cornerpiece(thickness, lockHeight, tolerance); }}
	translate([length-thickness*3, thickness*3, 0]) { rotate([0,0,0]){ cornerpiece(thickness, lockHeight, tolerance); }}
	translate([thickness*3, width-thickness*3, 0]) { rotate([0,0,180]){ cornerpiece(thickness, lockHeight, tolerance); }}
	translate([length-thickness*3, width-thickness*3, 0]) { rotate([0,0,90]){ cornerpiece(thickness, lockHeight, tolerance); }}
}

module topplane()
{
	mirror([0,0,1]) { baseplane(); }
}

module sideDovetail(width, height)
{
	translate([0, 4*thickness, 0]) {
		dovetail(thickness, lockHeight-thickness, 0);
		cube([thickness, width-8*thickness, lockHeight-thickness]);
	}
	translate([0, width-4*thickness, 0]) { mirror([0,1,0]) {	dovetail(thickness, lockHeight-thickness, 0); }}
}
module side(width, height, reduceWidth)
{
	translate([0,0,thickness]) { sideDovetail(width, height); }
	translate([0, reduceWidth, lockHeight])
	{
		cube([thickness, width-2*reduceWidth, height - 2*(lockHeight)]);
	}
	translate([0, 0, height - lockHeight]) { sideDovetail(width, height); }
}

if (part == "box_" || part == "bottom_")
{
	baseplane();
}

if (part == "box_" || part == "top_")
{
	translate([0,0,height]) { topplane(); }
}

if (part == "box_" || part == "sideX1_")
{
	color([1,0,0]) {
		side(width, height,0);
	}
}


if (part == "box_" || part == "sideY1_")
{
	color([0,0,1]) {
		translate([0, width, 0])
		{
			rotate([0,0,-90]) {side(length, height, thickness); }
		}
	}
}


if (part == "box_" || part == "sideX2_")
{
	color([1,0,0]) {
		translate([length,0, 0]) { mirror([1,0,0]) { side(width, height,0); }}
	}
}


if (part == "box_" || part == "sideY2_")
{
	color([0,0,1]) {
		mirror([0,1,0]){
			rotate([0,0,-90]) {side(length, height, thickness); }
		}
	}
}