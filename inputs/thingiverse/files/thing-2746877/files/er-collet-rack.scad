
// Numbers of collets to rack
collets_count=10;
// Number of rows in the rack
collet_rows=2;
// Choose your collet type
collet_type=1;//[0:ER11,1:ER16,2:ER20,3:ER25,4:ER32,5:ER40]
// Spacing (increase for smaller collets or big fingers)
collets_spacing=5;

/* [Hidden] */

$fn=100;

specs=[//		D		D1		L		L1		L2		L3
	/* ER11 */ [11,		11.5,	18,		3.8,	2.5,	2	],
	/* ER16 */ [16,		17,		27.5,	6.26,	4,		2.7	],
	/* ER20 */ [20,		21,		31.5,	6.36,	4.8,	2.8	],
	/* ER25 */ [25,		26,		34,		6.66,	5,		3.1	],
	/* ER32 */ [32,		33,		40,		7.16,	5.5,	3.6	],
	/* ER40 */ [40,		41,		46,		7.66,	7,		4.1	]
];

slope=sin(16); // all ER collets taper is 16°

D =specs[collet_type][0];
D1=specs[collet_type][1];
L =specs[collet_type][2];
L1=specs[collet_type][3];
L2=specs[collet_type][4];
L3=specs[collet_type][5];

depth=L-(L1+L2-L3)-1;

module collet()
{
	translate([0,0,-depth/2]) cylinder(d2=top_diam,d1=bottom_diam,depth,center=true);
}

module taper_cube(d,a,c)
{
	echo(d/2);
	if(c)
	{
		scale(d) rotate([0,0,45]) cylinder(d2=sqrt(2),d1=sqrt(2)/cos(a),1,center=true,$fn=4);
	}
	else
	{
		translate(d/2) scale(d) rotate([0,0,45]) cylinder(d2=sqrt(2),d1=sqrt(2)/cos(a),1,center=true,$fn=4);
	}
}

top_diam=D-slope;
bottom_diam=D-(slope*depth);
DCS=D1+collets_spacing;

cols=ceil(collets_count/collet_rows);
width=collets_spacing+DCS*cols;
length=collets_spacing+DCS*collet_rows;
thick=3;

difference()
{
	taper_cube([length,width,depth+collets_spacing],16);
	translate([thick,thick,depth+collets_spacing-1]) cube([length-thick*2,width-thick*2,thick]);
	translate([-thick,thick,-1]) taper_cube([length+thick*2,width-thick*2,(depth+collets_spacing)*0.3],16);
	translate([thick,thick,0]) taper_cube([length-thick*2,width-thick*2,(depth+collets_spacing)*0.5],16);
	translate([collets_spacing+D1/2,collets_spacing+D1/2,depth+collets_spacing])
	for(r=[0:collet_rows-1])
	{
		for(c=[0:cols-1])
		{
			translate([r*DCS,c*DCS,0]) collet();
		}
	}
}