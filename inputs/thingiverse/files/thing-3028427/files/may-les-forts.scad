// "May Les Forts be with you" provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

// select part to print
partToPrint = 0; // [0:show assembled, 1:first side part, 2: second side part, 3: crossbar, 4: hook part, 5: rest part]

// split big parts in half?
printSplitPart = 0; // [0: dont split, 1: first half, 2: second half]

// show with bottle
withBottle = "yes"; // [yes, no]

// length of neck (affects width of side parts)
neckLength = 55;  // [25:75]

// diameter of neck (size of holes)
neckDiameter = 30; // [25:50]

// distance from start of neck to center of gravity
centerOfGravity = 117; // [50:150]

// width and depth of the connecting bars
barDimension = 10;  // [5:15]

// how round to make the corners
cornerRadius = 3; // [0:0.5:5] 

// size of the hex bolts
boltFlat2Flat = 5; // [2.5:0.5:8]

clearance = 1*0.3;
tightFit = 1*0.2;

neckHoleDiameter = neckDiameter + 2*clearance;
neckRestDiameter = neckHoleDiameter + 2*barDimension;
neckRestScaleY = (neckHoleDiameter*sqrt(2) + 2*barDimension)/neckRestDiameter;

// distance from center of neck to neck-rest connectors
neckRestConnectorDistance = neckRestScaleY*sqrt(barDimension*(barDimension+neckHoleDiameter));  

// width of a horizontal cross section
sectionWidth = neckLength + sqrt(0.5)*(neckRestConnectorDistance - barDimension) - 0.5*neckHoleDiameter;

// length the longer side: ground to pivot point such that center of gravity is center of base
longSide = sectionWidth + sqrt(2)*centerOfGravity;

// Round to number of stories
barPitch = sqrt(0.5)*sectionWidth;
numStories = max(1, round((longSide - neckRestConnectorDistance + barDimension)/barPitch));

if (partToPrint==1 || partToPrint==2) {
  rotate(45)
    if (printSplitPart==0)
      SidePart(numStories=numStories, withFundament=true, topPart=true, withHookConnector=(partToPrint==1));
    else if (printSplitPart==1)
      rotate([180,0,90])
        SidePart(numStories=ceil(numStories/2), withFundament=true, topPart=false, withHookConnector=false);
    else
      SidePart(numStories=floor(numStories/2), withFundament=false, topPart=true, withHookConnector=(partToPrint==1));
}
else if (partToPrint==3) {
  CrossbarPart();
}
else if (partToPrint==4) {
    NeckHookPart();
}
else if (partToPrint==5) {
  NeckRestPart();
}
else {
  // Show whole structure assembled
  depth=neckRestDiameter;
  width = sqrt(2)*sectionWidth;
  height = numStories*barPitch;

  if (withBottle=="yes") {    
    dxz = sqrt(0.5)*((numStories+1)*barPitch - barDimension + neckRestConnectorDistance);
    translate([sectionWidth+0.5*neckDiameter-dxz, 0, dxz])
      Bottle();
  }
  
  translate([0, 0.5*depth])
    rotate([90, 0])
      rotate(45) {
        // First side part
        SidePart(numStories=numStories, withFundament=true, topPart=true, withHookConnector=true);
          
        // Rest part
        x0 = sqrt(0.5)*sectionWidth;
        y0 = numStories*barPitch + tightFit + neckRestConnectorDistance;
        z0 = 0.5*depth;
        translate([x0, y0, z0])
          rotate([0, 90])
            NeckRestPart();
      }
        
  // Second side part
  translate([0, -0.5*depth + barDimension])
    rotate([90, 0])
      rotate(45)
       SidePart(numStories=numStories, withFundament=true, topPart=true, withHookConnector=false);

  // Crossbars
  dz = sqrt(0.5)*barPitch;
  for (s = [1:numStories], k=[-1,+1]) 
    if (s!=1 || k!=-1) {
        x0 = (k==1)? sectionWidth : -0.5*sectionWidth + sqrt(0.5)*barDimension;
        z0 = (k==1)? -sqrt(0.5)*barDimension :  -0.5*sectionWidth;
        a = (k==+1)? 45 : -135;

        x = x0 - s*dz;
        z = z0 + s*dz;
        
      translate([x0 - s*dz, 0, z0 + s*dz])
        rotate([0, a])   
          translate([0,0,-0.5*boltFlat2Flat+tightFit])
            CrossbarPart();
    }
    
  // The hook
  x0 = -sectionWidth+barDimension-(numStories-1)*dz;
  z0 = (numStories+1)*dz + sqrt(0.5)*(neckRestConnectorDistance - barDimension);
  translate([x0, 0, z0])  
  rotate([90, 0, -90])
    NeckHookPart();
}


module Bottle() {
  diameter = 2.5*neckDiameter;
  shoulder = centerOfGravity/3;
  body = 1.6*centerOfGravity;
    
  rotate([0, -90]) {
    cylinder(d=neckDiameter, h=neckLength);
    translate([0,0,-shoulder])
      cylinder(d1=diameter, d2=neckDiameter, h=shoulder);
    translate([0,0,-shoulder-body])
      cylinder(d=diameter, body);
  }
}

module CrossbarPart() {
  flat2flat = boltFlat2Flat-tightFit;
  boltDiameter = flat2flat*2/sqrt(3);
  boltLength =  neckRestDiameter + 2; 
  barLength = neckRestDiameter - 2*(barDimension + tightFit);
  barThickness = 0.5*flat2flat + 0.5*barDimension;
  
  translate([0,0,0.5*flat2flat]) 
    rotate([90, 0])
      cylinder(d=boltDiameter, h=boltLength, center=true, $fn=6);
    
  translate([-0.5*barDimension, -0.5*barLength]) {
    difference() {
      cube([barDimension, barLength, barThickness]);
 
      // Fillets
      for (x=[0, barDimension-cornerRadius])
        translate([x, 0, barThickness-cornerRadius])
          cube([cornerRadius, barLength, cornerRadius]);  
    }
    
    intersection() {
      cube([barDimension, barLength, barThickness]);
        
      for (x=[cornerRadius, barDimension-cornerRadius])
        translate([x, 0, barThickness-cornerRadius])
          rotate([-90, 0])
            cylinder(r=cornerRadius, h=barLength, $fn=24);
    }
  }
}

module SidePart(numStories, withFundament=false, topPart=false, withHookConnector=false) {
  width = sqrt(2)*sectionWidth;
  height = numStories*barPitch;
  x0 = 0.5*width;
  x1 = x0 - 0.5*barDimension;
  x2 = x0 - barDimension;
  t = tightFit;

  difference() {
    union() {
      extraStory = (withFundament)? 1 : 0; 
      translate([0, -extraStory*barPitch])
        BasicSide(numStories + extraStory, withHookConnector && topPart);
        
        // extra pillar at fundament
        if (withFundament) {
          h = barPitch - barDimension;
          translate([+0.5*barDimension, 0.5*h])
            rotate(90)
              Crossbar(h);
        }
    }
    
    // connectors at top of part
    for (x=[-x0, x2-t])
      if (!topPart || x!=-x0) {
        z = (topPart)? 0.5*barDimension - t : -0.5*barDimension + t;
        translate([x, height - barDimension - t, z])
          cube([barDimension+t, barDimension+t, barDimension]);
      }
      
    // connectors of bottom of split part
    if (!withFundament)
      translate([-0.5*width, -barDimension, 0.5*barDimension - t])
        cube([width, barDimension+t, barDimension]);
    
    // Hex connectors
    boltDiameter = (boltFlat2Flat+tightFit)*2/sqrt(3);
    for (s=[0:numStories]) {
      for (x=[-x1, +x1])
        if ((s!=0 || !withFundament || x!=-x1)
           && (!withFundament || s>1 || x!=-x1) 
           && (s!=numStories || !topPart || x==-x1))
          translate([x, s*barPitch-0.5*barDimension])
            rotate(30)
              cylinder(d=boltDiameter, h=barDimension, $fn=6);
    }
    
    // Fundament at 45 degrees
    if (withFundament) {
      eps = 0.01;
      w = 2*sectionWidth + 1.5*barDimension;
      h = 1.5*barPitch + 1.5*barDimension;
      rotate(-45)
        translate([-0.5*w, -h])
          cube([w, h+eps, barDimension]);
    }
    
    // leftmost top corner when there is no hook connector
    if (topPart && !withHookConnector) {
      translate([-x0, height]) {
        // remove cross-bar fillet
        cube([barDimension+cornerRadius, cornerRadius, barDimension]);
          
        // Round corner
        difference() {
          translate([0, -cornerRadius])
            cube([cornerRadius, cornerRadius, barDimension]);
          translate([cornerRadius, -cornerRadius])
            cylinder(r=cornerRadius, h=barDimension, $fn=24);
        }
      }
    }
  }
}


module BasicSide(numStories, withHookConnector) {
  width = sqrt(2)*sectionWidth;
  height = numStories*barPitch;
  x0 = 0.5*width;
  x1 = x0 - 0.5*barDimension;
  x2 = x0 - barDimension;
  t = tightFit;
    
  difference() {
    union() {
      // Pillars
      extraHeight = barDimension - t;
      for (x=[-x0, x0-barDimension])
        translate([x, -extraHeight])
          cube([barDimension, numStories*barPitch + extraHeight, barDimension]);
  
      for (s=[1:numStories])
        translate([0, s*barPitch - barDimension])
          Crossbar(width=2*x2);   
    }
    
    
    // Make space for fillet
    if (withHookConnector)
      translate([-x0, height-cornerRadius])
        cube([cornerRadius, cornerRadius, barDimension]);
        
    // cut off a tiny bit of the pointy corner
    for (x=[-x0, x2-t])
      translate([x-cornerRadius, height + 0.6*cornerRadius])
        cube([barDimension+2*cornerRadius, cornerRadius, barDimension]);
  }
    
  if (withHookConnector) {
    // Attachment with fillets
    translate([-x0, height])
      HookConnector();       
  }
}

module HookConnector() {
  y1 = cornerRadius*sin(22.5);
  x2a = sqrt(2)*barDimension;
  x2b = cornerRadius/tan(22.5);
  x2 = x2a + x2b;
  y2 = -barDimension;
  y3 = sqrt(0.5)*x2b;
  x3 = x2a + y3;    
  c = 0.5*barDimension;
  t = 0.5*tightFit;
  length = sectionWidth - sqrt(0.5)*barDimension - t;
    
  difference() {
    union() {
      // the arm
      rotate(-45)
        translate([0, y1])
          difference() {
            cube([barDimension, length-y1, barDimension]);
             
            y4 = length-y1-3*c;
            translate([c-t, y4])
              cube([c+t,3*c+t, barDimension]);
            translate([0, y4+c, c-t])
              cube([barDimension,c+2*t, barDimension]);
          }
      // Special polygon for fillets
      linear_extrude(height=barDimension)
        polygon([[0,-y1], [0,y2], [x2,y2], [x2,cornerRadius], [x3,y3], [cornerRadius, -y1]]);
    }
    
    // inner corner
    translate([x2, cornerRadius])
      cylinder(r=cornerRadius, h=barDimension, $fn=24);
  }
  
  // outer corner
  translate([cornerRadius, -y1])
    cylinder(r=cornerRadius, h=barDimension, $fn=24);
}

module Crossbar(width) {
  x1 = 0.5*width;
  eps = 0.01;
  translate([-x1-eps, 0])    
    cube([width+2*eps, barDimension, barDimension]);
  translate([-x1, barDimension])    Fillet();
  translate([-x1, 0]) mirror([0,1,0]) Fillet();
  translate([x1, 0]) rotate(180)     Fillet();
  translate([x1, barDimension]) mirror([1,0,0]) Fillet();
}

module Fillet() {
  eps = 0.01;
    
  difference() {
    translate([-eps, -eps])
      cube([cornerRadius+eps, cornerRadius+eps, barDimension]);
    translate([cornerRadius, cornerRadius])
      cylinder(r=cornerRadius, h=barDimension, $fn=24);
  }
}

module NeckHookPart() {
  d1 = neckHoleDiameter;
  d2 = neckRestDiameter;
  r2 = 0.5*d2;

  // Hook
  difference() {
    cylinder(d=d2, h=barDimension, $fn=60);
      
    cylinder(d=d1, h=barDimension, $fn=60);
    translate([-r2, -r2])
      cube([d2, r2, barDimension]);
  }
 
  // rounded end 
  x1 = r2 - 0.5*barDimension; 
  translate([x1, 0])
    cylinder(d=barDimension, h=barDimension, $fn=24);
  
  // shaft with connector
  c = 0.5*barDimension;
  t = 0.5*tightFit;
  y2 = neckRestConnectorDistance*sqrt(0.5) + 3*c - t;
  translate([-r2, -y2])
    difference() {
      cube([barDimension, y2, barDimension]);
     
      translate([0, 0, c-t]) {
        cube([c+t, 3*c+t, barDimension]);
        cube([barDimension, c+t, barDimension]);
      }
      translate([0, 2*c-t, c-t])
        cube([barDimension, c+t, barDimension]);
    }
}

// Top of part at z=0, Center of neck is at origin with direction (0,+1,-1)
module NeckRestPart() {
  difference() {
    BasicNeckRest();
    
    // 45-degere hole at the center
    rotate([45, 0])
      cylinder(d = neckHoleDiameter, h=6*barDimension, center=true, $fn=60);
      
  }
}

// Neck rest w/o the hole 
module BasicNeckRest() {
  d1 = neckHoleDiameter;
  d2 = neckRestDiameter;
  scale_y = neckRestScaleY;
  
  
  difference() {
    translate([0, 0, -barDimension])
      union() {
        // Main cylinder
        scale([1, scale_y])
          cylinder(d = d2, h=barDimension, $fn=60);
          
        // Straight sides
        t = 0.5*tightFit;
        x0 = 0.5*d2;
        y0 = -neckRestConnectorDistance+t;
        translate([-x0, y0])
          cube([d2, neckRestConnectorDistance + 1.5*barDimension, barDimension]);
              
        w = 0.5*barDimension - t;
        for (x=[-x0, x0-barDimension])
          translate([x, y0-barDimension])
            cube([w, barDimension, barDimension]);
      }
      
    // Remove roughly half of cylinder
    rotate([45, 0])
      translate([-0.5*d2, 0, -d2-barDimension])
        cube([d2, d2, d2+barDimension]);
  }
    
  // rounded ends
  d3 = 0.5*(d2 - d1);
  x3 = 0.25*(d1+d2);
  y3 = 0.5*barDimension;
  intersection() {
    for (x=[-x3, +x3])
      translate([x, 0])
        rotate([45, 0])
          cylinder(d=d3, h=3*barDimension + d3, center=true, $fn=24);  
    
    translate([-0.5*d2, 0, -barDimension])
      cube([d2, d2, barDimension]);
  }
}


