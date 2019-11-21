$fn = 64;
wheel_grooves = 24;
wheel_diameter = 4.7;
wheel_height = 1.2;
rim_inset = 0.5;
rim_diameter = 3.2;
groove_size = 0.3;
groove_offset = wheel_diameter / 2;
hubcap_diameter = 1.6;
hubcap_height = 0.2;

module wheel() {
  difference() {
    cylinder(d=wheel_diameter, h=wheel_height);
    group() {
      translate([0, 0, wheel_height - rim_inset])
        cylinder(d=rim_diameter, h=rim_inset);
      for (i = [1:1:wheel_grooves])
        translate([sin(360 * i / wheel_grooves) * groove_offset, cos(360 * i / wheel_grooves) * groove_offset, wheel_height / 2])
          rotate([0, 0, atan2(cos(360 * i / wheel_grooves) * groove_offset, sin(360 * i / wheel_grooves) * groove_offset)])
            cylinder(d=groove_size, h=wheel_height, center=true, $fn = 6);
    }
  }
  
  translate([0, 0, wheel_height - rim_inset])
    cylinder(d=hubcap_diameter, h=hubcap_height);
}

for (x = [0, 8, 16, 24])
  translate([x, 0, 0])
    wheel();