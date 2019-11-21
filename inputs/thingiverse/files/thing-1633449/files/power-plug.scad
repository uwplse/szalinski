// preview[view:northeast, tilt:topdiagonal]

/* [Basic] */
// Thickness of walls
t=2.5;
// extra space behind the plug for wires
sock_ex_h=34;   

/* [Advanced] */
sock_w=28;
sock_d=48;
sock_h=21;
// extra faceplate on bottom
sock_ex_b=4.5;
// extra faceplate on top
sock_ex_t=7.5;
sock_fillet=5;

// Overall width
f_w=48+2*t;

/* [Hidden] */
f_d=sock_d+sock_ex_b+sock_ex_t;
f_corner=(f_w-sock_w-2*t)/2;

e=0.01;

power_plug();

module mount_screw() {
  // screw hole
  translate([0,0,-e]) cylinder(2*t+2*e, d=3.5, $fn=16);
  // nut clearout
  translate([0,0,t+e]) rotate(30) cylinder(sock_h+sock_ex_h+2*t+2*e, d=7, $fn=6);
}

module mount_ear() {
  w=f_corner;
  tt=5;
  
  difference() {
    union() {
      cube_fillet([w,tt,sock_h-t], top=[0,2.5]);
      translate([0,-1,(20-9)/2])
        cube_fillet([w+sock_fillet+t,1,9], bottom=[0,0,1], top=[0,0,1]);
    }
    // M5 screw
    translate([w/2,0,20/2]) rotate([-90]) {
      translate([0,0,-1-e]) cylinder(tt+1+2*e, d=5.3, $fn=16);
      // screw cap
      translate([0,0,5]) cylinder(tt-5+2*e, d=9);
    }
  }
}

module power_plug() {
difference() {
  union() {
    // faceplate
    linear_extrude(height=t) polygon([
      [0,sock_ex_b], [sock_ex_b,0], [f_w-sock_ex_b,0], [f_w,sock_ex_b],
      [f_w,sock_ex_b+25], [f_w-f_corner,f_d], [f_corner,f_d],
      [0,sock_ex_b+25]
    ]);
    // sock body
    translate([f_corner,sock_ex_b,0])
      cube_fillet([sock_w+2*t, sock_d+t, sock_h+sock_ex_h+t],
        top=[sock_w/3,sock_w/3,0,sock_w/3]);

    translate([0,sock_ex_b,t]) {
      // left mounting ear
      mount_ear();
      // right mounting ear
      translate([f_w,0,0]) mirror([1]) mount_ear();
    }
  }
  
  // begin difference
  // main socket hole
  translate([(f_w-sock_w)/2,sock_ex_b-e,-e])
    cube_fillet([sock_w, sock_d, sock_h+sock_ex_h+e],
      vertical=[0,0,sock_fillet,sock_fillet], top=[sock_w/3,sock_w/3,0,sock_w/3]);
  // screw holes
  translate([(f_w-40)/2,25+sock_ex_b,0]) {
    mount_screw();
    translate([40,0,0]) mount_screw();
  }

}
} /* end module power_plug */

/** END OF POWER_PLUG - BEGIN INCLUDES **/
module nut(d,h,horizontal=true){
    cornerdiameter =  (d / 2) / cos (180 / 6);
    cylinder(h = h, r = cornerdiameter, $fn = 6);
    if(horizontal){
        for(i = [1:6]){
            rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
        }
    }
}

module fillet(radius, height=100, $fn=$fn) {
  if (radius > 0) {
    //this creates acutal fillet
    translate([-radius, -radius, -height / 2 - 0.02]) difference() {
        cube([radius * 2, radius * 2, height + 0.04]);
        if ($fn == 0 && (radius == 2 || radius == 3 || radius == 4)) {
            cylinder(r=radius, h=height + 0.04, $fn=4 * radius);
        } else {
            cylinder(r=radius, h=height + 0.04, $fn=$fn);
        }

    }
  }
}

module cube_fillet(size, radius=-1, vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=4){
    if (center) {
        cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    } else {
        translate([size[0]/2, size[1]/2, size[2]/2])
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    }
}

module cube_negative_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=$fn){
    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(radius, size[2], $fn);
        } else {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(vertical[i], size[2], $fn);
        }
        rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) fillet(top[i], size[1-j[i]], $fn);
        rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) fillet(bottom[i], size[1-j[i]], $fn);

    }
}

module cube_fillet_inside(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=$fn){
    //makes CENTERED cube with round corners
    // if you give it radius, it will fillet vertical corners.
    //othervise use vertical, top, bottom arrays
    //when viewed from top, it starts in upper right corner (+x,+y quadrant) , goes counterclockwise
    //top/bottom fillet starts in direction of Y axis and goes CCW too

    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn);
        }
    }
}
