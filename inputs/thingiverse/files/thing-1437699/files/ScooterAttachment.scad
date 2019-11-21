/*******************************************************
Name ......... : ScooterAttachment.scad
Content ...... : Generate two bracket sets for scooter in
                 order to fasten snap hook with strap
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V1.0 du 02/04/2016
Licence ...... : GPL
********************************************************/
part = 0; // [0:All Parts,1:Top Front,2:Top Back,3:Bottom Front,4:Bottom Back]
PieceThickness = 4; // [2:0.1:10]
PieceHeight = 10; // [10:20]
ScrewDiameter = 3;  // [2.5:0.1:5]
TyingGap = 2; // [0.1:0.1:5]

/* [Attachment] */
AttachmentHoleDiameter = 7; // [3:0.1:15]
AttachmentHeight = 6; // [3:0.1:15]

/* [ScooterDiameters] */
TopCoreDiameter = 25.2; // [10:0.1:40]
BottomCoreDiameter = 32; // [10:0.1:40]
HandleDiameter = 23;  // [10:0.1:40]

/* [Hidden] */
WingsLength = 3.5*ScrewDiameter;

/********************************************************/
/********************* ELEMENTS *************************/
/********************************************************/
module drawPiece(front=true, top=true) {
  diameter = (top ? TopCoreDiameter : BottomCoreDiameter);
  difference() {
    union() {
      linear_extrude(height=PieceHeight) {
        difference() {
          union() {
            hull() {
              // External Perimeter of Main Hole
              circle(d=diameter+2*PieceThickness);
              // External Perimeter of Attachment Hole
              translate([0, -(AttachmentHoleDiameter+diameter)/2-PieceThickness, PieceHeight/2])
                rotate([0, 0, 90])
                  elongateCircle(r=AttachmentHoleDiameter/2+PieceThickness, elongation=AttachmentHoleDiameter, center=true);
              // Enforcement
              square([diameter+4*PieceThickness, 2*PieceThickness+TyingGap], center=true);
            }
            // Attachment Wings
            square([diameter+4*PieceThickness+2*WingsLength+(top ? HandleDiameter : 0), 2*PieceThickness+TyingGap], center=true);
            // External Perimeter of Handle Hole
            if(top) {
              translate([(diameter+HandleDiameter)/2+WingsLength+3*PieceThickness, 0])
                circle(d=HandleDiameter+2*PieceThickness);
              translate([-((diameter+HandleDiameter)/2+WingsLength+3*PieceThickness), 0])
                circle(d=HandleDiameter+2*PieceThickness);
            }
          }
          // Internal Perimeter of Main Hole
          circle(d=diameter);
          // Internal Perimeter of Attachment Hole
          translate([0, -(AttachmentHoleDiameter+diameter)/2-PieceThickness])
            rotate([0, 0, 90])
              elongateCircle(r=AttachmentHoleDiameter/2, elongation=AttachmentHoleDiameter, h=PieceHeight+1, center=true);
          // Internal Perimeter of Handle Hole
          if(top) {
            translate([(diameter+HandleDiameter)/2+WingsLength+3*PieceThickness, 0]) {
              circle(d=HandleDiameter);
              // Handle Path
              rotate([0, 0, -45])
                square([HandleDiameter, HandleDiameter]);
            }
            translate([-((diameter+HandleDiameter)/2+WingsLength+3*PieceThickness), 0]) {
              circle(d=HandleDiameter);
              // Handle Path
              rotate([0, 0, 135])
                square([HandleDiameter, HandleDiameter]);
            }
          }
          // Crop the other part
          translate([0, (front ? 1 : -1)*((diameter+AttachmentHoleDiameter-TyingGap)/2+2*PieceThickness)])
            square([diameter+2*HandleDiameter+2*WingsLength+8*PieceThickness+1, diameter+AttachmentHoleDiameter+4*PieceThickness], center=true);
        }
      }
      if(!front) {
        rotate([-90, 0, 0]) {
          translate([(diameter+WingsLength)/2+2*PieceThickness, -PieceHeight/2, PieceThickness+TyingGap/2])
            nutEnclosement(screwDiameter=3);
          translate([-(diameter+WingsLength)/2-2*PieceThickness, -PieceHeight/2, PieceThickness+TyingGap/2])
            nutEnclosement(screwDiameter=3);
        }
        translate([0, diameter/2+PieceThickness, PieceHeight/2])
          rotate([-90, 0, 0])
            nutEnclosement(screwDiameter=3);
      }
    }
    hull() {
      translate([0, -AttachmentHoleDiameter-diameter/2-1.5*PieceThickness, PieceHeight/2+AttachmentHeight])
        cube([diameter+4*PieceThickness, AttachmentHoleDiameter+PieceThickness, PieceHeight], center=true);
      translate([0, -diameter/2, PieceHeight+AttachmentHeight])
        cube([diameter+4*PieceThickness, AttachmentHoleDiameter+PieceThickness, PieceHeight], center=true);
    }
    rotate([90, 0, 0]) {
      translate([(diameter+WingsLength)/2+2*PieceThickness, PieceHeight/2, PieceThickness+TyingGap/2])
        screwHole(screwDiameter=ScrewDiameter, screwLength=15, headThroatDepth=0, nutDistance=2*PieceThickness+TyingGap);
      translate([-(diameter+WingsLength)/2-2*PieceThickness, PieceHeight/2, PieceThickness+TyingGap/2])
        screwHole(screwDiameter=ScrewDiameter, screwLength=15, headThroatDepth=0, nutDistance=2*PieceThickness+TyingGap);
    }
    translate([0, 3*PieceThickness/2+diameter/2, PieceHeight/2])
      rotate([-90, 0, 0])
        screwHole(screwDiameter=ScrewDiameter, screwLength=2*PieceThickness+1, headThroatDepth=0, nutDistance=ScrewDiameter/2+PieceThickness/2);
  }
}

module nutEnclosement(screwDiameter=3) {
  $fn=6;
  hull() {
    translate([0,0,-screwDiameter/2])
      cylinder(d=2.5*screwDiameter, h=screwDiameter);
    translate([0,0,-screwDiameter])
      cylinder(d=3.5*screwDiameter, h=screwDiameter);
  }
}

module elongateCircle(r=3, elongation=10, faceNumber=30, center=false) {
  hull() {
    translate([0, (center ? -elongation/2 : 0), 0])
      circle(r=r, $fn=faceNumber*2);
    translate([0, (center ? elongation/2 : elongation), 0])
      circle(r=r, $fn=faceNumber*2);
  }
}

/**
 * Provides a volume corresponding a screw hole with differents throats for screw and/or nut insertion
 */
module screwHole(screwDiameter=3, screwLength=15, headThroatDepth=10, nutDistance=0, nutThroatDepth=0, conicHead=false, seal=false) {
	union() {
		if(headThroatDepth > 0)
		  cylinder(d=2*screwDiameter, h=headThroatDepth);
    if(conicHead) {
      translate([0, 0, 0.01-screwDiameter/2])
        cylinder(d1=screwDiameter, d2=2*screwDiameter, h=screwDiameter/2);
    }
    if(seal && nutDistance>0) {
      translate([0, 0, 0.2-nutDistance])
        cylinder(d=screwDiameter, h=nutDistance-0.4);
      translate([0, 0, -screwLength])
        cylinder(d=screwDiameter, h=screwLength-nutDistance-screwDiameter-0.2);
    } else {
      translate([0, 0, 0.01-screwLength])
        cylinder(d=screwDiameter, h=screwLength+0.01-(seal ? 0.2 : 0));
    }
		if(nutDistance>0) {
		  translate([0, 0, -screwDiameter/2-nutDistance]) {
        cylinder(d=2*screwDiameter, h=screwDiameter, center=true, $fn=6);
        if(nutThroatDepth>0) {
          translate([-nutThroatDepth/2, 0, 0])
          cube([nutThroatDepth, 1.8*screwDiameter, screwDiameter], center=true);
        }
		  }
		}
	}
}

/********************************************************/
/********************** RENDERING ***********************/
/********************************************************/
$fn=60;
render() {
  if((part==0) || (part==1)) {
    // Top Front Attachment
    drawPiece(front=true, top=true);
  }
  if((part==0) || (part==2)) {
    // Top Back Attachment
    drawPiece(front=false, top=true);
  }

  translate([0, 35+AttachmentHoleDiameter+4*PieceThickness]) {
    if((part==0) || (part==3)) {
      // Bottom Front Attachment
      drawPiece(front=true, top=false);
    }
    if((part==0) || (part==4)) {
      // Bottom Back Attachment
      drawPiece(front=false, top=false);
    }
  }
}
