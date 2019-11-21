// This thing allows you to create corners, tees, crosses, 
// and splices for fixing up your window screens.
//
// This is licensed under the creative commons+attribution licence
// To fulfil the attribution requirement, please link to:
//		http://www.thingiverse.com/thing:897599

/* [Main] */

// what shape of screen connector
shape=0; // [0:corner,1:splice,2:tee,3:four way]

// the style of the screen connector
style=1; // [0:mitre,1:straight_end]

// how wide part is in mm
width=13.0;

// measurement from the edge to the corner in mm
depth_to_corner=25.47;

// how thick part is in mm
thickness=7.315;

// The angle of the joint in degrees (only works for corner)
angle=135;

/* [Advanced] */

// This makes it look nicer, but can make printablility more complex
outer_thickness=0;

/* [Hidden] */

module end(bevel,width,depth,thickness){
	translate([0,-width/2,0]) cube([depth-bevel,width,thickness]);
	translate([depth-bevel/2,0,thickness/2]) rotate([0,-90,0]) frustum(thickness,width,thickness-bevel*2,width-bevel*2,bevel);
}

module old_mitre_style(){
	outside_corner_r=width/6;
	inside_corner_r=width/18;
	bevel=thickness/3;
	translate([0,0,-thickness/2]) linear_extrude(thickness) {
		difference(){
			union(){
				translate([0,bevel-depth_to_corner,0]) square([width,depth_to_corner-bevel]);
				rotate([0,0,90]) square([width,depth_to_corner-bevel]);
				translate([width-outside_corner_r,width-outside_corner_r,0]) circle(r=outside_corner_r,$fn=20);
				square([width-outside_corner_r,width]);
				square([width,width-outside_corner_r]);
			}
			circle(r=inside_corner_r,$fn=20);
		}
	}
	translate([bevel/2-depth_to_corner,width/2,0]) rotate([0,90,0]) frustum(thickness,width,thickness-bevel*2,width-bevel*2,bevel);
	translate([width/2,bevel/2-depth_to_corner,0]) rotate([0,0,90]) rotate([0,90,0]) frustum(thickness,width,thickness-bevel*2,width-bevel*2,bevel);
}



module frustum(w,h,w2,h2,d){
	hull(){
		translate([-w/2,-h/2,d/2]) cube([w,h,0.01]);
		translate([-w2/2,-h2/2,-d/2]) cube([w2,h2,0.01]);
	}
}

module reliefs(angle,r=1,$fn=20){
	n=width/2+r/2;
	translate([ n, n,-1]) cylinder(r=r,h=thickness+2);
	translate([-n,-n,-1]) cylinder(r=r,h=thickness+2);
	translate([ n,-n,-1]) cylinder(r=r,h=thickness+2);
	rotate([0,0,angle]) {
		translate([ n, n,-1]) cylinder(r=r,h=thickness+2);
		//translate([-n,-n,-1]) cylinder(r=r,h=thickness+2);
		translate([ n,-n,-1]) cylinder(r=r,h=thickness+2);
	}
}

difference(){
	union(){
		if(shape==0){ //corner
			end(thickness/3,width,depth_to_corner+width,thickness,mitre=style==0);
			rotate([0,0,angle]) end(thickness/3,width,depth_to_corner+width,thickness);
			if(style==0||((angle%90)!=0)){
				cylinder(r=width/2,h=thickness,$fn=20);
			}else{
				translate([-width/2,-width/2,-outer_thickness]) cube([width,width,thickness+2*outer_thickness]);
			}
		}
		if(shape==1){ // straight (only miter style/no connector)
			end(thickness/3,width,depth_to_corner,thickness);
			rotate([0,0,180]) end(thickness/3,width,depth_to_corner,thickness);
		}
		if(shape==2){ // 3-way (always non-miter style)
			end(thickness/3,width,depth_to_corner+width,thickness);
			rotate([0,0,90]) end(thickness/3,width,depth_to_corner+width,thickness);
			rotate([0,0,180]) end(thickness/3,width,depth_to_corner+width,thickness);
			translate([-width/2,-width/2,-(outer_thickness-thickness)/2]) cube([width,width,outer_thickness]);
		}
		if(shape==3){ // 4-way (always non-miter style)
			end(thickness/3,width,depth_to_corner+width,thickness);
			rotate([0,0,90]) end(thickness/3,width,depth_to_corner+width,thickness);
			rotate([0,0,180]) end(thickness/3,width,depth_to_corner+width,thickness);
			rotate([0,0,-90]) end(thickness/3,width,depth_to_corner+width,thickness);
			translate([-width/2,-width/2,-(outer_thickness-thickness)/2]) cube([width,width,outer_thickness]);
		}
	}
	reliefs(angle);
}