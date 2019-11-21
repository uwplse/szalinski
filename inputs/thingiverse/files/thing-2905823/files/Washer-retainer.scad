// Retainers for hooped ends
// on washing drier racks
// 
// By misterC @ thingiverse

// CUSTOMIZER VARIABLES
/* [Main frame] */
// What diameter is the frame?
frame_dia = 15;		// [10:30]
// What length of frame to show?
frame_len = 75;		// [50:5:100]
// What diameter is the retaining peg?
peg_dia = 6;		// [4:0.5:10]
// What clearance to allow? (each side)
peg_clear = 1;		// [0:5]
// How long is the retaining peg shaft?
peg_len = 22;		// [10:30]
// What diameter is the peg head?
peg_hd_dia = 10;	// [6:20]
// What height is the peg head?
peg_hd_high = 2.5;	// [1:0.25:10]

/* [Rack sizes] */
// What is the wire diameter?
rack_wire_dia = 4.6;	// [3:0.2:8]
// What clearance to allow around wire? (each side)
rack_wire_clear = 0.2;	// [0.1:0.1:2]
// What is the outside diameter of the return hook?
rack_hook_dia = 24;		// [10:50]
// What is the total length of the return hook? (from outside of curve)
rack_hook_len = 34;		// [20:100]

/* [Bottom plate] */
// What wall thickness to use? (Base this on nozzle size)
bot_wall_thick = 1.6;	// [1:0.5:5]

/* [Top plate] */
// What wall thickness to use? (Base this on nozzle size)
top_wall_thick = 2;		// [1:0.5:5]

/* [Other factors] */
// Which items to show?
display = "Part";		// [Assembly:Full assembly,Part:Part assembly (frame & base),Frame:Just frame,Base:Bottom plate only,Top:Top plate only]
// How smooth should the curves be?
fn = 20;				// [20:10:120]

// PROGRAM VARIABLES AFTER THIS POINT
/* [Hidden] */
// Working constants
fudge = 1;
Ymirror = [1,0,0];
Xmirror = [0,1,0];
Zmirror = [0,0,1];

// Calculated values
rack_hook_rad = (rack_hook_dia-rack_wire_dia)/2;
rack_wire_len = rack_hook_len-rack_hook_rad;
plate_wire_space = rack_wire_dia+2*rack_wire_clear;
half_space = plate_wire_space/2;
peg_clear_rad = peg_dia/2 + peg_clear;
bot_inner_wall = rack_hook_rad - peg_clear_rad;

straight_base = 
		[
			[half_space+bot_wall_thick,		-(half_space+bot_wall_thick)],
			[half_space+bot_wall_thick,		half_space],
			[half_space,					half_space],
			[half_space,					-half_space],
			[-half_space,					-half_space],
			[-half_space,					half_space],
			[-bot_inner_wall,				half_space],
			[-bot_inner_wall,				-(half_space+bot_wall_thick)]
		];
curve_base = 
		[
			[half_space+bot_wall_thick,		-(half_space+bot_wall_thick)],
			[half_space+bot_wall_thick,		half_space+top_wall_thick],
			[half_space,					half_space+top_wall_thick],
			[half_space,					-half_space],
			[-half_space,					-half_space],
			[-half_space,					half_space+top_wall_thick],
			[-bot_inner_wall,				half_space+top_wall_thick],
			[-bot_inner_wall,				-(half_space+bot_wall_thick)]
		];
straight_top =
		[
			[-(bot_wall_thick+rack_hook_rad+half_space),	0],
			[-(bot_wall_thick+rack_hook_rad+half_space),	top_wall_thick],
			[-(peg_dia+peg_clear)/2,						top_wall_thick],
			[-(peg_dia+peg_clear)/2,						top_wall_thick+plate_wire_space],
			[(peg_dia+peg_clear)/2,							top_wall_thick+plate_wire_space],
			[(peg_dia+peg_clear)/2,							top_wall_thick],
			[bot_wall_thick+rack_hook_rad+half_space,		top_wall_thick],
			[bot_wall_thick+rack_hook_rad+half_space,		0]
		];
// PROGRAM 
$fn = fn;
if (display=="Top") show_top();
else if (display=="Base") translate([0,0,half_space+bot_wall_thick]) show_base();
else
	{
		show_frame();
		translate([0,0,peg_len/4-1]) rotate(90) show_rack("Salmon");
		translate([0,0,-peg_len/4+1]) rotate([0,180,-90]) show_rack("Cyan");
	}

// MODULES
module show_frame()
{
	color("DarkGray")
	{
		translate([0,0,-(peg_len+frame_dia)/2]) cylinder(d=peg_dia,h=peg_len+frame_dia/2);
		difference()
		{
			translate([0,0,peg_len/2]) scale([peg_hd_dia,peg_hd_dia,peg_hd_high]) sphere(d=1);

			cylinder(d=peg_hd_dia+fudge,h=peg_len/2);
		}
	}
	color("White") translate([0,0,-(frame_dia+peg_len)/2]) rotate([90,0,0]) cylinder(d=frame_dia,h=frame_len,center=true,$fn=2*fn);
}

module show_rack(colour)
{
	show_wire_hook();
	if (display=="Assembly" || display=="Part") color(str("Light",colour)) show_base();
	if (display=="Assembly") color(colour) rotate([0,180,0]) translate([0,-peg_clear_rad,-(half_space+top_wall_thick)]) show_top();
}

module show_wire_hook()
{
	$fn=2*fn;
	color("Lavender") rotate([90,0,0])
	{
		translate([rack_hook_rad,0,0]) cylinder(d=rack_wire_dia,h=rack_wire_len);
		rotate([-90,0,0]) rotate_extrude(angle=180) translate([rack_hook_rad,0,0]) circle(d=rack_wire_dia);
		translate([-rack_hook_rad,0,0]) cylinder(d=rack_wire_dia,h=3*rack_wire_len);
	}		

}

module show_base()
{
	mirrorme(Ymirror) rotate([90,0,0])
	{
		translate([rack_hook_rad,0,0]) linear_extrude(height=peg_clear_rad) polygon(points=curve_base);
		translate([rack_hook_rad,0,peg_clear_rad]) linear_extrude(height=rack_wire_len-peg_clear_rad) polygon(points=straight_base);
	}
	rotate_extrude(angle=180,$fn=2*fn) translate([rack_hook_rad,0,0]) polygon(points=curve_base);
}

module show_top()
{
	rotate([90,0,0]) linear_extrude(height=rack_wire_len-peg_clear_rad) polygon(points=straight_top);
}


module mirrorme(axis)
{
	children();
	mirror (axis) children();
}

