// Customisable coin chute for
// Gummibear
// 
// Options are circular, oval, polygonal (regular only) or rectangle
// square can be made by 4 sided polygon or rectangle with X=Y
//
// By misterC @ thingiverse

// CUSTOMIZER VARIABLES
/* [Coin sizes] */
// What diameter is the coin?
coin_dia = 35;		// [20:1:50]
// What thickness is the coin?
coin_thk = 3;		// [1:0.25:6]
// What tolerance do you want around the coin?
coin_tol = 0.5;		// [0:0.1:2]

/* [Chute sizes] */
// What wall thickness for the chute?
chute_wall = 1.2;	// [0.6:0.2:3.2]
// What top lip for the chute?
chute_lip = 5;		// [2:10]
// How far to drop before turning?
top_drop = 50;		// [20:100]
// How far to drop while turning?
turn_drop = 100;	// [50:250]
// How far to run while turning?
turn_run = 100;		// [50:250]
// What run out at the bottom?
bot_run = 100;		// [50:200]

/* [Other factors] */		//	these will be trial-and-error
// How smooth should the curve be (steps per 1°)?
deg_dec = 30;			// [1:50]
// How wide should the segments be?
seg = 1;			// [0.5:0.5:3]

// PROGRAM VARIABLES AFTER THIS POINT
/* [Hidden] */
// Calculated values
chute_wide = coin_dia+coin_tol;
chute_high = coin_thk+coin_tol;
half_chute = chute_wide/2;
drop_gap = turn_drop/(90);			// vertical increment per degree
chute_polygon = 
		[
			[-(half_chute+chute_wall),	0],
			[-(half_chute+chute_wall),	-(chute_high+2*chute_wall)],
			[-(half_chute-chute_lip),	-(chute_high+2*chute_wall)],
			[-(half_chute-chute_lip),	-(chute_high+chute_wall)],
			[-half_chute,				-(chute_high+chute_wall)],
			[-half_chute,				-chute_wall],
			[half_chute,				-chute_wall],
			[half_chute,				-(chute_high+chute_wall)],
			[half_chute-chute_lip,		-(chute_high+chute_wall)],
			[half_chute-chute_lip,		-(chute_high+2*chute_wall)],
			[half_chute+chute_wall,		-(chute_high+2*chute_wall)],
			[half_chute+chute_wall,		0]
		];

drop_gap = turn_drop/(90);

// PROGRAM 

// easy bits first
translate([0,turn_run+half_chute+chute_wall,turn_drop]) rotate(90)
	linear_extrude(height=top_drop) polygon(points=chute_polygon);	// coin drop
translate([turn_run+half_chute+chute_wall,0,0]) rotate([90,180,0])
	linear_extrude(height=bot_run) polygon(points=chute_polygon);	// coin runout

// now the tricky bit

for(ang=[0:1/deg_dec:90])

	rotate(ang) 															// move around the curve
	translate([turn_run+half_chute+chute_wall,0,sin(ang)*ang*drop_gap])		// move out along the radius
	rotate([ang-90,0,0])													// tilt the slide
	linear_extrude(height=seg,center=true) polygon(points=chute_polygon);	// model another bit
/*
//for (ang=[45:1/deg_dec:90])
	rotate(90-ang) 															// move around the curve
	translate([turn_run+half_chute+chute_wall,0,turn_drop-sin(90-ang)*ang*drop_gap])		// move out along the radius
	rotate([(90-ang)-90,0,0])													// tilt the slide
	linear_extrude(height=seg,center=true) polygon(points=chute_polygon);	// model another bit
}*/