/*
Simple Tool Box (c) by Jorge Monteiro

Simple Tool Box is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/
wallThickness = 1.5;
boxWidth = 90;
boxLength = 60;
boxHeight = 60;
separatorTopGap = 5;
separatorThickness = 1;

drawBox();
drawSeparators();

module drawSeparators() {
    separatorVertGrid = boxWidth/4;
    // Draw the walls
    translate([-boxWidth/2, 0, 0]) cube([boxWidth, separatorThickness, boxHeight-separatorTopGap]);
    translate([0, -boxLength/2, 0]) cube([separatorThickness, boxLength, boxHeight-separatorTopGap]);
    translate([-separatorVertGrid, -boxLength/2, 0]) cube([separatorThickness, boxLength, boxHeight-separatorTopGap]);
};

module drawBox() {
    // Draw the base
    translate([-boxWidth/2, -boxLength/2, 0]) cube([boxWidth,boxLength,wallThickness]);
    // Draw the walls
    translate([-boxWidth/2, -boxLength/2, 0]) cube([boxWidth, wallThickness, boxHeight]);
    translate([-boxWidth/2, boxLength/2-wallThickness, 0]) cube([boxWidth, wallThickness, boxHeight]);
    translate([-boxWidth/2, -boxLength/2, 0]) cube([wallThickness, boxLength, boxHeight]);
    translate([boxWidth/2-wallThickness, -boxLength/2, 0]) cube([wallThickness, boxLength, boxHeight]);
};
