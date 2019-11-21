/*
	Watch out, because all the surfaces are thin.
	Slice with 100% infill
*/

/* [Basic Settings] */

// Which part to print?
part = 0; // [0:Everything, 1:Lid Only, 2:Base Only; 3:DividerOnly]

// Which type of box to print?
CardType = "class"; // [class:Character's class cards,overlord:Overlord cards,custom:Custom]

// Cut a big window to show the card symbol?
CutWindow = 1; //[1:Yes, 0:No]

// Cut a window to show the card label?
CutLabel = 1; //[1:Yes, 0:No]


/* [Settings for Custom] */

CustomHeight = 64;
CustomWidth = 41;
CustomThickness = 5;

CustomWindowX = 30;
CustomWindowY = 30;
CustomWindowOffset = 4;

CustomLabelX = 5;
CustomLabelY = 25;
CustomLabelOffset = -18;


/* [Advanced] */

// Thickness of the walls
t = 1;

// Margin around the cards
Margin = 2;

// Size of the overhang
Overhang = 5;

// Roundness
Roundness = 3;

// Small gap between the base and the lid
gap = 0.5;

/* [Hidden] */

// Sizes of the various predefined card types
ClassSize = [64, 41, 5];
ClassHole = [30, 30, 4]; // X,Y,Offset
ClassLabel = [5, 25, -18]; // X,Y,Offset

OverlordSize = [89, 58, 15];
OverlordHole = [60, 40, 0]; // X,Y,Offset
OverlordLabel = [0, 0, 0]; // X,Y,Offset

// Jitter to ensure there are no coincident-surface problems
j = 0.1;

// Roundness detail. Mostly $fn will be set to this
detail = 50;

// Shortcuts used to make arrays easier to reference
x=0; y=1; z=2;


module TopBottom(card)
{
	h=card[x]+Margin+t+Overhang;
	w=card[y]+Margin+t+Overhang;

	roundbox([h, w, t], Roundness+Overhang/2-t*2, 0);
}


module case(card, hole, label)
{
	if(part == 0)
	{
		translate([-((card[x]+Margin+t+Overhang)+4+(card[y] + Margin / 2))/2, 0, 0])
		translate([(card[x]+Margin+t+Overhang)/2, 0, 0])
		union()
		{
			translate([0, 2, 0])
			translate([0, (card[y]+Margin+t+Overhang)*0.5, 0])
			base(card);

			translate([0, -2, 0])
			translate([0, -(card[y]+Margin+t+Overhang)*0.5, 0])
			lid(card, hole, label);

			translate([4, 0, 0])
			translate([(card[y] + Margin / 2)/2, 0, 0])
			translate([(card[x]+Margin+t+Overhang)/2, 0, 0])
			rotate([0, 0, 90]) 
			divider(card);
		}
	}
	if(part == 1)
	{
		lid(card);
	}
	if(part == 2)
	{
		base(card);
	}
	if(part == 3)
	{
		divider(card);
	}
}


module divider(card)
{
	h=card[x] + Margin / 2;
	w=card[y] + Margin / 2;
	roundness=t*3;

	roundbox([h, w, t], roundness, 0);
}


module base(card)
{
	// The actual size of the base is a bit (one "t") bigger than a card
	h=card[x]+Margin;
	w=card[y]+Margin;
	d=card[z]+Margin;
	
	union()
	{
		difference()
		{
			union()
			{
				// Thin base (widest part)
				TopBottom(card);

				// Walls
				roundbox([h+t*2, w+t*2, d+t], Roundness, t);
			}

			// Thumb holes
			translate([0, 0, d+t*2]) scale([1, 1, d/(w/3)]) 
			rotate([0, 90, 0]) 
			cylinder(r=w/3, h=h+t*2+j*2, center=true, $fn=detail);
			
		}
	}
}


module lid(card, hole, label)
{
	// The outer size of the base is a bit (one "t") bigger than a card
	base_h=card[x]+Margin+t;
	base_w=card[y]+Margin+t;
	base_d=card[z]+Margin+t;
	
	// The size of the lid is a bit (gap) bigger than the base all around
	h=base_h+gap+t;
	w=base_w+gap+t;
	d=base_d;

	r=hole[x]/2;
	s=hole[x]/ (hole[y] == 0 ? 1 : hole[y]); // prevent DivZero
	o=hole[z];

	union()
	{
		difference()
		{
			union()
			{
				// Thin base (widest part)
				TopBottom(card);

				// Walls
				roundbox([h+t*2, w+t*2, d+t], Roundness+t, t);
			}

			if(CutWindow == 1 && hole[x] > 0 && hole[y] > 0)
			{
				// Window
				translate([o, 0, -j]) scale([1, 1/s, 1]) cylinder(r=r, h=t+j*2, $fn=detail*2);
			}
			
			if(CutLabel == 1 && label[x] > 0 && label[y] > 0)
			{
				translate([label[z], 0, t/2]) cube([label[x], label[y], t+j*2], center=true, $fn=detail);
			}
		}
	}
}


// Size is the outside dimension
module roundbox(size, r, t)
{
	difference()
	{
		hull()
		{
			translate([-r, -r, 0]) translate([ size[x]*0.5,  size[y]*0.5, 0]) cylinder(r=r, h=size[z], $fn=detail);
			translate([ r, -r, 0]) translate([-size[x]*0.5,  size[y]*0.5, 0]) cylinder(r=r, h=size[z], $fn=detail);
			translate([-r,  r, 0]) translate([ size[x]*0.5, -size[y]*0.5, 0]) cylinder(r=r, h=size[z], $fn=detail);
			translate([ r,  r, 0]) translate([-size[x]*0.5, -size[y]*0.5, 0]) cylinder(r=r, h=size[z], $fn=detail);
		}
		if(t>0)
		{
			hull()
			{
				translate([-r, -r, -j]) translate([ size[x]*0.5,  size[y]*0.5, 0]) cylinder(r=r-t, h=size[z]+j*2, $fn=detail);
				translate([ r, -r, -j]) translate([-size[x]*0.5,  size[y]*0.5, 0]) cylinder(r=r-t, h=size[z]+j*2, $fn=detail);
				translate([-r,  r, -j]) translate([ size[x]*0.5, -size[y]*0.5, 0]) cylinder(r=r-t, h=size[z]+j*2, $fn=detail);
				translate([ r,  r, -j]) translate([-size[x]*0.5, -size[y]*0.5, 0]) cylinder(r=r-t, h=size[z]+j*2, $fn=detail);
			}
		}
	}
}



if(CardType == "class")
{
	case(ClassSize, ClassHole, ClassLabel);
}
if(CardType == "overlord")
{
	case(OverlordSize, OverlordHole, OverlordLabel);
}
if(CardType == "custom")
{
	case(
		[CustomHeight, CustomWidth, CustomThickness], 
		[CustomWindowX, CustomWindowY, CustomWindowOffset], 
		[CustomLabelX, CustomLabelY, CustomLabelOffset]
	);
}
