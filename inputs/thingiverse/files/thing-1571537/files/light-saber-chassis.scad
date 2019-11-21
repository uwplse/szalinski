// Made by Fredrik Hubinette, 2016
// Licence: CC - Attribution
//
// preview[view:north, tilt:bottom]

/* [Disk Configuration] */

// Disc diameter.
outer_diameter = 1.25;
// Disc diameter unit.
outer_diameter_unit = 25.4; // [25.4:inches, 1:mm]

// Disc thickness.
thickness = 0.1875;
// Disc thickness unit.
thickness_unit = 25.4; // [25.4:inches, 1:mm]

// Battery configuration.
battery_configuration = 1; // [0:none, 1:1x18650/18500, 2:1xAA/16500/16650, 3:2xAA/16500/16650, 4:2xAAA/10440, 5:3xAAA/10440, 6:4xAAA/10440]

// Circuit board width.
circuit_board_holder = 1; // [1:true, 0:false]
// Width of circuit board.
circuit_board_width = 0.93;
// Width of circuit board unit.
circuit_board_width_unit = 25.4; // [25.4:inches, 1:mm]

/* [Hole set 1] */
// Enable this hole set.
hole_set_1_enable = 0;  // [1:true, 0:false]
// Diameter of hole(s).
hole_set_1_diameter = 0.315;
// Diameter of hole(s) unit.
hole_set_1_diameter_unit = 25.4; // [25.4:inches, 1:mm]
// Distance from center of disc to hole.
hole_set_1_center_distance = 0.0;
// Distance from center of disc to hole unit.
hole_set_1_center_distance_unit = 25.4; // [25.4:inches, 1:mm]
// How many holes (spread evenly around the disc.)
hole_set_1_howmany = 1; // [1:25]
// How many degrees to rotate the holes around the center.
hole_set_1_angle = 0;  // [0:359]

/* [Hole set 2] */
// Enable this hole set.
hole_set_2_enable = 0;  // [1:true, 0:false]
// Diameter of hole(s).
hole_set_2_diameter = 0.116;
// Diameter of hole(s) unit.
hole_set_2_diameter_unit = 25.4; // [25.4:inches, 1:mm]
// Distance from center of disc to hole.
hole_set_2_center_distance = 0.3;
// Distance from center of disc to hole unit.
hole_set_2_center_distance_unit = 25.4; // [25.4:inches, 1:mm]
// How many holes (spread evenly around the disc.)
hole_set_2_howmany = 3; // [1:25]
// How many degrees to rotate the holes around the center.
hole_set_2_angle = 0;  // [0:359]

/* [Hole set 3] */
// Enable this hole set.
hole_set_3_enable = 1;  // [1:true, 0:false]
// Diameter of hole(s).
hole_set_3_diameter = 0.116;
// Diameter of hole(s) unit.
hole_set_3_diameter_unit = 25.4; // [25.4:inches, 1:mm]
// Distance from center of disc to hole.
hole_set_3_center_distance = 0.5025;
// Distance from center of disc to hole unit.
hole_set_3_center_distance_unit = 25.4; // [25.4:inches, 1:mm]
// How many holes (spread evenly around the disc.)
hole_set_3_howmany = 2; // [1:25]
// How many degrees to rotate the holes around the center.
hole_set_3_angle = 90;  // [0:359]

/* [Hole set 4] */
// Enable this hole set.
hole_set_4_enable = 0;  // [1:true, 0:false]
// Diameter of hole(s).
hole_set_4_diameter = 0.116;
// Diameter of hole(s) unit.
hole_set_4_diameter_unit = 25.4; // [25.4:inches, 1:mm]
// Distance from center of disc to hole.
hole_set_4_center_distance = 0.5025;
// Distance from center of disc to hole unit.
hole_set_4_center_distance_unit = 25.4; // [25.4:inches, 1:mm]
// How many holes (spread evenly around the disc.)
hole_set_4_howmany = 3; // [1:25]
// How many degrees to rotate the holes around the center.
hole_set_4_angle = 0;  // [0:359]

/* [Hidden] */

// Tolerance, holes will be made this much larger and
// outer diameter will made this much smaller. 0.2mm works well for
// most 3d printers, and you can always file the disks a bit if you
// need to.
tolerance = 0.2;
tolerance_unit = 1;  // [25.4:inches, 1:mm]


tolerance_mm = tolerance * tolerance_unit;
outer_diameter_mm = outer_diameter * outer_diameter_unit - tolerance_mm;
thickness_mm = thickness * thickness_unit;
circuit_board_width_mm = circuit_board_width * circuit_board_width_unit + tolerance_mm;

batt_dia =    [0,  18,  14,  14, 10.5, 10.5, 10.5 ];
batt_num =    [0,   1,   1,   2,    2,    3,    4 ];
batt_angle =  [0, -90, -90,  90,    0,   90,   45 ];
batt_offset = [0,0.28, 0.5, 0.5,  0.5, 1/sqrt(3), 1/sqrt(2)];
batt_offset2 =[0,   0,   0,   0,  0.5,    0,    0 ];

module hole_set(enable, dia, dia_unit, dist, dist_unit, howmany, angle) {
  dia_mm = dia * dia_unit + tolerance_mm;
  dist_mm = dist * dist_unit;
  if (enable) {
    for (n=[0:howmany]) {
      rotate(angle + n * 360 / howmany) {
        translate([0, dist_mm]) {
          circle(r = dia_mm / 2, $fn = 120);
        }
      }
    }
  }
}

linear_extrude(height=thickness_mm, convexity=12) {
  difference() {
    circle(r = outer_diameter_mm / 2, $fn=300);
    hole_set(hole_set_1_enable,
             hole_set_1_diameter,
             hole_set_1_diameter_unit,
             hole_set_1_center_distance,
             hole_set_1_center_distance_unit,
             hole_set_1_howmany,
             hole_set_1_angle);
    hole_set(hole_set_2_enable,
             hole_set_2_diameter,
             hole_set_2_diameter_unit,
             hole_set_2_center_distance,
             hole_set_2_center_distance_unit,
             hole_set_2_howmany,
             hole_set_2_angle);
    hole_set(hole_set_3_enable,
             hole_set_3_diameter,
             hole_set_3_diameter_unit,
             hole_set_3_center_distance,
             hole_set_3_center_distance_unit,
             hole_set_3_howmany,
             hole_set_3_angle);
    hole_set(hole_set_4_enable,
             hole_set_4_diameter,
             hole_set_4_diameter_unit,
             hole_set_4_center_distance,
             hole_set_4_center_distance_unit,
             hole_set_4_howmany,
             hole_set_4_angle);

    if (battery_configuration != 0) {
      translate([0, -batt_dia[battery_configuration] * batt_offset2[battery_configuration]])
        hull() {
          for (x=[0:batt_num[battery_configuration]]) {
            rotate(x * 360 / batt_num[battery_configuration] + batt_angle[battery_configuration]) {
              translate([batt_dia[battery_configuration] * batt_offset[battery_configuration], 0])
#               circle(r = (batt_dia[battery_configuration] + tolerance_mm)/2, $fn=100);
          }
        }
      }
    }

    if (circuit_board_holder) {
       translate([0, 7]) {
         hull() {
#          square([circuit_board_width_mm, 1], center=true);
          square([circuit_board_width_mm - 10, 10], center=true);
         }
       }
    }
  }
}