$fn=128;

BaseWidth=152*1;
BaseLength=190*1;
BandHeight_mm=12.7*1;
BandThickness_mm=3*1;

//Measure your head in mm with a sewing tape measure
HeadCircumference_mm = 540; //[450:750]


CircPercent = HeadCircumference_mm/540;
CalcLength = BaseLength*CircPercent/2;
CalcWidth = CalcLength*0.799;
echo(CalcLength);
echo(CalcWidth);

//Define an Oval (shape of band)
module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center); 
};
//Create the Band, with hole in back for rear ornament
difference() {
    difference() {oval (CalcLength+BandThickness_mm,CalcWidth+BandThickness_mm,BandHeight_mm,center=false,center=false);
translate ([0,0,-1]) oval (CalcLength,CalcWidth,BandHeight_mm+2,center=false);};
translate([(CalcLength+20)*-1,0,BandHeight_mm/2]) rotate([0,90,0]) cylinder(40,r=2.45,center=false);}

//Define the Mounting Bracket
module CubeMount(width, height, center=false){
    difference() {translate([-2.25,-3,BandHeight_mm/2-3]) cube([4.45,5.95,5.95]); difference() {translate([0.71,3,BandHeight_mm/2-3.05]) rotate([90,0,0]) cube([1.5,1.5,6.1]);
    translate([0.71,3,BandHeight_mm/2-3+1.45]) rotate([90,0,0]) cylinder(h=8,r=1.5,center=center);}}
};
//Front Mount for centerpiece
translate([CalcLength+BandThickness_mm,0,0]) CubeMount();
//Mounts for XL Leaves
translate([84/101*CalcLength+BandThickness_mm,43.5*CircPercent,0]) rotate([0,0,39]) CubeMount();
translate([84/101*CalcLength+BandThickness_mm,-43.5*CircPercent,0]) rotate([0,0,-39]) CubeMount();
//Mounts for L Leaves
translate([60/101*CalcLength+BandThickness_mm,62.8*CircPercent,0]) rotate([0,0,59]) CubeMount();
translate([60/101*CalcLength+BandThickness_mm,-62.8*CircPercent,0]) rotate([0,0,-59]) CubeMount();
//Mounts for M Leaves
translate([38/101*CalcLength+BandThickness_mm,72.3*CircPercent,0]) rotate([0,0,71]) CubeMount();
translate([38/101*CalcLength+BandThickness_mm,-72.3*CircPercent,0]) rotate([0,0,-71]) CubeMount();
//Mounts for S Leaves
translate([18/101*CalcLength+BandThickness_mm,76.9*CircPercent,0]) rotate([0,0,81]) CubeMount();
translate([18/101*CalcLength+BandThickness_mm,-76.9*CircPercent,0]) rotate([0,0,-81]) CubeMount();