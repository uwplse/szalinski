// "Chez Vactrol" provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

// Thickness of shell
shell = 1.2;      // [1.0:0.1:3.0]

// Tolerance used for upper/lower part
tightFit = 0.15;  // [0.10:0.01:0.30]

// Diameter of LED +tolerance
LED_Diameter = 5.3; // [3.0:0.1:9.9]

// Height of LED +tolerance
LED_Height = 9.0;        // [3.0:0.1:15.0]

// Diameter of LED "ring" + tolerance
LED_RingDiameter = 6.1; // [3.0:0.1:12.0]

// Height of LED "ring" + tolerance
LED_RingHeight = 1.4;   // [0.5:0.1:3.0]

// Spacing of LED leads
LED_LeadSpacing = 2.5; // [1.0:0.1:5.0]

// Diameter of LED leads + tolerance
LED_LeadDiameter = 1.2;  // [0.5:0.1:1.9]

// Distance, LED to holes for leads
LED_LeadLength = 4.0; // [1.0:0.5:6.0]

// Width of LDR photo cell + tolerance
PhotoCellWidth = 5.5; // [3.0:0.1:9.9]

// Height of LDR photo cell + tolerance
PhotoCellHeight = 4.8; // [3.0:0.1:9.9]

// Thickness of LDR photo cell + tolerance
PhotoCellThickness = 2.2; // [0.5:0.1:5.0]

// Spaceing of LDR photo-cell leads
PhotoCellLeadSpacing = 2.5; // [1.0:0.1:5.0]

// Diameter of LDR photo-cell leads + tolerance 
PhotoCellLeadDiameter = 1.2; // [0.5:0.1:1.9]

// Distance, LDR photo cell to holes for leads
PhotoCellLeadLength = 5;  // [1.0:0.5:6.0]

// Minimum vertical spacing between leads of the enclosure (round upwards to 0.1" pitch)
minVerticalLeadSpacing = max(PhotoCellLeadSpacing, PhotoCellWidth - PhotoCellLeadDiameter,
                                LED_LeadSpacing, LED_Diameter - LED_LeadDiameter);
verticalLeadSpacing = 2.54*ceil(minVerticalLeadSpacing/2.54);

// Minimum horizontal spacing between leads of the enclosure (round upwards to 0.1" pitch)
minLEDLength = LED_Height + LED_LeadLength;
minPhotoCellLength = PhotoCellThickness + PhotoCellLeadLength;
horizontalLeadSpacing = 2.54*ceil((minLEDLength + minPhotoCellLength)/2.54);

width = verticalLeadSpacing + max(PhotoCellLeadDiameter, LED_LeadDiameter) + 4*shell + 2*tightFit;
height = max(PhotoCellHeight, LED_Diameter, LED_RingDiameter) + 2*shell + 2*tightFit;
length = horizontalLeadSpacing + 0.5*(PhotoCellLeadDiameter + LED_LeadDiameter) + 4*shell + 2*tightFit;


translate([0, 0.5*width+1])
  VactrolCasePart(isUpperPart=true);
translate([0, -0.5*width-1])
  VactrolCasePart(isUpperPart=false);

module VactrolCasePart(isUpperPart) {
   h0 = 0.5*height;
   h1 = h0 - 0.5*shell;
   h2 = h0 + 0.5*shell;
   w1 = 2*shell;
   w2 = w1 + 2*tightFit;
   w3 = w2 + 2*shell;
   extraLength = horizontalLeadSpacing - minLEDLength - minPhotoCellLength;
    
   difference() {
     // Enclosing box
     BoxWithRoundCorners(length, width, h2, shell);
       
     // Ledgers around the edge
     translate([0, 0, h1])
       if (isUpperPart)
         Box(length-w1, width-w1, shell);
       else
         difference() {
           Box(length, width, shell+1);
           Box(length-w2, width-w2, shell+2);  
         }

     // Inner space of box
     translate([0, 0, h1])
       Box(length-w3, width-w3, h0);
       
     // cut-out for LED
     translate([0.5*horizontalLeadSpacing, 0, h0])
       LED(LED_LeadLength + 0.5*extraLength);
         
     // cut-out for photocell
     translate([-0.5*horizontalLeadSpacing, 0, h0])
       PhotoCell(PhotoCellLeadLength + 0.5*extraLength);
       
     // External holes for leads
     if (!isUpperPart)
       for (y=[-0.5*verticalLeadSpacing, +0.5*verticalLeadSpacing]) {
         translate([-0.5*horizontalLeadSpacing, y])
           cylinder(d=PhotoCellLeadDiameter, h=h0, $fn=24);
         translate([+0.5*horizontalLeadSpacing, y])
           cylinder(d=LED_LeadDiameter, h=h0, $fn=24);
       }
       
     // Pin1 marker
     if (isUpperPart)
       translate([0.5*horizontalLeadSpacing, -0.5*width + shell])
         Pin1Marker();
   }
   
   // isolator that keeps the leads apart
   w4 = PhotoCellLeadSpacing - PhotoCellLeadDiameter - 2*tightFit;
   l4 = minPhotoCellLength - PhotoCellThickness + 0.5*extraLength + 0.5*PhotoCellLeadDiameter;
   if (!isUpperPart && w4 > 0) 
     translate([-0.5*(horizontalLeadSpacing+PhotoCellLeadDiameter) - shell, -0.5*w4])
       cube([l4 + shell, w4, h2]);
   
   w5 = LED_LeadSpacing - LED_LeadDiameter - 2*tightFit;
   l5 = LED_LeadLength + 0.5*extraLength + 0.5*LED_LeadDiameter;
   if (!isUpperPart && w5 > 0) 
     translate([0.5*(horizontalLeadSpacing+LED_LeadDiameter)-l5, -0.5*w5])
       cube([l5+shell, w5, h2]);
   
}

module LED(leadLength) {
    r = 0.5*LED_Diameter;
    translate([-leadLength-LED_Height+r, 0]) {
      sphere(d=LED_Diameter, $fn=60);
      rotate([0, 90])
        cylinder(d=LED_Diameter, h=LED_Height-r, $fn=60);
    }
    // Ring
    translate([-leadLength-LED_RingHeight, 0])
      rotate([0,90])
        cylinder(d=LED_RingDiameter, h=LED_RingHeight, $fn=60);
    
    // Leads
    for (k=[-0.5, +0.5])
      translate([-leadLength, k*LED_LeadSpacing]) {
        rotate([0, 90])
          cylinder(d=LED_LeadDiameter, h=leadLength, $fn=12);
        rLead = 0.5*LED_LeadDiameter;
        translate([0, -rLead])
          cube([leadLength, 2*rLead, shell]); 
      }
}

module PhotoCell(leadLength) {
  translate([leadLength, -0.5*PhotoCellWidth, -0.5*PhotoCellHeight])
    cube([PhotoCellThickness, PhotoCellWidth, PhotoCellHeight]);
    
  // Hole between LED and photo cell
  wayTooMuch = 0.5*LED_Diameter;
  w = min(PhotoCellWidth, LED_Diameter);
  translate([leadLength, -0.5*w, -0.5*PhotoCellHeight])
    cube([PhotoCellThickness+wayTooMuch, w, PhotoCellHeight]);
    
  // Leads
  for (k=[-0.5, +0.5])
    translate([0, k*PhotoCellLeadSpacing])
      rotate([0, 90])
        cylinder(d=PhotoCellLeadDiameter, h=leadLength, $fn=12);
}

module Pin1Marker() {
  y1 = 2.5;
  x1 = y1/1.73;
  
  linear_extrude(height = 0.8)
    polygon([[0,0], [x1,y1], [-x1,y1]]);
}

module Box(l, w, h) {
  translate([-0.5*l, -0.5*w])
    cube([l, w, h]);
}

module BoxWithRoundCorners(l, w, h, r) {
  x1 = 0.5*l-r;
  y1 = 0.5*w-r;
  linear_extrude(height=h) {
    for (x=[-x1, +x1], y=[-y1, +y1])
      translate([x, y])
        circle(r=r, $fn=16);
    
    translate([-0.5*l, -y1]) square([l, 2*y1]);
    translate([-x1, -0.5*w]) square([2*x1, w]);
  }
}
