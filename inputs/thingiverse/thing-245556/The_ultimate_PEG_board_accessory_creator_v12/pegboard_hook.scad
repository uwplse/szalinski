/* [Peg Type] */
// Type of peg item:
peg_item = "U"; // [L:L shape Hook, R:Round hook, B:Supported Round hook, U:U hook]

// If U shape how big the is the end upright arm in relation to arm, Default 25%:
end_arm_percentage = 25; // [1:100]

// Length of hook from peg board, default 20:
peg_length = 20; // [20:80]

// Add shelf support for L,U or supported Hook, adds an extra peg and support arm
add_shelf_support = "N"; // [N: No, Y: Yes]

// Hook width in relation to hole size, less percentage thinner hook, default 100%:
hook_width_percentage = 100; // [50:150]

/* [Hidden] */
// An offset value used to nudge some parts, shouldn't need to be changed
magic_offset=10;

/* [Peg board] */
// size in mm the peg holes are, default 7mm: 
hole_size = 7; // [1:10]

// Backing material Tolerance, 10 for softest, 0 for harder, default 5: 
tolerance = 5; // [0:10]

// Thinkness of the peg board backing, default 6mm (1/4 inch):
backing_board = 6; // [1:20]

// The space middle to middle of each hole on the backing board, default 25mm (1 inch):
peg_offset = 25; // [20:40]


sphere_size=hole_size*(1+(tolerance*.006));
cylinder_radius=(hole_size-.5)/2;
object_width=7*(hook_width_percentage/100)+(tolerance/10);
object_clipping=object_width/2+1;
cylinder_height=backing_board-.5-(tolerance/5);
end_peg_length=max((1.6*magic_offset+peg_offset)*(end_arm_percentage/100),object_width);
hook_width=(hook_width_percentage/100)*6;



module fit_peg()
{
    union() {
        translate ([0,0,-backing_board+4]) 
            sphere(sphere_size/2, $fn=100);
        translate ([0,0,-backing_board+4]) 
            cylinder(h = backing_board+1, r = cylinder_radius,$fn=100);
    }
}

module back_arm() {

    if ( peg_item == "R" ) { 
        translate ([-peg_offset/2,0,(object_width-.5)+1]) 
            cube( size= [magic_offset+peg_offset,hook_width,hook_width], center=true); 
    } else { 
        translate ([-peg_offset/2-1,0,(object_width-.5)+1]) 
            cube( size= [magic_offset+peg_offset,hook_width,hook_width], center=true); 
    }
}

module arm() {
	if ( add_shelf_support == "Y") {
		translate ([-2*peg_offset+4.5,0,peg_length/2+magic_offset]) 
    		    cube( size= [hook_width,hook_width,peg_length], center=true);
	} else {
    		translate ([-peg_offset-1.5*hook_width,0,peg_length/2+5]) 
        		cube( size= [hook_width,hook_width,peg_length], center=true);
	}
}

module end_arm() {
	if ( add_shelf_support == "Y") {
    		translate ([-2*peg_offset+magic_offset,0,peg_length+7]) 
        		cube( size= [end_peg_length,hook_width,hook_width], center=true);
	} else {
    		translate ([-peg_offset-2*hook_width+(end_peg_length/2),0,peg_length+5]) 
        		cube( size= [end_peg_length,hook_width,hook_width], center=true);
	}
}


module hook() {
	if ( add_shelf_support == "Y") {
    		difference() {
        		translate ([-2*peg_offset+2*magic_offset,cylinder_radius-.25,peg_length]) {
            		rotate(a=[90,90,0]) {
                		rotate_extrude(convexity = 10, $fn = 100)
                		translate([6+cylinder_radius, 0, 0])
                		square(size=hook_width, $fn = 100);
            		}
        		}
        		translate ([-2*peg_offset+2*magic_offset,-(magic_offset+1)/2,-1]) cube( size= [80,80,80], center=false);
    		}
	} else {
		difference() {
        		translate ([-peg_offset+5,cylinder_radius-.25,peg_length]) {
           		rotate(a=[90,90,0]) {
                		rotate_extrude(convexity = 10, $fn = 100)
             	   	translate([6+cylinder_radius, 0, 0])
        		        square(size=hook_width, $fn = 100);
    		        }
	        }
        		translate ([-peg_offset+5,-(magic_offset+1)/2,-1]) cube( size= [80,80,80], center=false);
    		}
	}
}

module brace_arm() {
    translate ([-2*peg_offset,0,0]) fit_peg();
    translate ([-1.7*peg_offset,0,(object_width-.5)+1]) cube( size= [peg_offset,hook_width,hook_width], center=true);
    translate ([-2.2*peg_offset,-hook_width/2,1.5*hook_width])  {
        rotate([0,atan(7.5/peg_length),0]) cube( size= [hook_width/1.5,hook_width,peg_length], center=false);
    }
}

module brace() {
    difference() {
        brace_arm();
        translate ([-2+hook_width,0,peg_length/2+5]) 
            cube( size= [hook_width,hook_width+2,peg_length], center=true);
    }
}

rotate(a=[90,0,0]) {
    difference() {
        union() {
            translate ([-peg_offset,0,0]) 
                fit_peg();
            translate ([0,0,0]) 
                fit_peg();
            if ( add_shelf_support == "Y" && peg_item != "R") { 
                brace(); 
            }
            back_arm();
            if ( peg_item == "L" || peg_item == "B" || peg_item == "U" ) { 
                arm(); 
            }
            if ( peg_item == "R" || peg_item == "B") { 
                hook(); 
            }
            if ( peg_item == "U" ) { 
                end_arm(); 
            }

        }
        translate ([0,-object_clipping,0]) 
            cube( size= [190,3,190], center=true); // clipping plane
        translate ([0,object_clipping,0]) 
            cube( size= [190,3,190], center=true); // clipping plane
    }
}

