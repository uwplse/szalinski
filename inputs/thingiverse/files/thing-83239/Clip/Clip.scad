// How many mm thick the clip is
ClipThick = 3;
//How many mm of gap
ClipGap = 5;
//How many mm tall the clip is
ClipHeight = 20;
//How many mm long the clip is
ClipLength = 7.5;




module Clip (Thickness, Gap, Height, Length)
{
	difference()
	{
	cube([Gap+2*Thickness, Length, Height]);
	translate([Thickness, 0-0.5, Thickness]) cube([Gap, Length+1, Height-Thickness+1]);
	}
}

Clip (ClipThick, ClipGap, ClipHeight, ClipLength);