//use <../Libraries/double_fillet.scad>
//$vpr = [$vpr[0],0,$vpr[2]];

// Measured rope diameter without squishing it at all
ropeD = 4.5;
// Measured rope diameter with caliper firmly compressing rope
ropeFlatD = 2;

// Rough distance across all four knuckles, allowing some space between fingers
knuckleWidth = 85; 
// The thickness of the ring finger middle knuckle
fingerD2 = 15.5; 

// Diameter of grip
handleOD = 30;
// Largest diameter of base flange
baseOD = 50;
// Thickness of base flange
baseThickness = 3; 
// Angle of gripping teeth relative to overall handle, changes how easily rope will come out from tilting
angleOfAttack = 60;

// How many points to generate along curves, higher number makes smoother models / larger files / slower render
detail = 75;


// [Hidden]
fingerD = knuckleWidth/4;
toothDepth = ropeFlatD;
toothSpacing = ropeFlatD*2;

$fn = detail;
err = 0.002;

torusD1 = handleOD + fingerD2;
torusD2 = handleOD + fingerD2 * (1 - 0.75);
diff = (baseOD-handleOD)/2;
endRadius = 2.5 * ropeD;

rotate([0,0,0])
intersection() {
  rotate([90,0]) rope_clamp();
  oneWayGrip(toothDepth, toothSpacing, angleOfAttack, 3);
}



module rope_clamp() {
  intersection() {
    difference() {
      
      union() {
        translate([0,0,-err]) cylinder(d=handleOD, h=knuckleWidth+baseThickness);
        translate([0,diff/2,-baseThickness+err]) scale([1,(baseOD-diff)/baseOD,1]) cylinder(d=baseOD, h=baseThickness);

        difference() {
          translate([0,0,0]) 
            linear_extrude(fingerD/2) 
              circle(d=baseOD);
          
          rotate(179) rotate_extrude2(angle=182, convexity=4) translate([torusD1 / 2, err*2]) {
            translate([0,fingerD/2]) 
              scale([fingerD2/fingerD,1]) circle(d=fingerD,$fn=2*$fn/5);
            square([fingerD,fingerD/2]);
          }
        }

      }
      
      // finger indents
      scale([1,torusD2/torusD1]) 
        rotate_extrude2(angle=180, convexity=4) translate([torusD1 / 2, err*2]) {
          for (i=[0:3])
            translate([0,i * fingerD+fingerD/2]) 
              scale([fingerD2/fingerD,1]) circle(d=fingerD,$fn=2*$fn/5);
          square([fingerD,knuckleWidth]);
        }
        
    }
    
    // ellipse bound in xy plane, with handle upright
    translate([0,diff/2,-baseThickness+err]) linear_extrude(knuckleWidth*2) {
      scale([1,(baseOD-diff)/baseOD,1]) {
        circle(d=baseOD);
      }
    }
  }
}

function flatten(l) = [ for (a = l) for (b = a) b ] ;

module oneWayGrip(h, toothSpacing, angleOfAttack, zOffset) {
  r = ropeD;
  W = handleOD;
  H = 2 * handleOD / 3;
  wBottom = ropeFlatD;
  wTop = ropeFlatD; 
  
  x = toothSpacing/2;
  L = (knuckleWidth+baseThickness*2);
  l = L * cos(angleOfAttack);
  n = floor(l / toothSpacing);
  diff = (wTop - wBottom) / 2;

  points = flatten([
    flatten([ for (i = [ 0 : n ]) [[i * toothSpacing, 0],[i * toothSpacing, h]] ]), 
    [[(n+1)*toothSpacing,0],[L,0],[L,-baseOD],[0,-baseOD]]
  ]);
  
  //echo(points);
  //linear_extrude(l, convexity=2) 
  //  translate([-W,-2*H+err]) square([W*2,2*H]);
  
  // change from upright to print plate orientation
  rotate([0,180,90]) translate([r-baseThickness-err,0,0]) {
    for (j=[0,1]) translate([0,0,handleOD/2-H-zOffset]) mirror([0,j]) translate([0,-wBottom/2]) 
      union() {

        translate([-r,-(diff+wBottom/2+r+W)+wBottom,-H]) cube([L+r,diff+wBottom/2+r+W,H]);
        
        intersection() {
          // teeth edges, teeth angled so that they fade into surface at height - fillet radius
          translate([-r,0]) rotate([atan((wBottom/2)/(H-r)),0]) rotate([0,-angleOfAttack]) translate([0,wBottom/2-h,-H*5]) 
              linear_extrude(H*10, convexity=n) 
                translate([-j*x,0]) polygon(points);
          
          union() {
            // rounded straight edge along length of opening
            translate([endRadius-r,0,0]) rotate([90,0,90]) linear_extrude(L, convexity=2) {
              union() {
                translate([-W,0]) 
                  double_fillet(h=H, R=W,r1=r,r2=wBottom/2,xoffset=diff);
                square([wBottom,H-r]);
              }
            }
            
            // rounded end opening, at base
            translate([endRadius-r,-endRadius]) rotate(90) rotate_extrude2(angle=90) intersection() {
              translate([endRadius,0]) {
                translate([-W,0]) 
                  double_fillet(h=H, R=W,r1=r,r2=wBottom/2,xoffset=diff+wBottom/2);
              }
              square([endRadius+wBottom/2+1,H+1]);
            }
            
            // rounded straight edge, at base
            translate([-r,-W-endRadius,0]) rotate([90,0,180]) linear_extrude(W, convexity=2) {
              union() {
                translate([-W,0]) 
                  double_fillet(h=H, R=W,r1=r,r2=wBottom/2,xoffset=diff);
              }
            }
          }
        }
      }
    }
}


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
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
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
