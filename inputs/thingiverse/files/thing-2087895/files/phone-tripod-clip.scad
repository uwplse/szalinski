
// -- VARIABLES ---
//height or thickness of the clip/shoe in mm
clip_base = 41;
//inner/upper measurement of the clip/shoe in mm
clip_in = 33;
//height or thickness of the clip/shoe in mm
clip_h = 9;
//width [side of square] of the platform, in mm
plat_w = 50;
//height or thickness of the platform, in mm
plat_h = 12;
//height or length of the slidey posts, in mm
post_h = 105;
//width or thickness of the slidey posts, in mm
post_w = 4;
// "backrest width", mm
br_w = 6;
// "backrest height", mm
br_h = 25;
// "backrest spacing", mm
br_s = 4;
// width of the band (hair tie), in mm
band_w = 4;
//thickness of the phone, in mm (14 should be OK for most phones/cases)
phone_thick = 14;
//make this number larger if the slidey posts are too snug in the slidey post holes
hole_clearance = 0.55;
band_r = band_w/2;
//if you prefer my hard-coded supports to those of your printer software, uncomment the supports section below
support_th = 0.6;

module round_rect(w, l, r){
	translate([-(w-2*r)/2, -(l-2*r)/2, 0])minkowski(){
		square([w-2*r, l-2*r]);
		circle(r, $fn=16);
	}
}

// -- BASE ---
translate([-br_s-post_h, 0, 0])
	union(){
        //backstop
		hull(){
			translate([0, -(plat_w/2+post_w)/2, 0])
				cube([br_h, plat_w/2+post_w, post_w+br_s]);
			translate([-band_w, -plat_w/4-post_w/2, post_w+br_s+br_w-(br_w-band_w)])
				cube([br_h + band_w, plat_w/2+post_w, br_w-band_w]);
		}
		difference(){
			translate([-plat_h, 0, plat_w/2]){
                //clip-shoe
				rotate([0, 270, 0])
					linear_extrude(height=clip_h, scale=[clip_base/clip_in, clip_base/clip_in])
						round_rect(clip_in,clip_in,3);
				rotate([0, 90, 0]){
                    //Base
					linear_extrude(height=plat_h)
						round_rect(plat_w, plat_w, 5);
                    // LIP
                    difference(){
                        translate([plat_w/2-(post_w+br_s+br_w)-(phone_thick+band_w), -plat_w/2, 0])cube([phone_thick+band_w, plat_w, plat_h+band_w]);
                        translate([band_w,-plat_w/2,plat_h])cube([plat_w/3,plat_w/8,band_w*2]);
                        translate([band_w,plat_w/2-plat_w/8,plat_h])cube([plat_w/3,plat_w/8,band_w*2]);
                        hull(){
                            translate([plat_w/2-phone_thick-band_w,-plat_w/2,plat_h+band_w])
                            rotate([-90,0,0])
                            cylinder(r=band_w, h=plat_w, $fn=32);
                            translate([plat_w/2-phone_thick*2+band_w,-plat_w/2,plat_h+band_w])
                            rotate([-90,0,0])
                            cylinder(r=band_w, h=plat_w, $fn=32);
                        }
                    }
                    hull(){
                        translate([plat_w/2-(post_w+br_s+br_w)-(phone_thick+band_w), -plat_w/2, 0])cube([1, plat_w, plat_h+band_w]);
                        translate([-plat_w/2+5,plat_w/2-5,plat_h-1])cylinder(r=5, h=1);
                        translate([-plat_w/2+5,-plat_w/2+5,plat_h-1])cylinder(r=5, h=1);
                    }
				}
			}
			difference(){
				translate([plat_h+1, 0, (phone_thick + br_w + band_r*6)/2 + post_w + br_s])
					rotate([0, 270, 0])
						linear_extrude(height=band_w*2+plat_h)
							round_rect(phone_thick+br_w+band_r*6, plat_w/2+post_w+band_w*3.5, band_r);
				for (i=[-1,1]){
					translate([-band_w*2, i*plat_w*sqrt(2)/2, -plat_w*sqrt(2)/2+(phone_thick + br_w + band_r*6) + post_w + br_s])
						rotate([45, 0, 0])
							cube([band_w*2+plat_h+2, plat_w, plat_w]);
				}
			translate([0, 0, br_s + post_w + br_w])
				hull(){
					translate([-band_w, 0, band_r + phone_thick])
						rotate([0, 90, 0])
							cylinder(h=band_w*3, r=band_r, $fn=12);
						translate([-band_w, -plat_w/4 - post_w/2, 0])
							cube([band_w*3, plat_w/2 + post_w, 0.1]);
				}
			}
		}
        //POST
		for (i=[1,-1]){
			translate([0, -post_w/2 + i*plat_w/4, 0])cube([post_h, post_w, post_w]);
		}
        translate([0,0,post_w])rotate([0,90,0])cylinder(r=post_w, h=post_h, $fn=32);
        difference(){
            translate([0,-plat_w/4,0])cube([post_h, plat_w/2, post_w*0.5]);
            for (i=[1,-1]){
                hull(){
                    translate([post_h-post_w*1.5,i*(plat_w/8+post_w/4),0])cylinder(r=(plat_w/4 - post_w*1.5)/2, h=post_w, $fn=24);
                    translate([br_h+post_w*1.5,i*(plat_w/8+post_w/4),0])cylinder(r=(plat_w/4 - post_w*1.5)/2, h=post_w, $fn=24);
                }
            }
        }
	}



// -- base supports ---
//translate([-plat_h-br_s-post_h-clip_h,0,0]){
//    difference(){
//        translate([0,-21,0])cube([8,40,8]);
//        for (i = [-21:6:21]){
//            translate([0,i,0])cube([clip_h-1-support_th,3-support_th,clip_h-1]);
//            translate([support_th,i-3,0])cube([clip_h-1-support_th,3-support_th,clip_h-1]);
//        }
//        translate([clip_h, 0, plat_w/2 - 0.05])
//        rotate([0, 270, 0])
//        linear_extrude(height=clip_h, scale=[clip_base/clip_in, clip_base/clip_in])
//        round_rect(clip_in,clip_in,3);
//    }
//}


// -- TOP --
difference(){
	union(){
        difference(){
            hull(){
                translate([br_s+(phone_thick+band_r+br_w)/2, 0, 0])
                    linear_extrude(height=br_w)
                        round_rect(phone_thick+band_r+br_w, plat_w/2 + post_w, band_r);
                // ---lip
                translate([br_s, -(plat_w/2 + band_w)/2, br_w+band_w-1])
                    cube([phone_thick+band_r, plat_w/2 + band_w, 1]);
            }
            hull(){
                translate([br_s+phone_thick-band_r,-plat_w/4-band_r,br_w+band_w])rotate([-90,0,0])cylinder(h=plat_w/2+band_w, r=band_w, $fn=24);
                translate([br_s+band_w*1.5,-plat_w/4-band_r,br_w+band_w])rotate([-90,0,0])cylinder(h=plat_w/2+band_w, r=band_w, $fn=24);
            }
        }
        
        //backrest
		translate([br_s + band_r + phone_thick, 0, (br_w+br_h)/2])
			rotate([0, 90, 0])
				linear_extrude(height=br_w)
					round_rect(br_w+br_h, plat_w/2 + post_w, band_r);
        //slothouse
		translate([(br_w*2+br_s*2 + post_w)/2+br_s+band_r+phone_thick, 0, 0])
			linear_extrude(height=br_w+br_h-band_r)
				round_rect(br_s*2 + post_w, plat_w/2 + post_w+band_w, band_r);
	}
    // slide holes
	for (i=[1,-1]){
		translate([br_s*2+band_r+phone_thick+br_w-0.5, -(post_w+1)/2 + i*plat_w/4, -5])
			cube([post_w+hole_clearance, post_w+hole_clearance, post_h]);
	}
    translate([br_s*2+band_r+phone_thick+br_w-0.5+post_w/2, -plat_w/4, -5])cube([post_w/2+hole_clearance,plat_w/2,post_h]);
    translate([br_s*2+band_r+phone_thick+br_w-0.425,0,-5])cylinder(r=post_w+hole_clearance/2, h=post_h, $fn=32);
    
    // Band Slot
	translate([br_s+band_r*2.5+phone_thick, 0, 0])
		rotate([90,0,0])translate([0,band_r/2,-(br_h+br_w)/2])cylinder(r=band_r, h=br_h+br_w, $fn=24);
}