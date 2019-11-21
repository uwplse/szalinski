use <threads.scad>;

height = 70;
width = 20;
thread_diameter = 9;
thread_slop = 0.4;

module block() {  
  difference() {
    color("Red")
      cube([width, width, height]);
    group() {
      translate([width / 2, width / 2, width / 2])
        metric_thread(diameter=thread_diameter, internal=true, length=height - width / 2, $fn=100);
      translate([7, 0, 15])
        cube([6, width / 2, height - 2 * 15]);
    }
  }
}

module grip(center_x, center_y, diameter) {
  count = 12;
  center_offset = diameter - 1;
  for (i = [1:1:count])
    translate([sin(360 * i / count) * center_offset, cos(360 * i / count) * center_offset, 0])
      rotate([0, 0, atan2(cos(360 * i / count) * center_offset, sin(360 * i / count) * center_offset)])
        cylinder(diameter=2, h=12, center=true, $fn=32);
}

module bolt() {
  union() {
    color("SteelBlue")
      metric_thread(diameter=thread_diameter - thread_slop, length=height - 14, $fn=100);
    color("SpringGreen")
      difference() {
        cylinder(d=width-2, h=6, $fn=64);
        grip(0, 0, width / 2);
      }
   } 
}


block();
translate([40, 0, 0])
  bolt();