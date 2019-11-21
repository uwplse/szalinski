// v0.0.1 01/01/2016 - First version
// v0.0.2 02/01/2016 - Added missing fillets for the bottom
//					 - Add Ribbon parameters for customizer
//					 - Use -1 for auto calculation

// Which part do you want to see
part = "assembled"; // [bottom:Bottom only,top: Top only, ribbon1: Ribbon part 1, ribbon2: Ribbon part 2, ribbon: Ribbon in one piece, all: All on one buildplate, exploded: Exploded view, assembled: Assembled view]

/* [Box] */

// Width of the box in mm
Width=50;

// Depth of the box in mm
Depth=50;

// Height of the box in mm
Height=50;

BaseDimension=min(Width, Depth);

// Wall thickness of the box in mm (use -1 for auto calculation)
WallThickness=-1;
_WallThickness = (WallThickness == -1) ? BaseDimension * .06 : WallThickness;

// Distance between Lip and inner walls
Clearance=0.15;


/* [ Ribbon ] */
// Ribbon width in mm (use -1 for auto calculation)
RibbonWidth=-1;

// Ribbon thickness in mm (use -1 for auto calculation)
RibbonThickness=-1;

// Ribbon bow outer diameter in mm (use -1 for auto calculation)
RibbonDiameter=-1;

// Ribbon bow total width in mm (use -1 for auto calculation)
RibbonSize=-1;

// Ribbon ends in mm (use -1 for auto calculation)
RibbonEnd=-1;

_RibbonWidth = (RibbonWidth == -1) ? BaseDimension/5 : RibbonWidth;
_RibbonThickness = (RibbonThickness == -1) ? BaseDimension/40 : RibbonThickness;
_RibbonDiameter = (RibbonDiameter == -1) ? BaseDimension*.18 : RibbonDiameter;
_RibbonSize = (RibbonSize == -1) ? BaseDimension*.45 : RibbonSize/2;
_RibbonEnd = (RibbonEnd == -1) ? BaseDimension*.35 : RibbonEnd;

/* [Hidden] */
CutoutWidth=_RibbonWidth * .9; //BaseDimension*.15;
CutoutDepth=_RibbonWidth * .9; //BaseDimension*.15;
CutoutHeight=_WallThickness*.8;

/* [Hidden] */
HeightTop=Height*.25;
LipHeight=HeightTop*.6;
HeightBottom=Height - HeightTop;

GrooveWidth=_RibbonThickness;
GrooveDepth=.6;

FilletRadius=BaseDimension/25;
ChamferSize=BaseDimension/50;

$fn=36;

module top()
{
	union()
	{
		difference()
		{
			top1();
			top2();
			top3();
			top4();
			top5();
		}
		difference()
		{
			top6();
			top7();
		}
	}
}

module top1()
{
	main_form(HeightTop);
}

module main_form(h)
{
	// Top main body
	translate([-Width/2,-Depth/2,0]) cube([Width, Depth, h]);

	// Side ribbon
	translate([-Width/2 - _RibbonThickness, -_RibbonWidth/2, 0]) cube([_RibbonThickness, _RibbonWidth, h]);
	translate([+Width/2                  , -_RibbonWidth/2, 0]) cube([_RibbonThickness, _RibbonWidth, h]);
	translate([-_RibbonWidth/2, -Depth/2 - _RibbonThickness, 0]) cube([_RibbonWidth, _RibbonThickness, h]);
	translate([-_RibbonWidth/2, +Depth/2                  , 0]) cube([_RibbonWidth, _RibbonThickness, h]);
}

module top2()
{
	// Cutout for ribbon on top
	translate([-CutoutWidth/2, -CutoutDepth/2, HeightTop-CutoutHeight]) cube([CutoutWidth, CutoutDepth, CutoutHeight]);
}

module top3()
{
	// Grooves on the top
	translate([-Width/2, -_RibbonWidth/2 - GrooveWidth, HeightTop - GrooveDepth]) cube([Width, GrooveWidth, GrooveDepth]);
	translate([-Width/2, +_RibbonWidth/2              , HeightTop - GrooveDepth]) cube([Width, GrooveWidth, GrooveDepth]);
	translate([-_RibbonWidth/2 - GrooveWidth, -Depth/2, HeightTop - GrooveDepth]) cube([GrooveWidth, Depth, GrooveDepth]);
	translate([+_RibbonWidth/2              , -Depth/2, HeightTop - GrooveDepth]) cube([GrooveWidth, Depth, GrooveDepth]);
}

module top4()
{
	// Corner fillets
	corner_fillet(HeightTop);

	// Top Fillets
	top_fillet(HeightTop);
	rotate([0,0,180]) top_fillet(HeightTop);
}

module corner_fillet(h)
{
	// Corner Fillets
	translate([+Width/2, +Depth/2, 0]) fillet(FilletRadius, h);
	translate([+Width/2, -Depth/2, 0]) rotate([0,0,-90]) fillet(FilletRadius, h);
	translate([-Width/2, +Depth/2, 0]) rotate([0,0,90]) fillet(FilletRadius, h);
	translate([-Width/2, -Depth/2, 0]) rotate([0,0,180]) fillet(FilletRadius, h);
}

module top_fillet(h)
{
	translate([-_RibbonWidth/2, +Depth/2, h]) rotate([0,-90,0]) fillet(FilletRadius, (Width - _RibbonWidth)/2);
	translate([+_RibbonWidth/2, +Depth/2 + _RibbonThickness, h]) rotate([0,-90,0]) fillet(FilletRadius, _RibbonWidth);
	translate([+Width/2, +Depth/2, h]) rotate([0,-90,0]) fillet(FilletRadius, (Width - _RibbonWidth)/2);

	translate([Width/2, +Depth/2, h]) rotate([90,0,0]) fillet(FilletRadius, (Depth - _RibbonWidth)/2);
	translate([Width/2 + _RibbonThickness, +_RibbonWidth/2, h]) rotate([90,0,0]) fillet(FilletRadius, _RibbonWidth);
	translate([Width/2, -_RibbonWidth/2, h]) rotate([90,0,0]) fillet(FilletRadius, (Depth - _RibbonWidth)/2);
}

module top5()
{
	// Inside of top
	translate([-Width/2 + _WallThickness + Clearance, -Depth/2 + _WallThickness + Clearance, 0]) cube([Width - _WallThickness*2 - Clearance*2, Depth - _WallThickness*2 - Clearance*2, HeightTop - _WallThickness]);
}

module top6()
{
	// Lip of top
	translate([-Width/2 + _WallThickness + Clearance, -Depth/2 + _WallThickness + Clearance, -LipHeight]) 
	difference()
	{
		cube([Width - _WallThickness*2 - Clearance*2, Depth - _WallThickness*2 - Clearance*2, HeightTop - _WallThickness + LipHeight]);
		translate([_WallThickness, _WallThickness, 0]) cube([Width - _WallThickness*4 - Clearance*2, Depth - _WallThickness*4 - Clearance*2, HeightTop - _WallThickness + LipHeight]);
	}
}

module top7()
{
	// Lip Chamfer
	translate([-Width/2 + _WallThickness + Clearance, -Depth/2 + _WallThickness + Clearance, -LipHeight]) chamfer(ChamferSize, LipHeight);
	translate([+Width/2 - _WallThickness - Clearance, -Depth/2 + _WallThickness + Clearance, -LipHeight]) rotate([0,0,90]) chamfer(ChamferSize, LipHeight);
	translate([-Width/2 + _WallThickness + Clearance, +Depth/2 - _WallThickness - Clearance, -LipHeight]) rotate([0,0,-90]) chamfer(ChamferSize, LipHeight);
	translate([+Width/2 - _WallThickness - Clearance, +Depth/2 - _WallThickness - Clearance, -LipHeight]) rotate([0,0,180]) chamfer(ChamferSize, LipHeight);

	top_chamfer();
	rotate([0,0,180]) top_chamfer();
}

module top_chamfer()
{
	// Chamfer lip
	translate([+Width/2 - _WallThickness - Clearance, -Depth/2 + _WallThickness + Clearance, -LipHeight]) rotate([0,-90,0]) chamfer(ChamferSize, Width - _WallThickness*2 - Clearance*2);
	translate([+Width/2 - _WallThickness - Clearance, +Depth/2 - _WallThickness - Clearance, -LipHeight]) rotate([0,-90,90]) chamfer(ChamferSize, Width - _WallThickness*2 - Clearance*2);
}

module fillet(r, l, e=.001)
{
	// Fillets
	translate([-r, -r, -e])
	difference()
	{
		cube([r + e, r + e, l + e*2]);
		intersection()
		{
			cube([r*2, r*2, l + e*2]);
			cylinder(l + e*2, r=r, true);
		}
	}
}

module chamfer(h, l, e=.001)
{
	translate([-e,-e,-e])
	linear_extrude(l + e*2) polygon([[0,0], [0,h+e], [h+e,0]]);
}

module bottom()
{
	difference()
	{
		bottom1();
		bottom2();
		bottom3();
	}
}

module bottom1()
{
	main_form(HeightBottom);
}

module bottom2()
{
	translate([-Width/2 + _WallThickness, -Depth/2 + _WallThickness, _WallThickness]) cube([Width - _WallThickness*2, Depth - _WallThickness*2, HeightBottom - _WallThickness]);
}

module bottom3()
{
	// Corner fillets
	corner_fillet(HeightBottom);

	// Bottom Fillets
	rotate([0,180,0])
	{
		top_fillet(0);
		rotate([0,0,180]) top_fillet(0);
	}
}

module ribbon_part1()
{
	difference()
	{
		union()
		{
			ribbon1();
			ribbon2();
			difference()
			{
				ribbon3();
				ribbon4();
			}
		}
		translate([0,Clearance,0]) ribbon5(_RibbonThickness+Clearance);
	}
}

module ribbon1()
{
	translate([-CutoutWidth/2 + Clearance, -CutoutDepth/2 + Clearance, -CutoutHeight + Clearance]) cube([CutoutWidth - Clearance*2, CutoutDepth - Clearance*2, CutoutHeight - Clearance]);
}

module ribbon2()
{
	translate([0,CutoutDepth/2 - Clearance, 0])
	rotate([90,0,0])
	{
		ribbon2_half();
		mirror([1,0,0]) ribbon2_half();
	}
}

module ribbon2_half()
{
	linear_extrude(CutoutDepth - Clearance*2)
	difference()
	{
		ribbon2_shape();
		offset(-_RibbonThickness) ribbon2_shape();
	}
}

module ribbon2_shape()
{
	x=_RibbonSize - _RibbonDiameter/2;
	y=_RibbonDiameter/2;
	translate([x, y, 0]) circle(d=_RibbonDiameter);

	// Tangent calculation
	alfa=asin(y / sqrt(x*x + y*y));
	xt=x * cos(2*alfa);
	yt=x * sin(2*alfa);
	polygon([[x, 0], [0,0], [xt,yt]]);
}

module ribbon3()
{
	translate([-CutoutWidth/2, -CutoutDepth/2 + Clearance, 0]) cube([CutoutWidth, CutoutDepth - Clearance*2, _RibbonThickness*3]);
}

module ribbon4()
{
	translate([+CutoutWidth/2, +CutoutDepth/2 - Clearance, _RibbonThickness*3]) rotate([90,0,0]) fillet(ChamferSize, CutoutDepth - Clearance*2);
	translate([-CutoutWidth/2, +CutoutDepth/2 - Clearance, _RibbonThickness*3]) rotate([90,-90,0]) fillet(ChamferSize, CutoutDepth - Clearance*2);
}

module ribbon_part2()
{
	ribbon5(_RibbonThickness);
}

module ribbon5(h)
{
	union()
	{
		ribbon5_half(h);
		mirror([1,0,0]) ribbon5_half(h);
	}
}

module ribbon5_half(h)
{
	linear_extrude(h) polygon([
		[0, 0], 
		[-_RibbonEnd/sqrt(2), -_RibbonEnd/sqrt(2)], 
		[-_RibbonEnd/sqrt(2) + CutoutDepth*sqrt(2)/2, -_RibbonEnd/sqrt(2)],
		[-_RibbonEnd/sqrt(2) + CutoutDepth*sqrt(2)/2, -_RibbonEnd/sqrt(2) - CutoutDepth*sqrt(2)/2],
		[0, - CutoutDepth*sqrt(2)]]
	);
}

module part()
{
	if (part=="bottom")
	{
		bottom();
	}
	else if (part=="top")
	{
		translate([0,0,HeightTop]) rotate([0,180,0]) top();
	}
	else if (part=="ribbon1")
	{
		translate([0, 0, , CutoutDepth/2 - Clearance]) rotate([-90,0,0]) ribbon_part1();
	}
	else if (part=="ribbon2")
	{
		ribbon_part2();
	}
	else if (part=="ribbon")
	{
		translate([0, 0, CutoutDepth/2 - Clearance]) rotate([-90,0,0]) 
		union() 
		{
			ribbon_part1();
			ribbon_part2();
		}
	}
	else if (part=="exploded")
	{
		Spacing = 10;
		bottom();
		translate([0,0,HeightBottom + Spacing]) top();
		translate([0,0,Height + Spacing*2]) ribbon_part1();
		translate([0,-Spacing,Height + Spacing*2]) ribbon_part2();
	}
	else if (part=="assembled")
	{
		Spacing = .5;
		bottom();
		translate([0,0,HeightBottom + Spacing]) top();
		translate([0,0,Height + Spacing*2]) ribbon_part1();
		translate([0,-Spacing,Height + Spacing*2]) ribbon_part2();
	}
	else if (part=="all")
	{
		Spacing = 10;
		translate([-Width/2 - Spacing/2, 0, 0]) bottom();
		translate([+Width/2 + Spacing/2, 0, HeightTop]) rotate([0,180,0]) top();
		translate([-Width/2 - Spacing/2, -Width, CutoutDepth/2 - Clearance]) rotate([-90,0,0]) ribbon_part1();
		translate([+Width/2 + Spacing/2, -Width, 0]) ribbon_part2();
	}
}

render() part();
