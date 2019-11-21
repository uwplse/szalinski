/* [Ball end dimensions] */
// Outside diameter of ball
Ball_Dia = 50; // [30:60]
// Width of the blades in the ball
Ball_Wid = 6;	// [4:10]
// Thickness of the blades in the ball
Ball_Thk = 2.5;	// [1,1.5,2,2.5,3,3.5,4,4.5,5]

/* [Rod mount details] */
// OD of rod = inside diameter of finial
Rod_Dia =16.6;
// Depth of socket in finial
Rod_Depth = 19;
// Outside diameter of mounting cylinder
Mount_OD = 24;
// Diameter of external rings
Ring_OD = 28;
// Ring width
Ring_Wid = 4;
// Number of rings
Ring_Num = 3;
// Retaining screws - if 2 they are at 90 degrees
Screws = 2;	// [0:2]
// Core diameter of screw = hole size
Screw_Dia = 2.5;

/* [Quality] */
// Used for ball end circles
Ball_fn = 60;	// [6:200]
// Default facets used for other features
Facets = 40;	// [6:100]

/* [Hidden] */
Ball_Cir = Ball_Dia/2-Ball_Thk;
$fn = Facets;

{
	union() {
		
		//Socket
		difference() {
			cylinder(d=Mount_OD,h=Rod_Depth+10);
			translate([0,0,-1]) cylinder(d=Rod_Dia,h=Rod_Depth+1);
			translate([0,0,Rod_Depth-0.01]) cylinder(d1=Rod_Dia,d2=0,h=Rod_Dia/2);

			// Optional retaining screw
			if (Ring_Num<=3) {
				if (Screws>=1) translate([0,-20,(Rod_Depth+10)*0.5/Ring_Num+Ring_Wid/2]) rotate([270,0,0]) cylinder(d=Screw_Dia,h=20);
				if (Screws==2) translate([20,0,(Rod_Depth+10)*0.5/Ring_Num+Ring_Wid/2]) rotate([0,270,0]) cylinder(d=Screw_Dia,h=20);
				}
			else {
				if (Screws>=1) translate([0,-20,(Rod_Depth+10)*1.5/Ring_Num+Ring_Wid/2]) rotate([270,0,0]) cylinder(d=Screw_Dia,h=20);
				if (Screws==2) translate([20,0,(Rod_Depth+10)*1.5/Ring_Num+Ring_Wid/2]) rotate([0,270,0]) cylinder(d=Screw_Dia,h=20);
			}
		}

		// Rings on mounting cylinder
		for (i=[0:Ring_Num-1]) {
			translate([0,0,(Rod_Depth+10)*i/Ring_Num+Ring_Wid/2]) rotate_extrude() translate([Mount_OD/2,0,0]) circle(d=Ring_Wid);
		}

		// Ball
		translate([0,0,Rod_Depth+(Ball_Dia/2)+8]) {
			for (i=[0:45:135]) rotate([90,0,i]) difference() {
				translate([0,0,-Ball_Wid/2]) cylinder(d=Ball_Dia,h=Ball_Wid,$fn=Ball_fn);
				translate([0,0,-Ball_Wid/2-1]) cylinder(d=Ball_Dia-2*Ball_Thk,h=Ball_Wid+2,$fn=Ball_fn);
			}
		}
	}
}