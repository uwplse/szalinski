bed_thick=3.2;				//thickness of bed plate to clamp glass onto
glass_thick=2.25;		//thickness of glass plate to be clamped
width=5;					//how wide the clip will be
clip_thick=4;				//thickness of the clip bars
depth=5;					//how deep the clip will go onto the glass
nub=.25;					//how much the nubs should be smaller than the bed-glass combo for a tight fit


union(){
	difference(){
		cube([bed_thick+glass_thick+2*clip_thick,depth+clip_thick,width]);
		translate([clip_thick,clip_thick,-0.1])
			cube([bed_thick+glass_thick,depth+0.1,width+0.2]);
		difference(){
			translate([-0.1,-0.1,-0.1])
				cube([bed_thick+glass_thick+2*clip_thick+0.2,clip_thick+0.2,width+0.2]);
			translate([clip_thick,clip_thick,0])
				cylinder(h=width,r=clip_thick);
			translate([clip_thick+glass_thick+bed_thick,clip_thick,0])
				cylinder(h=width,r=clip_thick);
			translate([clip_thick,0,-0.1])
				cube([glass_thick+bed_thick,clip_thick,width+0.2]);
		}
	}
	difference(){
		translate([0,clip_thick+depth,0])
			cylinder(h=width,r=clip_thick+nub);
		translate([-clip_thick-nub,0,-0.1])
			cube([clip_thick+nub,100,width+0.2]);
	}
	difference(){
		translate([bed_thick+glass_thick+2*clip_thick,clip_thick+depth,0])
			cylinder(h=width,r=clip_thick+nub);
		translate([bed_thick+glass_thick+2*clip_thick,0,-0.1])
			cube([clip_thick+nub,100,width+0.2]);
	}

}