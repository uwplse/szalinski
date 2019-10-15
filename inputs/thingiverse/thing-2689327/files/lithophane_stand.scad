/* [General] */
// The width of the Lithophane
s = 90;
// The depth of the Lithophane
h = 18.5;
// Thickness of the walls holding the Lithophane
walls = 0.8;
// Height of the Lithophane walls
height = 2;

/* [Bottom] */
// Thickness of the bottom part of the Lithophane
thickness = 3;
// Padding of the bottom Part to the cable
bottom = 0.75;
// With of the brim
brim = 5;
// Diameter of the Cable
cableDiameter = 4;
// Cable offset in degrees
cableOffset = 90;

/* [Top] */
// Height of the top part walls
top = 2;
// Thickness of the top part of the Lithophane
thicknessTop = 0.9;

/* [Part] */
// Part to render
part = "both"; // [both, top, bottom]
// Spacing between parts
spacing = 10;

/* [Hidden] */
$fn = 360;
cableRadius = cableDiameter / 2;
rInner = h / 2 + (s * s) / (8 * h);

rOuter = rInner + thickness;
heightTotal = height + bottom * 2 + cableDiameter;

rBrim = rOuter + walls + brim;
rHole = rInner - walls;

rOuterTop = rInner + thicknessTop;
heightTotalTop = height + top;

if(part == "bottom") {
  bottom();
}

else if(part == "top") {
  top();
}

else if(part == "both") {
  bottom();
  
  translate([0, (h + walls) * 2 + thickness + brim + spacing, 0])
    top();
}

module bottom() {
  difference() {
    group() {
      bottomHalf();
      rotate([0, 0, 180])
        bottomHalf();
    }
    
    rotate([0, 90, cableOffset])
      translate([-cableRadius - bottom, 0, -s])
        cylinder(h= s, r=cableRadius);
  }
}

module top() {
  topHalf();
  rotate([0, 0, 180])
    topHalf();
}

module topHalf() {
  translate([0, rInner - h, 0]) {
    difference() {
      segment(top, heightTotalTop, rOuterTop);

      translate([-rBrim - 1, -rInner + h, -1])
        cube([(rBrim + 1) * 2, (rBrim + 1) * 2, heightTotalTop + 2]);
    }
  }
}

module bottomHalf() {
  translate([0, rInner - h, 0]) {
    difference() {
      segment(bottom * 2 + cableDiameter, heightTotal, rOuter);

      translate([-rBrim - 1, -rInner + h, -1])
        cube([(rBrim + 1) * 2, (rBrim + 1) * 2, heightTotal + 2]);
      
      hole();
    }
  }
  
  brim();
}

module segment(height, heightTotal, rOuter) {
  difference() {
    cylinder(r = rInner, h = heightTotal);

    translate([0, 0, -1])
      cylinder(r = rInner - walls, h = heightTotal + 2);
  }

  difference() {
    group() {
      cylinder(r = rOuter + walls, h = heightTotal);
    }

    translate([0, 0, height])
      cylinder(r = rOuter, h = heightTotal + 2);
  }
}

module hole() {
  translate([0, 0, bottom])
    cylinder(r = rHole, h = heightTotal + 2);
}

module brim() {
  translate([0, rInner - h, 0]) {
    difference() {
      cylinder(r = rBrim, h = bottom * 2 + cableDiameter);

      translate([-rBrim - 1, -rInner + h, -1])
        cube([(rBrim + 1) * 2, (rBrim + 1) * 2, heightTotal + 2]);

      hole();
    }
  }
}