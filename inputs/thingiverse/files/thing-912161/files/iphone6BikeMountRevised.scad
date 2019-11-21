
// mm 
phoneWidth = 71;

// mm 
phoneLength = 142;

// mm
phoneHeight = 10;

// mm 
phoneCornerRad = 10;

// mm
handlebarDiameter = 25;

// Measured from feet to bottom of holder (mm)
bridgeHeight = 20;



leftHalf();
mirror([1,0,0]) leftHalf();
module leftHalf()
{

rimWidth = 5;
barWidth = 20;
barTop = .6;  // fraction of length for y position of top of bar

$fn=100;
handlebarRad = handlebarDiameter/2;
cutoutRad = (phoneWidth-barWidth)/2;

y1 = handlebarRad+rimWidth;
y2 = y1+bridgeHeight*tan(20);


crossBarTop = barTop*phoneLength-phoneLength/2;
crossBarBottom = crossBarTop-barWidth;
cutoutLength = phoneLength/2 - phoneCornerRad - cutoutRad + crossBarBottom;



difference()
{
// outer box
roundedRect(phoneWidth+2*rimWidth,phoneLength+2*rimWidth,phoneHeight+rimWidth,phoneCornerRad+rimWidth);

//inner box
translate([0,0,rimWidth/2])
roundedRect(phoneWidth,phoneLength,phoneHeight,phoneCornerRad);
// left coutout
translate([-phoneWidth/2,-(phoneLength/2-cutoutRad-phoneCornerRad),-(phoneHeight+rimWidth)/2])
difference()
{
    cylinder(r=cutoutRad,h=rimWidth+phoneHeight);
    translate([-cutoutRad,0,0])
    cube([2*cutoutRad,cutoutRad,rimWidth+phoneHeight]);
}
translate([-phoneWidth/2-rimWidth,crossBarBottom-cutoutLength,-phoneHeight])
cube([cutoutRad+rimWidth,cutoutLength,2*phoneHeight]);

// Cutout entire right half
translate([-phoneWidth-barWidth/2,-phoneLength/2+barTop*phoneLength,-phoneHeight])
cube([phoneWidth,phoneLength,2*phoneHeight]);
translate([phoneWidth/2,0,0])cube([phoneWidth,phoneLength*2,phoneHeight*2],center=true);
// Cut front to just over bar height
translate([0,phoneLength/2,rimWidth/2+2])cube([phoneWidth/2,2*rimWidth,phoneHeight],center=true);
// Cut back
translate([0,-rimWidth/2-phoneLength/2,0])
    cube([phoneWidth-2*phoneCornerRad,rimWidth,2*phoneHeight],center=true);
}

// Gripper
translate([-phoneWidth/2-rimWidth,crossBarBottom+barWidth,(phoneHeight+rimWidth)/2])
rotate([90,0,0])
linear_extrude(height=barWidth)
polygon([[0,0],[rimWidth,0],[3*rimWidth/2,rimWidth],[0,rimWidth]],convexity=1);


translate([-barWidth/2,0,-bridgeHeight-(rimWidth+phoneHeight)/2])
rotate([90,0,90])
difference()
{
    union()
    {
        linear_extrude(height=rimWidth)
        polygon([[-y1,0],[y1,0],[y2,bridgeHeight],[-y2,bridgeHeight]],1);
        cylinder(r=handlebarRad+rimWidth,h=barWidth/2);
    }
    cylinder(r=handlebarRad,h=barWidth/2);
    translate([-y1,-handlebarRad-rimWidth,0])cube([2*y1,handlebarRad+rimWidth,20]);
}
}


// This module creates the shape that needs to be subtracted from a cube to make its corners rounded.

module createMeniscus(height, radius){

rrhide = 0.001;

//This shape is basicly the difference between a quarter of cylinder and a cube

difference(){

translate([radius/2 + rrhide, radius/2 + rrhide]){

cube([radius + rrhide, radius + rrhide, height + rrhide], center=true); 

}

cylinder(h = height, r = radius, $fn = 25, center=true);

}

}

// Now we just substract the shape we have created in the four corners

module roundedRect(xu, yu, zu, ru) { 

rotation = 0;

difference(){

cube([xu, yu, zu], center=true);

translate([xu/2-ru, yu/2-ru]){

rotate(0){ 

createMeniscus(zu, ru); 

}

}



translate([-xu/2+ru, yu/2-ru]){

rotate(90){

createMeniscus(zu, ru);

}

}

translate([-xu/2+ru, -yu/2+ru]){

rotate(180){

createMeniscus(zu, ru);

}

}



translate([xu/2-ru, -yu/2+ru]){

rotate(270){

createMeniscus(zu, ru);

}

}

}

}

module roundedRectX(x, y, z, r){

rotate([90,0,90]){

roundedRect(y, z, x, r);

}

}

module roundedRectY(x, y, z, r){

rotate([0,90,90]){

roundedRect(z, x, y, r);

}

}

module roundedRectZ(x, y, z, r){

roundedRect(x, y, z, r);

}