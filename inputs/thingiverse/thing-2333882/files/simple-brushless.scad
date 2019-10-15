
MOTOR_SIZE = 11; // [11:11xx, 18:18xx, 22:22xx, 23:23xx]

// Stack Hole Spacing
STACK_HOLE_SPACING = 20; // [30.5:30.5x30.5, 20:20x20, 16:16x16] 

// Prop clearance from the stack
STACK_CLEARANCE = 1;

// What is the prop size in inches?
PROP_SIZE_INCHES=2;

// How thick do you want the frame to be?
FRAME_THICKNESS=3;

// How thick do you need the prop guard rails to be
GUARD_WIDTH=3;

/* [Advanced Options] */

// Distance from the edge of the arm and the motor holes
MOTOR_MOUNT_MARGIN=5;

// Diameter of the center hole in the frame
MOTOR_MOUNT_CENTER_DIAMETER=5;

// Margin for the outside standoffs
STANDOFF_MARGIN=5;

/* [Hidden] */
$fn=64;

prop_size = PROP_SIZE_INCHES * 25.4; 

// Size of the board (calculated from the hole spacing)
stack_board_size = (
  STACK_HOLE_SPACING == 16 ? 20 :
  STACK_HOLE_SPACING == 20 ? 25 :
  STACK_HOLE_SPACING == 30.5 ? 36 : 
  0
);

stack_hole_spacing = (
  STACK_HOLE_SPACING != 0 ? STACK_HOLE_SPACING :
  0
);

stack_hole_diameter=(
  STACK_HOLE_SPACING >= 20 ? 3 :
  STACK_HOLE_SPACING >= 16 ? 2 :
  0
);


// The diagonal distance between motor holes
motor_mount_diaganal=(
   MOTOR_SIZE == 11 ? 9 :
   MOTOR_SIZE == 18 ? 12 :
   MOTOR_SIZE == 22 ? 16 : 
   MOTOR_SIZE == 23 ? 16 : 
   0
 );

// The diameter of the moter holes
motor_mount_hole_size=(
  MOTOR_SIZE >= 22 ? 3 :
  MOTOR_SIZE >= 11 ? 2 :
  0
);

wheelbase = (
  stack_board_size / sin(45) + 
  STACK_CLEARANCE + 
  prop_size
);

side = (
  (sin(45) * wheelbase) // distance between motors horizontally
  + prop_size// clearance for props (both motors horizontally)
  + GUARD_WIDTH * 2 // size of both sides of the guard
);
motorHoleDistance = sin(45) * motor_mount_diaganal;

echo("Wheelbase: ");
echo(wheelbase);
echo("Total Width: ");
echo(side);


// modules
module motorHoles() {
  center_offset = motor_mount_hole_size - motorHoleDistance;
  // center the module
  translate([0,center_offset,FRAME_THICKNESS*-1 / 2 ]) {
    rotate([0,0,45]) {
      union() {
        translate([motorHoleDistance/2,motorHoleDistance/2,0]) {
          cylinder(r=MOTOR_MOUNT_CENTER_DIAMETER/2, h=FRAME_THICKNESS*2);
        }
        translate([0,0,-FRAME_THICKNESS/2]) {
          cylinder(r=motor_mount_hole_size/2, h=FRAME_THICKNESS*2);
        }
        translate([0,motorHoleDistance,-FRAME_THICKNESS/2]) {
          cylinder(r=motor_mount_hole_size/2, h=FRAME_THICKNESS*2);
        }
        translate([motorHoleDistance,0,-FRAME_THICKNESS/2]) {
          cylinder(r=motor_mount_hole_size/2, h=FRAME_THICKNESS*2);
        }
        translate([motorHoleDistance,motorHoleDistance,-FRAME_THICKNESS/2]) {
          cylinder(r=motor_mount_hole_size/2, h=FRAME_THICKNESS*2);
        }
      }
    }
  }
}

module base() {
  width = motorHoleDistance + MOTOR_MOUNT_MARGIN;
  length = side / sin(45);
  rotate([0,0,45]) {
    cube([width, length, FRAME_THICKNESS], center=true);
  }
    rotate([0,0,-45]) {
    cube([width, length, FRAME_THICKNESS], center=true);
  }
  translate([0,side/2,0]) {
    cube([side, GUARD_WIDTH, FRAME_THICKNESS], center=true);
  }
  translate([0,-side/2,0]) {
    cube([side, GUARD_WIDTH, FRAME_THICKNESS], center=true);
  }  
  translate([side/2, 0,0]) {
    cube([GUARD_WIDTH, side, FRAME_THICKNESS], center=true);
  }
  translate([-side/2, 0 ,0]) {
    cube([GUARD_WIDTH, side, FRAME_THICKNESS], center=true);
  }
  //cube([side, side, FRAME_THICKNESS], center=true);
}

module allMotorHoles() {
  distance = sin(45) * wheelbase;
  center = distance / 2;
  translate([-center, -center, 0]) {
  translate([0, 0, 0]) {
    motorHoles();
  }
  translate([distance, 0,0]) {
    motorHoles();
  }
  translate([0, distance,0]) {
    motorHoles();
  }
  translate([distance, distance,0]) {
    motorHoles();
  }
}
}
module stackHoles() {
  translate([-stack_hole_spacing/2,-stack_hole_spacing/2,-FRAME_THICKNESS/2]) {
    translate([0,0,0]) {
      cylinder(r=stack_hole_diameter/2, h=FRAME_THICKNESS*2);
    }
    translate([0,stack_hole_spacing,0]) {
      cylinder(r=stack_hole_diameter/2, h=FRAME_THICKNESS*2);
    }
    translate([stack_hole_spacing,0,0]) {
      cylinder(r=stack_hole_diameter/2, h=FRAME_THICKNESS*2);
    }
    translate([stack_hole_spacing,stack_hole_spacing,0]) {
      cylinder(r=stack_hole_diameter/2, h=FRAME_THICKNESS*2);
    }
  }
}

module standoffHoles() {
  offset = side/2 - STANDOFF_MARGIN;
  translate([0,0,-FRAME_THICKNESS]) {
    translate([-offset, -offset,0]) {
      cylinder(r=1.5, h=FRAME_THICKNESS*2);
    }
    translate([offset, offset,0]) {
      cylinder(r=1.5, h=FRAME_THICKNESS*2);
    }
    translate([-offset, offset,0]) {
      cylinder(r=1.5, h=FRAME_THICKNESS*2);
    }
    translate([offset, -offset,0]) {
      cylinder(r=1.5, h=FRAME_THICKNESS*2);
    }
  }
}
difference() {
  base();
  allMotorHoles();
  stackHoles();
  standoffHoles();
}
