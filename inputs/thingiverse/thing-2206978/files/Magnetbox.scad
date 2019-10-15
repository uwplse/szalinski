
// Inner width
cube_w = 50; // [10:1:200]

// Inner height
cube_h = 70; // [10:1:200]

// Inner depth
cube_d = 30; // [10:1:200]

// Wall thickness
cube_t = 3; // [1:0.1:10]

// Magnet diameter
magnet_d = 10; // [1:0.1:40]

// Magnet depth
magnet_t = 4; // [1:0.1:20]

// How many magnets?
magnets = 3; // [1:1:5]

// Do you want rounded edges?
rounded = 1; // [1:Yes,0:No]

// Do you want a text label?
label = 0; // [1:Yes,0:No]

// The text you want on the front
TextLabel = "keys";

// Font size
font_size = 10; // [4:1:30]
font = "REGISTRATION PLATE UK:style=Bold";

/* [Hidden] */
slack = 0.25; // Slack
detail = 60;  // Variable for detail of cylinder and square. High number = high detail

difference() {
    
  // ******
  // Solids
  // ******  
  union(){
   
  if (rounded == 0) {
      cube([cube_w+cube_t*2,cube_d+cube_t*2+magnet_t,cube_h+cube_t],false);
  } // End if rounded
          
  if (rounded == 1) {   
     roundedcube([cube_w+cube_t*2,cube_d+cube_t*2+magnet_t,cube_h+cube_t], false, cube_t, "z");
  } // End if rounded
  
  } // End union Solids

 
  // *********
  // Subtracts
  // *********  
  union(){
  
  if (label == 1) {
      
    if (cube_t >= 2) {
   // Cut out text
   translate([cube_w/2+cube_t,cube_d+cube_t*2+magnet_t-1,cube_h/2+cube_t/2]) {
    rotate([90,0,180]) {
      linear_extrude(height = 1.6) {
        text(text = str(TextLabel), font = font, size = font_size, valign = "center", halign = "center");
      }
    }
    }
   } 
   
      if (cube_t < 2) {
   // Cut out text
   translate([cube_w/2+cube_t,cube_d+cube_t*2+magnet_t-0.6,cube_h/2+cube_t/2]) {
    rotate([90,0,180]) {
      linear_extrude(height = 1.6) {
        text(text = str(TextLabel), font = font, size = font_size, valign = "center", halign = "center");
      }
    }
    }
   } 
   
    }
      
  if (magnets == 1) {
          translate([cube_w/2+cube_t,magnet_t,cube_h/2+cube_t]) {
        rotate([90,0,0]) { 
          cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
        } // End rotate
      } // End translate
   } // End if magnets 
 
   if (magnets == 2) {
  translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
  
  } // End if magnets
  
  if (magnets == 3) {
      translate([cube_w/2+cube_t,magnet_t,magnet_d]) {
        rotate([90,0,0]) { 
          cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
        } // End rotate
      } // End translate
      
       translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
  
  } // End if magnets
  
  if (magnets == 4) {
      
      translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
      
       translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,magnet_d]) {
         rotate([90,0,0]) { 
         cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 } // End if magnets
  
 
  if (magnets == 5) {
      
       translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,cube_h+cube_t-magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
      
       translate([cube_w+cube_t*2-(magnet_d/2+cube_t*2),magnet_t,magnet_d]) {
         rotate([90,0,0]) { 
         cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate
 
  translate([magnet_d/2+cube_t*2,magnet_t,magnet_d]) {
    rotate([90,0,0]) { 
      cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
    } // End rotate
  } // End translate

    translate([cube_w/2+cube_t,magnet_t,cube_h/2+cube_t]) {
        rotate([90,0,0]) { 
          cylinder(d1=magnet_d+slack,d2=magnet_d+slack,h=magnet_t+slack,$fn=detail);
        } // End rotate
      } // End translate
  
 } // End if magnets
  
 
     translate([cube_t,cube_t+magnet_t,cube_t]) {
      cube([cube_w,cube_d,cube_h+1],false);
    } // End translate
 
 
  
  } // End union subtracts

} // End difference


// Rounded corners from https://danielupshaw.com/openscad-rounded-corners/

// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.2;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

