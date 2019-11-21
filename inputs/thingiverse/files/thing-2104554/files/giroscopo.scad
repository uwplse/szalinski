// Height
pieceHeight = 7; 

// Diameter of the tip
pivotDiameter = 4;

// Separation between tip and outer ring (tolerance)
pivotTolerance = 1;

// Inner piece diameter
innerDiameter = 25;

// Number of rings
numberOfRings = 3; // [1:50]

// Separation between rings
ringsSeparation = 2;

// Rings width
ringsWidth = 4;

// Text on the inner ring
innerRingText = "Text";

// Text size
textSize = 4; // [0:40]

// Include inner ring
innerRing = 1; // [0:No, 1:Yes]

// Include key ring
keyRing = 1; // [0:No, 1:Yes]

// Key ring diameter
keyRingDiameter = 8; // [6:20]


/* [Hidden] */
$fn=60;

rot = numberOfRings%2 != 0 ? 1 : 0;
if (keyRing == 1) {
    translate([0, innerDiameter/2 + (numberOfRings)*(ringsSeparation+ringsWidth)+(keyRingDiameter/2-ringsWidth/2), 0]) keyRing(keyRingDiameter/2, pieceHeight);
}
if (innerRing == 1) {
    difference() {pivotRing(innerDiameter/2, 0, pieceHeight, rot);
    translate([0, 0, pieceHeight-1]) linear_extrude(height=2) text(innerRingText, size=textSize, valign="center", halign="center", font="Arial:style:bold");
    }
}
  for (i = [1:numberOfRings]) {
    pivotRing(innerDiameter/2+i*(ringsSeparation+ringsWidth), innerDiameter/2+i*(ringsSeparation+ringsWidth)-ringsWidth, pieceHeight, i+rot);

}

//pivotRing(innerDiameter, 10, pieceHeight, 1);


module keyRing(r, h) {
    difference() {
       cylinder(r=r, h=h);
       translate([0, 0, -1]) cylinder(r=r-2, h=h+2);
    }
}

module pivotRing(r1, r2, h, dir) {
    difference() {
        union() {
            cylinder(r=r1, h=h);
            if (dir!=numberOfRings+rot) {rotation2 = dir%2==0 ? [90, 0, 0] : [0, 90, 0];
            translate([0, 0, pieceHeight/2]) rotate(a=rotation2) cylinder(r=(pivotDiameter-pivotTolerance)/2, h=2*(r1+ringsSeparation+ringsWidth), center=true); }
        }
     
        translate([0, 0, -1]) cylinder(r=r2, h=h+2);
        if (dir > 1) {rotation1 = dir%2==0 ? [0, 90, 0] : [90, 0, 0];
        translate([0, 0, pieceHeight/2]) rotate(a=rotation1) cylinder(r=(pivotDiameter+pivotTolerance)/2, h=2*(r1+0.2), center=true); }        
    }
    
    
    /*difference(){
        union() {
            cylinder(r=r1, h=h);
            rotation2 = dir%2==0 ? [90, 0, 0] : [0, 90, 0];
            translate([0, 0, pieceHeight/2]) rotate(a=rotation2) cylinder(r=(pivotDiameter-pivotTolerance)/2, h=2*(r1+ringsSeparation+ringsWidth+0.2), center=true);    
        }
        translate([0, 0, -1]) cylinder(r=r2, h=h+2);
        rotation1 = dir%2==0 ? [0, 90, 0] : [90, 0, 0];
        translate([0, 0, pieceHeight/2]) rotate(a=rotation1) cylinder(r=(pivotDiameter+pivotTolerance)/2, h=2*(r1+ringsSeparation+ringsWidth+0.2), center=true);
    }*/
    

    

}


module ring (r1, r2, h)
{
    difference() {
    cylinder(r=r1, h=h);
    translate([0, 0, -1]) cylinder(r=r2, h=h+2);
    }
}