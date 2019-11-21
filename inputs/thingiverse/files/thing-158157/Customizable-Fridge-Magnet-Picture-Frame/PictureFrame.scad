// Title: Picture Frame
// Author: http://www.thingiverse.com/Jinja
// Date: 28/9/2013

/////////// START OF PARAMETERS /////////////////

// The height of the picture
height = 45.5;

// The width of the picture
width = 36;

// The width of the frame border
border = 6;

// How much the border overlaps the edge of the picture
overlap = 2;

// How thick the frame is in total
thickness = 4;

// How thick the backing is
back_thickness = 2;

// The diameter of the magnet holes, 0 if you don't want holes. Even if you're not adding magnets, adding holes uses less plastic.
magnet_diameter = 12.8;

// whether or not to include a stand
stand = "NoStand"; //[ Stand, NoStand ]

// calibration, how many 10ths of a millimeter to adjust the backing size so it is a snug fit in the frame. Increase if it's too loose, decrease if it's too tight. Once you've found the right value for your printer you should be able to print frames of any size. Experiment with small frames first.
calibration = 0; //[-10:10]

// What to include on the plate
plate = "Both"; //[ Back, Front, Both ]


/////////// END OF PARAMETERS /////////////////
rounded = 0.7*1;
overhang=45*1;

adjust = calibration/10;

$fs=0.3*1;
//$fa=5*1; //smooth
$fa=8*1; //nearly smooth
//$fa=20*1; //rough


if( ( plate == "Front" ) || ( plate == "Both" ) )
{
	front( height, width, border, overlap, thickness, back_thickness, stand );
}

if( ( plate == "Back" ) || ( plate == "Both" ) )
{
	translate([0, width+border ,back_thickness*0.5])
	back( height+adjust+1, width+adjust+1, back_thickness, magnet_diameter);
}

module front( height, width, border, overlap, thickness, back_thickness, stand )
{
	difference()
	{
		translate([0,0,thickness*0.5])
		frame( height, width, border, overlap, thickness );
		translate([0,0,thickness-(0.5*back_thickness)])
		back( height+1, width+1, back_thickness*1.05 );
	}
	y = (height*0.7)*cos(75);
	x = y*cos(75);
	s = border-overlap-0.5;
	if( stand=="Stand" )
	{
		translate([height*0.5+s+0.5,0,thickness])
		hull()
		{
			translate([-s*0.5,0,0])
			cube([s,s,0.01], true);
			translate([-1-x,0,y])
			rotate([90,0,0])
			cylinder(s,1,1,true);
		}
	}
}


module back( height, width, back, diam )
{
	gap = 1;
	hremaining = (((height-diam)/2)-gap); 
	hnum=floor( hremaining/(diam+gap) );
	hspacing=((hremaining-((diam+gap)*hnum))/(hnum+1))+diam+gap;
	wremaining = (((width-diam)/2)-gap); 
	wnum=floor( wremaining/(diam+gap) );
	wspacing=((wremaining-((diam+gap)*wnum))/(wnum+1))+diam+gap;
	difference()
	{
		cube( [ height, width, back ], true );
		if( diam > 0 )
		{
			translate([0,0,-back])
			for(i=[-hnum:1:hnum])
			{
				for(j=[-wnum:1:wnum])
				{
					translate([i*hspacing,j*wspacing,0])
					cylinder( back*2, diam*0.5, diam*0.5 );
				}
			}
		}
	}
}

module frame( height, width, border, overlap, back )
{
	difference()
	{
		cube( [ height+2*(border-overlap), width+2*(border-overlap), back ], true );
		translate([0,0,-1])
		cube( [ height+2*(-overlap), width+2*(-overlap), back+2 ], true );
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
