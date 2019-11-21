// how far the flat portion of the handle (printbed side) should cut into the cylindrical handle profile
zOffset = 3;
// opening at its widest, not counting the rounded edge
slotWidest = 5;
// rounded edge radius at slot opening
slotWideR = 2; // fillet at opening of slot
// narrowst part of slot, should be slightly smaller than the bucket handle steel wire diameter
slotNarrowest = 2.9;

// Rough distance across all four knuckles, allowing some space between fingers
knuckleWidth = 85; 
// The thickness of the ring finger middle knuckle
fingerD2 = 15.5; 

// Diameter of grip
handleOD = 30;
// Thickness of each end of the handle, a fillet of same radius will be applied on the ends
baseThickness = 5; 

// How many points to generate along curves, higher number makes smoother models / larger files / slower render
detail = 150;

// [Hidden]
fingerD = knuckleWidth/4;

$fn = detail;
err = 0.002;

torusD1 = handleOD + fingerD2;
torusD2 = handleOD + fingerD2 * (1 - 0.75);
L = knuckleWidth+2*baseThickness;

intersection() {
  rotate([90,0]) handle();
  slot(slotWidest,slotWideR,slotNarrowest,0,zOffset);
}

module handle() {
  difference() {
    rotate_extrude() polygon(
      concat(
        [[0,0]], 
        arcPath(r=baseThickness, angle=90, offsetAngle=270, c=[handleOD/2-baseThickness,baseThickness]),
        arcPath(r=baseThickness, angle=90, offsetAngle=  0, c=[handleOD/2-baseThickness,L-baseThickness]),
        [[0,L]]
      )
    );
    
    // finger indents
    translate([0,0,baseThickness]) scale([1,torusD2/torusD1]) 
      rotate_extrude2(angle=180, convexity=4, size=L+1) translate([torusD1 / 2, err*2]) {
        for (i=[0:3])
          translate([0,i * fingerD+fingerD/2]) 
            scale([fingerD2/fingerD,1]) circle(d=fingerD,$fn=2*$fn/5);
        square([fingerD,knuckleWidth]);
      }
      
  }
}

module slot(widest, rWide, narrowest, rNarrow, zOffset) {
  W = handleOD;
  H = handleOD*2/3-zOffset;
  diff = (widest-narrowest)/2;

  // change from upright to print plate orientation
  rotate([0,180,90]) translate([-err,0,0]) {
    difference() {
      for (j=[0,1]) translate([0,0,handleOD/2-zOffset-H]) mirror([0,j])
        union() {
          translate([-err,1-(diff+narrowest/2+rWide+W),-H]) cube([L+2*err,diff+narrowest/2+rWide+W,H]);
          
          // rounded straight edge along length of opening
          translate([-err,0,0]) rotate([90,0,90]) linear_extrude(L+2*err, convexity=2) {
            translate([-handleOD/2-rWide-diff-narrowest/2,0]) 
              double_fillet(h=H, R=rWide+handleOD/2,r1=rWide,r2=rNarrow,xoffset=diff);
          }
        }
      translate([-1,0,handleOD*(1/2-2/3)+rNarrow]) rotate([0,90,0]) cylinder(d=widest,h=L+2); 
    }
  }
}

// based on get_fragments_from_r documented on wiki
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language
function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));

// Draw a circular arc with center c, radius r, etc.
// "center" parameter centers the sweep of the arc about the offsetAngle (half to each side of it)
function arcPath(r=1, angle=360, offsetAngle=0, c=[0,0], center=false) = 
  let (
    fragments = ceil((abs(angle) / 360) * fragments(r,$fn)),
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0)
  )
  [ for (i = [0:fragments] ) let(a2=i*step+a) c+r*[cos(a2), sin(a2)] ];

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
module rotate_extrude2(angle=360, convexity=2, size=200) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = false;//(version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}

// make a smooth radiused transition between a "lower" and "upper" section
// with a fillet at beginning and end
module double_fillet(h, R, r1, r2, xoffset=0) {
  intersection() {
    square([R+r2+max(xoffset,0),h]);

    xL = r1 + r2 + xoffset;
    yL = h - r1 - r2;
    L = max(sqrt(xL * xL + yL * yL), r1 + r2);
    ratio = (r1 + r2) / L;
    //echo("ratio", ratio);
    //echo("xl",xL," yL",yL, "r1+r2",r1+r2," L",L);
    if (ratio > 1 || yL < 0) {
      c = r1+r2;
      a = r2 > h-r1 ? r2-h+r1 : h - r1 - r2;
      a1 = a * (r2 > h-r1 ? r1 : r2) / (r1 + r2);
      b = sqrt(c*c - a*a);
      h1 = (r2 > h-r1 ? h - r1 + a1 : r2 + a1);
      //echo(a,a1,h,h1,b,c);
      
        union() {
          if (R > r1) square([R-r1,h]);
          translate([R-r1,h-r1]) circle(r=r1);
          difference() {
            square([R-r1+b, h1]);
            translate([R-r1+b, r2]) circle(r=r2);
          }
        }
    } else {
      a1 = acos( ratio );
      angle1 = yL < 0 ? a1 : a1;
      a2 = atan( abs(yL) / xL );
      //echo("xl",xL," yL",yL, "r1+r2",r1+r2," L",L, " angle1",angle1, " angle2:",angle2);
      angle2 = (a2 < 0) ? 180 + a2 : a2;
      x1 = r1 * cos(angle1 - angle2) - r1;
      y1 = r1 * sin(angle1 - angle2) + (h - r1);
      x2_ = L - r2 * cos(angle1);
      y2_ = - r2 * sin(angle1);
      x2 = x2_ * cos(-angle2) - y2_ * sin(-angle2) - r1;
      y2 = x2_ * sin(-angle2) + y2_ * cos(-angle2) + (h - r1); 
      //echo("x1,y1=", x1, y1, "x2,y2=", x2,y2, "x2_,y2_", x2_, y2_);
      
      union() {
        translate([R - r1,h - r1]) circle(r = r1);
        translate([R,0])
        difference() {
          if (r1 > R) {
            polygon([[-R, 0], [xoffset+r2, 0], [xoffset+r2, r2], [x2, y2], [x1, y1], [-r1, h - r1]]);
          } else {
            polygon([[-R, 0], [xoffset+r2, 0], [xoffset+r2, r2], [x2, y2], [x1, y1], [-r1, h - r1], [-r1, h], [-R, h]]);
          }
          translate([r2 + xoffset, r2]) circle(r=r2);
          //translate([-r1,h-r1]) %rotate(-angle2) translate([L,0]) circle(r=r2);
        }
      }
    }
  }
}
