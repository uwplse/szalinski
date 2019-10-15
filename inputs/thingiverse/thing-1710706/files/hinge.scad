// Hinge

// Which parts to print?
part = "all"; // [pin:Pin Only, side1:Side 1 only, side2: Side 2 only, both: Both sides no pin, cap: Hinge pin cap, all: All parts]

// Outer diameter of the hinge barrel.
barrel_diameter = 5;

// The closest any parts are allowed to come to each other.
spacing = 0.5;

// The length of the hinge.
length = 40;

// How many sections?
section_count = 4;

// How thick is the cap at each end of the pin.
pin_cap_thickness = 2;

side_length = 20;

hinge(barrel_diameter, spacing, length, section_count,
      pin_cap_thickness, 200, side_length, part);

// Function to calculate the needed section length to give a particular overall length
function hinge_section_from_overall(overall, section_count, spacing, pin_cap_thickness) =
    (overall - pin_cap_thickness * 2 - spacing * (section_count + 1))/section_count;

function hinge_side_offset(side, side_length) = (side == 1) ? 0 : -side_length;
function hinge_cutout_offset(side, side_length) =
    (side == 1) ? 0 : side_length;

module hinge_pin_cap (pin_cap_thickness, barrel_diameter, pin_diameter, pin_length, facets) {
  difference() {
    translate([0,0,pin_length-spacing]) {
      cylinder(d=barrel_diameter, h=pin_cap_thickness, $fn=facets);
    }
    hinge_pin (pin_cap_thickness, barrel_diameter, pin_diameter, pin_length, facets);
  }
}

module hinge_pin (pin_cap_thickness, barrel_diameter, pin_diameter, pin_length, facets) {
  union() {
    translate([0,0,-pin_cap_thickness-spacing]) {
      cylinder(d=barrel_diameter, h=pin_cap_thickness, $fn=facets);
    }
    translate([0,0,-spacing]) {
      cylinder(d=pin_diameter, h=pin_length + spacing, $fn=facets);
    }
  }
}

module hinge_side(barrel_diameter, side_thickness, side_length, full_offset, length, section_offset, side, facets) {
  difference() {
    translate([hinge_side_offset(side, side_length),
               barrel_diameter/2 - side_thickness,
               -full_offset]) {
      difference() {
        cube([side_length, side_thickness, length]);
        // Cutouts
        // Bottom
        translate([hinge_cutout_offset(side, side_length),
                   -side_thickness/2,
                   0]) {
          cylinder(d=barrel_diameter+spacing*2, h = full_offset, $fn=facets);
        }
        // Top
        translate([hinge_cutout_offset(side, side_length),
                   -side_thickness/2,
                   length - full_offset]) {
          cylinder(d=barrel_diameter+spacing*2, h = full_offset, $fn=facets);
        }
        // Sections
        for (i = [side:2:section_count-1]) {
          translate([hinge_cutout_offset(side, side_length),
                     -(barrel_diameter/2 - side_thickness),
                     i*section_offset + pin_cap_thickness]) {
            cylinder(d=barrel_diameter+spacing*2, h = section_offset, $fn=facets);
          }
        }
      }
    }
    // Match to barrel
    translate([0,0,-full_offset]) {
      cylinder(d=barrel_diameter, h=length, $fn=facets);
    }
  }
}

function should_render_section(section, part) =
    section % 2 == 1 ? part == "all" || part == "both" || part == "side1" :
                       part == "all" || part == "both" || part == "side2";

module hinge(barrel_diameter, spacing, length, section_count,
             pin_cap_thickness, facets, side_length, part) {
pin_diameter = barrel_diameter/2 - spacing;
section_length = hinge_section_from_overall(length, section_count, spacing, pin_cap_thickness);
section_offset = section_length + spacing;
side_thickness = (barrel_diameter - pin_diameter - spacing*2)/2;
// Shift needed to put the thing back on the origin.
full_offset = spacing+pin_cap_thickness;
pin_length = section_offset*section_count + spacing;

translate([0,0,full_offset]) {
  union() {
    // Sections of the barrel.
    for (i = [0: section_count-1]) {
      if (should_render_section(i, part)) {
        translate([0,0,i*section_offset]) {
          difference() {
            hull() 
            {
              cylinder(d=barrel_diameter, h=section_length, $fn=facets);
              if (i%2 == 0) {
                translate([barrel_diameter,barrel_diameter/2-side_thickness+0.01,0]) {
                  cube([1,0.01,section_length]);
                }
              } else {
                translate([-barrel_diameter,barrel_diameter/2-side_thickness+0.01,0]) {
                  cube([1,0.01,section_length]);
                }
              }
            }
            translate([0,0,-spacing]) {
              cylinder(d=pin_diameter+spacing*2, h=section_length+spacing*2, $fn=facets);      
            }
          }
        }
      }
    }
    
    // Side 1
    if (part == "all" || part == "both" || part == "side1") {
      hinge_side(barrel_diameter, side_thickness, side_length, full_offset, length,
          section_offset, 0, facets);
    }
    // Side 2
    if (part == "all" || part == "both" || part == "side2") {
      hinge_side(barrel_diameter, side_thickness, side_length, full_offset, length,
          section_offset, 1, facets);
    }

    // The pin.
    // TODO The pin should print with one cap separated when printed by itself.
    if (part == "all" || part == "pin" || part=="cap") {
      if (part != "cap") {
        hinge_pin (pin_cap_thickness, barrel_diameter, pin_diameter, pin_length, facets);
      }
      if (part != "pin") {
        hinge_pin_cap (pin_cap_thickness, barrel_diameter, pin_diameter, pin_length, facets);
      }
    }
  }
}
}
