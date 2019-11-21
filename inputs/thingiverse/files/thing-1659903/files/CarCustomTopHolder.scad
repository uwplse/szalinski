// preview[view:north west, tilt:top diagonal]
include <MCAD/boxes.scad>  // Include Boxes library to get easy rounded boxes

// Text line 1, example: Phone model name
phone_name = "Your custom";

// Font size for text line 2, "TextLabel"
font_size = 10; // [3:29]

// Text line 2, example: Your own name 
TextLabel = "text";
font = "REGISTRATION PLATE UK:style=Bold";

// The width of your phone including any cover you have on it
phone_width = 62; // [50:150]

// The length from the back of the connector to the back of the phone
phone_depth = 7; // [2:0.1:7]

// The total depth/thickness of your phone
phone_thickness = 12; // [2:0.1:16]
    
rotate([180,0,180]) {
// Difference will construct a main shape and subtract cut outs
difference() {
    
  // Main Shape
  union(){
    translate([((phone_thickness+11-phone_depth)/2)-2,0,0]) {
    roundedBox([phone_thickness+11-phone_depth+4, phone_width+8, 30], 4, true, $fn=40);
    }
    roundedBox([26, 50, 30], 4, true, $fn=40);
  } // End union
  
  // Cut outs
  translate([20,0,0]) {
    cube([40,phone_width,32],true);
    cube([42,49,32],true);   
    }
    translate([-6.1,0,5]) {
      cube([4.2,42,35],true);
    }
   
  } // End difference
    
// Add ons
  
difference() {
  union(){
    translate([-4,-25,-15]) {
      cube([4,50,51.1],false);
      cube([11-phone_depth,50,45],false);
    }

    translate([-3.9,-10,-15]) {
      cube([2.05,20,54.1],false);
    }

    translate([((phone_thickness+11-phone_depth))-2,phone_width/2-1,0]) {    
      roundedBox([4, 5.5, 30], 2, true, $fn=40);
    }
    
    translate([((phone_thickness+11-phone_depth))-2,-phone_width/2+1,0]) {    
      roundedBox([4, 5.5, 30], 2, true, $fn=40);
    }
  } // End union
  
  // Cut out text
   translate([6-phone_depth,0,11]) {
    rotate([90,180,90]) {
      linear_extrude(height = 1.5) {
        text(text = str(TextLabel), font = font, size = font_size, valign = "center", halign = "center");
      }
    }
    }
    
     translate([6-phone_depth,0,-10]) {
    rotate([90,180,90]) {
      linear_extrude(height = 1.5) {
        text(text = str(phone_name), font = font, size = 4, valign = "center", halign = "center");
      }
    }
    }
} // End difference

}


