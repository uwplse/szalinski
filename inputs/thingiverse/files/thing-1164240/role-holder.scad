
// outer diameter of the bearing
bearingOuterDiameter = 22.2;  // [10:0.1:50]

// inner (shaft) diameter of the bearing
bearingInnerDiameter = 8; // [5:0.1:15]

// height of bearing (add 0.2-0.5 according to your printer) 
bearingHeight = 7; // [5:0.1:30]

// bearing spacer diameter (addition to bearingInnerDiameter)
bearingSpacerDiameter = 3; // [0.1:0.1:20]

// bearing spacer depth
bearingSpacerDepth = 0.5; // [0:0.1:3]

// distance between bearings
bearingsDistance = 100; // [70:125]

// depth of plate(s)
plateDepth = 3.5; // [2:0.1:15]

// height of frame clamp
frameClampHeight = 30; // [10:50]

// width of frame clamp 
frameClampWidth = 40; // [10:60]

// depth of Prusa i3 (or similar printer) frame
frameDepth = 6; // [4:0.1:10]


/* [hidden] */
cornerRadius = 5;
pulleyDiameter = bearingOuterDiameter + bearingHeight + 1;
plateWidth = pulleyDiameter + cornerRadius;
knobY = plateWidth - (bearingInnerDiameter + bearingSpacerDiameter) / 2;
endX = (bearingsDistance + pulleyDiameter);
centerX = endX / 2;
leftKnobX = pulleyDiameter / 2;
rightKnobX = bearingsDistance + pulleyDiameter / 2;
fixY = cornerRadius / 2;
leftFixX = cornerRadius / 2;
rightFixX = endX - cornerRadius / 2;

module roundedCube (size, radius) {
  x = size[0];
  y = size[1];
  z = size[2];

  translate ([x/2,y/2,0])
  linear_extrude (height=z)
  hull() {
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0]) circle(r=radius);
    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0]) circle(r=radius);
    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0]) circle(r=radius);
    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0]) circle(r=radius);
  }
}

module pulley() {
  difference() {
    cylinder (d=pulleyDiameter, h=bearingHeight);
    cylinder (d=bearingOuterDiameter, h=bearingHeight);

    translate ([0, 0, bearingHeight/2]) rotate_extrude (convexity = 10) translate ([pulleyDiameter/2, 0,0]) circle (d=bearingHeight - 2);
  }
}

module bearingKnob() {
  union() {
    cylinder (h=bearingHeight+plateDepth/2+bearingSpacerDepth,d=bearingInnerDiameter);
    //cylinder (h=bearingHeight, d=bearingOuterDiameter); // test bearing
  }
}

module bearingSpacer() {
  difference() {
    cylinder (h=bearingSpacerDepth, d=bearingInnerDiameter+bearingSpacerDiameter);
    bearingKnob();
  }
}

module bearingKnobWithSpacer() {
  union() {
    bearingKnob();
    bearingSpacer();
  }
}

module clamp (depth=plateDepth) {
  translate ([(frameClampWidth + frameDepth + 2) / -2, 0, 0])
  linear_extrude (height=depth)
  difference() {
    polygon (points=[[0,frameClampHeight], [frameClampWidth + frameDepth + 2, frameClampHeight], [frameClampWidth/2 + frameDepth + 2, 0], [frameClampWidth/2, 0]]);
      
    center = (frameClampWidth + frameDepth + 2) / 2;
      
    polygon (points=[[center - frameDepth / 2, 0], [center + frameDepth / 2, 0], [center + frameDepth / 2, frameClampHeight], [center - frameDepth / 2, frameClampHeight]]);
  }
}

module plate1() {
  difference() {
    union() {
      roundedCube ([endX, cornerRadius, plateDepth], cornerRadius);
      hull() {
        roundedCube ([pulleyDiameter, cornerRadius, plateDepth], cornerRadius);
        translate ([pulleyDiameter/2, knobY, 0]) cylinder (d=bearingOuterDiameter, h=plateDepth);
      }
      
      hull() {
        translate ([bearingsDistance, 0, 0]) roundedCube ([pulleyDiameter, cornerRadius, plateDepth], cornerRadius);  
        translate ([rightKnobX, knobY, 0]) cylinder (d=bearingOuterDiameter, h=plateDepth);
      }
      
      translate ([leftKnobX, knobY, plateDepth]) bearingKnobWithSpacer();
      translate ([rightKnobX, knobY, plateDepth]) bearingKnobWithSpacer();
    
      translate ([0,0,plateDepth]) {
        hull() {
          translate ([cornerRadius/2,cornerRadius/2,0]) cylinder (h=bearingHeight+2*bearingSpacerDepth, d=cornerRadius*2);
          translate ([bearingsDistance + pulleyDiameter - cornerRadius/2, cornerRadius/2, 0]) cylinder (h=bearingHeight+2*bearingSpacerDepth, d=cornerRadius*2);
        }
      }
      
      translate ([centerX, - frameClampHeight - cornerRadius/2 + 0.005, 0]) clamp (depth=plateDepth*2 + bearingHeight + bearingSpacerDepth);
    }
    
    translate ([leftFixX,fixY,plateDepth]) cylinder (h=bearingHeight+2*bearingSpacerDepth, d=cornerRadius);
    translate ([centerX,fixY,plateDepth]) cylinder (h=bearingHeight+2*bearingSpacerDepth, d=cornerRadius);
    translate ([rightFixX,fixY,plateDepth]) cylinder (h=bearingHeight + 2*bearingSpacerDepth, d=cornerRadius);
  }
}

module plate2() {
  union() {
    difference() {
      union() {
        roundedCube ([endX, cornerRadius, plateDepth], cornerRadius);
        hull() {
          roundedCube ([pulleyDiameter, cornerRadius, plateDepth], cornerRadius);
          translate ([leftKnobX, knobY, 0]) cylinder (d=bearingOuterDiameter, h=plateDepth);
        }
    
        hull() {
          translate ([bearingsDistance, 0, 0]) roundedCube ([pulleyDiameter, cornerRadius, plateDepth], cornerRadius);  
          translate ([rightKnobX, knobY, 0]) cylinder (d=bearingOuterDiameter, h=plateDepth);
        }
      }
      
      translate ([leftKnobX, knobY, plateDepth / 2]) bearingKnob();
      translate ([rightKnobX, knobY, plateDepth / 2]) bearingKnob();
    }

    translate ([leftKnobX, knobY, plateDepth]) bearingSpacer();
    translate ([rightKnobX, knobY, plateDepth]) bearingSpacer();
    
    translate ([leftFixX, fixY,plateDepth]) cylinder (h=bearingHeight + 2*bearingSpacerDepth, d=cornerRadius);
    translate ([centerX,fixY,plateDepth]) cylinder (h=bearingHeight + 2*bearingSpacerDepth, d=cornerRadius);
    translate ([rightFixX,fixY,plateDepth]) cylinder (h=bearingHeight + 2*bearingSpacerDepth, d=cornerRadius);
  }
}

plate1();
translate ([0, plateWidth + cornerRadius + 10, 0]) plate2();
translate ([leftKnobX, -pulleyDiameter, 0]) pulley();
translate ([rightKnobX, -pulleyDiameter, 0]) pulley();

/*
//test pulleys on knobs
translate ([leftKnobX, knobY, plateDepth + bearingSpacerDepth]) pulley();
translate ([rightKnobX, knobY, plateDepth + bearingSpacerDepth]) pulley();
*/

