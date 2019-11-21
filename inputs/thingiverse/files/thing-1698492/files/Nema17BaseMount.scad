x_width = 42;
y_width = 42;
rounding = 3;
thickness = 5;

// A plate fitting a nema17 motor. 
// x_width and y_width must be > motor_width
module nema_17_mount(x_width = 42, y_width = 42, rounding = 0, thickness=5)
{
  motor_width = 42;
  bolt = 4;

	$fs = 0.1;
	
  difference()
  {
    // plate
    if (rounding != 0) {
      x_offset = x_width/2-rounding;
      y_offset = y_width/2-rounding;
      hull() {
        for (x = [-x_offset, x_offset]) {
          for (y = [-y_offset, y_offset]) {
            translate([x, y, 0]) 
              cylinder(r=rounding, h=thickness);
          }
        }
      }
    } else {
      translate([0,0,thickness/2])
        cube([x_width, y_width, thickness], center=true); 
    }
    
    //nema 17 mount
    translate([0,0,-1])
    union() {
      // bolt holes
      for (x = [-15.5, 15.5]) {
        for (y = [-15.5, 15.5]) {
          translate([x, y, 0])
            cylinder(r=bolt/2, h=thickness+2);
        }
      }
      // shaft cover hole
      cylinder(r=11.5, h=thickness+2);
    }
  }
}

nema_17_mount(x_width, y_width, rounding, thickness);
