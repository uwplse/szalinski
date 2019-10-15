include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

// Outer size
size = 15; //[5:60]

// Inner hole size
inner_size = 9; //[3:55]

// Number of pins
pins = 8; //  [3,4,5,6,7,8,9,10]

// notches on pins
notches = 1; // [0,1,2,3,4]

notch_depth = 1.1;

notch_height = 9;

// Ring thickness
ring_height = 4; // [2:6]

// Pin height
pin_height = 18; // [5:30]

pin_radius = 4;

// pin wall size in mm
pin_wall_thickness = 1;

//  This section is creates the build plates for scale
//  for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//  when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//  when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


//CUSTOMIZER VARIABLES END

//  This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module pin(rot) {
  rotate([0,0,rot]) {
    translate([inner_size + pin_radius, 0, (pin_height / 2)]) {
      difference() {
        scale([1,0.8,1]) cylinder(r=pin_radius, h=pin_height, center=true, $fs=1);

        // drill out the pin
        scale([1,0.8,1]) cylinder(r=pin_radius - pin_wall_thickness, h=pin_height * 1.1, center=true, $fs=1);

        // notches
        for (p=[notches/2 * -1 + 1:notches/2]) {
          translate([0, 0, p * ring_height]) {
            translate([1.5,0,0]) cube([notch_depth, 360/pins, notch_height], center=true);
          }
        }
      }
    }
  }
}

translate([0, 0, ring_height/2]) difference() {
  cylinder(r=size, h=ring_height, center=true);

  // cut out center hole
  cylinder(r=inner_size, h=ring_height + 2, center=true);
}


difference() {
  for (i=[1:pins]) {
    pin(i * (360 / pins));
  }

  // outer ring to shear off the pins
  translate([0,0,(ring_height + pin_height) / 2.2]) {
    difference() {
      cylinder(r=size*2, h=ring_height + pin_height, center=true);
      cylinder(r=size, h=ring_height + pin_height, center=true);
    }
  }
}
