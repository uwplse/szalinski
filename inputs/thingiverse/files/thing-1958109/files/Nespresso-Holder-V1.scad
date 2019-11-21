TOLERANCE           = 0.2;
SIZE_X              = 37;
SIZE_Y              = (37 + TOLERANCE) / 2;
COUNT               = 3;

PADDING             = 0.1;
BASE_HEIGHT         = 2;
STOPPER_Y           = 3.0;
STOPPER_HEIGHT      = 1;
STOPPER_WIDTH       = 3.5;
WALL_WIDTH          = 2.5;
WALL_HEIGHT         = BASE_HEIGHT + STOPPER_Y + STOPPER_HEIGHT;
END_STOPPER_HEIGHT  = WALL_HEIGHT + 1.5;

function pos_x(j) = WALL_WIDTH + (SIZE_X + PADDING)  * (j - 1);

module half() {
  for(i=[1:1:COUNT]) {

    // Walls
    translate([pos_x(i), 0, 0]) {
      color("DarkKhaki") {
        linear_extrude(WALL_HEIGHT) {
          square([SIZE_X + PADDING, WALL_WIDTH]);
        }
      }
    }

    // Stoppers
    difference() {
      translate([pos_x(i), WALL_WIDTH, BASE_HEIGHT + STOPPER_Y]) {
        color("DeepSkyBlue") {
          linear_extrude(STOPPER_HEIGHT) {
            square([SIZE_X + PADDING, STOPPER_WIDTH]);
          }
        }
      }

      if (i == COUNT) {
        translate([pos_x(COUNT),WALL_WIDTH,BASE_HEIGHT + STOPPER_Y])
          linear_extrude(STOPPER_HEIGHT) {
            polygon([[1 + WALL_WIDTH + SIZE_X/2, STOPPER_WIDTH],
                [1 + WALL_WIDTH + SIZE_X, 0],
                [1 + WALL_WIDTH + SIZE_X, STOPPER_WIDTH]]);
          }
      }
    }


    // Cup Platform
    translate([pos_x(i), WALL_WIDTH, 0]) {
      color("red") {
        linear_extrude(BASE_HEIGHT) {
          square([SIZE_X, SIZE_Y]);
        }
      }
    }

    // PADDINGS
    translate([pos_x(i) + SIZE_X, WALL_WIDTH, 0]) {
      color("DarkGreen") {
        linear_extrude(BASE_HEIGHT) {
          square([PADDING, SIZE_Y]);
        }
      }
    }

  }


  // End Stopper
  translate([0,0,0]) {
    color("YellowGreen") {
      linear_extrude(END_STOPPER_HEIGHT) {
        square([WALL_WIDTH, SIZE_Y + WALL_WIDTH]);
      }
    }
  }

  // Supports
//support_count = 10;
//for(i=[SIZE_X/support_count:SIZE_X/support_count:SIZE_X]) {
//  radius = 0.4;
//  translate([radius + i, STOPPER_WIDTH / 2 + WALL_WIDTH, BASE_HEIGHT])
//    cylinder(h=STOPPER_Y, r=radius, center=false);
//}
}

// Holder
translate([pos_x(COUNT) + PADDING + SIZE_X, SIZE_Y + WALL_WIDTH,0]) {
  color("Magenta") {
    difference() {
      cylinder(h=BASE_HEIGHT, r=(SIZE_Y + WALL_WIDTH), center=false);
      translate([(SIZE_Y + WALL_WIDTH)/2,0, 1.1])
      #cylinder(h=BASE_HEIGHT, r=3, center=false);
    }
  }
}

half();
translate([0, 2 * (SIZE_Y + WALL_WIDTH), 0])
mirror([0,1,0]) half();
