wallThickness = 4;

insideX = 48;
insideY = 36;
insideZ = 85;
inside = [insideX, insideY, insideZ];

outsideX = insideX + (wallThickness * 2);
outsideY = insideY + (wallThickness * 2);
outsideZ = insideZ + wallThickness;
outside = [outsideX, outsideY, outsideZ];

smallInsideX = 10;
smallInsideY = 5;
smallInsideZ = 31;
smallInside = [smallInsideX, smallInsideY, smallInsideZ];

smallOutsideX = smallInsideX + (wallThickness * 2);
smallOutsideY = smallInsideY + (wallThickness * 2);
smallOutsideZ = smallInsideZ + wallThickness;
smallOutside = [smallOutsideX, smallOutsideY, smallOutsideZ];

brushTranslation = [
  (outsideX - smallOutsideX)/2,
  (outsideY - wallThickness),
  0
];

union() {
    difference() {
        cube(outside);
        translate([wallThickness, wallThickness, wallThickness]) {
            cube(inside);
        }
    }
    translate(brushTranslation) {
        difference() {
            cube(smallOutside);
            translate([wallThickness,wallThickness, wallThickness]) {
                cube(smallInside);
            }
        }
    }
}