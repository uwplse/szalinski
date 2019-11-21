// This makes the holes bigger.
tolerance = .3;
// This determines how thick the base of the riser will be in mm.
rise = 0; // [0:100]
// This Determines the angle of the wedge, between 0 and 45 degrees. Dont forget you can stack these too!
angle = 7.5; // [0:45]

// Copyright 2010 D1plo1d

// This library is dual licensed under the GPL 3.0 and the GNU Lesser General Public License as per http://creativecommons.org/licenses/LGPL/2.1/ .

//testNutsAndBolts();

module SKIPtestNutsAndBolts()
{
	$fn = 360;
	translate([0,15])nutHole(3, proj=2);
	boltHole(3, length= 30, proj=2);
}

MM = "mm";
INCH = "inch"; //Not yet supported

//Based on: http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
METRIC_NUT_AC_WIDTHS =
[
	-1, //0 index is not used but reduces computation
	-1,
	-1,
	6.40,//m3
	8.10,//m4
	9.20,//m5
	11.50,//m6
	-1,
	15.00,//m8
	-1,
	19.60,//m10
	-1,
	22.10,//m12
	-1,
	-1,
	-1,
	27.70,//m16
	-1,
	-1,
	-1,
	34.60,//m20
	-1,
	-1,
	-1,
	41.60,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	53.1,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	63.5//m36
];
METRIC_NUT_THICKNESS =
[
	-1, //0 index is not used but reduces computation
	-1,
	-1,
	2.40,//m3
	3.20,//m4
	4.00,//m5
	5.00,//m6
	-1,
	6.50,//m8
	-1,
	8.00,//m10
	-1,
	10.00,//m12
	-1,
	-1,
	-1,
	13.00,//m16
	-1,
	-1,
	-1,
	16.00//m20
	-1,
	-1,
	-1,
	19.00,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	24.00,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	29.00//m36
];

COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS =
[//based on max values
	-1, //0 index is not used but reduces computation
	-1,
	-1,
	2.98,//m3
	3.978,//m4
	4.976,//m5
	5.974,//m6
	-1,
	7.972,//m8
	-1,
	9.968,//m10
	-1,
	11.966,//m12
	-1,
	-1,
	-1,
	15.962,//m16
	-1,
	-1,
	-1,
	19.958,//m20
	-1,
	-1,
	-1,
	23.952,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	29.947,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	35.940//m36
];

module nutHole(size, units=MM, tolerance = +0.0001, proj = -1)
{
	//takes a metric screw/nut size and looksup nut dimensions
	radius = METRIC_NUT_AC_WIDTHS[size]/2+tolerance;
	height = METRIC_NUT_THICKNESS[size]+tolerance;
	if (proj == -1)
	{
		cylinder(r= radius, h=height, $fn = 6, center=[0,0]);
	}
	if (proj == 1)
	{
		circle(r= radius, $fn = 6);
	}
	if (proj == 2)
	{
		translate([-radius/2, 0])
			square([radius*2, height]);
	}
}

module boltHole(size, units=MM, length, tolerance = +0.0001, proj = -1)
{
	radius = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[size]/2+tolerance;
//TODO: proper screw cap values
	capHeight = METRIC_NUT_THICKNESS[size]+tolerance; //METRIC_BOLT_CAP_HEIGHTS[size]+tolerance;
	capRadius = METRIC_NUT_AC_WIDTHS[size]/2+tolerance; //METRIC_BOLT_CAP_RADIUS[size]+tolerance;

	if (proj == -1)
	{
	translate([0, 0, -capHeight])
		cylinder(r= capRadius, h=capHeight);
	cylinder(r = radius, h = length);
	}
	if (proj == 1)
	{
		circle(r = radius);
	}
	if (proj == 2)
	{
		translate([-capRadius/2, -capHeight])
			square([capRadius*2, capHeight]);
		square([radius*2, length]);
	}
}



/* length, width of wedge
    height of side 1 and 2 
    drill oldschool and/or newschool pattern 
    bolt size (M)

    NOTE: if both oldschool and newschool bits are set to 1, 
    the newschool pattern will be displaced to match on one side.
*/
module wedge(len, wid, hei1, hei2, oldschool, newschool, bolt, angle1, derpschool) {

len = 80;
bolt_wid = 41.28;
new_len = 53.98;
old_len = 63.5;
angle1 = angle;
hei1 = tan(angle1)*len+rise;
hei2 = rise;

mx = len/2;
my = wid/2;

difference() {
  rotate([0,-90,0])
  linear_extrude(height=wid)
    polygon (points = [[0,0],[0,len],[hei2,len],[hei1,0]]);


/* for sunken holes you'll never need, 
   translate z by 
                     hei1 + (hei2-hei1)/len * (mx + x*mx*3/4) -0.5
*/

if (oldschool==1) {
  for (x = [-1,1])
  for (y = [-1,1]) 
  translate([-my + y * bolt_wid/2, mx + x * old_len/2, hei1+hei2 ])
  rotate([180,0,0])
  boltHole(bolt, length=hei1+hei2+0.1, tolerance=tolerance, 2);
}

if (newschool==1) {
  for (x = [-1,1])
  for (y = [-1,1]) 
  translate([-my + y * bolt_wid/2, mx + x * new_len/2 +(old_len-new_len)/2 * oldschool, hei1+hei2])
  rotate([180,0,0])
  boltHole(bolt, length=hei1+hei2+0.1, tolerance=tolerance, 2);
}
if (newschool==1) {
  for (x = [-1,1])
  for (y = [-1,1]) 
  translate([-my + y * bolt_wid/2, mx + x * new_len/2 -(old_len-new_len)/2 * oldschool, hei1+hei2])
  rotate([180,0,0])
  boltHole(bolt, length=hei1+hei2+0.1, tolerance=tolerance, 2);
}
}
}

/* example */
wedge (90, 58, 15, 10, 1, 1, 5);
/**/