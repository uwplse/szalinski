// Allsorts Bracelet provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

// Select part to print
partToPrint=1; // [1:link, 2:cube-bottom, 3:cube-middle, 4:cube-top, 5:whole-cube, 6:puck-outer, 7:puck-inner, 8:whole-puck, 9:button, 10:magnet-lock]

// Height of "cube" part
cubeHeight = 9.5;   // [7.5:0.5:12.5]

// Width of "cube" part
cubeWidth=19.0; // [15:0.5:25]

// Outer diameter of "puck" part
puckOuterDiameter=22.5; // [20:0.5:25]

// Inner diameter of "puck" part
puckInnerDiameter=9.5;  // [7.5:0.5:10]

// Height of "puck" part
puckHeight=11.5;    // [10:0.5:15]

// Diameter of "button" part
buttonDiameter=17; // [15:0.5:25]

// Outer diameter of magnet lock
tubeDiameter = 12.7;       // [10:0.1:15]

// Length of magnet lock
tubeLength = 22;        // [15:1:25]

// Diameter of magnet +tolerance (magnet-lock part only)
magnetDiameter = 10.5;           // [2:0.1:15]

// Length of magnet (magnet-lock part only)
magnetLength = 2;             // [2:0.1:10]


linkAxleDiameter = 1*3;
linkWall = 1*2;
linkOuterDiameter = 2*linkWall + linkAxleDiameter;
linkWidth = 1*4;

buttonHeight=1*6.4;
buttonPearlDiameter=1*1.6;
buttonPearlGrid=1*2.5;
buttonEdgeRadius=1*3;

tightFit=1*0.15;
clearance = 1*0.3;

if (partToPrint==1) {
  TypeBLink(linkWidth, linkOuterDiameter, linkAxleDiameter, 0, clearance);
}
else if (partToPrint==2 || partToPrint==4) {
  colors=["White", "Black", "Orange"];
  color(colors[partToPrint-2])
    CubePart(partToPrint-2);
}
else if (partToPrint==3) {
  color("Black")
    mirror([0, 0, 1])
      CubePart(layer=1);
}
else if (partToPrint==5) {
  for (layer=[0:2]) {
    colors=["White", "Black", "Orange"];
    color(colors[layer])
      translate([0,0,layer*cubeHeight/3])
        CubePart(layer);
  }
}
else if (partToPrint==6) {
  color("Yellow")
    mirror([0,0,1])
      OuterPuckPart();
}
else if (partToPrint==7 || partToPrint==8) {
    color("Black")
      InnerPuckPart();
    if (partToPrint==8)
      color("Yellow")
        OuterPuckPart();
}
else if (partToPrint==9) {
  color("Pink")
    ButtonPart();
}
else if (partToPrint==10) {
    color("Black")
      TubePart();
}


module CubePart(layer) {
  height = cubeHeight/3;
    
  difference() {
    translate([-0.5*cubeWidth, -0.5*cubeWidth])  
      cube([cubeWidth, cubeWidth, height]);

    translate([0, 0, -height*layer]) {
      x1 = 0.5*(cubeWidth+clearance);     
      for (x=[-x1, +x1])
        translate([x, -0.5*cubeWidth])
          Fillet(cubeWidth);
    
    
      if (layer!=2) {
        translate([x1, 0])
          LinkCutout();
        translate([-x1, 0])
          mirror([1, 0, 0])
            LinkCutout();
      }
    }
  }  
}

module OuterPuckPart() {
  h = sqrt(0.75)*0.5*linkAxleDiameter + 0.5*linkOuterDiameter + clearance;
  w = linkWidth+clearance;
  difference() {
    cylinder(d=puckOuterDiameter, h=puckHeight, $fn=90);
      
    cylinder(d=puckOuterDiameter-2*linkWall, h=h, $fn=90);
    cylinder(d=puckInnerDiameter+tightFit, h=puckHeight, $fn=60);
      
    translate([-0.5*puckOuterDiameter, -0.5*w])
      cube([puckOuterDiameter, w, h]);
  }
}

module InnerPuckPart() {
  h = sqrt(0.75)*0.5*linkAxleDiameter + 0.5*linkOuterDiameter;
  difference() {
    union() {
      cylinder(d=puckOuterDiameter-2*(linkWall+tightFit), h=h, $fn=90);
      cylinder(d=puckInnerDiameter-tightFit, h=puckHeight, $fn=60);
    }  
    x1 = 0.5*(puckOuterDiameter+clearance);           
    translate([x1, 0])
      LinkCutout();
    translate([-x1, 0])
      mirror([1, 0, 0])
        LinkCutout();
  }
}


module ButtonPart() {
  x1=0.5*(buttonDiameter+clearance);
  gridX=buttonPearlGrid;
  offsetY=0.25*sqrt(3)*buttonPearlGrid;
  r = 0.5*buttonDiameter - buttonEdgeRadius;
    
  difference() {
    union() {
      BasicButton();
        
      maxGrid=r + buttonHeight + (0.5*PI-1)*buttonEdgeRadius;
      for (x=[0:gridX:2*maxGrid]) {
        Pearls(x, 0, maxGrid);
        Pearls(x+0.5*gridX, offsetY, maxGrid);
      }
    } 
    
    translate([x1, 0])
      LinkCutout();
    translate([-x1, 0])
      mirror([1, 0, 0])
        LinkCutout();
  }
}

module BasicButton() {
  r=buttonEdgeRadius;
  x0=0.5*buttonDiameter-r;
  y0=buttonHeight-r;
    
  rotate_extrude() {
    square([x0, buttonHeight]);
    square([0.5*buttonDiameter, y0]);  
    translate([x0,y0])
      circle(r=r, $fn=30);
  }
}

module Pearls(x, y0, maxGrid) {
  gridY=0.5*sqrt(3)*buttonPearlGrid;    
  for (y=[y0:gridY:maxGrid]) {
    Pearl(x, y);
    if (x!=0) Pearl(-x, y);
    if (y!=0) Pearl(x, -y);
    if (x!=0 || y!=0) Pearl(-x, -y);
  }
}

module Pearl(x, y) {
  d = sqrt(x*x + y*y);
  r1 = 0.5*buttonDiameter;
  r0 = r1 - buttonEdgeRadius;
    
  if (d < r0)
    translate([x, y])
      cylinder(d=buttonPearlDiameter, h=buttonHeight+0.5*buttonPearlDiameter, $fn=12);
  else  {
    d0 = d - r0;
    arc = 0.5*buttonEdgeRadius*PI;
    arg = atan2(y, x);
    a = (d0<arc)? 90*d0/arc : 90;
    r2 = r0 + buttonEdgeRadius*sin(a);
    x2 = x*r2/d;
    y2 = y*r2/d;
    z2 = buttonHeight + buttonEdgeRadius*(cos(a)-1) - max(0, d0-arc);
    if (z2>0.5*buttonPearlDiameter && abs(y2) > 0.5*(linkWidth + buttonPearlDiameter))
    translate([x2, y2, z2])
      rotate([0, a, arg])
        cylinder(d=buttonPearlDiameter, h=buttonPearlDiameter, center=true, $fn=12);
//       if (d0 < arc) {
//      a = 90*d0/arc;
//      r2 = r0 + buttonEdgeRadius*sin(a);
//      x2 = x*r2/d;
//      y2 = y*r2/d;
//      z2 = buttonHeight + buttonEdgeRadius*(cos(a)-1);
//      if (abs(y2) > 0.5*(linkWidth + buttonPearlDiameter))
//      translate([x2, y2, z2])
//        rotate([0, a, arg])
//          cylinder(d=buttonPearlDiameter, h=buttonPearlDiameter, center=true, $fn=12);
//    }
//    else {
//      z = buttonHeight-buttonEdgeRadius-(d0-arc);
//      if (z > 0.5*buttonPearlDiameter)
//        translate([0, 0, z])
//          rotate([0, 90, arg])
//            cylinder(d=buttonPearlDiameter, h=r1+0.5*buttonPearlDiameter, $fn=12);
//    }
  }
}

module TubePart() {
  x1=0.5*(tubeDiameter+clearance);
  
  difference() {
    BasicTube();
      
    translate([x1, -0.5*tubeLength])
      LinkCutout();
  }
}

module BasicTube() {
  r=0.5*tubeDiameter;
    
  translate([0,0,r])
    rotate([90,0])
      difference() {
        union() {
          cylinder(d=tubeDiameter, h=tubeLength, $fn=60);
          rotate(-30)
            translate([0,-r])
              cube([r, r, tubeLength]);
          rotate(30)
            translate([-r,-r])
              cube([r, r, tubeLength]);
        }    
        translate([-r, -2*r])
          cube([2*r, r, tubeLength]);
        cylinder(d=magnetDiameter, h=magnetLength, $fn=30);
        translate([0,0,tubeLength-magnetLength])
          cylinder(d=magnetDiameter, h=magnetLength, $fn=30);
      }
}

module Fillet(length) {
  r=0.5*(linkOuterDiameter - clearance);
  x1=0.5*linkOuterDiameter;
  z1=sqrt(0.75)*0.5*(linkAxleDiameter-clearance);
    
  difference() {
    translate([-x1, 0])
      cube([linkOuterDiameter, length, z1]);
      
    rotate([-90, 0]) {
      translate([-x1, -z1])
        cylinder(r=r, h=length, $fn=48);
      translate([x1, -z1])
        cylinder(r=r, h=length, $fn=48);
    }
  }
}

module LinkCutout() {
  w=linkWidth+2*clearance;
  d=linkOuterDiameter+clearance;
  r=0.5*d;
  s=sqrt(0.5)*r;
  z1=sqrt(0.75)*0.5*(linkAxleDiameter-clearance);
    
  translate([-r, 0])
    difference() {
      translate([0, 0, z1])
        rotate([-90, 0]) {
          cylinder(d=d, h=w, center=true, $fn=24);
          linear_extrude(height=w, center=true)
            polygon([[-s,-s], [0,r], [r,r], [r,-2*s-r]]);
        }
      
      width=0.5*(linkAxleDiameter-clearance);
      w2=0.8;
      eps=0.01;   
      rotate([90, 0]) {
        linear_extrude(height=w+eps, center=true)
          AxleCrossView(linkAxleDiameter, width, clearance);
        linear_extrude(height=w2, center=true)
          AxleCrossView(linkAxleDiameter, width+2*w2, clearance);
      } 
    }
}

// The axle is extruded from the Axle cross-view
//
// diameter    axle diameter (plus clearance)
// width       width of axle at bottom (<diameter)
// length      length of extruded axle
// clerance    distance between moving parts

module Axle(diameter, width, length, clearance=0) {
  rotate([90, 0])
   linear_extrude(height=length, center=true)
     AxleCrossView(diameter, width, clearance); 
}

// The axle lies flat when printed, but it is rounded at the top
//
// diameter    axle diameter (plus clearance)
// width       width of axle at bottom (<diameter)
// clerance    distance between moving parts

module AxleCrossView(diameter, width, clearance=0) {
  r = 0.5*(diameter - clearance);
  x1 = 0.5*width;
  y1 = sqrt(0.75)*r;

  intersection() {
    translate([0, y1])
      circle(r=r, $fn=36);
    translate([-x1, 0])
      square([width, y1+r]);
  }  
}

// Link with bushing (type-B)

module TypeBLink(linkWidth,
                 outerDiameter, 
                 axleDiameter,
                 extraLength = 0,
                 clearance = 0,
                 topStopAngle = 90,
                 bottomStopAngle = 90) {
  linear_extrude(height=linkWidth-clearance) {
    HalfALink(outerDiameter = outerDiameter, 
               axleDiameter = axleDiameter, 
               openingGap = 0.5*axleDiameter,
               extraLength = 0.5*extraLength, 
               clearance = clearance,
               topStopAngle = topStopAngle,
               bottomStopAngle = bottomStopAngle);
    mirror([1, 0, 0])
      HalfALink(outerDiameter = outerDiameter, 
                 axleDiameter = axleDiameter, 
                 openingGap = 0.5*axleDiameter,
                 extraLength = 0.5*extraLength,
                 clearance = clearance,
                 topStopAngle = topStopAngle,
                 bottomStopAngle = bottomStopAngle);
  }
}
// Half a Link is the right half of a (Type-A or B) link. It can also be combined with other parts.
//
// outerDiameter       Diameter of the link (plus clearance)
// axleDiameter        A positive value for a bushing with a hole for the axle (i.e type-B link)
// openingGap          Specifies the width of a possible opening gap (less clearance)
// extraLength         Makes the links longer
// clearance           Distance between moving parts
// flatBottom
// topStopAngle        Angle of top stop block
// bottomStopAngle     Angle of bottom stop block  

module HalfALink(outerDiameter,
                 axleDiameter=0,
                 openingGap=0,
                 extraLength = 0,
                 clearance = 0,
                 flatBottom = false,
                 topStopAngle = 90,
                 bottomStopAngle = 90) {
  x0 = 0.5*outerDiameter + extraLength;
  D1 = outerDiameter - clearance;
                       
  difference() {
    union() {
      translate([x0, 0]) {
        circle(d=D1, $fn=48);
        // stop angles (90 degrees=no stop)
        StopBlock(D1, topStopAngle);
        mirror([0,1])
          StopBlock(D1, bottomStopAngle);
      }
      
      // connection between link halves
      y_t = 0.25*sqrt(3)*D1;     
      y0 = flatBottom? -0.5*D1 : -y_t;
      translate([0, y0])
        square([x0, y_t-y0]);
    }
    
    // axle and opening
    translate([x0, 0]) {
      if (axleDiameter > 0)
        circle(d=axleDiameter+clearance, $fn=36);
      if (openingGap > 0) {
        HalfAnOpening(openingGap, outerDiameter, axleDiameter, topStopAngle, clearance);
        mirror([0, 1])
          HalfAnOpening(openingGap, outerDiameter, axleDiameter, bottomStopAngle, clearance);
      }
    }
    
    // Narrow mid part
    D2 = outerDiameter + clearance;
    y2 = 0.5*sqrt(3)*outerDiameter;
    translate([extraLength, y2])
      circle(d=D2, $fn=48);
    translate([0, y2-0.5*D2])
      square([extraLength, D2]);
    
    if (!flatBottom) {
      translate([extraLength, -y2])
        circle(d=D2, $fn=48);
      translate([0, -y2])
      square([extraLength, 0.5*D2]);
    }
  }
}

// The stop block limits the rotation of the links
//
// diameter        diameter of link
// stopAngle       angle (CCW rotation) of stop block 

module StopBlock(diameter, stopAngle) {
  r = 0.5*diameter;
    
  intersection() {
    square([r, r]);
    rotate(stopAngle)
      square([r,r]);
  }
}

// Half an opening is the upper half of the opening of a type-B (bushing) link
//
// opening gap     width of opening (less clearance), half of which is in the upper half (this part)
// axleDiameter    (less clearance)
// stopAngle       angle of stop block (90 degrees=no stop block)
// clearance       distance between moving parts (e.g. axle and bushing)

module HalfAnOpening(openingGap,
                        outerDiameter,
                        axleDiameter,
                        stopAngle = 90,
                        clearance = 0) {
    // bushing for axle
  R = 0.5*(outerDiameter - clearance);
  w = 0.5*(outerDiameter - axleDiameter) - clearance;

  // opening
  y0 = 0.5*openingGap + 0.5*clearance;
  // fancy fillet/radius
  r = 0.5*w;
  Rmid = R - r;
  y1 = y0+r;
  y_t = R*sin(stopAngle);
  // touches outer perimeter or stop block?
  x1 = (y_t < y1)? (Rmid-y1*sin(stopAngle))/cos(stopAngle) : sqrt(Rmid*Rmid-y1*y1);
  x2 = 1.5*R;
  y2 = (y_t < y1)? y1 + (x2-x1)*tan(stopAngle) : y1*x2/x1;
  difference() {
    polygon([[0, 0], [0, y0], [x1, y0], [x1,y1], [x2,y2], [x2, 0]]);
    translate([x1, y1])
      circle(r=r, $fn=24);
  }
}
