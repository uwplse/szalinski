// Author: GrAndAG
// Version: 2.2

// preview[view:north west, tilt:top diagonal]
/* [Parameters] */

// Length of holder (mm)
length = 7;
// Diameter of holder
diameter = 4;  //  [2:30]
// Thickness of holder wall (mm) [not affects mount legs]
thickness = 1.2;  // [0.6:0.2:3.6]
// Make or not the gap in circle
gap = 1;  // [1:Yes, 0:No]
// Gap size [not accurate)
gap_size = 3.5;  // [1:0.5:25]
// Direction of the gap (0: Bottom, 90: Side, 180: Top)
gap_angle = 0; // [0:5:180]

/* [Misc] */

// Increase this value if clip is too tight. Or decrease - if it too loose.
reduce = 0.3;
// Show 2020 extrusion for referrence
show_2020_extrusion = 0; // [0:No, 1:Yes]

/* [Hidden] */
eps = 0.05;
$fn=128;

module rounded_rect(size = [1, 1, 1], r = 1, center = false) {
	translate(center ? [0, 0, 0] : (size / 2))
	hull() {
		for (x = [-size[0] / 2 + r, size[0] / 2 - r])
			for (y = [-size[1] / 2 + r, size[1] / 2 - r])
				translate([x, y, 0])
					cylinder(r = r, h = size[2], center = true);
	}
}

module pie(r=3, a=30, h=1) {
	angle = a % 360;
   linear_extrude(height=h) intersection() {
        if (angle == 0 && a != 0) {
            circle(r=r);
        } else if (angle>0 && angle<=90) {
            intersection() {
                circle(r=r);
                square(r);
                rotate(angle-90) square(r);
            }
        } else if (angle>90 && angle<=180) {
            intersection() {
                circle(r=r);
                union() {
                    square(r);
                    rotate(angle-90) square(r);
                }
            }
        } else if (angle>180 && angle<=270) {
            intersection() {
                circle(r=r);
                union() {
                    square(r);
                    rotate(90) square(r);
                    rotate(angle-90) square(r);
                }
            }
        } else if (angle>270 && angle<=360) {
            intersection() {
                circle(r=r);
                union() {
                    square(r);
                    rotate(90) square(r);
                    rotate(180) square(r);
                    rotate(angle-90) square(r);
                }
            }
        }
    }
}


module frame2020(length=100) {
    module gap() {
        module half_gap() {
            linear_extrude(height = length+eps)
                polygon(points=[[-eps,0.62-eps],[2-0.3,2.75-0.55],[2.5,2.75-0.55],[2.5,0], [3.5,0], [6.2, 2.7], [6.2, 5.3+eps], [-eps, 5.3+eps]], 
                        paths=[[0,1,2,3,4,5,6,7]]);
        }
        translate([-10,-5.3,-eps/2]) union() {
            half_gap();
            translate([0,10.6,0]) mirror([0,1,0])
            half_gap();
        }
    }
    
    difference() {
        translate([-10,-10,0]) rounded_rect([20, 20, length], r=1.5);
        for(angle=[0:90:270]) {
            rotate([0,0, angle]) gap();
        }
        cylinder(d=5, h=length+eps);
    }
    *%translate([-3.1, -8.8, 0])
        #cube([6.2,1,10]);
}

module clip() {
    gap_size_tmp = (gap_size > (diameter-thickness/2)) ? (diameter-thickness/2) : gap_size;

    w = 8.5;
    
    t_w = 3.7;
    t_l = 7.4;
    t_h = 2.5;
    t_w2 = t_w/sqrt(2);
    t_l2 = t_l/sqrt(2);
    leg_gap = 2.8+1.46; //1.451
    gap_angle_updated = (gap == 0) ? 0 : gap_angle;
    gap_size_updated = (gap == 0) 
               ? (diameter > 5) 
                 ? 2.5 
                 : diameter-2.5 
               : (gap_angle == 0 && gap_size_tmp > 3.5) 
                 ? 3.5 
                 : gap_size_tmp;
    gap_size_updated2 = (gap_angle != 0) 
                        ? (diameter > 5) 
                          ? 2.5 
                          : diameter-2.5 
                        : gap_size_updated;
    ang = asin((gap_size_updated/2)/(diameter/2))*2;
    ang2 = asin((gap_size_updated2/2)/(diameter/2))*2;
    //gap_angle_updated = (gap_angle <= 48) ? 48+ang/2 : gap_angle;
    circle_offset = -diameter/2-thickness+(diameter/2-diameter/2*cos(ang2/2)+(thickness-thickness*cos(ang2/2)));
    
    difference() {
        sp = 7.2;
        sp_d = 1;
        addon = (gap && gap_angle == 0) ? -0.6 : -1.5;
        union() {
            difference() {
                union() {
                    translate([-w/2, -thickness, 0])
                        cube([w, thickness, length]);
                    translate([-(sp)/2, 0, 0])
                        cube([sp, 1.8, length]);
                    translate([-(sp+sp_d)/2, 0, 0])
                        cube([sp+sp_d, sp_d/2, length]);
                    translate([-(7.2-reduce+addon)/2, 1.8, 0])
                        cube([7.2-reduce+addon, 1.8, length]);
                    translate([-(7.2-reduce+addon+1.4)/2, 1.8+1.2/2, 0])
                        cube([7.2-reduce+addon+1.4, 1.2/2, length]);
                    translate([-(7.2-reduce+addon)/2, 1.8+1.6/2+0.3, 0])
                        cylinder(d=1.4, h=length);
                    translate([+(7.2-reduce+addon)/2, 1.8+1.6/2+0.3, 0])
                        cylinder(d=1.4, h=length);
                    translate([-(sp+sp_d)/2, 1.5, 0])
                        cube([sp+sp_d, 1, length]);
                }
                translate([0,circle_offset,-eps/2])
                    rotate([0,0,90-ang/2]) {
                        cylinder(d=diameter, h=length+eps);
                        if (gap && gap_angle_updated==0)
                            pie(r=diameter/2+thickness+eps/2, h=length+eps, a=ang);
                    }
                
                // legs gap
                translate([-leg_gap/2, t_h-0.3-eps/2, -eps/2])
                    cube([leg_gap, 1.4+eps, length+eps]);
                translate([0, 0, length/2])
                    resize([t_l2, 2.2, length+eps])
                    rotate([-90,0,0]) {
                        intersection() {
                            rotate([0,0,45])
                                cylinder(d1=t_l, d2=t_w, h=t_h, $fn=4);
                            translate([-t_l2/2,-t_w2/2,0])
                                cube([t_l2, t_w2, t_h]);
                        }
                        translate([-t_w2/2,-t_w2/2,t_h])
                            cube([t_w2, t_w2, eps/2]);
                    }
                /*
                translate([-2.5+0.4-addon/2,7.2/2,0]) 
                    rotate([0,0,49])
                    translate([-5/2,0,-eps/2]) 
                    cube([2, 1, length+eps]);
                mirror([1,0,0])
                    translate([-2.5+0.4-addon/2,7.2/2,0])
                    rotate([0,0,49])
                    translate([-5/2,0,-eps/2]) 
                    cube([2, 1, length+eps]);
                */
            }
            // legs inner rounds
            translate([-leg_gap/2,2.65,0]) 
                cylinder(d=1.9, h=length);
            translate([leg_gap/2,2.65,0]) 
                cylinder(d=1.9, h=length);
        
            t_delta = 1.872;
            difference() {
                translate([(t_l)/2-t_delta,0,0]) 
                    cube([1.5,0.823, length]);
                translate([(t_l)/2-t_delta,1/2,-eps/2]) 
                    cylinder(d=1, h=length+eps);
            }
            difference() {
                translate([(-t_l)/2+t_delta-1.5,0,0]) 
                    cube([1.5,0.823, length]);
                translate([(-t_l)/2+t_delta,1/2,-eps/2]) 
                    cylinder(d=1, h=length+eps);
            }
            
            // circle
            translate([0,circle_offset,0])
            rotate([0,0,90-ang/2+gap_angle_updated])
            union() {
                difference() {
                    cylinder(d=diameter+thickness*2, h=length);
                    translate([0,0,-eps/2]) {
                        cylinder(d=diameter, h=length+eps);
                        if (gap)
                            pie(r=diameter/2+thickness+eps, h=length+eps, a=ang);
                    }
                }
                if (gap) {
                    translate([(diameter+thickness)/2,0,0])
                        cylinder(d=thickness, h=length);
                    rotate([0,0,ang])
                        translate([(diameter+thickness)/2,0,0])
                            cylinder(d=thickness, h=length);
                }
            }
        }
        // frame cut
        *translate([0,10,-eps/2])
            resize([20-reduce])
            frame2020(length+eps);
        for(x=[0:1])
            mirror([x,0,0]) 
                hull() {
                    translate([(sp+sp_d)/2, sp_d/2, -eps/2])
                        cylinder(d=sp_d, h=length+eps);
                    translate([(sp+sp_d-2-reduce)/2, 1.5, -eps/2])
                        cube([2, 1, length+eps]);
                    *translate([(6.2-0.2)/2+0.3, 1.5+1/2, -eps/2])
                        cylinder(d=1, h=length+eps);
                }
    }
    
}

if (show_2020_extrusion) {
    %translate([0,10,-3]) 
//        resize() 
            frame2020(length+6);
}

//resize() 
clip();



