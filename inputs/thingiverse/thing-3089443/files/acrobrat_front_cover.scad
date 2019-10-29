/* [Camera] */
// Diameter of the camera cutout
camDiameter = 15;
// Offset where the initial hole is positioned
camOffset = 25;
// Angle of the beginning of the cutout
camAngle1 = 0;
// Angle of the end of the cutout
camAngle2 = -52;
// Angle height offset
camZOffset = 38;

/* [Misc] */
paddingBottom = 2;
spacing = 25;
standoffDiameter = 5;
walls = 0.6;
straightLength = 33;
offsetX = 7.7;
offsetY = 10.5;
padding = 0.6;

roundness1 = -7.4;
roundness2 = -11;

/* [Hidden] */
$fn = 50;
totalHeight = (paddingBottom) * 2 + spacing;
standoffRadius = standoffDiameter / 2;
radius = standoffRadius + walls;
camRadius = camDiameter / 2;

camHeight = 50;

c = sqrt(offsetX * offsetX + offsetY * offsetY);
alphaInner = 50;
r = c / (2 * sin(alphaInner / 2));

alphaOuter= 90;
r1 = c / (2 * sin(alphaOuter / 2));

steps = 5;

offsetHoleY = 43.5;

rotate([0, 270, 0])
bumper();

/*
translate([-15,0,0])
    rotate([0,0,-90])
        mirror([1,1, 0])
            bumper();
            */

module bumper() {
    difference() {
        shapeSlim(radius + padding, radius  / 2);
        translate([0, 0, totalHeight - paddingBottom]) {
            shape(standoffRadius + padding);
            translate([0, -radius - 1, 0])
                cube([straightLength, straightLength + radius + 1, totalHeight]);
            translate([0, straightLength, 0])
                rotate([0, 0, -35])
                    cube([straightLength, straightLength + radius + 1, totalHeight]);
        }
        
        translate([0, 0, paddingBottom - totalHeight]) {
            shape(standoffRadius + padding);
            translate([0, -radius - 1, 0])
                cube([straightLength, straightLength + radius + 1, totalHeight]);
            translate([0, straightLength, 0])
                rotate([0, 0, -35])
                    cube([straightLength, straightLength + radius + 1, totalHeight]);
        }
        
        translate([0, 0, -1]) {
            cylinder(r = standoffRadius, h = totalHeight + 2);
            translate([offsetX, offsetHoleY, 0])
                cylinder(r = standoffRadius, h = totalHeight + 2);
        }
        
        hull() {
          translate([camHeight - radius - camZOffset - 1, camOffset, totalHeight / 2])
            rotate([0, -90, 0])
              cylinder(r=camRadius, h = camHeight);
          
          translate([camHeight - radius - camZOffset - 1, camOffset, totalHeight / 2])
            rotate([camAngle2, -90, 0])
              cylinder(r=camRadius, h = camHeight);
        }
    }
}

module shape(radius) {
    difference() {
        group() {
            hull() {
                cylinder(r = radius, h = totalHeight);
                translate([0, straightLength, 0])
                    cylinder(r = radius, h = totalHeight);
            }
            translate([offsetX, offsetHoleY, 0])
                cylinder(r = radius, h = totalHeight);

            translate([0, straightLength, 0])
                rotate([0, 0, roundness2])
                    translate([r, 0, 0])
                        segment(130, steps, 175, 50, radius); // 50
        }
    }
    
    cylinder(r = radius, h = totalHeight);    
    translate([offsetX, offsetHoleY, 0])
        cylinder(r = radius, h = totalHeight);
}


module shapeSlim(radius, smaller) {
    difference() {
        group() {
            hull() {
                translate([-smaller, 0, 0])
                    cylinder(r = radius - smaller, h = totalHeight);
                translate([-smaller, straightLength, 0])
                    cylinder(r = radius - smaller, h = totalHeight);
            }
            translate([offsetX, offsetHoleY, 0])
                cylinder(r = radius, h = totalHeight);

            translate([-smaller, straightLength, 0])
                rotate([0, 0, roundness1])
                    translate([r, 0, 0])
                        segment(125, steps, 175, 50, radius - smaller); // 50
        }
    }
    
    cylinder(r = radius, h = totalHeight);    
    translate([offsetX, offsetHoleY, 0])
        cylinder(r = radius, h = totalHeight);
}

module segment(start, steps, end, alpha, radius) {
    r = c / (2 * sin(alpha / 2));

    for(a = [start:steps:end]) {
        hull() {
            rotate([0, 0, a])
                translate([r, 0, 0])
                    cylinder(r = radius, h = totalHeight);
            rotate([0, 0, a + steps])
                translate([r, 0, 0])
                    cylinder(r = radius, h = totalHeight);
        }
    }
}