// Customisable pastry cutter for
// blank shape and Vol-au-vent wall
// 
// Options are circular, oval, polygonal (regular only) or rectangle
// square can be made by 4 sided polygon or rectangle with X=Y
//
// By misterC @ thingiverse

// CUSTOMIZER VARIABLES
/* [Basic choices] */
// Do you want a regular polygon, a circle, square/rectangle or an oval?
shape_choice = "Polygon";	// [Circle:Circular,Oval:Oval,Polygon:Regular polygon (3 to 12 sides),Rectangle:Rectangular]
//
// What width of Vol-au-Vent wall?
vol_wall = 18;			// [10:0.5:25]
// What depth of cutter?
cutter_depth = 25;		// [10,15,20,25,30]
// What wall thickness? (base this on your nozzle diameter)
cutter_wall = 1.2;		// [0.6,0.8,1.0,1.2,1.4,1.6,1.8,2]
// Top lip size?
lip_dim = 3;			// [3:6]
//
//Which cutter to show in preview
part ="both";	// [top:Upper cutter,base:Lower cutter,both:Both cutters]

/* [Circular cutter options] */
// What diamater should the cutter shape be?
circ_dia=75;		// [40:5:150]

/* [Oval cutter options] */
// What overall width should the cutter shape be?
pill_len = 150;		// [50:5:200]
// What diameter should the ends of the cutter be?
pill_dia = 90;		// [20:5:200]

/* [Polygon cutter options] */
// How many faces do you want?
poly_faces = 6;		// [3:12]
// and what length should each side be?
poly_side = 75;		// [50:5:150]

/* [Rectangular cutter options]*/
// What width should the cutter shape be?
rect_wide = 100;		// [40:5:160]
// What height should the cutter shape be?
rect_high = 75;			// [40:5:160]


// PROGRAM VARIABLES AFTER THIS POINT
/* [Hidden] */
// Calculated values
// centres & half_centre are the eccentricity dims for ovals, so can be zero for non ovals
centres = (shape_choice=="Oval") ?	pill_len - pill_dia : 0;
half_centre = (shape_choice=="Oval") ? centres/2 : 0;
out_rad = (shape_choice=="Circle") ? circ_dia/2 
		: (shape_choice=="Oval") ? pill_dia/2 
		: (shape_choice=="Polygon") ? poly_side/(2*sin(180/poly_faces)) 
		: 0;
in_rad = out_rad - vol_wall;
// offset dimension for showing both pieces
both_off = (shape_choice=="Circle" || shape_choice=="Polygon") ? 1.2*out_rad 
		: (shape_choice=="Oval") ? 0.6*pill_len 
		: 0.75*rect_wide;

// Shape values matrix (X,Y for rectangular otherwise radius)
shape_set = (shape_choice=="Rectangle") ? [
		[rect_wide,	rect_high],
		[rect_wide-2*vol_wall,	rect_high-2*vol_wall],
		[rect_wide+2*cutter_wall,	rect_high+2*cutter_wall],
		[rect_wide-2*(vol_wall+cutter_wall),	rect_high-2*(vol_wall+cutter_wall)],
		[rect_wide+2*lip_dim,	rect_high+2*lip_dim],
		[rect_wide-2*(vol_wall+lip_dim),	rect_high-2*(vol_wall+lip_dim)]		
		] : [
		out_rad,
		in_rad,
		out_rad + cutter_wall,
		in_rad - cutter_wall,
		out_rad + lip_dim,
		in_rad - lip_dim
		];

// how many grips will we put onto cutter sides (or round a cutter radius)
// x & y for rectangle sides, c around curve of circular, o for straight of oval
// polygons get grips at corners, so we only need to know the angle
x_grip = (shape_choice=="Rectangle") ? get_a_grip(shape_set[1].x,2.3) : 0;
y_grip = (shape_choice=="Rectangle") ? get_a_grip(shape_set[1].y,2.3) : 0;
c_grip = (shape_choice=="Circle") ? get_a_grip(shape_set[1]*2*PI,4)
		: (shape_choice=="Oval") ? get_a_grip(shape_set[1]*PI,3) : 0;
c_ang = (shape_choice=="Circle") ? 360/c_grip
		: (shape_choice=="Oval") ? 180/c_grip : 0;
o_grip = (shape_choice=="Oval") ? get_a_grip(centres,3) : 0;
p_ang = (shape_choice=="Polygon") ? 360/poly_faces : 0;

$fn = (shape_choice=="Polygon") ? poly_faces : 60;		// Cheat at doing polygon, otherside reasonably smooth curves
fudge = 1;		// small offset to assist with difference() volumes

// PROGRAM - process which part(s) to show and call the necessary module(s)

if (part == "top")
{
	if (shape_choice=="Rectangle") rect_top();
	else top();
}
else if (part == "base")
{
	if (shape_choice=="Rectangle") rect_base();
	else base();
}
else
{
	translate([-both_off,0,0])
	{
		if (shape_choice=="Rectangle") rect_top();
		else top();
	}
	translate([both_off,0,0])
	{
		if (shape_choice=="Rectangle") rect_base();
		else base();
	}
}

// MODULES AND FUNCTIONS

module top()
{
	// outside shape, bulb facing out
	base();
	// inside shape, bulb facing in
	difference()
	{
		shape(1,cutter_depth);	// cutter body

		translate([0,0,-fudge]) shape(3,cutter_depth+2*fudge);	// inner shape
	}
	difference()
	{
		shape(1,lip_dim);		// bulb at top faces in

		translate([0,0,-fudge]) shape(5,lip_dim+2*fudge);
	}
	// grips between inner and outer shapes
	intersection()
	{
		difference()	// "donut" of top lip
		{
			shape(4,lip_dim);

			translate([0,0,-fudge]) shape(1,lip_dim+2*fudge);
		}

		translate([0,0,lip_dim/2]) union()		// all the webs
		{
			if (shape_choice=="Circle") for (ang=[0:c_ang:360]) poly_grip(ang,vol_wall);
			else if (shape_choice=="Polygon") for (ang=[0:p_ang:360]) poly_grip(ang,poly_side/3);		// big grip at corners
			else	// only oval left
			{
				translate([half_centre,0,0]) for (ang=[-90+c_ang:c_ang:90-c_ang]) poly_grip(ang,vol_wall);		// first curve
				translate([-half_centre,0,0]) for (ang=[90+c_ang:c_ang:270-c_ang]) poly_grip(ang,vol_wall);		// last curve
				rect_grips(0,o_grip,shape_set[4],centres);		// straights are like rectangle long side
			}
		}
	}
}

module base()
{
	difference()
	{
		union()
		{
			shape(4,lip_dim);			// bulb at top faces out
			shape(2,cutter_depth);	// cutter body
		}

		translate([0,0,-fudge]) shape(0,cutter_depth+2*fudge);	// inner shape
	}
}

module shape(num,depth)
{
	if (shape_choice=="Oval")
	{
		for (end=[-half_centre,half_centre]) translate([end,0,0]) cylinder(r=shape_set[num],h=depth);
		translate([-half_centre,-shape_set[num],0]) cube([centres,shape_set[num]*2,depth]);
	}
	else cylinder(r=shape_set[num],h=depth);
}

module poly_grip(rot_ang,what_grip)
{
	rotate(rot_ang) translate([shape_set[1],0,0]) cube([3*vol_wall,what_grip,lip_dim],center=true);
}

module rect_top()
{
	// outside shape, bulb facing out
	rect_base();
	// inside shape, bulb facing in
	difference()
	{
		rect_shape(1,cutter_depth,0);		// cutter body

		rect_shape(3,cutter_depth,2*fudge);	// inner shape
	}
	difference()
	{
		rect_shape(1,lip_dim,0);			// bulb at top faces in

		rect_shape(5,lip_dim,2*fudge);
	}
	// grips between inner and outer shapes
	intersection()
	{
		difference()	// "donut" of top lip
		{
			rect_shape(4,lip_dim,0);

			rect_shape(1,lip_dim,2*fudge);
		}

		translate([0,0,lip_dim/2]) union()		// all the webs
		{
			rect_grips(0,x_grip,shape_set[4].y,shape_set[1].x);
			rect_grips(90,y_grip,shape_set[4].x,shape_set[1].y);
		}
	}
}

module rect_base()
{
	difference()
	{
		union()
		{
			rect_shape(4,lip_dim,0);		// bulb at top faces out
			rect_shape(2,cutter_depth,0);	// cutter body
		}

		rect_shape(0,cutter_depth,2*fudge);	// inner shape
	}
}

module rect_shape(num,height,is_fudged)
{
	translate([0,0,height/2]) cube([shape_set[num].x,shape_set[num].y,height+is_fudged],center=true);
}

module rect_grips(rot_ang,what_grip,grip_high,length)
{
	rotate(rot_ang)
		if (what_grip==1) cube([vol_wall,2*grip_high,lip_dim],center=true);
		else
		{
			grip_gap = (length-(vol_wall*what_grip))/(what_grip-1);
			for (grip=[0:what_grip-1])
				translate([(grip*(grip_gap+vol_wall))+(vol_wall-length)/2,0,0]) cube([vol_wall,2*grip_high,lip_dim],center=true);
		}
}

function get_a_grip(length,multiple)	// returns an integer based on vol_wall and the length to support
= round(length/(multiple*vol_wall));