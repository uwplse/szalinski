//!OpenSCAD

/* 
Simple spinning top, with a kind of flower form(s)
Made by Daniel K. Schneider
TECFA, University of Geneva
License: Creative Commons - BY-NC-SA

There are several parameters you can change. See the end of the file

*/

$fn=30;

// Play with the parameters below. E.g., start with number of petals. A number between 2 and 15 maybe.
n_petals = 10;
// Choose between 3 models for the petals: quadratic, square or linear/straight.
model_number = 1;
// Building block of a petal. Each petal is defined as a string of block with a "hull" around it.
block_width = 4;
// Building block of a petal. Height should be anything that is printable, e.g. between 0.5 and 20.
block_height = 2;
// Radius of the hub. A good value is 10, i.e. a width of 2cm.
hub_radius = 6;
// Radius of the hole. 4-5 mm is about the size of a pen. Must be at least 1.5 smaller than radius.
hole_radius = 4;
// A small tip will enhance spinning time. A large tip encourages some "walking".
tip_radius = 1;
// Height of the hub in the middle. Something between 5 and 30 ?
hub_height = 24;
// Petal length in terms of blocks. Try between 2 and 10.
N_petal_blocks = 4;
// Height of the stick to be inserted into the hole. Chose anything that allows grabbing it.
stick_height = 1 * hub_height;
// Radius of the stick. Must be equal or small than hole_radius
stick_radius = hole_radius - 0.05;
// Since you also can use the top up-side-down, you can try a what happens if you got a flat stick. Alternatively, just insert the round end into the hole.
rounded_stick = false;
// set the x position of the removable stick
stick_position_x = 30;
// set the y position of the stick
stick_position_y = 35;


union(){
  difference() {
    create_flower();

    create_hole();
  }
  create_stick();
}


module create_flower() {
  deg_petals = 360 / n_petals;
  hub_half_height = hub_height / 2;
  // Flower without the hole. It has a three-part hub plus petals.
  union(){
    // The lower part of the hub- lower part
    cylinder(r1=hub_radius, r2=hub_radius, h=hub_half_height, center=false);
    translate([0, 0, hub_half_height]){
      // The lower part of the hub, upper part
      cylinder(r1=hub_radius, r2=tip_radius, h=hub_half_height, center=false);
    }
    translate([0, 0, hub_height]){
      // hub tip, a ball
      sphere(r=tip_radius);
    }
    // Loop to create N petals. Each  one is rotated
    for (rot = [0 : abs(deg_petals) : 360 - deg_petals]) {
      if (model_number == 1) {
        create_petal(rot);
      } else if (model_number == 2) {
        create_petal2(rot);
      } else {
        create_petal3(rot);
      }

    }

  }
}

module create_hole() {
  hub_half_height = hub_height / 2;
  // Three objects that will be subtracted to create the hole. One stick plus a ball on top. The cylinder at the bottom will shave off stuff that inhibits 3D printing.
  union(){
    translate([0, 0, (-0.2 - hub_half_height)]){
      cylinder(r1=hole_radius, r2=hole_radius, h=hub_height, center=false);
    }
    translate([0, 0, (0 - 3 * hub_half_height)]){
      cylinder(r1=hub_radius, r2=hub_radius, h=(3 * hub_half_height), center=false);
    }
  }
}

module create_stick() {
  // Stick to insert into the hole. Sorry you got to find a good position for this manually. Change x and y values if needed. 2
  translate([stick_position_x, stick_position_y, 0]){
    union(){
      cylinder(r1=stick_radius, r2=stick_radius, h=stick_height, center=false);
      if (rounded_stick) {
        translate([0, 0, stick_height]){
          sphere(r=stick_radius);
        }
      }

    }
  }
}

module create_petal(rotation) {
  rotate([0, 0, rotation]){
    // Untick hull for a postmodern experience...
    // chain hull
    for (pos = [0 : abs(1) : N_petal_blocks - 1]) {
      hull() {
      // This formula  will create a curved line. You can try others....
      translate([(pos * (2 * block_width)), (pow(pos, 4) * -0.1), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      // This formula  will create a curved line. You can try others....
      translate([((pos + 1) * (2 * block_width)), (pow((pos + 1), 4) * -0.1), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      }  // end hull (in loop)
     } // end loop

  }
}

module create_petal2(rotation) {
  rotate([0, 0, rotation]){
    // Untick hull for a postmodern experience...
    // chain hull
    for (pos = [0 : abs(1) : N_petal_blocks - 1]) {
      hull() {
      // This formula  will create a curved line. You can try others....
      translate([(pos * (2 * block_width)), (pow(pos, 2) * 1), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      // This formula  will create a curved line. You can try others....
      translate([((pos + 1) * (2 * block_width)), (pow((pos + 1), 2) * 1), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      }  // end hull (in loop)
     } // end loop

  }
}

module create_petal3(rotation) {
  rotate([0, 0, rotation]){
    // Untick hull for a postmodern experience...
    // chain hull
    for (pos = [0 : abs(1) : N_petal_blocks - 1]) {
      hull() {
      // This formula  will create a curved line. You can try others....
      translate([(pos * (1 * block_width)), (pos * (1 * block_width)), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      // This formula  will create a curved line. You can try others....
      translate([((pos + 1) * (1 * block_width)), ((pos + 1) * (1 * block_width)), 0]){
        cylinder(r1=block_width, r2=block_width, h=block_height, center=false);
      }
      }  // end hull (in loop)
     } // end loop

  }
}
