fn = 64;
// Radius of the loop part of the pin
pin_radius = 5;
// Pin length
pin_length = 40;
// Pin width
pin_width = 10;
// Thickness of the arms
pin_thickness = 2;
// Gap between the arms. When you put something of this thickness in the pin, the arms should be parallel.
pin_gap = 1.34;

// Tooth width
tooth_width = 2.2;
// Tooth height
tooth_height = 1;
// Which side to put the teeth on. Set to false to put teeth on flat side.
teeth_on_spring_side = true;

linear_extrude(pin_width) pin_section();

module pin_section() {
  difference() {
    translate([0, pin_radius], 0) {
      difference() {
        circle(pin_radius, $fn=fn);
        circle(pin_radius - pin_thickness, $fn=fn);
      }
    }
    translate([0, pin_thickness]) polygon([
      [0, 0],
      [0, pin_gap + tooth_height],
      [(pin_gap+tooth_height)/pin_gap*pin_length, 0]
    ]);
  }

  square([pin_length, pin_thickness]);
  if (!teeth_on_spring_side) {
    translate([0, pin_thickness]) teeth();
  }

  difference() {
    rotate([0, 0, atan(pin_gap/pin_length)*-1])
    translate([0, pin_gap + tooth_height + pin_thickness]) {
      square([pin_length, pin_thickness]);
      if (teeth_on_spring_side) mirror([0, 1, 0]) teeth();
    }
    
    translate([0, pin_radius], 0) circle(pin_radius - pin_thickness, $fn=fn);
  }
}

module teeth() {
  translate([(pin_length-pin_radius)%tooth_width, 0])
  for (i = [pin_radius : tooth_width : pin_length-tooth_width]) {
    polygon([[i, 0], [i + tooth_width/2, tooth_height], [i + tooth_width, 0]]);
  }
}

