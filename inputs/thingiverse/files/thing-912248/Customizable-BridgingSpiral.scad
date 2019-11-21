// OpenSCAD  test object for bridges
// Also tests for on-extruder fan cooling unevenness in X,Y axes.

// Parametrised to use as much space on a print bed as required.
// this design uses only half the spiral of the original.

// Customiser enabled

// preview[view:north east, tilt:top diagonal]

/*[Bridges]*/
// length of the shortest bridge
min_bridge_length = 10; //[10:5:180]

// length of the longest bridge
max_bridge_length = 100; //[20:5:200]

// Total number
number_of_bridges = 10; //[4:1:20]

// difference between subsequent bridges
bridge_increment = (max_bridge_length - min_bridge_length) / (number_of_bridges - 1) ; //5;

// Test the XY cooling efficiency
show_XY_test = "yes"; // [yes,no]

/*[Shape]*/
// diameter of the central hub
hub_diameter = 24; //[18:1:30]

// width of each bridge
bridge_width = 3; //[1:1:8]

// thickness of the vertical walls
wall_thickness = 1; //[1:10]

// layer height of each bridge
bridge_height = 0.8; //[0.1:0.1:2]

// height of each bridge above the previous bridge
bridge_z_gap = 0.2; //[0.2:0.1:1]

/* [Hidden] */
// angle between each bridge
bridge_angle = 180.0 / (number_of_bridges -1);

spiralResolution = 12*1;
spiralIncrement = 1/spiralResolution;
maxAngle = bridge_angle * (number_of_bridges-1);
eps = 0.1 * 1; 
$fn = 90 * 1;


function spiralOffset(angle) = min_bridge_length + angle/maxAngle * (max_bridge_length - min_bridge_length);
function extensionAngle(length) = asin((bridge_width*0.5)/length);

module bridgeTest() {
	tubeHeight = number_of_bridges * (bridge_height + bridge_z_gap);
	heightStride = bridge_height + bridge_z_gap;

	difference() {
		union() {
			// Central hub
			cylinder(r = hub_diameter/2, h = tubeHeight);
			
			// The spokes (bridges)
			for (i=[0:number_of_bridges-1]) {
				length = spiralOffset(i*bridge_angle) + wall_thickness * 2;
				start_height = i * heightStride  + bridge_z_gap;
				hull() {
					rotate([0, 0, i*bridge_angle]) {
						translate([hub_diameter/2 - wall_thickness, 0, start_height]) {
							translate([0, -bridge_width/2, 0])
							cube([length , bridge_width, bridge_height], center=false);
							if (i < number_of_bridges-1) {
								translate([0, bridge_width/2 - eps, 0]) {
									cube([spiralOffset(i*bridge_angle + extensionAngle(length)) + wall_thickness, eps, bridge_height], center=false); // only an approximation
								}
							}
						}
					}
				}
				// Outer Spiral uprights
				if (i < number_of_bridges-1) {
					for (f=[0 : spiralResolution-1]) {
						frac  = f / spiralResolution;
						top	  = start_height + bridge_height;
						//end	= i == number_of_bridges-1 && f == spiralResolution-1;
						angle = i*bridge_angle + bridge_angle * f / spiralResolution;
						hull()  { // This hull sweeps through all the supports making a nice spiral
							rotate([0, 0, angle]) {
								translate([hub_diameter/2 + spiralOffset(angle), -bridge_width/2, 0]) {
									cube([wall_thickness, wall_thickness, top + heightStride * frac], center=false);
								}
								rotate([0, 0, bridge_angle * spiralIncrement])
								translate([hub_diameter/2 + spiralOffset(angle + bridge_angle * spiralIncrement),
										   -bridge_width/2, 0]) {
									cube([wall_thickness, wall_thickness, top + heightStride * (frac + spiralIncrement)], center=false); 
								}
							}
						}
					}
				} else { // last upright of outer spiral
					rotate([0, 0, i*bridge_angle]) {
						translate([length + hub_diameter/2 - wall_thickness*2, -bridge_width/2, 0]) {
							cube([wall_thickness, bridge_width, start_height + heightStride-bridge_z_gap], center=false);
						}
					}
					if (show_XY_test == "yes") {
						// extra leg
						rotate([0, 0, i*bridge_angle -90]) {
							translate([length + hub_diameter/2 - wall_thickness*2, -bridge_width/2, 0]) {
								cube([wall_thickness, bridge_width, start_height + heightStride-bridge_z_gap], center=false);
							}
						}
						// extra bridge
						rotate([0, 0, i*bridge_angle - 90]) {
							translate([hub_diameter/2 - wall_thickness, 0, start_height]) {
								translate([0, -bridge_width/2, 0])
								cube([length , bridge_width, bridge_height], center=false);
							}
						}
					}
				}
			}
		}
		// core out the cylinder and remove the un-needed side
		cylinder(r=hub_diameter/2 - wall_thickness, h=tubeHeight*3, center=true);
		translate([-hub_diameter/2, -hub_diameter-bridge_width/2, -1]) {
			cube([hub_diameter, hub_diameter, tubeHeight+2], center=false);
		}
	}

}

bridgeTest();