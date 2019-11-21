/// Wet Pallette for painting.

// Cut a piece of a Paper towel to fit the trays.
// Cut same sized piece of Baker's Parchment on top.
// Paint goes on the Parchment.
// Cover to prevent drying.

// Program prints sizes to cut.

// Sloping trays mean it can be printed without support, or with invisible supports underneath.
// Ideas from:
//    - http://www.fullborerminiatures.com/articles/wetpalette.html
//    - 

// preview[view:north east, tilt:top diagonal]

// All measurements in mm
// Total Width
Tray_width = 80;         // [80:200]
//Total Depth
Tray_depth = 70;         // [50:200]
// Two Palettes
Doubled = "yes";          // [yes,no]
// Palette section depth
Depth = 7;                // [2:20]
// Wall thickness
Wall_thickness = 1;       // [1:0.1:2]
// Base thickness
Base_thickness = 1;       // [1:0.1:2]
// Water Tray depth
Water_depth = 15;         // [5:2:20]
// Water Tray width
Water_width = 20;         // [10:100]
// min angle for no support printing. Tray angle
no_support_angle = 33;    // [0:2:50]
/* [Visualise]  */
Show_parchment = "no";    // [yes,no]
// Turn on to export for printer
Print_orientation = "no"; // [yes,no]
// Add lid
Show_lid = "no";          // [yes,no]
Lid_thickness = 1;        // [1:0.2:3]

/*  [Hidden] */
parchment_buffer = 10; // Paper towel is this much bigger than parchment
single_tray_width =  Tray_width - Water_width - Wall_thickness*3 - ((Doubled=="yes") ? Wall_thickness : 0);
double_tray_width = single_tray_width/2;
parchment_width  = (Doubled=="yes")
						? double_tray_width - parchment_buffer*2 - Wall_thickness*3
						: single_tray_width - parchment_buffer*2 - Wall_thickness*2;
parchment_height = (Tray_depth - parchment_buffer*2)*cos(no_support_angle);
lid_height = max(Lid_thickness/2, 3);

// internals
Delta = 0.1; // overlaps
$fn = 20;    // round corners


// Build the well shape
module well(h, w, d, thick=Wall_thickness)  {
	extra = d*sin(no_support_angle)/cos(no_support_angle); //atan ?
	scaleup = h/(h-extra);
	linear_extrude(height=d, scale=[1,scaleup]) {
	translate([0,thick,0])
		difference() {
			offset(r=thick)
				square(size=[w,h-extra-Wall_thickness], center=false);
			square(size=[w,h-extra-Wall_thickness], center=false);
		}
	}
	// floor
	translate([-thick/2,thick/2,0])
		cube(size=[w+thick,h-extra+thick, Base_thickness], center=false);
}

// unprinted extras
module paper(w,h) {
	// paper towel
	color([0,0.7,0.8])
	translate([-parchment_buffer/2,-parchment_buffer/2,-Base_thickness/2])
		cube(size=[w+parchment_buffer,h+parchment_buffer, Delta]);
	// parchment
	color([0.7,0.7,0])
	cube(size=[w,h, Delta]);
}

module tray()  {
	water_height = Tray_depth/2;
	tray_width = (Doubled=="yes") ? double_tray_width : single_tray_width;
	// tray 1
	well(Tray_depth, tray_width, Depth);
	if (Doubled == "yes")  {
		// second tray
		translate([tray_width+Wall_thickness*2+Water_width,0,0 ])
			well(Tray_depth, tray_width, Depth);
	}
	// water
	translate([tray_width+Wall_thickness, Tray_depth-water_height, -(Water_depth-Depth)])
		well(water_height-Wall_thickness, Water_width, Water_depth);
	translate([tray_width+Wall_thickness, 0, -(Water_depth-Depth)])
		well(water_height-Wall_thickness, Water_width, Water_depth);

	// walls
	translate([0,Wall_thickness,-(Water_depth-Depth)])
	difference() {
		linear_extrude(height=Water_depth,convexity=5) {
			difference() {
				offset(r=Wall_thickness)
					square(size=[Tray_width-Wall_thickness*2,Tray_depth-Wall_thickness], center=false);
				square(size=[Tray_width-Wall_thickness*2,Tray_depth-Wall_thickness*2], center=false);
			}
		}
		// cut front
		translate([0,Tray_depth-Wall_thickness*3,-Water_depth/2])
			cube(size=[Tray_width-Wall_thickness*2, Wall_thickness*4, Water_depth*2]);
	}
	// Parchment
	if (Show_parchment == "yes")  {
		translate([0,parchment_buffer+Wall_thickness,Base_thickness*2]) {
			translate([parchment_buffer+Wall_thickness,0,0])
				paper(parchment_width, parchment_height);
			if (Doubled == "yes")  {
				translate([parchment_buffer+Wall_thickness*3+Water_width+tray_width,0,0])
					paper(parchment_width, parchment_height);
			}
		}
	}
}

Rotate = (Print_orientation == "yes") ? 90 : 0;
rotate([Rotate,0,0])
	tray();
echo(str("Parchment width=",parchment_width, "\n             Parchment height=",parchment_height,"\n"));
if (Show_lid == "yes") {
	extra = d*sin(no_support_angle)/cos(no_support_angle);
	translate([0,-Tray_depth-Water_depth*2,0]) {
	difference() {
		// outer
		cube(size=[Tray_width+Wall_thickness*4+Delta*2, Tray_depth+Wall_thickness*4+Delta*2, lid_height]);
		// inner
		translate([Wall_thickness, Wall_thickness, Lid_thickness+Delta])
		cube(size=[Tray_width+Wall_thickness*2+Delta*2, Tray_depth+Wall_thickness*2+Delta*2, Lid_thickness*3]);
	}
	}
}
// Todo:
// - drain holes (angled)