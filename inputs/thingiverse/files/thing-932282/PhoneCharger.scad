


width=110; // [90:150]

/* [Hidden] */
$fn=100;

//
/*/
    2 ________ 3
     /        \
  1 /          \4
    \          /
    6\________/ 5
*/
charger_dimensions= [
  [ -7,13.5/2],
  [  0,  0],
  [ 25, 0],
  [ 25+7,13.5/2],
  [25, 13.5],
  [ 0,13.5],
];

// adjustments for my charger
scale([0.9, 0.9, 0.9]) {

// charger
  translate([-12.5, 0, 0])
    linear_extrude(height = 25) {
     difference() {
       offset(r = 3) {
         polygon (points=charger_dimensions);
       }
       offset(r = 1) {
         polygon (points=charger_dimensions);
       }
     }
    }

// Phone
  difference() {
    translate([0,-6,12.5]) {
      color ("red") cube([width,10,25], center=true);
    }
    translate([0,-9,15]) {
      color ("blue") cube([width+1,10,24], center=true);
    }
  }
}
