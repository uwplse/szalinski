/* ==============================================================
  Configuration
============================================================== */

// What do you want to create?
create = "both"; // [pot,coaster,both]

// Diameter (bottom, top will be + 15%) of your pot.
diameter = 133; // [20:200]

// Thickness of the outer walls
wallthickness = diameter * 0.01; // [1:5]

// How fine should the 3D model be?
resolution = 100; // [20:200]

// Hole count of the pot
hole_count = 5; // [0:10]

// Size of the holes in mm
hole_size = diameter * 0.1; // [5:20]

// Standoffs
stand_count = 6; // [0:10]


/* ==============================================================
  Code
============================================================== */

if (create == "pot") {
  pot(diameter, wallthickness, hole_count, hole_size, resolution);
}
if (create == "coaster") {
  coaster(diameter, wallthickness, stand_count, resolution);
}
if (create == "both") {
  pot(diameter, wallthickness, hole_count, hole_size, resolution);
  translate ([0,diameter*1.3,0])
  coaster(diameter, wallthickness, stand_count, resolution);
}

/* ==============================================================
  Modules
============================================================== */

module pot (diameter, wallthickness, hole_count, hole_size, resolution) {
  
   $fn = resolution;
 
   difference(){
  
    // pot
    difference(){
      union(){
        // outer shell
        translate([0,0,0])
          cylinder(h = diameter, r1 = diameter/2, r2 = diameter*1.2/2);
        // rim
        translate([0,0,diameter-(diameter*0.15-wallthickness)-wallthickness])
          cylinder(h = diameter*0.15, r = diameter*1.25/2);
        // overhang
        translate([0,0,diameter*0.85-diameter*0.07])
          cylinder(h = diameter*0.07, r1 = diameter*1.14/2, r2 = diameter*1.25/2);
      }
      // inside
      translate([0,0,wallthickness-0.01])
        cylinder(
          h   = diameter-wallthickness+0.02,
          r1  = (diameter-2*wallthickness)/2,
          r2  = (diameter-2*wallthickness)*1.2/2
        );
    }
    
    // hole(s)
    if ( hole_count == 1 ) {
      // just one hole in the middle
      translate([0,0,-0.01])
      cylinder(h = wallthickness+0.02, d = hole_size);
    }
    else {
      // distribute all holes across the bottom
      hole_degrees_between = 360 / hole_count;
      translate([0,0,-wallthickness-0.01])
      for (rotation =[0:hole_degrees_between:360-hole_degrees_between]) {
        rotate([0,0,rotation])translate([0,diameter*0.15,wallthickness])
          translate([0,diameter*0.1,-0.01])
          cylinder(h = wallthickness+0.02+10, d = hole_size);
      }
    }
    
  }
  
}

module coaster (diameter, wallthickness, stand_count, resolution) {
  
  stand_degrees_between = 360 / stand_count;
  
  $fn = resolution;
  
  union(){
    // coaster
    difference(){
      // outer shell
      translate([0,0,0])
        cylinder(
          h   = diameter*.1,
          r1  = (diameter+wallthickness)/2+(diameter*0.05),
          r2  = (diameter+wallthickness*2)/2+(diameter*0.05)
        );
      // inside
      translate([0,0,wallthickness])
        cylinder(
          h   = diameter-wallthickness,
          r1  = (diameter)/2+(diameter*0.05),
          r2  = (diameter)/2+(diameter*0.05)
        );
    }
    
    // feet
    union(){
			
			difference () {
				
				for (rotation =[0:stand_degrees_between:360-stand_degrees_between]) {
					rotate([0,0,rotation])translate([0,diameter * 0.2,wallthickness])
					minkowski () {
						$fn = resolution/4;
						cube([0.01, (diameter / 2 - diameter * 0.1) - diameter * 0.2, 0.01 ]);
						sphere(r=diameter * 0.02);
					}
				}
				translate([0,0,-diameter*0.1])
        cylinder(
          h   = diameter*.1,
          r1  = (diameter+wallthickness)/2+(diameter*0.05),
          r2  = (diameter+wallthickness*2)/2+(diameter*0.05)
        );
			}
    }
  }
}
