//Dualstrusion or regular?
part = "first"; //[first:Body (regular),second:Body (dualstrusion),third:Face(dualstrusion)]

//Pixel size in millimeters
pixel_size = 1;

scale(pixel_size)
{
//make it on its side
translate([0,0,8]) rotate([0,90,0])
{

if(part == "first")
{
union()
{
//legs
cube([8,4,6 + 1]);
translate([0,8,0]) cube([8,4,6 + 1]);
//body
translate([0,4,6]) cube([8,4,12]);
//head
//translate([0,2,16]) cube(8);
//eyes + mouth
difference()
{
translate([0,2,16]) cube(8);

union()
{
//mouth
translate([2,2,16 - 0.1]) cube([1,0.5,3 + 0.1]);
translate([2,2,17]) cube(1);
translate([5,2,16 - 0.1]) cube([1,0.5,3 + 0.1]);
translate([5,2,17]) cube(1);
translate([3,2,17]) cube([2,0.5,3]);
translate([3,2,17]) cube([2,1,2]);
//left eye
translate([1 - 0.1,2,20]) cube([2,1,2]);
translate([1 - 0.1,2,20]) cube([1,2,2]);
translate([2 - 0.1,2,21]) cube([1,2,1]);
//right eye
translate([5 + 0.1,2,20]) cube([2,1,2]);
translate([6 + 0.1,2,20]) cube([1,2,2]);
translate([5 + 0.1,2,21]) cube([1,2,1]);
}
}
}
}
else if (part == "second")
{
union()
{
//legs
cube([8,4,6 + 1]);
translate([0,8,0]) cube([8,4,6 + 1]);
//body
translate([0,4,6]) cube([8,4,12]);
//head
//translate([0,2,16]) cube(8);

//eyes + mouth
difference()
{
translate([0,2,16]) cube(8);

union()
{
//mouth
translate([2,2,16 - 0.1]) cube([1,1,3 + 0.1]);
translate([5,2,16 - 0.1]) cube([1,1,3 + 0.1]);
translate([3,2,17]) cube([2,1,3]);
//left eye
translate([1 - 0.1,1,20]) cube([1,2,2]);
translate([2 - 0.1,1,21]) cube([1,2,1]);
//right eye
translate([6 + 0.1,1,20]) cube([1,2,2]);
translate([5 + 0.1,1,21]) cube([1,2,1]);
}
}
}
}
else if (part == "third")
{
union()
{
//mouth
translate([2,2,16 - 0.1]) cube([1,1,3 + 0.1]);
translate([5,2,16 - 0.1]) cube([1,1,3 + 0.1]);
translate([3,2,17]) cube([2,1,3]);
//left eye
translate([1 - 0.1,2,20]) cube([1,1,2]);
translate([2 - 0.1,2,21]) cube([1,1,1]);
//right eye
translate([6 + 0.1,2,20]) cube([1,1,2]);
translate([5 + 0.1,2,21]) cube([1,1,1]);
}
}

}
}