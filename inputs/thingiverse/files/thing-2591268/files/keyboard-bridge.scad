// Keyboard bridge for pizza stand and WASD ten-keyless keyboard
// by HarlemSquirrel
// harlemsquirrel@gmail.com
// http://www.thingiverse.com/HarlemSquirrel


// *** Variables ***
// *****************

// Length of keyboard bridge
kb_length = 320; //[50:400]
// Width of keyboard bridge
kb_width = 20; //[5:50]
// Height of keyboard bridge
kb_height = 30; //[5:50]

// Pizza stand tube diameter
pstand_tube_diameter = 8; //[1:20]
// Pizza stand distance between center of bars
pstand_span = 215; //[50:300]


// *** Modules ***
// ***************

module keyboard_bridge_base() {
  difference() {
  cube([kb_length, kb_width, kb_height]);
  
  translate([((kb_length - pstand_span)/2), (kb_width + 1), 2])
    rotate([90,0,0]) {
      
        cylinder(d=(pstand_tube_diameter + 1), h=(kb_width + 2), $fn=100);
      translate([pstand_span, 0, 0])
        cylinder(d=(pstand_tube_diameter + 1), h=(kb_width + 2), $fn=100);
    }
  }
}

module end_cuttout() {
  rotate([90,0,0])
    resize([((kb_length - pstand_span)/1.5), 0, 0])
    cylinder(d=(kb_height * 1.5), h=(kb_width + 2));
}

module center_cuttout() {
  translate([(kb_length/2), (kb_width + 1), 0])
    rotate([90,0,0])
    resize([0,kb_height,0])
    cylinder(d=(pstand_span/1.2), h=(kb_width + 2));
}


// **** Main ****
// **************

difference() {
  keyboard_bridge_base();
  center_cuttout();
  translate([0, (kb_width + 1), 0])
    end_cuttout();
  translate([kb_length, (kb_width + 1), 0])
    end_cuttout();
}