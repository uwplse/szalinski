// Title: Micro Wallet
// Author: http://www.thingiverse.com/Jinja
// Date: 14/9/2013

/////////// START OF PARAMETERS /////////////////

// The more cards you carry, the bigger this should be. This is the only thing you really need to change.
inner_thickness = 10;

// Percentage to increase wall thickness
increase_wall = 0; // [0:100]

// The inner width. This is the width of the clip in the unlocked position.
inner_width = 65; // [60:80]

// The height of the wallet
height = 8; //[6:30]

// The width of your credit cards. You only need to change this if you plan to use the holder for something other than credit cards.
card_width = 56;

/////////// END OF PARAMETERS /////////////////
rounded = 0.7*1;
overhang=45*1;

$fs=0.3*1;
//$fa=5*1; //smooth
$fa=8*1; //nearly smooth
//$fa=20*1; //rough

x = inner_width*1;
y = height*1;
r = sqrt((x*x)+(y*y));
cc = card_width*1;
a = asin(cc/r);
b = acos(x/r);
c = (a-b);
new_length = cc/sin(c);
additional = new_length-x;

wall_thickness2 = 2 * (1+(increase_wall/100));
wall_thickness = wall_thickness2-(2*rounded);
height2 = height-wall_thickness2;

minkowski()
{
difference()
{
	wedge( additional+new_length+2*wall_thickness, new_length+2*wall_thickness, (inner_thickness+rounded)+2*wall_thickness, height );

	wedge( additional+new_length, new_length, (inner_thickness+rounded), height );
}

diamond(rounded);
}

module wedge( length, length2, thickness, height )
{
	hull()
	{
		translate([(-length+length2)*0.5,0,height*0.5])
		cube( [length2, thickness, 0.1], true );

		translate([(length-length2)*0.5,0,-height*0.5])
		cube( [length2, thickness, 0.1], true );
	}
}



module bar( length, diam1, diam2, height )
{
	hull()
	{
		translate( [-length*0.5, 0, -height*0.5] )
		cylinder( height, diam1*0.5, diam2*0.5 );
		translate( [length*0.5, 0, -height*0.5] )
		cylinder( height, diam1*0.5, diam2*0.5 );
	}
}

module cutter(dist, overhang)
{
	size = dist*2;

	translate([dist,-dist,-dist])
	cube([size,size,size]);

	translate([-dist-size,-dist,-dist])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,-overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,-90+overhang,0])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,90+overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,180-overhang,0])
	cube([size,size,size]);

}

module diamond( rounded )
{
	dist = rounded;
	difference()
	{
		cube([2*rounded,2*rounded,2*rounded], true);
		for(i=[0:45:179])
		{
			rotate([0,0,i])
			cutter(dist, overhang);
		}
	}
}
