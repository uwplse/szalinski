//Width of the label area
labelWidth = 12; //[6,9,12,18]
//Length of the label area
labelLength = 30; //[10:100]
//Diameter of your cable
cableDiameter = 5; //[3:1:10]
//Cable tie type
cableTieW = 2.5; //[2.5:T18, 3.5:T30, 4.6:T50]

/* [Advanced] */
//Cable tie thickness
cableTieT = 1.3;
//Spacing between label area and cable tie hole
innerMargin = 1;
//Spacing between cable tie hole and outer edge
outerMargin = 2;

/* [Hidden] */
//Calculated variables
cableTieHoleW = cableTieW + 1;
cableTieHoleT = cableTieT + 0.5;
totalLength = labelLength + (innerMargin*2) + (outerMargin*2) + (cableTieHoleW*2);

cableTieHoleX = (labelLength/2)+(cableTieHoleW/2)+innerMargin;
cableTieHoleY = (cableDiameter*0.4)+(cableTieHoleT/2);

$fn=30;

difference(){
union(){
if (((cableDiameter*0.8)+(cableTieHoleT*2)) > labelWidth) {
    totalWidth = (cableDiameter*0.8)+(cableTieHoleT*2)+2;
    cube([totalLength, totalWidth, 1], center=true);
} else {
    totalWidth = labelWidth + 2;
    cube([totalLength, totalWidth, 1], center=true);
}
translate([0,0,1]) {
    difference(){
        cube([totalLength, cableDiameter*0.8, cableDiameter*0.3], center=true);
        translate([0,0,cableDiameter/2]) {
            rotate([0,90,0]) {
                cylinder(h=totalLength+1, d= cableDiameter, center=true);
            }
        }
    }
}
}
union(){
translate([cableTieHoleX,cableTieHoleY,0]) {
cube([cableTieHoleW, cableTieHoleT, 10], center=true);
}
translate([-1*cableTieHoleX,cableTieHoleY,0]) {
cube([cableTieHoleW, cableTieHoleT, 10], center=true);
}
translate([cableTieHoleX,-1*cableTieHoleY,0]) {
cube([cableTieHoleW, cableTieHoleT, 10], center=true);
}
translate([-1*cableTieHoleX,-1*cableTieHoleY,0]) {
cube([cableTieHoleW, cableTieHoleT, 10], center=true);
}
}
}