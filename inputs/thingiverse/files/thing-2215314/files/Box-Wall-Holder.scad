// Depth of box
d = 72; // [10:1:200]

// Height of mount
h = 80; // [10:1:200]

// Width of mount
w = 30; // [10:1:200]

// How thick do you want the mount?
t = 4; // [1:1:20]

// Screw head size
s=10; // [1:1:20]

// Screw size
m=4; // [1:1:10]

// Do you want counter sink screws?
sink = 1; // [1:Yes,0:No]

/* [Hidden] */
f2=3;
detail = 60;  // Variable for detail of cylinder and square. High number = high detail
sp=25;

difference() {
    
  // ******
  // Solids
  // ******  
  union(){
      
    // Left
      
    translate([0,0,0]) { // Move the next solids to this coordinates. x,y,z
      roundedcube([d+t*2,w+t,h], false, t, "z");
      //cylinder(d1=10,d2=20,h=10,$fn=detail); // d1 = bottom diameter, d2 = top diameter
    } // End translate
    
    translate([0,-s*2,0]) {
      roundedcube([t,w,h], false, t/2, "z");
    } // End translate
    
  translate([t/2,-s*2,t]) {
    rotate([0,90,0]) {
 polyhedron(
               points=[[0,0,0], [t,0,0], [t,s*2,0], [0,s*2,0], [0,s*2,s*2], [t,s*2,s*2]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}
}    

 translate([t,-f2,h]) {
    rotate([0,90,0]) {
 polyhedron(
               points=[[0,0,0], [h,0,0], [h,f2,0], [0,f2,0], [0,f2,f2*2], [h,f2,f2*2]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}
} 

// Right

   translate([0,w+sp,0]) { // Move the next solids to this coordinates. x,y,z
      roundedcube([d+t*2,w+t,h], false, t, "z");
      //cylinder(d1=10,d2=20,h=10,$fn=detail); // d1 = bottom diameter, d2 = top diameter
    } // End translate
    
    translate([0,w+t+sp+s*2,0]) {
      roundedcube([t,w,h], false, t/2, "z");
    } // End translate
    

  translate([t/2,w+w+sp+t+s*2,0]) {
    rotate([90,270,90]) {
 polyhedron(
               points=[[0,0,0], [t,0,0], [t,s*2,0], [0,s*2,0], [0,s*2,s*2], [t,s*2,s*2]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}
}    
    
    
    translate([t,w+w+sp+t+f2,0]) {
    rotate([90,270,90]) {
 polyhedron(
               points=[[0,0,0], [h,0,0], [h,f2,0], [0,f2,0], [0,f2,f2*2], [h,f2,f2*2]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}
}    
  } // End union Solids


  // *********
  // Subtracts
  // *********  
  union(){
      
  // left
      translate([t,t,t]) { // Move the next solids to this coordinates. x,y,z
        cube([d,w,h],false); // true= center, false= 0,0
  }
  
  
  
        translate([-0.1,-s,h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=m,h=t+1,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
         translate([-0.1,-s,h-h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=m,h=t+1,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
  if (sink == 1) {
  
        translate([t-2,-s,h-h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=s+1,h=3,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
       translate([t-2,-s,h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=s+1,h=3,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
  
  }
  
  // Right
  
      translate([t,w+sp,t]) { // Move the next solids to this coordinates. x,y,z
        cube([d,w,h],false); // true= center, false= 0,0
  }
  
  if (sink == 1) {
  
        translate([t-2,w+w+sp+t+s,h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=s+1,h=3,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
        translate([t-2,w+w+sp+t+s,h-h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=s+1,h=3,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  }
  
  
  
        translate([-0.1,w+w+sp+t+s,h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=m,h=t+1,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
  
  
         translate([-0.1,w+w+sp+t+s,h-h/4]) {
      rotate([0,90,0]) {
  cylinder(d1=m,d2=m,h=t+1,$fn=detail); // d1 = bottom diameter, d2 = top diameter
  }
  }
  
  
  
  
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