// preview[view:south west, tilt:top diagonal]
include <MCAD/boxes.scad>  // Include Boxes library to get easy rounded boxes

/* [Top holder spec] */
// Which one would you like to see?
part = "first"; // [first:Top holder,second:Connector]

// Text line 1, example: Phone model name
phone_name = "";

// Font size for text line 2, "TextLabel"
font_size = 11; // [3:29]

// Text line 2, example: Your own name 
TextLabel = "";
font = "REGISTRATION PLATE UK:style=Bold";

// The width of your phone including any cover you have on it
phone_width = 71; // [50:150]

// The length from the back of the connector to the back of the phone
phone_depth = 8; // [0:0.1:7]

/* [Connector adapter spec] */
// The width of the connector
connector_width = 11.1; // [0:0.1:32]

// The depth of the connector
connector_depth = 6.2; // [0:0.1:14]

// The height of the connector
connector_height = 17; // [0:0.1:29]

print_part();

module print_part() {
	if (part == "first") {
		topholder();
	} else if (part == "second") {
		connector();
	} else {
		topholder();
	}
}

module topholder() {
    
rotate([180,0,180]) {
// Difference will construct a main shape and subtract cut outs
difference() {
    
  // Main Shape
  union(){
    translate([5,0,0]) {
    roundedBox([20, phone_width+8, 30], 4, true, $fn=72);
    }
    roundedBox([26, 50, 30], 4, true, $fn=72);
  } // End union
  
  // Cut outs
  translate([12,0,0]) {
    cube([27,phone_width,32],true);
    cube([26,49,32],true);   
    }
    translate([-6.1,0,5]) {
      cube([4.2,42,35],true);
    }
    
    translate([14,0,0]) {    
      cube([4, 300, 32], true);
    }
 
   
  } // End difference
    
// Add ons
  
difference() {
  union(){
    translate([-4,-25,-15]) {
      cube([2.5,50,51.1],false);
      cube([10.5-phone_depth,50,45],false);
    }

    translate([-3.9,-10,-15]) {
      cube([2.05,20,54.1],false);
    }
    
    translate([10,phone_width/2+2,0]) {    
      roundedBox([8, 4, 30], 2, true, $fn=72);
    }
    
    translate([10,-phone_width/2-2,0]) {    
      roundedBox([8, 4, 30], 2, true, $fn=72);
    }
    
  }
  
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
  
  
}
}
}



module connector() {
    
rotate([0,10,180]) {
  translate([-40,0,-0.5]) {
// Difference will construct a main shape and subtract cut outs
difference() {
    
  // Main Shape
  union(){
    translate([0,0,0]) {
    roundedBox([16, 37.8, 31], 2, true, $fn=72);
    }
    translate([0,-18.9,-15.5]) {
      cube([8, 37.8, 31], false);
    }
  } // End union
  
  // Cut outs
  translate([-2.15,17,-5.8]) {
    cube([4.3,2.10,21.34],false);   
  }
  
  translate([-2.15,-17-2.10,-5.8]) {
    cube([4.3,2.10,21.34],false);
  }
  
  cylinder( 35,3,3, true, $fn=30);
  
  translate([0,-2.75,-18]) {
    cube([10,5.5,35],false);
  }
  
  rotate([0,-10,0]) {
    translate([-15,-20,-18.6]) {
      cube([25,40,5],false);
    }
  }
  
  // Customized hole
  translate([-connector_depth/2,-connector_width/2,15.6-(connector_height-1)]) {
    cube([connector_depth,connector_width,connector_height-1],false);
  }
  
  } // End difference
    
}
}
}