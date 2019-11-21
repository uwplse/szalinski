include <sg90.scad>
include <holes.scad>

wall = 1.32;
e = 0.01; // added to prevent coplanar difference

function inch(i) = i * 25.4;

// Base block
block_w = inch(1.75);
block_d = inch(0.25);
block_h = inch(1.125);


module block_w_servo(servo_mount_o) {
  screw_block_d = 2.5;
  servo_inset_h = 1.5;

  difference() {
    union() {
      translate([servo_mount_o-servo_width/2-wall,0,0]) {
        // Servo support block
        difference() {
          union() {
            translate([-(servo_mount_o-servo_width/2-wall),0,0]) 
              mount_block();
            cube([servo_width+2*wall,servo_depth+2*servo_ear_depth,block_d]);
          }
          translate([wall,servo_ear_depth,block_d-servo_inset_h])
            cube([servo_width, servo_depth, servo_inset_h+e]);
        }
        // bottom block to screw the servo into
translate([wall,0,block_d]) difference() {
 translate([-1.3,0,0])
  cube([servo_width+2*wall,servo_ear_depth,screw_block_d],
    top=[0,screw_block_d,0,screw_block_d], $fn=4);
          translate([servo_width/2,servo_ear_depth/2,e ]) cylinder(r=1.8, h=screw_block_d);
        }
        
        
 // top block to screw the servo into
translate([0,servo_depth+servo_ear_depth,block_d]) difference() {
  cube([servo_width+2*wall,servo_ear_depth,screw_block_d],
    
  top=[0,screw_block_d,0,screw_block_d], $fn=4);
    
  translate([servo_width/2+wall,servo_ear_depth/2,e]) cylinder(r=1.8, h=screw_block_d);
        }
      }
    }

    // servo passthrough hole
    translate([servo_mount_o,servo_ear_depth+servo_depth-servo_big_tip_r,-e]) {
      cylinder_poly(h=block_d+2*e, r=servo_big_tip_r);
      translate([0,-servo_big_tip_r,0]) cylinder_poly(h=block_d+2*e, r=2.8);
    }
  }
}




//Carriage and Modifications 

difference () {
import("x-carriage_with_end_stop.stl");
     translate([35,-6,0]) cube([12,18,9]);
}


difference () {
    translate([9.5,34,0]) cube([7,5,12]);
    translate([3,34,3]) cube([14,2.5,6]);
}

difference () {
    translate([-17.5,34,0]) cube([7,5,12]);
    translate([-24.5,34,3]) cube([14,2.5,6]);
}

translate([16,-40.5,0]) rotate([0,0,90]){
    difference ()
    {    
    block_w_servo(-0);
    translate([0,servo_ear_depth/2,-e ]) cylinder(r=1.8, h=12);
     translate([0,30,-e]) cylinder(r=1.8, h=12);
    }
}


