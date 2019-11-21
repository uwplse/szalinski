
/* [Dimensions] */
// Height/depth of large diameter side
large_height=10;
// Height/depth of small diameter side
small_height=10;

// Diameter of spool holes (makerbot spool is 82 and 53)
diameter1=82;
diameter2=53;

strut_width=10;

/* [Options] */
// Lip to hold adapter, use if larger spool hole will be on the bottom
lip=0; // [0:None,2:Small,3:Medium,5:Heavy]
// How far out the lip comes. 0 makes the lip come out as far as it is thick in a bevel (and doesn't need support!)
lip_extent=3; // [0:10]
// Hole in the middle, 0 to disable
hole_diameter=6;
hole=hole_diameter/2;

/* [Tweaks] */
struts=3; // [2:8]
bevel=2;

// Fillet joint between struts (0 to disable)
fillet_radius=8;

/* [Hidden] */

depth=[large_height,small_height];
depth1=large_height;
depth2=small_height;

radii=[max(diameter1,diameter2)/2,min(diameter1,diameter2)/2];

module inner_fillet(r,w,h) {
  angle = 360/(2*struts);
  rh = r/sin(angle);
  wh = w/(2*sin(angle));
  rha = r*sin(angle);
  rhb = rh-rha;
  ro=r*sin(90-angle);
  rl=sqrt(pow(wh+rhb,2)+pow(ro,2));
  difference() {
    cylinder(r=rl,h=h);
    for (i=[180/struts:360/struts:360]) {
      rotate([0,0,-i]) {
        translate([rh+wh,0,-0.1]) {
          cylinder(r=r,h=h+0.2);
        }
      }
    }
  }
}

module chamfer_strut(r,w,h,c) {
  intersection() {
    union() {
      translate([0,0,-min(h,c)]) {
        cylinder(r=r,h=h);
        translate([0,0,h]) {
          cylinder(r1=r,r2=r-c,h=c);
        }
      }
    }
    translate([0,-w/2,0]) {
      cube([r,w,h]);
    }
  }

}

module lip(r,w,t,e) {
  translate([0,0,t]) {
    mirror([0,0,1]) {
      if (e) {
        chamfer_strut(r=r+e,w=w,h=t,c=0);
      } else {
        chamfer_strut(r=r+t,w=w,h=t,c=t);
      }
    }
  }
}

difference() {
  h1=depth1 + lip;
  union() {
    for (i=[0:360/struts:360]) {
      rotate([0,0,i]) {
        if (fillet_radius) {
          inner_fillet(r=fillet_radius,w=strut_width,h=h1+depth[1]);
        }
        translate([0,0,depth[0]]) {
          mirror([0,0,1]) {
            chamfer_strut(r=radii[0],w=strut_width,h=depth[0],c=bevel);
          }
        }
        translate([0,0,h1]) {
          chamfer_strut(r=radii[1],w=strut_width,h=depth[1],c=bevel);
        }
        if (lip) {
          translate([0,0,depth[0]]) {
            lip(r=radii[0],w=strut_width,t=lip,e=lip_extent);
          }
        }
      }
    }
  }
  if (hole) {
    translate([0,0,-0.1]) {
      cylinder(r=hole,h=h1+depth[1]+0.2);
    }
  }
}
