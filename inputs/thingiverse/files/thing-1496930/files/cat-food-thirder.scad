// This work is licensed under the Creative Commons Attribution 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/
// or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

// Select US oz size, or 0 to use custom measurements.
canSize = 5.5; //[0,3,5.5]

// Only used if Predefined Size is 0
customHeight = 36;
// Only used if Predefined Size is 0
customDiameter = 76;

// Number of portions to create. If your cat needs a half can, set to 4 and give them two portions.
numberOfPortions = 3;//[3:1:10]

// Make thicker if your printer is having problems.
wallThickness = 1;

module dragons() {
  // Beyond this point be tunables that you shouldn't normally tune.
}
spokeCount=numberOfPortions;

// These numbers need measurements
threeOzHeight = 36;
fiveOzHeight = 36;
height = canSize == 5.5 ? fiveOzHeight : canSize == 3 ? threeOzHeight : customHeight;

// These numbers need measurements
threeOzDiameter = 58;
fiveOzDiameter = 76;
diameter = canSize == 5.5 ? fiveOzDiameter : canSize == 3 ? threeOzDiameter : customDiameter;

radius = diameter/2;

for(legRotation = [0 : 360/spokeCount: 360-spokeCount]) {
    rotate([0,0,legRotation]) translate([-wallThickness/2,0,0]) cube([wallThickness,radius,height]);
}