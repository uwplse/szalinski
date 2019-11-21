/*
  Slide Clamp
  version 1.0
  2013-06-06
  by Kirk Saathoff
*/


/* [Global] */

// Rod Length is the total lenth of the clamp
rodLen = 140;

// Rod Width is the width of the clamp rod
rodWidth = 10;

// Rod Thickness is the thickess of the clamp rod
rodThickness = 5;

// Jaw Length
jawLen = 30;

// Jaw Width
jawWidth = 14;

// Vee Depth
veeDepth = 4;

// Clearance for slider opening
clearance = 0.85;

/* [Hidden] */

hookLen = jawWidth*.7;

slideWidth = rodWidth+rodThickness;
slideDepth = rodThickness*2;

clearanceHalf = clearance/2;

module hook()
{
//	color("red")
        	cube([hookLen, rodThickness*1, rodThickness]);
}

module vee(_jawLen)
{
	echo("jawLen in vee", _jawLen);
//	color("red")
	translate([jawWidth, _jawLen-rodThickness*2, -0.01])
	rotate([0, 0, 45])
	{
        	cube([veeDepth, veeDepth, rodThickness+.02]);
	}
}

module Jaw(offset)
{
//	echo("jawLen", jawLen);

	_jawLen = jawLen + offset;
	echo("_jawLen in Jaw", _jawLen);

	jawAngle = atan((jawWidth*.6)/_jawLen);
	jawHyp = jawLen/cos(jawAngle);

	difference() {
		union() {
			difference()
			//union() 
			{
		     	cube([jawWidth, _jawLen, rodThickness]);
		    		 	rotate(-jawAngle) { 
						translate([-jawWidth, 0, -0.01]) 
							cube([jawWidth, jawHyp, rodThickness+.02]);
				}
			}
		    translate([jawWidth-(hookLen), _jawLen, 0]) hook();
		}
	    vee(_jawLen);
	}
}

module slider()
{
//    jawLen = 25;
	union() {
		difference()
		//union() 
		{
			cube([jawWidth, slideWidth, slideDepth]);
			translate([-0.01, (slideWidth/2-(rodWidth/2))-clearanceHalf, 
				(slideDepth/2-(rodThickness/2))-clearanceHalf]) {
				cube([jawWidth+.02, rodWidth+clearance, rodThickness+clearance]);
			}
		}
		translate([0, slideWidth, (slideDepth/2)-(rodThickness/2)]) {
			Jaw(-5/2);
		}
	}
}

module rod()
{
	union()
	{
		cube([rodLen, rodWidth, rodThickness]);
		translate([0, rodWidth-0.01, 0]) {
			Jaw(0);
		}
	}
}

module print_part() {

	rod();
	translate([jawWidth+rodThickness+5, 15+slideDepth, jawWidth]) {
		rotate([0, 0, 0])
		rotate([90, 90, 0])
		{
			slider();
		}
	}
}

print_part();





