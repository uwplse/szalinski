// Modifed 120-100mm adaptor adaptor
// Initially by dcartoon
// - http://www.thingiverse.com/thing:423186/

// Now with:
// - full or quarter printing,
// - square or circular mounting flange,
// - ronded corners if square,
// - overlaps for easy F6 creation,
// - added lip to make it easier to cable-tie or attach the 100mm pipe.
// - if 4 pieces then:
//   - overlaps are curved and fit well,
//   - strain and fitting relief channel at joins.

// preview[view:south west, tilt:top diagonal]


/* [Adaptor] */
// Diameter at Base (mm)
Base_diameter  = 120;
// Diameter at Top
Top_diameter   = 100;
// Complete Height of Adaptor
Total_Height   = 65;
// Height from Base to end of taper
Taper_height   = 40;
Wall_thickness = 1.35;


/* [Flange] */
Flange_shape   = "square"; // [square,circular]
//Thickness of flange plate
Flange_sq_thickness    = 3;
// Offset from outer corner of Flange
flange_sq_hole_offset  = 6;
Flange_sq_hole_dia     = 4;
// corner(sq only) rounding (0=none)
flange_rounded = 4;
// flange(circular only) width
Flange_c_width = 20;

/* [Details] */
// Add a lip for gripping with cable ties
Add_lip       = "yes"; // [yes,no]
Lip_thickness = 2;
// On small print beds print 4 of these.
Quarter_only  = "no"; // [yes,no]
// how much overlap (for each quarter). 
Overlap       = 10; //[0:1:12]
// Strain and Fit relief channel (for quarters)
relief_dia = 0.4; //[0:0.1:1]


/* [Hidden] */
straight_height = Total_Height - Taper_height;
max_dia = max(Base_diameter, Top_diameter) + Wall_thickness*2; // used for clipping in intersections
lip_dia = Top_diameter + Lip_thickness;
lip_height = (lip_dia - Top_diameter);
//relief_dia = 0.3;

Delta = 0.1;
$fn = 200;



//----------------------------------

module adaptor(base_dia, taper_height, straight_height, top_dia, wall_thick, lip_height, lip_dia)  {
	// straight top
	translate([0, 0, taper_height-Delta])
	difference() {
		union () {
			cylinder(h = straight_height, d = top_dia);
			// Lip
			if (Add_lip == "yes") {
				// lip + ramp. So no support required
				translate([0,0,straight_height-lip_height])
					cylinder(h=lip_height, d=lip_dia);
				translate([0,0,straight_height-lip_height*2+Delta]) // ramp
					cylinder(h=lip_height, d1=top_dia, d2=lip_dia);
			}
		}
		// remove core
		translate([0, 0, -Delta])
			cylinder(h = straight_height+Delta*2, d=top_dia-wall_thick*2);
	}

	// Tapered base
	difference() {
		translate([0, 0, 0])
			cylinder(h = taper_height, d1 = base_dia, d2 = top_dia);
		translate([0, 0, -Delta])
		cylinder(h = taper_height+Delta*2, d1 = base_dia-wall_thick*2, d2 = top_dia-wall_thick*2);
	}
}

module flange_2d() {
	if (Flange_shape == "square")
		linear_extrude(height= Flange_sq_thickness) {
				translate([-Base_diameter/2+flange_rounded, -Base_diameter/2])
					square(size = [Base_diameter-flange_rounded*2, Base_diameter]);
				translate([-Base_diameter/2, -Base_diameter/2+flange_rounded])
					square(size = [Base_diameter, Base_diameter-flange_rounded*2]);
				// corners
				translate([-Base_diameter/2+flange_rounded, -Base_diameter/2+flange_rounded])
					circle(r=flange_rounded);
				translate([Base_diameter/2-flange_rounded, Base_diameter/2-flange_rounded])
					circle(r=flange_rounded);
				translate([-Base_diameter/2+flange_rounded, Base_diameter/2-flange_rounded])
					circle(r=flange_rounded);
				translate([Base_diameter/2-flange_rounded, -Base_diameter/2+flange_rounded])
					circle(r=flange_rounded);
		}
	else {
		cylinder(h=Flange_sq_thickness, d=Flange_c_width*2+Base_diameter);
	}
}

module flange() {
	hole_offset = (Flange_shape=="square") ? 0 : Flange_c_width/8-Flange_c_width*0.32;
	flange_hole_pos = Base_diameter/2 - flange_sq_hole_offset + hole_offset;
	difference() {
		flange_2d();
		translate([0, 0, -Delta])
			//cylinder(h = Flange_sq_thickness+Delta*2, d = Base_diameter-Wall_thickness*2);
			cylinder(h = Taper_height+Delta*2, d1 = Base_diameter-Wall_thickness*2, d2 = Top_diameter-Wall_thickness*2);
		// Holes
		translate([flange_hole_pos, flange_hole_pos, -Delta])
			cylinder(h = Flange_sq_thickness+Delta*2, d=Flange_sq_hole_dia);
		if (Quarter_only != "yes") {
		// holes for other quadrants
			translate([-flange_hole_pos, -flange_hole_pos, -Delta])
				cylinder(h = Flange_sq_thickness+Delta*2, d=Flange_sq_hole_dia);
			translate([-flange_hole_pos, flange_hole_pos, -Delta])
				cylinder(h = Flange_sq_thickness+Delta*2, d=Flange_sq_hole_dia);
			translate([flange_hole_pos, -flange_hole_pos, -Delta])
				cylinder(h = Flange_sq_thickness+Delta*2, d=Flange_sq_hole_dia);
		}
	}
}


module overlap() {
	intersection() {
		// make a slightly larger adaptor and cut it
		adaptor(Base_diameter+Wall_thickness*2-Delta, Taper_height, straight_height, Top_diameter+Wall_thickness*2-Delta, Wall_thickness, lip_height, 0);
		intersection() 
			cylinder(h=Total_Height, d=max_dia+Wall_thickness*2);
			// little Overlap slice
			translate([0,-Overlap/2,-Delta])
				cube(size=[max_dia/2+Delta, Overlap,Total_Height+Delta*2]);
	}
}

module relief_channel() {
	taper_angle = atan( ((Base_diameter - Top_diameter)/2) / Taper_height);
	taper_length = Taper_height / cos(taper_angle);
	// straight
	translate([Top_diameter/2, 0, Taper_height])
		cylinder(h=straight_height, d=relief_dia);
	// taper
	translate([Base_diameter/2, 0, 0])
	rotate([0, -taper_angle, 0])
	translate([0, 0, -Delta])
		cylinder(h=taper_length+Delta*2, d=relief_dia);
}


module Adaptor(quarter=false) {
	if (quarter) {
		difference() {
			union() {
				intersection() {
					union() {
						adaptor(Base_diameter, Taper_height, straight_height, Top_diameter, Wall_thickness, lip_height, lip_dia);
						flange();
					}
					// cut the quarter
					translate([0,0,-Delta])
					cube(size = [max_dia/2+Delta, max_dia/2+Delta, Total_Height+Delta*2]);
				}
				// overlap pieces
				overlap();
			}
			// the relief channel
			relief_channel();
			// lip removal
			intersection() {
				adaptor(Base_diameter+Wall_thickness*2, Taper_height+Delta*2, straight_height, Top_diameter+Wall_thickness*2, Wall_thickness, lip_height, 0);
				// little Overlap slice
				translate([-Overlap/2,0,Taper_height-Delta])
					cube(size=[Overlap, max_dia/2+Delta, straight_height+Delta*2]);
			}
			// lip_relief
			rotate([0,0,-atan(Overlap/Top_diameter)])
			translate([0, Top_diameter/2, Taper_height+straight_height-lip_height*2]) //Overlap/2
				cylinder(h=lip_height*2, d=relief_dia);
		}
	} else {
		// make as one piece
			adaptor(Base_diameter, Taper_height, straight_height, Top_diameter, Wall_thickness, lip_height, lip_dia);
			flange();
	}
}

//---------------------------------
Adaptor(Quarter_only=="yes");

// demo
// translate([0, Base_diameter/3, 0])
// rotate([0,0,45])
//	Adaptor(true);
