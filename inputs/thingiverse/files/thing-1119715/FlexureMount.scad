include <MCAD/metric_fastners.scad>

// preview[view:south, tilt:top]

/* [Mount Settings] */
// Vertical distance from chassis mounting bolt to probe mounting bolts (center to center)
distanceToMount = 16.4;
// Thickness(height) of the part.
thickness = 8;
// Rounded edges
filletRadius = 2.5;

// Chassis bolt
chassisBoltDiameter = 5.5;
// Recess for chassis bolt
counterBore = 10;
// Chassis mount bolt is on its own tab to the side
tabX = 20;
tabY = 20;
tabThickness = 5;

// Sensor bolt hole spacing
spacing = 10.5;
// Bolt size for sensor and adjustment bolts
boltDiameter = 3.5;
// Nut size for sensor and adjustment bolts
nutDiameter = 5.5;
nutThickness = 2.4;
// How much material under sensor nuts
nutHeight = 4.6;
// Recess for adjustment bolt
washerDiameter = 7.2;

/* [Flexure Settings] */
//part = 4; // [1:Asymmetric,2:Assymetric Folded,3:Symmetric,4:Symmetric 2,5:Symmetric Double,6:Double Shifted]

// Width of flexure portion
totalX = 27;
// Vertical margin around flexure cutout
margin = 2.5;

// Dimensions of the inner shuttle which moves
shuttleX = 18;
shuttleY = 11;

// Slot width determines travel distance in each direction
slotWidth = 1.5;

// Notches narrow down the beams to the minWidth
minWidth = 1.6;
// Thickness of beams where not notched
maxWidth = 1.6;

// Higher notch scaling makes notches in beams wider
notchScale = 2;




/* [Hidden] */
err = 0.02;
// Beam length, may be automatically overriden to longer length if centerSize permits
l = 8;
$fn = 100;

totalY = shuttleY + slotWidth*4 + maxWidth*2 + margin*2;
echo(totalY); // will require a bolt about this length + 5mm

probe_mount();
//display_assembly();

module display_assembly() {
  translate([0,totalY/2+0.3,thickness/2]) rotate([90,0,0]) color("white", 1) washer(3);
  translate([0,-totalY/2,thickness/2]) rotate([90,0,0]) color("white", 1) washer(3);
  translate([0,-totalY/2-0.8*3-0.3,thickness/2]) rotate([-90,0,0])color("red", 1) flat_nut(3);
  translate([spacing/2,0,nutHeight+nutThickness]) rotate([180,0,0]) color("silver", 1) flat_nut(3);
  translate([-spacing/2,0,nutHeight+nutThickness]) rotate([180,0,0]) color("silver", 1) flat_nut(3);
  translate([0,maxWidth-shuttleY/2,thickness/2]) rotate([-90,0,0]) color("silver", 1) flat_nut(3);
  translate([0,totalY/2+0.3,thickness/2]) rotate([90,0,0]) color("black", 1) cap_bolt(3,30);
  color([0,0,1,0.5]) probe_mount();
}



module probe_mount() {
  difference() {
    union() {
      linear_extrude(thickness) translate([0,-totalY/4+distanceToMount/2+tabY/4]) roundedSquare(totalX,totalY/2+distanceToMount+tabY/2,filletRadius,center=true);
      linear_extrude(tabThickness) difference() {
        union() {
          translate([-totalX/2-tabX,distanceToMount-tabY/2]) roundedSquare(tabX,tabY,filletRadius);
          translate([-totalX/2-filletRadius*2,distanceToMount-tabY/2]) square([filletRadius*4,tabY]);
        }
        translate([-tabX/2-totalX/2,distanceToMount]) circle(d=chassisBoltDiameter);
      }
    }
    translate([-spacing/2,0,nutHeight]) rotate([0,0,0]) cylinder(d=nutDiameter*2/sqrt(3), h=thickness, $fn=6);
    translate([spacing/2,0,nutHeight]) rotate([0,0,0]) cylinder(d=nutDiameter*2/sqrt(3), h=thickness, $fn=6);
    translate([-spacing/2,0]) cylinder(d=boltDiameter, h=100, center=true);
    translate([spacing/2,0]) cylinder(d=boltDiameter, h=100, center=true);
    translate([0,maxWidth-shuttleY/2,thickness/2]) rotate([-90,0,0]) {
      rotate([0,0,30]) cylinder(d=nutDiameter*2/sqrt(3), h=nutThickness+err, $fn=6);
      translate([0,thickness/2,nutThickness/2])cube([nutDiameter,thickness,nutThickness], center=true);
    }
    translate([0,0,thickness/2]) rotate([-90,0,0]) cylinder(d=boltDiameter, h=(totalY/2+distanceToMount+tabY/2)*3, center=true);
    translate([0,totalY/2,thickness/2]) rotate([-90,0,0]) cylinder(d=washerDiameter, h=(distanceToMount+tabY/2-totalY/2)*2);
    
    translate([0,0,-thickness/2]) linear_extrude(thickness*2) 
      flexureAsym([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale);
    translate([-totalX/2-tabX/2,distanceToMount,3]) cylinder(d=counterBore, h=tabThickness);
  }
}

module print_part() {

  //%color("red", 0.25) square([shuttleX,shuttleY],center=true); // show shuttle size
  //%color("yellow", 0.25)square([centerSize,totalY],center=true); // show centerSize
  //%color("blue", 0.25) translate([shuttleX/2-maxWidth/2,0]) square([maxWidth,totalY],center=true); // show centerSize
  //%color("blue", 0.25) translate([-shuttleX/2+maxWidth/2,0]) square([maxWidth,totalY],center=true); // show centerSize
  linear_extrude(thickness) difference() {
    roundedSquare(totalX,totalY, 2.5,center=true);
    if (part == 1) {
      flexureAsym([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale);
    } else if (part == 2) {
      flexureAsymFolded([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale);
    } else if (part == 3) {
      flexureSymmetric([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale, centerSize);
    } else if (part == 4) {
      flexureSymmetric2([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale, centerSize);
    } else if (part == 5) {
      flexureSymmetricDouble([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale, centerSize);
    } else if (part == 6) {
      flexureDoubleShifted([shuttleX,shuttleY],slotWidth,l,minWidth,maxWidth,notchScale, centerSize);
    }
  }
}

module roundedSquare(l, w, r,center) {
  x = center ? 0 : l/2;
  y = center ? 0 : w/2;
  translate([x,y]) union() {
    square([l-2*r,w], center=true);
    square([l,w-2*r], center=true);
    // rounded corners
    translate([-l/2+r,-w/2+r]) circle(r = r);
    translate([l/2-r,-w/2+r]) circle(r = r);
    translate([-l/2+r,w/2-r]) circle(r = r);
    translate([l/2-r,w/2-r]) circle(r = r);
  }
}

module beam(l, s, w1, w2, dScale=1) {
  d = (w2 - w1)*dScale;  // can scale d... should this be a parameter?
  x = sqrt( pow(d/2,2) - pow((d+w1-w2)/2,2) );
  intersection() {
    union() {
      // slot above and below beam
      translate([0,(s+w2)/2]) square([l,s], center=true);
      translate([0,-(s+w2)/2]) square([l,s], center=true);
      // semicircle where beam necks down
      translate([-l/2+x,-(d+w1)/2]) circle(d = d);
      translate([l/2-x,-(d+w1)/2]) circle(d = d);
      translate([-l/2+x,(d+w1)/2]) circle(d = d);
      translate([l/2-x,(d+w1)/2]) circle(d = d);
    }
    roundedSquare(l,w2+2*s,s/2,center=true);
  }
}

// Asymmetric in horizontal direction, beam length is determined by shuttle size
module flexureAsym(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (beamLength+maxWidth-slotWidth > shuttleX) ? beamLength : shuttleX-maxWidth+slotWidth;
  a = l/2-shuttleX/2+maxWidth;
  b = (shuttleY+slotWidth)/2;
  c = maxWidth + slotWidth;
  
  union() {
    translate([a,b+c/2]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b-c/2]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    
    x1 = shuttleX/2+slotWidth/2;
    // outer side slots
    translate([x1,0]) square([slotWidth, b*2],center=true);
    translate([-x1,0]) square([slotWidth, (b+c)*2],center=true);
    // rounded corners for outer slot path
    translate([-x1,b+c]) circle(d=slotWidth);
    translate([-x1,-b-c]) circle(d=slotWidth);
    
    x2 = x1+a;
    // connect outer side slots to beamSlots horizontally
    translate([a-x2/2,b+c]) square([x2,slotWidth], center=true);
    translate([a-x2/2,-b-c]) square([x2,slotWidth], center=true);
  }
}

// Asymmetric in horizontal direction, beam length is determined by shuttle size
module flexureAsymFolded(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (beamLength + 2*maxWidth > shuttleX) ? beamLength : shuttleX - 2*maxWidth;
  a = shuttleX/2-l/2-maxWidth;
  b = (shuttleY + maxWidth)/2 + slotWidth;
  c = (maxWidth + slotWidth)/2;

  union() {
    translate([a,-b-2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b+2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    
    x1 = shuttleX/2+slotWidth/2;
    // outer side slots
    translate([x1,0]) square([slotWidth, 2*b+2*c],center=true);
    translate([-x1,0]) square([slotWidth, 2*b-2*c],center=true);

    // rounded corners for outer slot path
    //translate([-x1,b+3*c]) circle(d=slotWidth);
    //translate([-x1,-b-3*c]) circle(d=slotWidth);
    translate([x1,b+c]) circle(d=slotWidth);
    translate([x1,-b-c]) circle(d=slotWidth);

    x2 = x1-a;
    // connect outer side slots to beamSlots horizontally
    translate([x1-x2/2,b+c]) square([x2,slotWidth], center=true);
    translate([x1-x2/2,-b-c]) square([x2,slotWidth], center=true);

    x3 = a-l/2-maxWidth/2;
    translate([x3,b+3*c]) square([2*c,slotWidth], center=true);
    translate([x3,-b-3*c]) square([2*c,slotWidth], center=true);
    translate([x3,b-c]) square([2*c,slotWidth], center=true);
    translate([x3,-b+c]) square([2*c,slotWidth], center=true);

    translate([x3-c,-b-c]) square([slotWidth, 4*c],center=true);
    translate([x3-c,b+c]) square([slotWidth, 4*c],center=true);
    
    // rounded corners for outer slot path
    translate([x3-c,b+3*c]) circle(d=slotWidth);
    translate([x3-c,-b-3*c]) circle(d=slotWidth);
    translate([x3-c,b-c]) circle(d=slotWidth);
    translate([x3-c,-b+c]) circle(d=slotWidth);

  }
}

module flexureSymmetric(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale, centerSize) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (2*beamLength+centerSize+2*maxWidth > shuttleX) ? beamLength : (shuttleX - 2*maxWidth - centerSize)/2;
  a = (centerSize + l)/2;
  b = (centerSize > shuttleX) ? shuttleY/2 : (shuttleY + slotWidth)/2;
  c = (slotWidth + maxWidth)/2;
  
  union() {
    // horizontal slots with rounded holes on end
    translate([-a,-b-c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b-c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b+c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b+c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
   
    // center slots
    translate([0,b]) square([a*2-l+slotWidth, slotWidth],center=true);
    translate([0,-b]) square([a*2-l+slotWidth, slotWidth],center=true);

    // outer vertical slots
    translate([a+l/2+slotWidth/2+maxWidth,0]) square([slotWidth, shuttleY+4*c+slotWidth],center=true);
    translate([-a-l/2-slotWidth/2-maxWidth,0]) square([slotWidth, shuttleY+4*c+slotWidth],center=true);
    
    // connect outer vertical slots to outer horizontal slots
    translate([a+l/2+c-slotWidth/2,b+2*c]) square([2*c, slotWidth],center=true);
    translate([-a-l/2-c+slotWidth/2,b+2*c]) square([2*c, slotWidth],center=true);
    translate([a+l/2+c-slotWidth/2,-b-2*c]) square([2*c, slotWidth],center=true);
    translate([-a-l/2-c+slotWidth/2,-b-2*c]) square([2*c, slotWidth],center=true);

    // rounded corners for outer slot path
    translate([a+l/2+maxWidth+slotWidth/2,b+2*c]) circle(d=slotWidth);
    translate([-a-l/2-maxWidth-slotWidth/2,b+2*c]) circle(d=slotWidth);
    translate([a+l/2+maxWidth+slotWidth/2,-b-2*c]) circle(d=slotWidth);
    translate([-a-l/2-maxWidth-slotWidth/2,-b-2*c]) circle(d=slotWidth);
  }
}

// inside-out version of flexureSymmetric
module flexureSymmetric2(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale, centerSize) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (2*beamLength+centerSize-2*slotWidth > shuttleX) ? beamLength : (shuttleX - centerSize)/2 + slotWidth;
  a = (centerSize + l)/2;
  c = (slotWidth + maxWidth)/2;
  b = (centerSize >= shuttleX) ? shuttleY/2-2*c+slotWidth/2 : (shuttleY + slotWidth)/2;
  
  union() {
    // horizontal slots with rounded holes on end
    translate([-a,-b-c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b-c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b+c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b+c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
   
    // center slots
    translate([0,b+2*c]) square([a*2-l+slotWidth, slotWidth],center=true);
    translate([0,-b-2*c]) square([a*2-l+slotWidth, slotWidth],center=true);

    x1 = shuttleX/2+slotWidth/2;
    // outer vertical slots
    translate([x1,0]) square([slotWidth, 2*b],center=true);
    translate([-x1,0]) square([slotWidth, 2*b],center=true);
    // rounded corners for outer slot path
    translate([x1,b]) circle(d=slotWidth);
    translate([-x1,b]) circle(d=slotWidth);
    translate([x1,-b]) circle(d=slotWidth);
    translate([-x1,-b]) circle(d=slotWidth);
    l1 = centerSize;
    // connect outer vertical slots to outer horizontal slots
    translate([(x1+a)/2,b]) square([abs(x1-a), slotWidth],center=true);
    translate([-(x1+a)/2,b]) square([abs(x1-a), slotWidth],center=true);
    translate([(x1+a)/2,-b]) square([abs(x1-a), slotWidth],center=true);
    translate([-(x1+a)/2,-b]) square([abs(x1-a), slotWidth],center=true);
  }
}

module flexureSymmetricDouble(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale, centerSize) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (2*beamLength+centerSize-2*slotWidth > shuttleX) ? beamLength : (shuttleX+2*slotWidth-centerSize)/2;
  a = (centerSize + l)/2; // horizontal offset of center of beam from center of shuttle
  b = (centerSize >= shuttleX) ? shuttleY/2-maxWidth/2 : shuttleY/2+slotWidth+maxWidth/2; // vertical offset of first beam nearest shuttle
  c = (slotWidth + maxWidth)/2; // half the vertical distance between beams
  e = max(a+l/2+slotWidth/2+maxWidth, shuttleX/2+slotWidth/2+maxWidth+slotWidth); // horizontal offset of outer 

  union() {  
    // horizontal slots with rounded holes on end
    translate([-a,-b-2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b-2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,-b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b+2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b+2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
   
    // center slots
    translate([0,b+c]) square([a*2-l+slotWidth, slotWidth],center=true);
    translate([0,-b-c]) square([a*2-l+slotWidth, slotWidth],center=true);

    // outer vertical side slots
    translate([-e,0]) square([slotWidth, 2*b+6*c],center=true);
    translate([e,0]) square([slotWidth, 2*b+6*c],center=true);
    // connect outer vertical slots to outer horizontal slots
    translate([-(e+a)/2,-b-3*c]) square([e-a, slotWidth],center=true);
    translate([(e+a)/2,-b-3*c]) square([e-a, slotWidth],center=true);
    translate([-(e+a)/2,b+3*c]) square([e-a, slotWidth],center=true);
    translate([(e+a)/2,b+3*c]) square([e-a, slotWidth],center=true);
    // rounded corners for outer slot path
    translate([e,-b-3*c]) circle(d=slotWidth);
    translate([-e,-b-3*c]) circle(d=slotWidth);
    translate([e,b+3*c]) circle(d=slotWidth);
    translate([-e,b+3*c]) circle(d=slotWidth);
    
    x3 = (shuttleX/2+slotWidth/2);
    // Slots for sides of shuttle
    translate([-x3,0]) square([slotWidth, 2*b-2*c],center=true);
    translate([x3,0]) square([slotWidth, 2*b-2*c],center=true);
    // connext shuttle side slots horizontally
    translate([-(x3+a)/2,-b+c]) square([abs(x3-a), slotWidth],center=true);
    translate([(x3+a)/2,-b+c]) square([abs(x3-a), slotWidth],center=true);      
    translate([-(x3+a)/2,b-c]) square([abs(x3-a), slotWidth],center=true);
    translate([(x3+a)/2,b-c]) square([abs(x3-a), slotWidth],center=true);
    // rounded corners for inner slot path
    translate([x3,b-c]) circle(d=slotWidth);
    translate([-x3,b-c]) circle(d=slotWidth);
    translate([x3,-b+c]) circle(d=slotWidth);
    translate([-x3,-b+c]) circle(d=slotWidth);
  }
}

module flexureDoubleShifted(shuttleSize, slotWidth, beamLength, minWidth, maxWidth, notchScale, centerSize) {
  shuttleX = shuttleSize[0];
  shuttleY = shuttleSize[1];
  l = (2*beamLength+centerSize-2*slotWidth > shuttleX) ? beamLength : (shuttleX+2*slotWidth-centerSize)/2;
  a = (centerSize + l)/2; // horizontal offset of center of beam from center of shuttle
  b = (centerSize >= shuttleX) ? shuttleY/2-maxWidth/2 : shuttleY/2+slotWidth+maxWidth/2; // vertical offset of first beam nearest shuttle
  c = (slotWidth + maxWidth)/2; // half the vertical distance between beams
  e = max(a+l/2+slotWidth/2+maxWidth, shuttleX/2+slotWidth/2+maxWidth+slotWidth); // horizontal offset of outer 

  offset = (centerSize >= shuttleX) ? 2*c : 0;
  //translate([0,offset])
  union() {  
    // horizontal slots with rounded holes on end
    translate([-a,-b-2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b-2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,-b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,-b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([-a,b+2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
    translate([a,b+2*c]) beam(l, slotWidth, minWidth, maxWidth, notchScale);
   
    // center slots
    translate([0,b-c]) square([a*2-l+slotWidth, slotWidth],center=true);
    translate([0,-b-3*c]) square([a*2-l+slotWidth, slotWidth],center=true);

    // outer vertical side slots
    translate([-e,0]) square([slotWidth, 2*b+6*c],center=true);
    translate([e,0]) square([slotWidth, 2*b+6*c],center=true);
    // connect outer vertical slots to outer horizontal slots
    translate([-(e+a)/2,-b-3*c]) square([e-a, slotWidth],center=true);
    translate([(e+a)/2,-b-3*c]) square([e-a, slotWidth],center=true);
    translate([-(e+a)/2,b+3*c]) square([e-a, slotWidth],center=true);
    translate([(e+a)/2,b+3*c]) square([e-a, slotWidth],center=true);
    // rounded corners for outer slot path
    translate([e,-b-3*c]) circle(d=slotWidth);
    translate([-e,-b-3*c]) circle(d=slotWidth);
    translate([e,b+3*c]) circle(d=slotWidth);
    translate([-e,b+3*c]) circle(d=slotWidth);
    
    x3 = (shuttleX/2+slotWidth/2);
    // Slots for sides of shuttle
    translate([-x3,0]) square([slotWidth, 2*b-2*c],center=true);
    translate([x3,0]) square([slotWidth, 2*b-2*c],center=true);
    // connext shuttle side slots horizontally
    translate([-(a+x3)/2,-b+c]) square([abs(x3-a), slotWidth],center=true);
    translate([(a+x3)/2,-b+c]) square([abs(x3-a), slotWidth],center=true);      
    translate([-(a+x3)/2,b-c]) square([abs(x3-a), slotWidth],center=true);
    translate([(a+x3)/2,b-c]) square([abs(x3-a), slotWidth],center=true);
    // rounded corners for inner slot path
    translate([x3,b-c]) circle(d=slotWidth);
    translate([-x3,b-c]) circle(d=slotWidth);
    translate([x3,-b+c]) circle(d=slotWidth);
    translate([-x3,-b+c]) circle(d=slotWidth);
  }
}
