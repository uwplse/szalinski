$fn = 70;

//All measurements are in mm (as long as they are actually a measurement, not
// a relative value. This will be stated if it's not in mm

//Height of the ring
ringHeight = 5;

//Diameter of the ring on the outside
outerDiameter = 20;

//Diameter of the ring on the inside
innerDiameter = 17;

//Text on the ring (if you want any)
ringText = "One ring to rule them all";

//If you want the text to wrap around the entire ring, leave this at 0
//This value is not a metric or imperial measure, just the amount of space
// 'left' at the back of the ring.
//The higher this value is, the closer the letters will be together
letterWrapOffset = 3;

//This is not a regular way of adjusting text size, but it will have to do
//Basically it sets the size relative to the ring. Experiment around with
// different values. I've found 2.5 is a good default value. Remember, this
// is not metric or imperial, just a relative value
textSize = 2.5;

//The vertical position of the letters incase you want an offset. Positive
// and negative values both work
verticalLetterPos = 0;

//This is the depth of the letter in mm
letterDepth = 5;

offsetLetters = 360 / (len(ringText) + letterWrapOffset);

union() {
    for (i = [0:len(ringText)]) {
        translate([-sin(i * offsetLetters) * (outerDiameter / 2.15), cos(i * offsetLetters) * (outerDiameter / 2.15), (-(textSize * ringHeight / 4) / 2) + verticalLetterPos]) {
            rotate([90, 0, i * offsetLetters + 180]) {
                linear_extrude(height = letterDepth / 5) {
                    text(ringText[i], size = textSize * ringHeight / 4, halign = "center");
                }
            }
        }
    }

    difference() {
        sphere(d = outerDiameter);
        union() {
            translate([0, 0, ringHeight / 2]) {
                cylinder(d = outerDiameter + 1, h = outerDiameter);
            }
            translate([0, 0, -(ringHeight / 2) - outerDiameter]) {
                cylinder(d = outerDiameter + 1, h = outerDiameter);
            }
            translate([0, 0, -(ringHeight + 1) / 2]) {
                cylinder(d = innerDiameter, h = ringHeight + 1);
            }
        }
    }
}
