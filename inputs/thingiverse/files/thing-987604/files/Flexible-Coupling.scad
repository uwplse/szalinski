// Flexible Coupling with ideas taken from
// - Gyrobot - http://www.thingiverse.com/thing:38678
// - MarcoAlici - http://www.thingiverse.com/thing:44078

// Features:
// - top and bottom independent hole diameters
// - smooth exterior spirals for coupling
// - hex or square captive nuts
// - recessed bolts
// - optimisations for no support printing
// - D shafts optional

// Customizer
// preview[view:south west, tilt:top diagonal]


/* [Base Dimensions] */
// Outer diameter of Coupling
Outer_diameter = 22;
// Total height of coupling.
Total_height = 30;
// Height of each end block
Base_height  = 8;
// Number of flexible spirals in core.
Num_spiral = 7;
// Twistyness of the Spirals(degrees). The longer and thinner the spiral arms are -  the springier the resulting coupling will be.
Spiral_degree = 90;

/* [Upper Shaft] */
// Diameter of hole at top of coupling
Upper_shaft_dia = 8;
// Does the upper shaft have a D shape
Upper_D  = "yes"; // [yes,no]
// Width from face of D to back of shaft
Upper_shaft_D_depth = 7.5;
// Diameter of hole at top of coupling

/* [Lower Shaft] */
Lower_shaft_dia = 5;
// Does the lower shaft have a D shape
Lower_D  = "yes"; // [yes,no]
// Width from face of D to back of shaft
Lower_shaft_D_depth = 4.5;

/* [Fixings] */
// Diameter of the locking bolts (top and bottom)
Bolt_diameter = 3.1;
// Type of captive Nut. Hex or square(slot shape)
Nut_type = "hex"; // [hex, square]
// Width of the captive Nut (gripping the locking bolt)
Nut_diameter  = 6.6;
// Thickness of Nut
Nut_thickness  = 2.6;
// Tweak to radial position of Nut slots. (Maximize space between slot and outer surface).
Nut_position_tweak  = 1; //[-3:0.5:3]

/* [Details] */
// Bolt head recess. (If enough room)
Bolt_recess = 1.5;
// Simplify printing by making bolt hole hex shape.(no support)
Simplify_printing = "no"; // [yes,no]
// Show cutaway for clarity
Show_Cross_section = "no"; //[yes, no]


/* [Hidden] */
Delta = 0.1;				// Adj for geometry overlaps so F6 works well.
Resolution = 80;			// for cylinders
Max_hole = max(Upper_shaft_dia, Lower_shaft_dia);
Upper_shaft_D_offset = (Upper_D == "yes") ? Upper_shaft_D_depth - Upper_shaft_dia/2 : 0;
Lower_shaft_D_offset = (Lower_D == "yes") ? Lower_shaft_D_depth - Lower_shaft_dia/2 : 0;

//---------------------------
// The Spring Coupling
module square_spring(inner_R, outer_R, height, angle, numspirals) {
	num_slices = round((50*height/Resolution + 20*Spiral_degree/height)/3);
	//echo(num_slices, 50*height/Resolution, 20*Spiral_degree/height);
	intersection(){
		translate([0,0,-Delta])
			cylinder (d=Outer_diameter, h=height+2*Delta, center=false, $fn=Resolution);
		// spiral
		ext = Outer_diameter*0.5 / Num_spiral;
		linear_extrude(height=height, center=false, convexity=1, twist=angle, slices=num_slices)
			polygon([[inner_R, 0],
					 [outer_R+ext, 0],
					 [outer_R*cos(180/numspirals)+ext, outer_R*sin(180/numspirals)],
					 [inner_R*cos(180/numspirals),     inner_R*sin(180/numspirals)]
					]);
	}
}

// The grub screw holes and slots
module screw_hole(dia, res=Resolution) {
	pos = dia/2;
	offset = (pos + Max_hole/2)/2;
	// hex or square captive nut
	nut_res = (Nut_type == "hex") ? 6 : 4;
	nut_rotate = (Nut_type == "hex") ? 0 : 45;
	slot_size = (Nut_type == "hex") ? cos(30) : cos(45);
	rotate([0,90,0]) {
		// bolt hole (grub screw)
		translate ([-Base_height/2,0,offset])
			cylinder(d=Bolt_diameter, h=pos*1.2,center=true, $fn=res);
		// Bolt head recess (if room)
		translate ([-Base_height/2,0,Outer_diameter/2-Bolt_recess/2+Delta])
			cylinder(d=Bolt_diameter*2, h=Bolt_recess+Delta*2,center=true, $fn=res);
		// Hex Nut Recess
		translate([-Base_height/2-Delta, 0, offset-Nut_position_tweak]) 
		rotate([0,0,nut_rotate])
			cylinder(d=Nut_diameter, h=Nut_thickness, center=true, $fn=nut_res); // hex nut
		// Slot for Nut entry
		translate([0,0,offset-Nut_position_tweak])
			cube(size=[Base_height, Nut_diameter*slot_size, Nut_thickness], center=true);
	}
}

module end(dia, hole_dia, D_flat_pos, res=Resolution) {
	difference() {
		union() {
			difference(){
				cylinder (d=dia, h=Base_height, center=false, $fn=res); // main cyl
				// remove central hole
				translate([0,0,-Delta])
					cylinder(d=hole_dia, h=Base_height+2*Delta, center=false, $fn=res);
			}
			// "D" flat-face on shaft
			if (D_flat_pos != 0) {
				translate([D_flat_pos,-hole_dia/2,0])
					cube(size=[hole_dia/2, hole_dia, Base_height], center=false);
			}
		}
		// subtract screw hole and slot
		boltres = (Simplify_printing == "yes") ? 6 : res;
		screw_hole(dia, boltres);
	}
}


//--------------------------
// The Coupling
difference() {
	union() {
		// top block
		end(Outer_diameter, Lower_shaft_dia, Lower_shaft_D_offset);
		// bottom block (flipped over)
		translate([0,0,Total_height]) 
		rotate([0,180,0]) 
			end(Outer_diameter, Upper_shaft_dia, Upper_shaft_D_offset);
		// Spring
		spring_height = Total_height - 2*Base_height;
		for (i=[1:Num_spiral])  {
			rotate([0,0,360*i/Num_spiral]) 
			translate ([0,0,Base_height-Delta]) 
				square_spring(Max_hole/2, Outer_diameter/2, spring_height+2*Delta, Spiral_degree, Num_spiral);
		}
	}
	//
	if (Show_Cross_section == "yes") {
		dim = max(Outer_diameter, Total_height);
		rotate([0,0,-90])
		translate([0, -dim/2, -Delta])
			cube(size=dim+2*Delta);
	}
}
