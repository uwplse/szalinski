/* [Basic Settings] */

// This is the number of cups to generate.
cups_to_print = 2; // [1:12]

// This is the overall height of each cup (or the cup height plus the height of the outside lip).
total_height = 11; // [7:20]

// This is the height of the cup up to the outside lip (or the depth of the hole the cup is inserted into).
cup_height = 8.7; // [5:0.1:15]

// This is the radius of the cup without the lip (or the radius of the hole the cup is inserted into).
cup_outer_radius = 21.6; // [15:0.1:30]

// This is the additional radius of the outside lip.
lip_overlap = 5; // [3:10]

// This is the thickness of the wall of the cup.
wall_thickness = 1.25;

// Calculated Values
radial_segmets = 100*1;
cups_per_row = 3*1;
cup_center = cup_outer_radius+lip_overlap;

function cup_offset(i) = [
  floor(i/cups_per_row)*((cup_center*2)+5), 
  (i%cups_per_row)*((cup_center*2)+5), 
  0
];

function cup_origin(i) = [
  cup_offset(i)[0]+cup_center, 
  cup_offset(i)[1]+cup_center, 
  0
];

module create_cups(cups)
  for(i=[0:cups-1]) 
    translate(cup_origin(i))
    difference () {
      union () {
          cylinder(h=total_height,r=cup_outer_radius,$fn=radial_segmets);
          cylinder(h=total_height-cup_height,r=cup_outer_radius+lip_overlap,$fn=radial_segmets);
      }
      translate([0,0,(-1*wall_thickness)])
        cylinder(h=total_height,r=cup_outer_radius-wall_thickness,$fn=radial_segmets);
    }

create_cups(cups_to_print);