

/**
* based on http://deskthority.net/w/images/c/c8/Cherry_MX_1%C3%971_keycap_specification_%281983%29.pdf
*/

// preview[view:north east, tilt:top diagonal]

//Is there a cap ontop of the mount?
Cap_Enabled = "yes"; // [yes, no]
//Is there a mount for a cherry mx compatible key?
Mx_Mount_Enabled = "yes"; // [yes, no]
//Is there a homing bump?
Homing_Enabled = "no"; // [yes, no]
//What homing type is it?
Homing_Type = "dot"; // [dot, round]
//What size should the homing bump be?
Homing_Size = 1.2;

if (Homing_Type == "dot") {
    Homing_Size = 1.2;
} else {
    Homing_Size = 3;
}

if (Cap_Enabled == "yes") {
   cap(); 
}
if (Mx_Mount_Enabled == "yes") {
    mxMount();
}
if (Homing_Enabled == "yes") {
    if (Homing_Type == "dot") {
       homing("dot", Homing_Size, $fn=60);
    }
    if (Homing_Type == "Round") {
        homing("round", Homing_Size);
    }
}

/** a simple plane where to develop the keycap on top of
* NOTE: the depth of 0.95mm... it shouldn't matter because you should build
* your keycap on top of it. If not expanding the geometry with more plastic
* there, but instead using as a base for a wooden keycap cup or some
* other crazy idea, use the minimum your material/printer
* will be comfortable with
*/
module cap(){
    union()
    {
	translate([0,0, -0.9/2])
		cylinder(0.9, 12.2, 12.2, center=true, $fn=360);
    difference() {
        translate([0,0, 0.45])
            cylinder(0.9, 12.2, 11, center=true, $fn=360);
        translate([0,0, 0.9])
            cylinder(0.9, r = 10, center = true, $fn=360);
    }
    difference() {
        translate([0,0, 0.45]) {
            cube(size=[1.17,20,0.9], center=true);
            cube(size=[20,1.17,0.9], center=true);
        }
        translate([0,0,0.45])
            cylinder(h=1.17, r=5.6/2, center=true, $fn=360 );
    }
    translate([0,0, -2.7])
        rcylinder(r=12.2,h=2.7,n=0.6,$fn=360);
    }
}

module homing(type, size) {
    translate([0,0, -2.9]) {
        if (type=="dot"){
            translate([0,0, size/2])
                sphere(size,center = true);
        }
        if (type=="round") {
            rcylinder(r=size,h=2.7,n=0.6,$fn=360);
        }
    }
}

/**
* The female part of the steam.
* NOTE: i'm not 100% sure on the height, as the drawing I found does not have
* it measured... and i can't infer it with full confidence when
* just accounting for the other measurements. the drawing os probably more
* concerned with the keycap per se.
*/
module mxMount(){
	mx_height = 5.1;
	translate( [0,0,mx_height/2] ){
		difference(){
			cylinder( h=mx_height, r=5.6/2, center=true, $fn=360 );
				cube( size=[1.17,4.1,mx_height+2], center=true );
				cube( size=[4.1,1.17,mx_height+2], center=true );
		}
	}
}

// r[adius], h[eight], [rou]n[d]
module rcylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}
