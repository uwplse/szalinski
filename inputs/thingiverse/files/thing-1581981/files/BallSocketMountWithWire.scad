/* [Ball Socket] */
// Diameter of ball that socket will fit to
ballDiameter = 11.75;
// Clearance for ball socket.  This is added to the socket diameter to account for fused filament tolerances and/or part shrinking depending on plastic type
ballClearance = 0.35;
// The angle of the socket opening.  Should be less than 180 to provide a snap fit.  Too small and the ball won't be able to press into the socket.  Too large and it may fall out easily.
openingAngle = 145; // must be less than 180 for snap fit
// Thickness of the socket/cup wall
cupThickness = 1.2;
// How much space between the socket mounting surface and the edge of the ball.  If 0 then inner bottom of ball socket is on the same plane as the top of the pad.  Positive values will position the socket further away from the pad.  Negative values are not supported.
socketHeight = 7; 

// Fillet angle.  To transition between the spherical socket and the flat pad, there is a rounded fillet.  This angle determines where the outside of the socket and the curved fillet meet.  Larger angles form a larger, sturdier transition.
filletAngle = 60; // [20:90]

/* [Pad] */
// Width of rectangular pad
padWidth = 25;
// Length of rectangular pad 
padLength = 25;
// Thickness of rectangular pad
padThickness = 2;
// Radius of rounded corners on pad
padRadius = 4;

/* [Wire Hole] */ 
// Diameter of Wire hole
wireDiameter = 4;
// Radius of 90degree bend in wire hole center, should be less than socketHeight
wireBendRadius = 5;
// Angle of horizontal wire hole exit, relative to pad.
wireHoleAngle = 45;

/* [Other] */
// Resolution of part mesh, in mm
resolution = 0.5; // [0.2:0.1:3]

/* [Hidden] */
dBall = ballDiameter + ballClearance;

ballSocketWired();

module ballSocketWired() {
  $fs = resolution;
  $fa = 1;
  $err = 0.002;

  difference() {
    ballSocketWithPad(dBall, openingAngle, cupThickness, socketHeight, filletAngle, padWidth, padLength, padThickness, padRadius, resolution);
    if (wireBendRadius > 0 && wireDiameter > 0)
      rotate([0,0,wireHoleAngle]) union() {
        // 90 degree curve in wire hole
        translate([wireBendRadius,0,socketHeight]) rotate([90, 0, 0]) 
          rotate([0,0,180]) rotate_extrude2(angle=90, size=wireBendRadius+wireDiameter/2+1, $fs=resolution)
            difference() {
              translate([wireBendRadius, 0]) 
                circle(d=wireDiameter, $fs=resolution);
              
              translate([-(wireDiameter+wireBendRadius),-wireDiameter/2-1]) 
                square([wireDiameter+wireBendRadius,wireDiameter+2]);
            }
        // side exit straight hole
        translate([wireBendRadius-$err,0,socketHeight-wireBendRadius]) rotate([0,90,0]) cylinder(d=wireDiameter, h=padWidth-wireBendRadius+2*$err, $fs=resolution);
        // top straight hole
        rotate([0,0,180]) translate([0,0,socketHeight-$err]) cylinder(d=wireDiameter, h=dBall/2+$err, $fs=resolution);
      } 
  }
}

module roundedSquare(x,y,r) {
  if (r > 0) {
    hull() for (i=[-1,1], j=[-1,1]) 
      translate([i*(x/2-r), j*(y/2-r)]) circle(r=r); 
  } else {
    square([x,y], center=true);
  }
}

module ballSocketWithPad(dBall, openingAngle, cupThickness, socketHeight, filletAngle, padWidth, padLength, padThickness, padRadius=0, resolution=0.3) {
  $fs = resolution;
  $fa = 1;
  $err = 0.002;

  cupBottomOffset = cupThickness - socketHeight;
  R = dBall/2+cupThickness;
  r = (R*(1-cos(filletAngle)) - cupBottomOffset) / (1 + cos(filletAngle));
  
  translate([0,0,-padThickness]) linear_extrude(padThickness) 
    roundedSquare(padWidth, padLength, padRadius);
    
  intersection() {
    ballSocket(dBall, cupThickness, openingAngle, filletAngle, socketHeight);
    // create bounds so fillet does not extend past edge of pad
    union() {
      translate([0,0,r > 0 ? r : 0]) cylinder(r=R+$err,h=R*2);
      linear_extrude(r) roundedSquare(padWidth, padLength, padRadius);
    }
  }
  
}


module ballSocket(dBall, cupThickness, openingAngle, filletAngle, socketHeight=0, roundedEdge = false) {
  cupBottomOffset = cupThickness - socketHeight;
  R = dBall/2+cupThickness;
  r = (R*(1-cos(filletAngle)) - cupBottomOffset) / (1 + cos(filletAngle));
  openingOffset = cos(openingAngle/2) * R;

  rotate([180,0]) translate([0,0,-R+cupBottomOffset]) rotate_extrude(convexity=3)
    union() {
      intersection() {
        difference() {
          union() {
            circle(d=dBall+2*cupThickness, center=true);
            translate([0,-cupBottomOffset]) circle_fillet(R, filletAngle, cupBottomOffset);
          }
          circle(d=dBall, center=true);
        }
        rotate([0,0,-90]) angle_cut2d(openingAngle, R+socketHeight+(r>0?r:0)+$err);
        translate([0,-openingOffset+$err]) square([R+$err+(r>0?r:0)*2, R-cupBottomOffset+openingOffset+$err]);
      }
      
      if (roundedEdge) {
        rotate([0,0,-90+openingAngle/2]) translate([dBall/2+cupThickness/2,0]) 
          circle(d=cupThickness);
      }
    }
}

module rotate_extrude2(angle=360, convexity=2, size=1000) {
  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation
  
  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=3)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}

module angle_cut(angle=90,size=1000) {
  x = size*cos(angle/2);
  y = size*sin(angle/2);
  translate([0,0,-size]) 
    linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
}

module circle_fillet(R, angle, offset) {
  r = (R*(1-cos(angle)) - offset) / (1 + cos(angle));
  x = r * sin(angle);
  X = R * sin(angle);
  echo(R, r);
  R2 = X-(r-x);
  if (r > 0) {
    translate([0,R-r])
      mirror([1,0]) translate([-R2-r, 0, 0]) fil_2d_i(r,180-angle,R2,$err);
  }
}

module angle_cut(angle=90, size=1000) {
  translate([0,0,-size]) 
    linear_extrude(2*size)
      angle_cut2d(angle, size);
}

module angle_cut2d(angle=90,size=1000) {
  x = size*cos(angle/2);
  y = size*sin(angle/2);
  polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
}

// 2d primitive for inside fillets.
module fil_2d_i(r1, angle=90, extendX=0, extendY=0, halfAlign=false, r2=0) {
  //echo(r1, r2, angle, extendX, extendY);
  r = max(r1,r2);
  s1 = (r2 == 0) ? 1 : ((r2 > r1) ? r1/r2 : 1);
  s2 = (r2 == 0) ? 1 : ((r2 > r1) ? 1 : r2/r1);
  x1 = r + extendX;
  y1 = r + extendY;
  x2 = r * sin(angle);
  y2 = r * cos(angle);
  scale([s1,s2]) difference() {
    polygon((angle > 180) ?
      [[0,0],[0,y1],[x1,y1],[x1,-r],[x2,-r]]:  
      [[0,0],[0,y1],[x1,y1],[x1,y2],[x2,y2]]
    );
    rotate(halfAlign ? 90 : 0) circle(r=max(r2,r));
  }
}

// 3d polar inside fillet.
module fil_polar_i(R, r, angle=90, extendX=0,extendY=0, halfAlign=false, r2=0, angle2=90) {

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation
  
  //echo(R);
  render(convexity=5)
  if (angleSupport) {
    rotate([0,0,-angle/2]) rotate_extrude(angle=angle,convexity=3) {
      difference() {
        if (R<=0) {
          mirror([1,0]) translate([R-r, 0, 0]) fil_2d_i(r,angle2,extendX,extendY, halfAlign, r2);
        } else {
          translate([R-r, 0, 0]) fil_2d_i(r,angle2,extendX,extendY, halfAlign, r2);
        }
        if (R-r < 0)
          translate([-4*(r+extendX),-r]) square([4*(r+extendX),2*r+extendY+2]);
      }
    }
  } else {
    difference() {
      rotate_extrude(convexity=7) {
        difference() {
          if (R<=0) {
            mirror([1,0]) translate([R-r, 0, 0]) fil_2d_i(r,90,extendX,extendY, halfAlign, r2);
          } else {
            translate([R-r, 0, 0]) fil_2d_i(r,90,extendX,extendY, halfAlign, r2);
          }
          if (R-r < 0)
            translate([-4*(r+extendX),-r]) square([4*(r+extendX),2*r+extendY+2]);
        }
      }
      angle_cut(angle);
    }
  }
}