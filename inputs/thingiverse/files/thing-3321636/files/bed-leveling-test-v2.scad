// bed leveling test.scad
// Creative Commons Atribution (CC-BY 3.0) License Applies
// Author:  David O'Connor (https://www.thingiverse.com/lizard00)

// Version History:
// 29 Dec 2018  Initial Version; posted to Thingiverse
// 30 Dec 2018  Added option not to have letters
//              Prevented printing of non-alphabetic characters



squareSize = 20;  // Square Width
patternSize = 220;  // Pattern Width (best around 90% of your build plate width)
height = 1.2;  // Square Height
// True to print letters on the top faces
printLetters = true; //[true, false]
// Number of rows of squares
n = 7; // [2, 3, 4, 5, 6, 7]

///////////////////////////////////////////

fontStyle = "Liberation Sans:style=Bold";
letterThicknessFactor = 0.5;
letterSizeFactor = 0.75;
imax = floor((n-1)/2);
dx = patternSize / (n-1);

for (i = [1:n]) {
    x = -0.5*patternSize + (i-1)*dx;
    for (j = [1:n]) {
        y = -0.5*patternSize + (j-1)*dx;
        charNum = 64+i + (n - j) * n;
        textString = chr(charNum <= 90 ? charNum : charNum + 6);
        translate([x, y, 0.5*height]) {
            cube([squareSize, squareSize, height], center=true);
            if (printLetters == true) {
                color([1, 0, 0]) translate([0, 0, letterThicknessFactor*height])linear_extrude(height*letterThicknessFactor) {
                    text(textString, valign = "center", halign = "center", size = letterSizeFactor * squareSize, font=fontStyle);
                }
            }
        }
    }
}
        