innerOffset = 7.8;
radius = 13;
depth = 7.2;
wallThickness = 1.7;
width = 27.25;
length = 43;

module cutoutpiece(adjust)
{
    union(){
        translate([0,innerOffset,0]) cube([radius, (radius*2)-adjust,depth]); //inner rectangle
        translate([radius,radius + innerOffset-(adjust/2),0]) cylinder(depth,r=(radius - (adjust/2)));
    }
 }
 
difference(){
    cube([width, length, depth]); //outer cube
    difference(){
        translate([wallThickness * 2, wallThickness, wallThickness]) cube([width - wallThickness, length - (wallThickness *2), depth - (wallThickness * 2)]); // innercube
        cutoutpiece(0);
    }
    translate([0,wallThickness/2,0]) cutoutpiece(wallThickness);
}

