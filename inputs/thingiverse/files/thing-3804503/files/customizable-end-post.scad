$fn=64;

// (mm)
clamp_inner_diameter = 3;
// (mm)
clamp_outer_diameter = 6;
// (mm)
clamp_length = 6;
// (mm)
height = 21;

// Rounded cylinder from https://www.thingiverse.com/thing:244678
// Same parameters and position as built-in 3D cylinder.
// Additional f parameter to specify rounded edges.
// f defaults to 0, a normal cylinder
module rcylinder(r=1, r1=0, r2=0, h=1, f=0) {
	if(f==0) {
		if(r1==0) {
			cylinder(r=r,h=h);
		}
		else {
			cylinder(r1=r1,r2=r2,h=h);
		}
	}
	else {
		for(
			v=acos(h/(sqrt( h*h + (r1-r2)*(r1-r2) )))
		) {
			for(
				byo=sin(v)*f,
				bxo=cos(v)*f
			) {
				union() {
					translate([0,0,0])
						cylinder(r=(r1==0?r-f:r1-f),h=f*2);
					translate([0,0,h-2*f])
						cylinder(r=(r2==0?r-f:r2-f),h=f*2);
					translate([0,0,f+byo])
						cylinder(r1=(r1==0?r:r1-f+bxo),r2=(r2==0?r:r2-f+bxo),h=h-2*f);
					translate([0,0,h-f])
						rotate_extrude()
							translate([(r2==0?r-f:r2-f),0,0])
								circle(r=f);
					translate([0,0,f])
						rotate_extrude()
							translate([(r1==0?r-f:r1-f),0,0])
								circle(r=f);
				}
			}
		}
	}
}

// bottom ball
difference() {
    translate([0,0,3]) sphere(4.1);
    translate([0,0,-1]) cube([8,8,2],center=true);
}

// shaft
translate([0,0,0]) cylinder(height-clamp_length,2,2); 

// aligator clamp holder
difference() {
    translate([0,0,height-clamp_length]) rcylinder(clamp_outer_diameter/2, 0, 0, clamp_length,1);
    translate([0,0,height-clamp_length+1]) cylinder(clamp_length,clamp_inner_diameter/2, clamp_inner_diameter/2);
}