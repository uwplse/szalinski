// Missling Link provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

// Diameter of the axle
axleDiameter = 4; // [1:0.5:10]

// Thickness of various walls
wallThickness = 2; // [1:0.5:5]

// Clearance between moving parts
clearance = 0.3; // [0.1:0.05:0.5]

// part to print
partToPrint = 1; // [1:type-A (link with axle), 2: type-B (link with bushing), 3: type-C (center link), 4: type-M (magnet lock), 5: type-P (pocket), 6: type-T (transformation link)]

// Width of link at the center
centerLinkWidth = 4; // [1:0.5:10]

// Width of all other links
otherLinkWidth = 4; // [1:0.5:10]

// Number of links on each side of the center
numLinksOnEachSide = 2; // [1:4];

// Longer links
extraLength = 0; // [0:25]

// Depth of pocket (type-P links)
pocketDepth = 2.5; // [0:0.5:20]

// Magnet diameter (type-M links)
magnetDiameter = 4; // [1:0.1:25]

// Magnet length
magnetLength = 6; // [1:0.1:25]

// Top stop angle (90 = no stop block)
topStopAngle = 90; // [0:90]

// Bottom stop angle (90 = no stop block)
bottomStopAngle = 90; // [0:90]

outerDiameter = axleDiameter + 2*wallThickness;

if (partToPrint==1)
  TypeALink(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle);
else if (partToPrint==2)
  TypeBLink(otherLinkWidth, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle, bottomStopAngle);
else if (partToPrint==3)
  TypeBLink(centerLinkWidth, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle, bottomStopAngle);
else if (partToPrint==4)
  TypeMLink(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, magnetDiameter, magnetLength, extraLength, wallThickness, clearance, topStopAngle);
else if (partToPrint==5)
  TypePLink(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, extraLength, pocketDepth, wallThickness, clearance, topStopAngle);
else if (partToPrint==6)
  TypeTLink(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle);

// Link with axle (type-A)

module TypeALink(centerLinkWidth,
                    otherLinkWidth,
                    numLinksOnEachSide,
                    outerDiameter,
                    axleDiameter,
                    extraLength = 0,
                    clearance = 0,
                    topStopAngle = 90) {
  
  HalfALinkWithAxle(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, 0.5*extraLength, clearance, topStopAngle);
  mirror([1, 0, 0])
    HalfALinkWithAxle(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, 0.5*extraLength, clearance, topStopAngle);
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

// Link with magnet lock (type-M)

module TypeMLink(centerLinkWidth,
                    otherLinkWidth,
                    numLinksOnEachSide,
                    outerDiameter,
                    axleDiameter,
                    magnetDiameter,
                    magnetLength,
                    extraLength,
                    wall,
                    clearance = 0,
                    topStopAngle = 90) {
  totalWidth = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
  r1 = 0.5*(axleDiameter - clearance);
  z1 = sqrt(0.75)*r1; 
  r2 = 0.5*outerDiameter;
  z2 = sqrt(3)*r2;
  height = z1+z2-r2-0.5*clearance;
  length = wall + magnetLength + extraLength;
                        
  mirror([1, 0, 0])
    HalfALinkWithAxle(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, 0, clearance, topStopAngle);
                        
  difference() {
    union() {
      translate([0, -0.5*totalWidth])
        cube([length, totalWidth, height]);
      translate([wall+extraLength, 0, 0.5*magnetDiameter+wall])
        rotate([0, 90])
          cylinder(d=magnetDiameter+2*wall, h=magnetLength, $fn=60);
    }
    
    // hole for magnet
    translate([wall+extraLength, 0, 0.5*magnetDiameter+wall])
        rotate([0, 90])
          cylinder(d=magnetDiameter, h=magnetLength, $fn=60);
    
    // clearance for type-B links
    intersection() {
      translate([-0.5*outerDiameter, 0, z1])
        rotate([90, 0])
          cylinder(d=outerDiameter+clearance, h=totalWidth, center=true, $fn=48);
      SlotsForTypeBLinks(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, 0, clearance);
    }
  }
}
// Link with pocket (type-P)

module TypePLink(centerLinkWidth,
                 otherLinkWidth,
                 numLinksOnEachSide,
                 outerDiameter,
                 axleDiameter,
                 extraLength,
                 pocketDepth,
                 wall,
                 clearance = 0,
                 topStopAngle = 90) {                      
  totalWidth = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
  r1 = 0.5*(axleDiameter - clearance);
  z1 = sqrt(0.75)*r1; 
  r2 = 0.5*outerDiameter;
  z2 = sqrt(3)*r2;
  height = z1+z2-r2-0.5*clearance;
  pocketWidth = totalWidth - 2*wall;
  pocketLength = extraLength - 2*wall;
                        
  // Pocket               
  difference() {
    union() {
      TypeALink(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle);
  
      if (extraLength>2*clearance)
          rotate([90, 0])
            linear_extrude(height=totalWidth, center=true) {
                TypePSideView(outerDiameter, axleDiameter, 0.5*extraLength, wall, clearance);
                mirror([1, 0])
                  TypePSideView(outerDiameter, axleDiameter, 0.5*extraLength, wall, clearance);
            }
    }
    
    if (pocketDepth>0 && pocketWidth>0 && pocketLength>0)
      translate([0, 0, height-pocketDepth])
        Pocket(pocketLength, pocketWidth, pocketDepth, 1);
  }
}

// Transformation link (type-T) has space for a single, wide, link on one of the axles 
// and any given number of links on the other axle.

module TypeTLink(centerLinkWidth,
                 otherLinkWidth,
                 numLinksOnEachSide,
                 outerDiameter,
                 axleDiameter,
                 extraLength=0,
                 clearance = 0,
                 topStopAngle = 90) {
  transformedLinkWidth = 2*(numLinksOnEachSide-1)*otherLinkWidth + centerLinkWidth;
  TypeALink(transformedLinkWidth, otherLinkWidth, 1, outerDiameter, axleDiameter, extraLength, clearance, topStopAngle);
           
  // Use entirely round parts on the left axis             
  totalWidth = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
  r = 0.5*(axleDiameter - clearance);
  z1 = sqrt(0.75)*r;  
  translate([-0.5*(outerDiameter + extraLength), 0]) {
    difference() {
      // the "round part"
      translate([0, 0, z1])
        rotate([90, 0])
          cylinder(d=outerDiameter-clearance, h=totalWidth, center=true, $fn=48); 
      
      // remove slots for the type-B links
      translate([-0.5*outerDiameter, 0])
        SlotsForTypeBLinks(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, extraLength, clearance);
        
      // remove sub-zero part
      translate([-0.5*outerDiameter, -0.5*totalWidth, -outerDiameter])
        cube([outerDiameter, totalWidth, outerDiameter]);
    }
    
    axleWidth = 0.5*(axleDiameter-clearance);  
    AxleWithBumps(centerLinkWidth, otherLinkWidth, numLinksOnEachSide,
                     axleDiameter, axleWidth, totalWidth, clearance);
  }
}

// (Right) half a type-A link. Left side is the mirror image.

module HalfALinkWithAxle(centerLinkWidth,
                         otherLinkWidth,
                         numLinksOnEachSide,
                         outerDiameter,
                         axleDiameter,
                         extraLength=0,
                         clearance = 0,
                         topStopAngle = 90) {
  totalWidth = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
                                
  difference() {
    // extruded type-A link
    rotate([90, 0])
      linear_extrude(height=totalWidth, center=true)
        TypeASideView(outerDiameter=outerDiameter,
                        axleDiameter=axleDiameter,
                        extraLength=extraLength,
                        clearance=clearance,
                        topStopAngle=topStopAngle);

    // Remove slots for the type-B links
    SlotsForTypeBLinks(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, extraLength, clearance);      
  }
  
  // Axle
  axleWidth = 0.5*(axleDiameter-clearance);
  translate([0.5*outerDiameter + extraLength, 0])
    AxleWithBumps(centerLinkWidth, otherLinkWidth, numLinksOnEachSide,
                     axleDiameter, axleWidth, totalWidth, clearance);
}

// Cuts out slots for the type-B links in one half of a type-A link.

module SlotsForTypeBLinks(centerLinkWidth, otherLinkWidth, numLinksOnEachSide, outerDiameter, extraLength=0, clearance=0) {
    totalWidth = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
    // Possible cut-out for center link
    if (numLinksOnEachSide % 2 == 1)
      translate([0, -0.5*(centerLinkWidth+clearance)])
        cube([outerDiameter+extraLength, centerLinkWidth+clearance, outerDiameter]);
      
    // Cut-out for "other links"
    for (n=[1:2:numLinksOnEachSide-1], s=[+1,-1]) {
      y = 0.5*(totalWidth + clearance) - (n+0.5)*otherLinkWidth;
      translate([0, s*y - 0.5*(otherLinkWidth + clearance)]) 
        cube([outerDiameter+extraLength, otherLinkWidth+clearance, outerDiameter]);
    } 
}

// The axles has "bumps" that prevents type-B links to fall off

module AxleWithBumps(centerLinkWidth,
                     otherLinkWidth,
                     numLinksOnEachSide, 
                     diameter, 
                     width, 
                     length, 
                     clearance=0) {
  length = centerLinkWidth + 2*numLinksOnEachSide*otherLinkWidth - clearance;
                             
  Axle(diameter, width, length, clearance);
      
  // "bumps"
  bump = 0.8;  
  for (n=[1:2:numLinksOnEachSide-1], s=[+1,-1]) {
    y = 0.5*(length + clearance) - (n+0.5)*otherLinkWidth;
    translate([0, s*y])
      Axle(diameter, width+2*bump, bump, clearance);
  }
    
  // if center link is cut out, then place a "bump" there too
  if (numLinksOnEachSide % 2 == 1) {
    Axle(diameter, width+2*bump, bump, clearance);
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

// The pocket has round corners
//
// length  length of pocket (x-coordinate)
// width   width of pocket (y-coordinate)
// depth   depth of pocket (z-coordinate)
// radius  corner radius

module Pocket(length, width, depth, radius) {
  r = (radius>0 && width>=2*radius && length>=2*radius)? radius : 0;
    
  if (r>0)
     for (j=[-0.5, +0.5], k=[-0.5,+0.5])
       translate([j*(length-2*r), k*(width-2*r)])
         cylinder(r=r, h=depth, $fn=16);
  translate([-0.5*length, -0.5*width+r])
    cube([length, width-2*r, depth]);     
  translate([-0.5*length+r, -0.5*width])
    cube([length-2*r, width, depth]);
}

// Type-P links are constructed from type-A parts with extra length in the middle of the link,
// where a pocket is cut out. This is the part from which the pocket is cut out (side view).
//
// outerDiameter       Diameter of the link (plus clearance)
// axleDiameter        Diameter of the axle (plus clearance)
// extraLength         Length of this part
// wall                Thickness of walls around the pocket
// clearance           Distance between moving parts

module TypePSideView(outerDiameter,
                         axleDiameter,
                         extraLength,
                         wall,
                         clearance = 0) {
  r0 = 0.5*(outerDiameter - clearance);
  r1 = 0.5*(axleDiameter - clearance);
  z1 = sqrt(0.75)*r1; 
  r2 = 0.5*outerDiameter;
  z2 = sqrt(3)*r2;
  height = z1+z2-r2-0.5*clearance;
                        
                 
  difference() {
    union() {
      square([extraLength+wall, height]);
      translate([extraLength, 0])
        square([wall, z2]);
    }  
    
    translate([extraLength, z1+z2])
      circle(d=outerDiameter+clearance, $fn=48);
    translate([0.5*outerDiameter+extraLength, z1])
      circle(d=outerDiameter+clearance, $fn=48);
  }
}

// Half a type-A link viewed from the side
//
// outerDiameter       Diameter of the link (plus clearance)
// axleDiameter        Diameter of the axle (plus clearance)
// openingGap          Specifies the width of a possible opening gap (less clearance)
// extraLength         Makes the links longer
// clearance           Distance between moving parts
// topStopAngle        Angle of top stop block

module TypeASideView(outerDiameter,
                         axleDiameter,
                         extraLength = 0,
                         clearance = 0,
                         topStopAngle = 90) {
  r = 0.5*(axleDiameter - clearance);
  y1 = sqrt(0.75)*r;

  difference() {
    translate([0, y1])
      HalfALink(outerDiameter=outerDiameter,
                 extraLength=extraLength,
                 clearance=clearance,
                 flatBottom=true,
                 topStopAngle=topStopAngle);
    translate([0, -outerDiameter])
      square([outerDiameter+extraLength, outerDiameter]);
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
