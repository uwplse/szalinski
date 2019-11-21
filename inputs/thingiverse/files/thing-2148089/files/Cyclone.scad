// Cyclone Dust Collector for Woodworking
// by György Balássy 2017 (http://www.thingiverse.com/balassy)
// http://www.thingiverse.com/thing:
//
// Original design by Marius Gheorghescu, July 2013 (http://www.thingiverse.com/thing:124551).

// Diameter of the hose to the vacuum in mm. The internal diameter of the exhaust hole on the top.
vacuum_hole_diameter = 32;

// Internal diameter of the intake hole in mm.
intake_hole_diameter = 45;

// Height of the main body in mm.
body_height = 51;		

// Height of the cyclone chamber in mm.
cone_height = 90;		

// Diameter of the hopper connector (bottle neck) in mm. The internal diameter of the debris collector hole on the bottom.
hopper_diameter = 28;

// Thickness of the walls in mm.
wall_thickness = 2;

// Which part do you want to render?
partToRender = "ALL";  // [ALL, CYCLONE, MOUNT_PLATE]

// The distance between the outer radius of the hopper hole and the inner radius of the mount plate. Set to a negative value when printing in one piece, or a small positive value to tolerate the inaccuracy of your printer.
mount_plate_space_radius = 0.5;                    

/* [Hidden] */

$fa = 1;       // Default minimum facet angle.
$fs = 1;       // Default minimum facet size.
delta = 0.1;   // Ensures that no faces remains after boolean operations.

mainColor = [0.117, 0.565, 1];      // DodgerBlue: RGB(30, 144, 255)
highlightColor = [0.384, 0.726, 1]; // Lighter DodgerBlue: RGB(98, 185, 255)

body_diameter = vacuum_hole_diameter + 2 * intake_hole_diameter + 6 * wall_thickness;		
vacuum_hole_radius = vacuum_hole_diameter / 2;
intake_hole_radius = intake_hole_diameter / 2;
body_radius = body_diameter / 2;
hopper_radius = hopper_diameter / 2;

bolt_diameter = 7;
bolt_length = 30;
bolt_head_diameter = 12;    // 11.8 = Tight fit for M6 bolt.
bolt_head_height = 5;

mount_plate_height = 2 * wall_thickness + bolt_head_height;
mount_plate_ring_radius = 20;

debris_container_cover_thickness = 3;

// Length of the hopper connector in mm.
hopper_height = mount_plate_height + debris_container_cover_thickness;

module cyclone_cone() {
	difference() {
		cylinder(r1=hopper_radius + wall_thickness, r2=body_radius + wall_thickness, h=cone_height);
    translate([0, 0, -delta])
		  cylinder(r1=hopper_radius, r2=body_radius, h=cone_height + 2 * delta);
	}
}

module cyclone_intake(createEmptyPipe) {
	intake_length = body_radius + vacuum_hole_radius;

	translate([0, intake_hole_radius + vacuum_hole_radius + 2 * wall_thickness, body_height - intake_hole_radius - wall_thickness * 2])//-intake_hole_radius + body_height])
    rotate([0, 90, 0]) 
      difference() {
        cylinder(r=intake_hole_radius + 2 * wall_thickness, h=intake_length);

        if (createEmptyPipe)          
          translate([0, 0, -delta])
            cylinder(r=intake_hole_radius, h=intake_length + 2 * delta);  // Double wall size used here for strength.
      }	
}

module cyclone_body() {
  // Calculate the length of the exhaust vacuum tube.
	inner_tube_height =  body_height + cone_height / 2.5;

	difference() {
    union() {
      // Main body.
      difference() {
        cylinder(r=body_radius + wall_thickness, h=body_height);

        translate([0, 0, -wall_thickness]) 
          cylinder(r=body_radius, h=body_height + delta - wall_thickness);
      }

      // Tube inside for the exhaust vacuum hose.
      translate([0, 0, body_height - inner_tube_height]) 
        cylinder(r=vacuum_hole_radius + wall_thickness, h=inner_tube_height);
    }

		// Hole for the exhaust vacuum hose.
    translate([0, 0, body_height - inner_tube_height - delta]) 
		  cylinder(r=vacuum_hole_radius, h=inner_tube_height + 2 * delta);
	}
}

module cyclone_top() {
	difference() {
		cyclone_body();
		cyclone_intake(false);
	}

	cyclone_intake(true);
}

module cyclone_hopper_connector() {
	difference() {
		cylinder(r=hopper_radius + wall_thickness, h=hopper_height);
    translate([0, 0, -delta])
		  cylinder(r=hopper_radius, h=hopper_height + 2 * delta);
	}
}

module cyclone_mount_plate() {
  bolt_position_radius = hopper_radius + wall_thickness + mount_plate_ring_radius / 2;
  bolt_position_distance = bolt_position_radius * cos(45);

  difference() {
    cylinder(r=hopper_radius + wall_thickness + mount_plate_ring_radius, h=mount_plate_height);
    translate([0, 0, -delta])
      cylinder(r=hopper_radius + wall_thickness + mount_plate_space_radius - delta, h=mount_plate_height + 2 * delta);

    // Bolts.
    translate([bolt_position_distance, bolt_position_distance, mount_plate_height + delta])
      cyclone_bolt();     
    translate([bolt_position_distance, -bolt_position_distance, mount_plate_height + delta])
      cyclone_bolt();  
    translate([-bolt_position_distance, bolt_position_distance, mount_plate_height + delta])
      cyclone_bolt();  
    translate([-bolt_position_distance, -bolt_position_distance, mount_plate_height + delta])
      cyclone_bolt();                  
  }
}

module cyclone_bolt() {
  translate([0, 0, -bolt_head_height]) {
    // Head.
    cylinder(d = bolt_head_diameter, h = bolt_head_height, $fn = 6);

    // Body.
    translate([0, 0, -bolt_length + delta])
      cylinder(d = bolt_diameter, h = bolt_length);
  }
}

module cyclone() {  
  if(partToRender == "MOUNT_PLATE" || partToRender == "ALL") {
    color(highlightColor)
      translate([0, 0, debris_container_cover_thickness])
        cyclone_mount_plate();  
  }

  if(partToRender == "CYCLONE" || partToRender == "ALL") {
    color(mainColor) {
      cyclone_hopper_connector();      

      translate([0, 0, hopper_height])
        cyclone_cone();

      translate([0, 0, hopper_height + cone_height]) 
        cyclone_top();
    }  
  }
}

cyclone();
