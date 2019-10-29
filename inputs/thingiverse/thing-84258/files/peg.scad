
/* [Peg Type] */
// Type of peg item:
peg_item = "U"; // [L:L shape Hook,R:Round hook,B:Supported Round hook,U:U hook]

// If U shape how big the is the end upright arm in relation to arm, Default 25%:
end_arm_percentage=25; // [10:100]

// Length of hook from peg board, default 20:
peg_length = 20; // [20:80]

// Add shelf support for L,U or supported Hook, adds an extra peg and support arm
add_shelf_support = "N"; // [N: No,Y: Yes]

// Hook width in relation to hole size, less percentage thinner hook, default 100%:
hook_width_percentage=100; // [60:100]

/* [Peg board] */
// size in mm the peg holes are, default 7mm: 
hole_size = 7; // [1:10]

// Backing material Tolerance, 10 for softest , 0 for harder, default 5: 
tolerance = 5; // [1:10]

// Thinkness of the peg board backing, default 6mm ( 1/4 ):
backing_board = 6; // [1:20]

// The space middle to middle of each hole on the backing board, default 25mm (1inch):
peg_offset = 25; // [20:40]


sphere_size=hole_size*(1+(tolerance*.006));
cylinder_radius=(hole_size-.5)/2;
object_width=hole_size*(hook_width_percentage/100)+(tolerance/10);
object_clipping=object_width/2+1;
cylinder_height=back_board-.5-(tolerance/5);
end_peg_length=peg_length*(end_arm_percentage/100);
hook_width=hole_size*(hook_width_percentage/100)-.5;

module fit_peg()
{
union() {
sphere(3.6, $fn=50);
translate ([0,0,-1]) cylinder(h = backing_board+.5, r1 = cylinder_radius, r2 = cylinder_radius,$fn=50);
}

}
module back_arm() {

if ( peg_item == "R" ) { translate ([13.75,0,(object_width-.5)+1]) cube( size= [28.75,hook_width,hook_width], center=true); } else { translate ([5,0,(object_width-.5)+1]) cube( size= [48,hook_width,hook_width], center=true); }
}

module arm() {
translate ([-15.75,0,peg_length/2+5]) cube( size= [hook_width,hook_width,peg_length], center=true);
}

module end_arm() {
translate ([-15.75+(end_peg_length/2),0,peg_length+5]) cube( size= [end_peg_length+hook_width,hook_width,hook_width], center=true);
}
module hook() {
difference() {
	translate ([0,cylinder_radius,13.5+(object_width-.5)]) {
		rotate(a=[90,90,0]) {
			rotate_extrude(convexity = 10, $fn = 50)
			translate([6+cylinder_radius, 0, 0])
			square(size=hook_width, $fn = 50);
		}
	}

translate ([0,-12.5,0]) cube( size= [80,80,80], center=false);
}
}

module brace_arm() {
	translate ([25-peg_offset-peg_offset,0,0]) fit_peg();
	translate ([-24,0,(object_width-.5)+1]) cube( size= [12,hook_width,hook_width], center=true);
	translate ([-peg_offset*1.125,-hook_width/2,hook_width])  {
	rotate([0,33-peg_length/3,0]) cube( size= [hook_width,hook_width,peg_length], center=false);
	}

}

module brace() {
difference() {
brace_arm();
translate ([-15.75+hook_width,0,peg_length/2+5]) cube( size= [hook_width,hook_width+2,peg_length], center=true);
}
}

rotate(a=[90,0,0]) {
difference() {
union() {
translate ([25-peg_offset,0,0])fit_peg();
translate ([25,0,0]) fit_peg();
if ( add_shelf_support == "Y" && peg_item != "R") { brace(); }
back_arm();
if ( peg_item == "L" || peg_item == "B" || peg_item == "U" ) { arm(); }
if ( peg_item == "R" || peg_item == "B") { hook(); }
if ( peg_item == "U" ) { end_arm(); }

}
translate ([0,-object_clipping,0]) cube( size= [190,3,190], center=true); // clipping plane
translate ([0,object_clipping,0]) cube( size= [190,3,190], center=true); // clipping plane
}
}