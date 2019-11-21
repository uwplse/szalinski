// min bridge
// max bridge
// bridge increments


//small, 10-100:5
//large, 10-200:10

/*[Bridges]*/

// length of the shortest bridge
min_bridge_length = 10;

// length of the longest bridge
max_bridge_length = 100;

// difference between subsequent bridges
bridge_increment = 5;

// width of each bridge
bridge_width = 3;

// layer height of each bridge
bridge_height = 0.8;

// height of each bridge above the previous bridge
bridge_z_gap = 0.2;

/*[Shape]*/
// diameter of the central hub
hub_diameter = 24;

// angle between each bridge
bridge_angle = 18;

// thickness of the vertical walls
wall_thickness = 1;



// ignore
spiralResolution = 12*1; // ignore
spiralIncrement = 1/spiralResolution; // ignore
numBridges = ceil((max_bridge_length - min_bridge_length) / bridge_increment) + 1;
maxAngle = bridge_angle * (numBridges-1);
eps = 0.1 * 1; // ignore
$fn = 90 * 1; // ignore


function spiralOffset(angle) = min_bridge_length + angle/maxAngle * (max_bridge_length - min_bridge_length);
function extensionAngle(length) = asin((bridge_width*0.5)/length);

module bridgeTest() {
	tubeHeight = numBridges * (bridge_height + bridge_z_gap);
	heightStride = bridge_height + bridge_z_gap;

	difference() {
		union() {
			cylinder(r = hub_diameter/2, h = tubeHeight);
	
			for (i=[0:numBridges-1]) {
				assign (length = spiralOffset(i*bridge_angle) + wall_thickness * 2,
						 height = i * heightStride) {
					hull()
					rotate([0, 0, i*bridge_angle]) {
						translate([hub_diameter/2 - wall_thickness, 0, height + bridge_z_gap]) {
							translate([0, -bridge_width/2, 0])
							cube([length , bridge_width, bridge_height], center=false);
							if (i < numBridges-1) {
								translate([0, bridge_width/2 - eps, 0]) {
									cube([spiralOffset(i*bridge_angle + extensionAngle(length)) + wall_thickness, eps, bridge_height], center=false); // only an approximation
								}
							}
						}
					}
					if (i < numBridges-1) {
						for (f=[0 : spiralResolution-1]) {
							assign(frac=f/spiralResolution,
									top = height + bridge_height + bridge_z_gap,
									end = i == numBridges-1 && f == spiralResolution-1,
									angle = i*bridge_angle + bridge_angle * f / spiralResolution
 ) {
								hull()
								rotate([0, 0, angle]) {
									translate([hub_diameter/2 + spiralOffset(angle), -bridge_width/2, 0]) {
										cube([wall_thickness, wall_thickness, top + heightStride * frac], center=false);
									}
									rotate([0, 0, bridge_angle * spiralIncrement])
									translate([hub_diameter/2 + spiralOffset(angle + bridge_angle * spiralIncrement), -bridge_width/2, 0]) {
										cube([wall_thickness, wall_thickness, top + heightStride * (frac + spiralIncrement)], center=false);	
									}
								}
							}
						}
					} else {
						rotate([0, 0, i*bridge_angle]) {
							translate([length + hub_diameter/2 - wall_thickness*2, -bridge_width/2, 0]) {
								cube([wall_thickness, bridge_width, height + heightStride], center=false);
							}
						}
					}
				}
			}
		}
		cylinder(r=hub_diameter/2 - wall_thickness, h=tubeHeight*3, center=true);
	}

}

bridgeTest();