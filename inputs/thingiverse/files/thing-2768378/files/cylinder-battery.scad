// cylindrical battery spacer with holes to route wires

module cell(length, diameter, button_dia, button_height) {
     difference() {
          union() {
               cylinder(length, diameter/2, diameter/2, true);
               translate([0,0,length/2]) cylinder(button_height, button_dia/2, button_dia/2);
          };
          hole_angle = atan(diameter/(length+button_height));
          hole_rad = 1;
          translate([0,0,length/2])
               rotate([hole_angle,0,0])
               translate([0,0,length/2])
               cylinder(length*3, hole_rad, hole_rad, true);
          translate([0,0,-length/2])
               rotate([-hole_angle,0,0])
               translate([0,0,-length/2])
               cylinder(length*3, hole_rad, true);
     };
}

// AAA
$fa = 3;
$fs = .1;
cell(44-1, 10, 4, 1);
