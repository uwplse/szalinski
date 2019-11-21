//
// Pacman Ghost
// ------------
//
// Created by Joao Alves (jpralves@gmail.com)
// ------------------------------------------
//
// Parameters:


// Figure diameter
diameter = 25; // [25:5:100]

height = diameter*0.65; 
// Add keychain
key_chain = 0; // [1:On, 0:Off]
// Add LED hole
led_Hole = 0; // [0:Off, 5:5mm, 8:8mm, 10:10mm]

// Detail
$fn=100; // [20:Low Res, 50:Normal Res, 100:Hi Res]

rotate([0,0,-90])
difference() {
  union() {
    cylinder(d = diameter, h = height);
    translate([0, 0, height]) sphere(d = diameter);
    if (key_chain == 1) {
      translate([0, 0, height+diameter/2])
        rotate([0, 90, 0])
          rotate_extrude()
            translate([4, 0, 0])
              circle(r = 1.5);
    }
  }
  translate([diameter/2, -diameter/4, height])
    sphere(d = diameter/3.5);
  translate([diameter/2, diameter/4, height])
    sphere(d = diameter/3.5);
  translate([0, 0, -0.1]) 
    for(a = [0:11]) {
      rotate([a/12*360,-90,0]) 
        scale([1.5,1,1])
          translate([0,0,diameter/12.5]) 
            cylinder(diameter, 0,diameter/25*6.5, $fn=4);
    }
  if (led_Hole > 0) {
    union() {
      cylinder(d = led_Hole+2, h = height-(led_Hole+2));
      translate([0, 0, height-(led_Hole+2)]) sphere(d = led_Hole+2);
    }
  }
}