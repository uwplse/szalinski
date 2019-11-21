/*  Cam lock cover for Ikea & other cheap furniture
    Russell Salerno 2/7/2017
*/

$fn=120;

crossDepth = 3.5;
crossThickness = 1.2;
crossHeight = 8.9;
crossWidth = 6.4;

capDepth = 0.8;
capDia = 14.7;

translate([0, 0, capDepth]) linear_extrude(crossDepth) square([crossThickness, crossHeight], center=true); 
translate([0, 0, capDepth]) linear_extrude(crossDepth) square([crossWidth, crossThickness], center=true); 
linear_extrude(capDepth) circle(d=capDia, center=true);