include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

// Number of pins (Anzahl der Pins)
pins = 10; //  [2:22]

// Pin height (Pin Hoehe)
pin_height = 20; // [5:30]



//CUSTOMIZER VARIABLES END

// #########################################################################################
// #########################################################################################

// Inner hole size
inner_size = pins*1.0+4; //[3:55]


// pin wall size in mm
pin_wall_thickness = 1.3*1.0;


// Outer size
size = inner_size+7*1.0; //[5:60]

// Ring thickness
ring_height = 3*1.0; // [2:6]


// notches on pins
notches = 1*1; // [0,1,2,3,4]
notch_depth = 1.80*1.0;
notch_height = pin_height-8;

pin_radius = 4.5*1.0;

//  This section is creates the build plates for scale
//  for display only, doesn't contribute to final object
build_plate_selector = 0*1.0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//  when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100*1.0; //[100:400]

//  when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100*1.0; //[100:400]



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
            translate([2.0,0,0]) cube([notch_depth, 360/pins, notch_height], center=true);
          }
        }
      }
    }
  }
}

translate([0, 0, ring_height/2]) difference() {
  color("red") cylinder(r=size, h=ring_height, center=true);

  // cut out center hole
  # cylinder(r=inner_size, h=ring_height + 2, center=true);
} 


difference() {
  for (i=[1:pins]) {
    color("lightgreen") pin(i * (360 / pins));
  }

  // outer ring to shear off the pins
  translate([0,0,(ring_height + pin_height) / 2.2]) {
    difference() {
      cylinder(r=size*2, h=ring_height + pin_height, center=true);
      cylinder(r=size, h=ring_height + pin_height, center=true);
    }
  }
}
