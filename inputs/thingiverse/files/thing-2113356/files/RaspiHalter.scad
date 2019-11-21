//Width of the object that goes into the stand
width = 33; // [0:0.5:100]
//Length of the bridge between both feet
length = 30; // [0:0.5:100]
//Thickness of the feet
thickness = 10; // [1:0.5:100]

module side()
{
 difference()
 {
  translate([0,0,-thickness/2])
  cube([15, 15, thickness]);
  translate([0,15,0])
  cylinder(d=25, h=thickness+2, $fn=25, center=true);
 }
}

module end()
{
 translate([0, 0, thickness/2])
 side();

 translate([15-1, 0, 0])
 cube([width+2, 3, thickness]);

 translate([width, 0, 0])
 translate([30, 0, , thickness/2])
 mirror([1,0,0])
 side();
}

module model()
{
 translate([0,thickness,0])
 rotate([90,0,0])
 end();

 translate([15+width/2-thickness/2,thickness-1,0])
 cube([thickness, length+2, 3]);

 translate([0,thickness+length+thickness,0])
 rotate([90,0,0])
 end();
}

model();