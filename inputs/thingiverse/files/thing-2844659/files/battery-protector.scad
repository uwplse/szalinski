/* Quadcopter battery protector: reduce the rate at which you burn through batteries :-)

  Copyright 2018 Lluis Mora

  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// Parameters

// Battery length in mm
battery_length = 105;

// Battery width in mm
battery_width = 34;

/*
 Battery sizes:

 - Turnigy 2200mAh 3S: 105 x 34
 - Turnigy 5000mAh 3S: 144 x 50
*/

module ignoretherestofvariables() {}

$fn = 200;

// All sizes in mm

// Fixed values
protector_height = 8;
protector_thickness_bottom = 1.5;
protector_thickness_walls = 1;
balancer_clip_distance = 20;
balancer_clip_width = 10;
balancer_clip_interior_space = 2;
strapholder_width = 20;
strapholder_interior_space = 2;

// Strap holders

module strapholder(width, wall_thickness, interior_space) {
  difference() {
      linear_extrude(height = 2 * wall_thickness)
        offset(wall_thickness) square([width, interior_space + 3 * wall_thickness]);

      translate([wall_thickness, -1 * wall_thickness, -wall_thickness]) {
        cube([width - 2 * wall_thickness, interior_space + 3 * wall_thickness, 4 * wall_thickness]);
      }

    translate([-width, -2 * wall_thickness, -wall_thickness]) {
      cube([3 * width, wall_thickness * 3, 4 * wall_thickness]);
    }
  }
}

module clip(width, wall_thickness, interior_space) {
  cube([width, interior_space + wall_thickness, 2 * wall_thickness]);

  translate([0, interior_space, 0]) {
    cube([width, wall_thickness, protector_height - protector_thickness_walls]);
  }
}

// Base and build

difference() {

  linear_extrude(height = protector_height)
    offset(protector_thickness_walls) square([battery_length + (2 * protector_thickness_walls), battery_width + (2 * protector_thickness_walls)]);

  translate([protector_thickness_walls, protector_thickness_walls, protector_thickness_bottom]) {
    cube(size = [battery_length, battery_width, protector_height]);
  }
}

// Balancer clip, on the left side
translate([balancer_clip_distance, -protector_thickness_walls, 0]) {
  mirror([0,1,0]) clip(balancer_clip_width, protector_thickness_walls, balancer_clip_interior_space);
}

// Strap holders
translate([(battery_length/2) - (strapholder_width/2), battery_width + 2 * protector_thickness_walls , 0]) {
 strapholder(strapholder_width, protector_thickness_walls, strapholder_interior_space);
}

translate([(battery_length/2) - (strapholder_width/2), -(protector_thickness_walls - protector_thickness_walls), 0]) {
 mirror([0,1,0])strapholder(strapholder_width, protector_thickness_walls, strapholder_interior_space);
}
