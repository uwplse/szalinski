// preview[view:south west, tilt:top diagonal]
include <MCAD/boxes.scad>  // Include Boxes library to get easy rounded boxes

/* [Top holder spec] */
// Which one would you like to see?
part = "second"; // [first:Top holder,second:Connector]

// Text line 1, example: Phone model name
phone_name = "phone";

// Font size for text line 2, "TextLabel"
font_size = 11; // [3:29]

// Text line 2, example: Your own name 
TextLabel = "Name";
font = "REGISTRATION PLATE UK:style=Bold";

// The width of your phone including any cover you have on it (in mm)
phone_width = 63; // [50:150]

// The length from the back of the connector to the back of the phone (in mm)
phone_depth = 4; // [0:0.1:7]

// Add extra support on the side holders?
support = 0; // [1:Yes,0:No]

// Only needed if you have extra support: The total depth/thickness of your phone (in mm)
phone_thickness = 12; // [2:0.1:16]


/* [Connector adapter spec] */
// The width of the connector (in mm)
connector_width = 11.1; // [0:0.1:32]

// The depth of the connector (in mm)
connector_depth = 6.2; // [0:0.1:14]

// The height of the connector (in mm)
connector_height = 17; // [0:0.1:29]

// Advanced: Offset of the connector (experimental) (in mm)
offset = 0; // [-10:0.1:10]

// Advanced: Add 10 mm to the phone depth (experimental)
extraD = 0; // [1:Yes,0:No]

// The shape of the connector
connector_shape = "square"; // [square:Square,ellipse:Ellipse]

module oval(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center, $fs = 0.01);
}

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
    translate([((phone_thickness+extraD*10+11-phone_depth)/2)-2,0,0]) {
    roundedBox([phone_thickness+extraD*10+11-phone_depth+4, phone_width+8, 30], 4, true, $fn=40);
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
   
   if (support == 0) { 
    translate([phone_thickness+extraD*10+11-phone_depth-2,0,0]) {    
      cube([4, 300, 32], true);
    }
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
      
if (support == 0) {

    translate([((phone_thickness+extraD*10+11-phone_depth))-4,phone_width/2+2,0]) {    
      roundedBox([4, 4, 30], 2, true, $fn=40);
    }
    
    translate([((phone_thickness+extraD*10+11-phone_depth))-4,-phone_width/2-2,0]) {    
      roundedBox([4, 4, 30], 2, true, $fn=40);
    }
    
    }



if (support == 1) {

    translate([((phone_thickness+extraD*10+11-phone_depth))-2,phone_width/2-1,0]) {    
      roundedBox([4, 5.5, 30], 2, true, $fn=40);
    }
    
    translate([((phone_thickness+extraD*10+11-phone_depth))-2,-phone_width/2+1,0]) {    
      roundedBox([4, 5.5, 30], 2, true, $fn=40);
    }
    
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
}


module connector() {

if (extraD == 0) {
rotate([0,10,180]) {
  translate([-40,0,-0.5]) {
// Difference will construct a main shape and subtract cut outs
difference() {
    
  // Main Shape
  union(){
    translate([0,0,0]) {
    roundedBox([16, 37.8, 31], 2, true, $fn=40);
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
  
  translate([0,offset,0]) {
    cylinder( 35,3,3, true, $fn=30);
  }
  
  translate([0,-2.75+offset,-18]) {
    cube([10,5.5,35],false);
  }
  
  rotate([0,-10,0]) {
    translate([-15,-20,-18.6]) {
      cube([25,40,5],false);
    }
  }
  
  // Customized hole
    if(connector_shape == "square") {
      translate([-connector_depth/2,-connector_width/2+offset,15.6-(connector_height-1)]) {  
          cube([connector_depth,connector_width,connector_height-1],false);
      }
    } else {
     translate([0,offset,15.6-(connector_height-1)]) {  
          oval(connector_depth/2,connector_width/2,connector_height-1,false);
      }
    }
  
  } // End difference
    
}
}
}

if (extraD == 1) {
rotate([0,10,180]) {
  translate([-40,0,-0.5]) {
// Difference will construct a main shape and subtract cut outs
difference() {
    
  // Main Shape
  union(){
    translate([-8,0,-2]) {
    roundedBox([20, 37.8, 35], 2, true, $fn=40);
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
  
  translate([-10,-2.75+offset,-18]) {
    cube([20,5.5,35],false);
  }
  
  union(){
      translate([-10,0,0]) {
  translate([0,offset,0]) {
    cylinder( 35,3,3, true, $fn=30);
  }
  
  rotate([0,-10,0]) {
    translate([-35,-20,-23.6]) {
      cube([55,40,10],false);
    }
  }
  
  // Customized hole
  translate([-connector_depth/2,-connector_width/2+offset,15.6-(connector_height-1)]) {
    cube([connector_depth,connector_width,connector_height-1],false);
  }
  }
  }
  
  } // End difference
    
}
}
}


}








