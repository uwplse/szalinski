// License: Creative Commons, Attribution
// Parametrized coin cell holder

// Author: dereulenspiegel

// Battery count
nr = 10; //[5:50]

// Battery type
battery = "CR2023"; //[CR2025, CR2023, AG13, custom]

// Radius of the battery
custom_radius = 10; // [2:50]

// Width of the battery 
custom_width = 3.4; //[1:10]

// Text
custom_text = "cells";

// Width of the divider and walls
width_divider = 0.8;

$fn=128;

module holder(radius, width, text) {
  length = nr*(width_divider+width) + width_divider;
  
  difference(){
    cube([2*radius + 2*width_divider, length, radius+width_divider]);
    for(i = [0:nr]){
      translate([width_divider+radius, (i*(width_divider + width) + width_divider + width), radius+width_divider]){
        rotate([90,0,0]){
          cylinder(h=width, r=radius);
        }
      }
    }
    rotate([90,0,0]){
      translate([radius+width_divider,radius/2,-0.3]){
        linear_extrude(1.2){
          text(text,size=3, halign="center", valign="center");
        }
      }
    }
  }
}

if (battery == "CR2023") {
  holder(10, 3.4, "CR2023");
}
if (battery == "AG13") {
  holder(6, 5.7, "AG13"); 
}
if (battery == "CR2025") {
  holder(10, 2.8, "CR2025");
}
if (battery == "custom") {
  holder(custom_radius, custom_width, custom_text);
}
