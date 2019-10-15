// Wall Thickness Test Object

start_thickness = 0.2; // [0:0.01:2]
increment = 0.05; // [0:0.01:0.2]
iterations = 30; // [10:1:50]
length = 10; // [5:2:50]
offset = 10; // [5:2:40]
height = 1.0; // [0.1:0.1:2]
base_thickness = 1; // [1:1:100]
base_height = 1.0; // [0.1:0.1:2]
  
module walltest()
{
  module testline(width, length, height, offset, theta)
  {
      rotate(theta)
      translate([0, offset, 0])
      cube([width, length, height], center=false);
  }

  difference() {
    cylinder(base_height, offset+base_thickness, offset+base_thickness, center=false);
    translate([0, 0, -1])
    cylinder(base_height+2, offset, offset, center=false);
  }

  for(i = [0:iterations]) {
    testline(start_thickness + i * increment, length, height, offset, 360/(iterations+1) * i);
    echo(start_thickness + i * increment);
  }
}

walltest();