// "Cheesy Electronics Enclosure" provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

// Select part to print
partToPrint = 1; // [1:front, 2:box, 3:battery clip]

// Panel height
panelHeight = 128.5;  // [40.0:0.5:240.0]

// Panel width
panelWidth = 70.5;  // [25.0:0.1:225.0]

// Enclosure depth
enclosureDepth = 40; // [25.0:0.5:65.0]

// With battery compartment
withBattery = "yes";  // [yes,no]

// Mounting screws on a 0.2" horizontal grid
horizontalUnit = 1*5.08;
mountingHoleHorizontalDistance = horizontalUnit*floor((panelWidth-14.5)/horizontalUnit);
mountingHoleVerticalDistance = panelHeight - 6;

// Panel thickness
mountingFrameThickness = 1*2;
chezPanelThickness = 1*4;

// Mounting holes (panel to mounting rail)
mountingHoleX = 0.5*mountingHoleHorizontalDistance;
mountingHoleY = 0.5*mountingHoleVerticalDistance;
mountingHoleDiameter = 1*3.4;
mountingHeadDiameter = 1*7;
mountingRailHeight = max(0, panelHeight - mountingHoleVerticalDistance); 

// Box dimensions
enclosureWidth = panelWidth;
enclosureWallThickness = 1*2;
enclosureToRailTolerance = 1*1.0;
enclosureScrewDistance = 1*3;
enclosureHeight = panelHeight - 2*(mountingRailHeight + enclosureToRailTolerance);
enclosureScrewX = 0.5*enclosureWidth - enclosureWallThickness - enclosureScrewDistance;
enclosureScrewY = 0.5*enclosureHeight - enclosureWallThickness - enclosureScrewDistance;
enclosureScrewDiameter = 1*3.4;
enclosureScrewHeadDiameter = 1*7;

// Battery dimensions
batteryWidth = 1*47;
batteryHeight = 1*15.5;
batteryDepth = 1*26.5;
batterySlotWidth = 1*52;
batterySlotHeight = batteryHeight + 2;
battery_x0 = -0.5*batterySlotWidth;
battery_y0 = -enclosureScrewY + 0.5*enclosureScrewHeadDiameter + enclosureWallThickness + 1;
batteryClipWidth=1*10;

if (partToPrint==1)
  FrontPanelPart();
else if (partToPrint==2)
  BoxPart();
else if (partToPrint==3)
  BatteryClipPart();


module FrontPanelPart() {
  difference() {
    BoxWithRadius(panelWidth, panelHeight, chezPanelThickness, radius=2);
     
    MountingHoles();
    EnclosureScrews(chezPanelThickness);
    ChezHoles();
     
    // Battery compartment
    if (withBattery=="yes")
      translate([0, battery_y0+0.5*batterySlotHeight])
        BoxWithRadius(batterySlotWidth, batterySlotHeight, chezPanelThickness, radius=2);
     
    // actual front panel (lower part)
    panel_x1 = enclosureScrewX - enclosureScrewDistance;
    panel_y1 = enclosureScrewY - enclosureScrewDistance;
    panel_y0 = (withBattery=="yes")? battery_y0 + batterySlotHeight + 5 : -panel_y1;
    panel_y_mid = 0.5*(panel_y0 + panel_y1);
    w = 2*panel_x1;
    h = panel_y1 - panel_y0;

    translate([0, panel_y_mid, mountingFrameThickness])
      BoxWithRadius(w, h, chezPanelThickness, radius=2);
   }
}

module BoxPart() {
  z1 = enclosureDepth + enclosureWallThickness;
  
  difference() {
    union() {
      BasicBox();
      MountingBlocks(enclosureScrewHeadDiameter + 2*enclosureWallThickness, z1);
      BatteryClipLedger();
    }
    
    MountingBlocks(enclosureScrewHeadDiameter, enclosureDepth);
    EnclosureScrews(z1);
  }
  
  for (k = [-0.37, -0.17, +0.17, +0.37])
    translate([0, k*enclosureHeight])
      BracketWithSlot();
}

module BatteryClipPart() {
  clearance = 3;
  z2 = min(enclosureDepth-clearance, 0.6*batteryDepth);
  z1 = min(enclosureDepth-clearance - 5, 0.4*batteryDepth);
  z0 = enclosureDepth - clearance - z2;
    
  
  HalfABatteryClip(z0, z1, z2, batteryClipWidth);
  mirror([1, 0, 0])
     HalfABatteryClip(z0, z1, z2, batteryClipWidth);
}

module MountingHoles() {
   r = 0.5*mountingHeadDiameter;
   x1 = 0.5*panelWidth;
   y1 = max(0.5*panelHeight, mountingHoleY + r);
   z1 = mountingFrameThickness;
   dist_y = y1 - mountingHoleY;
    
   for (x=[-mountingHoleX, +mountingHoleX], y=[-mountingHoleY, +mountingHoleY]) {
     translate([x, y])
       cylinder(d=mountingHoleDiameter, h=mountingFrameThickness+chezPanelThickness, $fn=24);
     translate([x, y, z1])
       cylinder(d=mountingHeadDiameter, h=chezPanelThickness, $fn=48);
   }
   
   for (x=[-x1, mountingHoleX], y=[-y1, mountingHoleY - r])
     translate([x, y, z1])
       cube([x1-mountingHoleX, dist_y + r, chezPanelThickness]);
   
   x2 = mountingHoleX - r;
   for (x=[-mountingHoleX, x2], y=[-y1, mountingHoleY])
     translate([x, y, z1])
      cube([r, r, chezPanelThickness]);
}

module EnclosureScrews(length) {
  for (p = [[enclosureScrewX, 0], [-enclosureScrewX, 0], [0, enclosureScrewY], [0, -enclosureScrewY]])
    translate(p)
      cylinder(d=enclosureScrewDiameter, h=length, $fn=6);
}

module ChezHoles() {
   x0 = -0.5*panelWidth;
    
   ChezHole(x0+19, 10, 25);
   ChezHole(x0-1, 0.3*panelHeight, 16);
   ChezHole(-0.15*panelWidth, 0.5*panelHeight-4, 15); 
   ChezHole(0.34*panelWidth, 0.15*panelHeight, 13);
   ChezHole(0.37*panelWidth, -0.05*panelHeight, 8);
   ChezHole(0.42*panelWidth, -0.13*panelHeight, 18);
   ChezHole(0.15*panelWidth, -0.45*panelHeight, 12); 
   ChezHole(battery_x0, battery_y0 + 0.5*batterySlotHeight, 15);
   ChezHole(x0+10, -5.8, 10);
}

module ChezHole(x, y, diam) {
  dz = min(diam, 2*chezPanelThickness);
  z = mountingFrameThickness + chezPanelThickness;
    
  translate([x, y, z])
    scale([1, 1, dz/diam])
      sphere(d=diam);
}

module BoxWithRadius(width, height, depth, radius) {
  w = 0.5*width - radius;
  h = 0.5*height - radius;
    
  for (x=[-w, +w], y=[-h, +h])
    translate([x, y])
      cylinder(r=radius, h=depth, $fn=12);
  translate([-w, -0.5*height])
    cube([2*w, height, depth]);
  translate([-0.5*width, -h])
    cube([width, 2*h, depth]);
}

module BasicBox() {
  x1 = 0.5*enclosureWidth - enclosureWallThickness;
  y1 = 0.5*enclosureHeight - enclosureWallThickness;
  z1 = enclosureDepth + enclosureWallThickness;
  difference() {
    BoxWithRadius(enclosureWidth, enclosureHeight, z1, radius=enclosureWallThickness);
    
    translate([-x1, -y1, enclosureWallThickness])
      cube([2*x1, 2*y1, z1]);
  }
}

module MountingBlocks(diam, z1) {
  x0 = 0.5*enclosureWidth;
  y0 = 0.5*enclosureHeight;
  r = 0.5*diam;
    
  intersection() {
    for (p = [[enclosureScrewX, 0], [-enclosureScrewX, 0], [0, enclosureScrewY], [0, -enclosureScrewY]])
      translate(p)
        cylinder(r=r, h=z1, $fn=60);
    
    translate([-x0, -y0])
      cube([2*x0, 2*y0, z1]);
 }

  w = x0-enclosureScrewX;
  h = y0-enclosureScrewY;
  translate([-enclosureScrewX-w, -r]) cube([w, 2*r, z1]);
  translate([enclosureScrewX, -r]) cube([w, 2*r, z1]);
  translate([-r, -enclosureScrewY-h]) cube([2*r, h, z1]);
  translate([-r, enclosureScrewY]) cube([2*r, h, z1]);
}

module BracketWithSlot() {
  z1 = enclosureDepth + enclosureWallThickness;
  x1 = 0.5*enclosureWidth;
  bracket_w = enclosureWallThickness + 2.5;
  bracket_slot = 2;
  bracket_h = 2*enclosureWallThickness + bracket_slot;
    
  translate([0, -0.5*bracket_h])
    difference() {
      union() {
        translate([-x1, 0]) cube([bracket_w, bracket_h, z1]);
        translate([x1-bracket_w, 0]) cube([bracket_w, bracket_h, z1]);  
      }

       translate([-x1+enclosureWallThickness, enclosureWallThickness, 0])
         cube([enclosureWidth - 2*enclosureWallThickness, bracket_slot, z1]);
    }
}

module BatteryClipLedger() {
  w = enclosureWidth - 2*enclosureWallThickness;
  x1 = 0.5*w;
  y1 = 0.5*enclosureHeight; 
  h = y1 - (-battery_y0 - 0.5*batterySlotHeight + 15.5);
  t = 2*enclosureWallThickness;
  translate([-x1, -y1]) cube([w, h, t]);
  translate([-x1, y1-h]) cube([w, h, t]);
}

module HalfABatteryClip(z0, z1, z2, w) {
  t = 2;
  r = 0.5*t;
  x0 = r;
  y0 = z1;    
  a=30;
  c = cos(a);
  s = sin(a);
  x1 = x0-r*c;
  y1 = y0-r*s;
  x2_bis = x1 + y1*s/c;
  x2_prim = x2_bis - r*s/c;  
  x2 = x2_prim - r;
  y2 = r;
  x2_t = x2 + r*c; 
  y2_t = y2 + r*s;
  x3_bis = x2_bis + t/c;
  y3_t = r*s;
  x3_t = x3_bis - y3_t*s/c;
  x3_c = x3_t - r*c; 
  x3 = x3_c + r;
    
  x5 = x0 + 2*r/c;
  y5 = y0;
    
  x4 = x5 - r*c;
  y4 = y5 - r*s;
  x6 = x4;
  y6 = y5 + r*s;
  
  y7 = z2;
  x7 = x6 + (y7-y6)*s/c;
  x8 = x7 - t/c;
  y8 = y7;
  x9 = x1;
  y9 = y0 + r*s;
  
  
  minusTolerance = 0.5;
  h0 = 0.5*batteryHeight - minusTolerance;
  translate([h0, z0])
    linear_extrude(height=w)
      difference() {
        union() {  
          translate([x0, y0])
            circle(d=t, $fn=24);
          translate([x3_c, 0])
            circle(d=t, $fn=24);
          polygon([[x0,y0], [x1,y1], 
                   [x2_t, y2_t], [x2, y2], [x2,0], 
                   [x3,0], [x3_t, y3_t],  
                   [x4,y4], [x5,y5], [x6,y6], 
                   [x7,y7], [x8,y8], [x9,y9]]);
        }
    
        translate([x2, y2])
          circle(d=t, $fn=24);
        translate([x5, y5])
          circle(d=t, $fn=24);
      }
      
  cube([x3 + h0, z0, w]);
}
