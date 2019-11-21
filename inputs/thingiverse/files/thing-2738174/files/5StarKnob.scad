/* [Knob Handle] */
// Number of points on the star
points = 5; // [3:20]
// Diameter of the outermost tip of knob handle
handleOuterDiameter = 75;
// Diameter of the innermost indent in the knob handle
handleInnerDiameter = 30;
// Radius of the star points
pointRadius = 10;

// Vertical thickness of knob handle
handleThickness = 20;
// Radius of top fillet, forms rounded edge all around top of handle
rTopFillet = 10;
// Radius of bottom fillet, forms rounded edge all around bottom of handle
rBottomFillet = 5;

/* [Knob Base] */
// Diameter of the base, this comprises the mating surface when knob is tightended
baseDiameter = 20;
// Distance from bottom of knob base to underside of handle
baseHeight = 15;
// Radius of fillet between handle and base of knob.  Recommended less than or equal to Base Height.
rTransitionFillet = 10;

/* [Bolt Hole] */
// Diameter of bolt hole.  Fits bolt shank, or plain round shaft.
boltDiameter = 7;
// Diameter of bolt head.  Size across flats (wrench size). Set to zero if no head (shaft hole only).
boltHeadDiameter = 13; // 
// Thickness of the bolt head (or nut). Set to zero if no head (shaft hole only).
boltHeadThickness = 20;
// Distance from base of knob to bottom of bolt head (how much thread is inside of knob)
boltHeadHeight = 5;
// Number of sides on bolt head (or nut) (6 for hex head bolt, 4 for carriage bolt, for example)
boltHeadSides = 6;
// Diameter of counterbore, which the bolt head should fit freely inside.  If 0 then a default hex-head counterbore will be automatically calculated as (boltHeadDiameter * 2/sqrt(3) + 1)
boltCounterboreDiameter = 0;
// Radius of rounded edge at top of counterbore
rCounterboreFillet = 2;
/* [Other] */
// Resolution in mm.  This model can take a long time to generate, especially at high detail.  To keep things responsive use a coarse (higher numeric value) resolution while making changes, then change to a finer setting just before clicking "Create Thing" and generating the model.
resolution = 0.75; // [0.2:0.05:5]

/* [Hidden] */
$fs=resolution;
$fa=1;

counterboreDiameter = boltCounterboreDiameter == 0 ? boltHeadDiameter * 2/sqrt(3) + 1 : boltCounterboreDiameter;

starKnob(points, handleOuterDiameter, handleInnerDiameter, pointRadius, handleThickness);

function calculateR4(r1,r2,r3,th) = (pow(r1,2)-2*r3*cos(th)*(r1-r2)-2*r1*r2+pow(r3,2))/(2*(cos(th)*(r1-r2)+r2-r3));
function calculateB(r2,r3,r4,th) = asin((r3+r4)*sin(th)/(r2+r4));

// a knob with profile of continuous circular curves
module starKnob(points, handleOuterDiameter, handleInnerDiameter, pointRadius, handleThickness) {
  th = 180/points;
  r1 = handleOuterDiameter/2;
  r2 = pointRadius;
  r3 = handleInnerDiameter/2;
  r4 = calculateR4(r1,r2,r3,th);
  Btemp1 = calculateB(r2,r3,r4,th);
  Btemp2 = calculateB(r2,r3+0.001,calculateR4(r1,r2,r3+0.001,th),th);
  B = Btemp2 > Btemp1 ? Btemp1 : 180 - Btemp1;
  A = 180 - th - B;
  err = 0.002;
  
  r5 = sqrt( pow(r1-r2,2)+pow(r2,2)-2*(r1-r2)*r2*cos(B));
  r3Max = ((r1-r2)*cos(th)+r2);
  //echo("A",A,"B",B);
  echo("r1",r1,"r2",r2,"r3",r3,"r4",r4,"r5",r5);
  //echo("Btemp2", Btemp2, "Btemp1",Btemp1);

  //echo(r3Max);
  bottomDiameter = ((r4 > 0) ? handleInnerDiameter : r3Max*2) - rBottomFillet * 2;
  rBottomFillet2 = (baseDiameter - bottomDiameter) / 2;
  xBaseFillet = baseDiameter / 2 - rBottomFillet2;

  difference() {
    union() {
      
      // ================ HANDLE + TRANSITION ===============
      difference() {
        intersection() {
          union() {
            translate([0,0,-min(baseHeight,rTransitionFillet)-err]) linear_extrude(handleThickness+min(baseHeight,rTransitionFillet)+2*err, convexity=6) difference() {
              union() {
                if (r3 >= r3Max) {
                  intersection() {
                    circle(r=r3Max/cos(th),$fn=points);
                    rotate([0,0,th])circle(r=(r1-r2+r2*cos(th))/cos(th),$fn=points);
                  }
                } else {
                  circle(r=r5);
                }
                for (i=[1:points]) rotate(2*i*th) translate([r1 - r2,0]) circle(r=r2);
              }
              if (r4>0) {
                for (i=[1:points]) rotate((2*i+1)*th) translate([r3+r4,0]) circle(r=r4);
              }
            }
          }
          
          union() {
            // outer handle bounds cylinder 
            cylinder(r=r1+err, h=handleThickness+err);
            // base transition fillet
            if (rTransitionFillet > 0) translate([0,0,-rTransitionFillet]) {
              fil_polar_i(-baseDiameter/2, rTransitionFillet, 360, baseDiameter/2, handleThickness+err);
            }
          }
        }
        
        //render(convexity=points+2) {
          // Cutouts to create smooth handle edges
          if (r4>0) { // indents in between star points
              for (i=[1:points]) {
                if (rTopFillet > 0) {
                  // top fillet cutouts
                  rotate((2*i-1)*th) translate([r3+r4,0,handleThickness-rTopFillet]) 
                    rotate([0,0,180]) fil_polar_i(-r4, rTopFillet, 2*A+0.01, r4,0.1);
                  rotate(2*i*th) translate([r1-r2,0,handleThickness-rTopFillet]) 
                    fil_polar_i(r2, rTopFillet, 2*(180-B)+0.01, $fs/5,$fs/5);
                }
                if (rBottomFillet > 0) {
                  // bottom fillet cutouts
                  rotate((2*i-1)*th) translate([r3+r4,0,rBottomFillet])
                    translate([0,0,]) rotate([180,0,180]) fil_polar_i(-r4, rBottomFillet, 2*A+0.01, r4, rTransitionFillet+err);
                  rotate(2*i*th) translate([r1-r2,0,rBottomFillet])
                    rotate([180,0,0]) fil_polar_i(r2, rBottomFillet, 2*(180-B)+0.01, $fs/5, rTransitionFillet+err);
                }
              }     
          } else { // no indent, flat sides
            for (i=[1:points]) {
              if (rTopFillet > 0) {
                rotate((2*i+1)*th-90) translate([handleOuterDiameter/2,r3Max-rTopFillet,handleThickness-rTopFillet]) 
                  rotate([0,0,180]) fil_linear_i(handleOuterDiameter, rTopFillet, 90, $fs/5, $fs/5, false);
                rotate(2*i*th) translate([r1-r2,0,handleThickness-rTopFillet]) 
                  rotate([0,0]) fil_polar_i(r2, rTopFillet, 360/points, $fs/5, $fs/5, true);
              }
              if (rBottomFillet > 0) {
                rotate((2*i+1)*th+90) translate([handleOuterDiameter/2,-r3Max+rBottomFillet,rBottomFillet]) 
                  rotate([180,0,180]) fil_linear_i(handleOuterDiameter, rBottomFillet,90, rTransitionFillet+err, handleOuterDiameter/2, false);
                rotate(2*i*th) translate([r1-r2,0,rBottomFillet]) 
                  rotate([180,0]) fil_polar_i(r2, rBottomFillet, 360/points, $fs/5, rTransitionFillet+err, true);
              }
            }
          }
        //}
      }
      
      // =============== BASE ===============
      // base cylinder
      translate([0,0,-baseHeight]) cylinder(d=baseDiameter, h=baseHeight-rTransitionFillet+err);
      
      // reverse transition fillet for bases larger than bottom of handle
      if (baseDiameter > bottomDiameter && rTransitionFillet > 0)
        rotate([180,0,180]) fil_polar_i(-xBaseFillet, rBottomFillet2, 360, err, err, false, min(baseHeight,rTransitionFillet) + err);
    }
    
    
    // ================ BOLT ================= 
    // bolt shank cutout
    if (boltHeadHeight > 0)
      translate([0,0,-baseHeight-1]) cylinder(d=boltDiameter, h=boltHeadHeight+1+err);

    if (boltHeadDiameter > 0 && boltHeadThickness > 0) {
      // bolt counterbore
      translate([0,0,-baseHeight+boltHeadHeight+boltHeadThickness-err]) cylinder(d=counterboreDiameter, h=baseHeight+handleThickness+2*err);
      // hex cap cutout
      translate([0,0,-baseHeight+boltHeadHeight-err]) cylinder(d=boltHeadDiameter*2/sqrt(3), h=boltHeadThickness+2*err, $fn=boltHeadSides);
      // rounded counterbore edge
      if (rCounterboreFillet > 0) 
        translate([0,0,handleThickness-rCounterboreFillet]) fil_polar_i(-counterboreDiameter/2,rCounterboreFillet,360,1,1);
    }

  }
  
  /*
  // show inner and outer diameter
  translate([0,0,20]) {
    color([1,0,0,0.2]) linear_extrude(1) 
      for (i=[0:points-1]) rotate([0,0,360/points * i]) translate([r5,0]) circle(r=r2);
    color([0,1,0,0.3]) linear_extrude(1) difference() { 
        circle(r=r1); 
        circle(r=r3); 
        for (i=[0:points-1]) rotate([0,0,360/points * i]) translate([r5,0]) circle(r=r2);
      }
    color([0,0,1,0.25]) linear_extrude(1) circle(r=r3);
  }
  */
  
}


module angle_cut(angle=90,size=1000) {
  x = size*cos(angle/2);
  y = size*sin(angle/2);
  translate([0,0,-size]) 
    linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
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
module fil_polar_i(R, r, angle=90, extendX=0,extendY=0, halfAlign=false, r2=0) {

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
          mirror([1,0]) translate([R-r, 0, 0]) fil_2d_i(r,90,extendX,extendY, halfAlign, r2);
        } else {
          translate([R-r, 0, 0]) fil_2d_i(r,90,extendX,extendY, halfAlign, r2);
        }
        if (R-r < 0)
          translate([-4*(r+extendX),-1]) square([4*(r+extendX),r+extendY+2]);
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
            translate([-4*(r+extendX),-1]) square([4*(r+extendX),r+extendY+2]);
        }
      }
      angle_cut(angle);
    }
  }
}

// 3d linear inside fillet.
module fil_linear_i(l, r, angle=90,extendX=0, extendY=0, halfAlign=false, r2=0) {
  rotate([0, -90, 180]) {
    linear_extrude(height=l, center=false) {
      fil_2d_i(r, angle,extendX,extendY, halfAlign, r2);
    }
  }
}
