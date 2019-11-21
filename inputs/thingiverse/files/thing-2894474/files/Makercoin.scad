// Maker coin template and customizer.
// Derived from kwm's original script:
// - https://www.thingiverse.com/thing:1897796
// Using the fidget component from enekomontero
// - https://www.thingiverse.com/thing:2883077
// Authors: kwm Nov 2016, enekomontero April 2018, Neon22 May 2018


// A Maker coin design - edit logo module to personalise.

/* [Parameters] */
Coin_diameter   = 40;
// Must be less than half Coin diameter;
Thickness       = 8; 
// Should be less than Thickness
Inner_thickness = 5;  
// Outer ring core (should be less than Thickness)
Internal_torus_diameter = 6;
// Visualisation
Show_Cross_section = false; //[true, false]

/* [Notches] */
Notch_count  = 10;  //[0:20]
Notch_radius = 3;
//Should be less than Notch_radius
Notch_offset = 0;   //[-3:0.5:8]
// Create a separable core (0=None)
Fidget_gap   = 0.4; //[0:0.2:2]

/* [Logo] */
Text_scale   = 0.87;
Label        = "SFW";


/* [Hidden] */
//lots of math to make sure the circles are tangent etc
ring_radius = Thickness/2;
coin_radius = Coin_diameter / 2;
ring_dist = coin_radius-ring_radius;
diff = ring_radius-Inner_thickness;
// dish radius
r2 = (pow(ring_dist,2)-(pow(ring_radius,2)-pow(diff,2)))/((2*ring_radius)+(2*diff));
r2_dist = r2+Inner_thickness;
r3 = Internal_torus_diameter/2;


Delta = 0.1; // to ensure overlaps when we need them - e.g. difference()
cyl_res = 80; // to control roundness


//Use custom work in here:
module logo() {
	linear_extrude(h=$ring_radius*2, convexity = 10)
	scale(Text_scale)
		text(text=Label, valign="center", halign="center");
}




// Main code as series of modules - OpenSCAD is cool
module main_profile() {
// 2D profile to be swept
	difference() {
		// outer rounded blank
		union() {
			// rectangle
			polygon(points=[[0,0],[ring_dist,0],[ring_dist,ring_radius,],[0,r2_dist]]);
			translate([ring_dist,ring_radius,0])
				circle(ring_radius);
		}
		// inner central dish 
		translate([0,r2_dist,0])
			circle(r2+Delta);
	}
}

module main_coin() {
// swept profile is 3D
	rotate_extrude(convexity=2, $fn=cyl_res)
		main_profile();
}

module internal_torus() {
// Ring for support
	rotate_extrude(convexity=2, $fn=cyl_res)
	translate([ring_dist,ring_radius,0]) 
		circle(r3);
}

module notches() {
// Notches round outside
	for (angle=[0:360/Notch_count:359]) {
		rotate([0,0,angle])
		translate([coin_radius+Notch_offset,0,0]) 
			cylinder(r=Notch_radius, h=Thickness, $fn = cyl_res);
	}
}

module fidget_split() {
// splitter for Fidget version
	gap = Thickness/1.5;
	translate([0,0,Thickness/2])
	rotate_extrude(convexity = 2, $fn=cyl_res) 
		translate([coin_radius-Thickness,0,0])
		difference(){
			difference(){
				rotate(90,0,0)
					#circle(gap,$fn=6);
				rotate(90,0,0)
					#circle(gap-Fidget_gap,$fn=6);
			}
			translate([-(gap+1),0,0])
				square(Thickness*1.5,center=true);
		}
}

//now put it all together
module makercoin() {
	difference() {
		union() {
			difference() {
				main_coin();
				translate([0,0,-Delta])
					logo();
			}
			internal_torus();
		}
		notches();
		fidget_split();
	}	
}


// The main attraction
if (Show_Cross_section) {
	difference() {
		makercoin();
		translate([0,-40,-10])
			cube(size=40);
	}
} else {
	makercoin();
}

//
//logo();