/* [Basic] */
// Render mode with rougher edges (CAUTION: turn OFF before thing creation! - preview will fail (script timeout) but export will work!)
render_mode = 1; // [0:off, 1:on]

// Total height of hotend (top to nozzle tip) in mm (E3Dv6: ~63mm, Some Clones: ~74mm)
hotend_height = 63; // [60:85]

// Zip tie holes on backplate
zip_tie_holes_backplate = 1; // [0:no, 1:yes]

// Include cooling fan holder
include_fan_holder = 1; // [0:no, 1:yes]

// Zip tie hole on fan holder
zip_tie_hole_fan_holder = 1; // [0:no, 1:yes]

/* [Sensor Holder]  */
// Add a sensor holder to the carriage (if activated: print with support advised!) - ATTENTION: Depending on the position of your sensor holder, it may interfere with other components (e.g. cooling fan of hotend, cable chain, ...) -> Based on this fact, the sensor holder on the back of the carriage is still the recommended version (links can be found in the thing-description.)
include_sensor_holder = 0; // [0:no, 1:yes]

// X-Offset of sensor holder mounting point in mm (>0mm recommended)
x_offset_sensor = 0; // [-8:0.1:20]

// Y-Offset of sensor holder mounting point in mm (0mm recommended)
y_offset_sensor = 0; // [-2:0.1:20]

// Z-Offset of sensor holder mounting point in mm
z_offset_sensor = 0; // [-12:0.1:15]

// Select your sensor diameter (Most common: M18, M12, M8)
sensor_diameter = 18; //[6:1:20]

// Height/thickness of the sensor holder (default: 8mm)
sensor_holder_height = 8; //[5:0.1:20]

// Thickness of the wall surrounding the sensor (default: 4mm)
sensor_holder_wall_thickness = 4;  //[2:0.1:10]

/* [Expert Fine Tuning] */
// Thickness of backplate in mm (6mm recommended)
thickness_backplate = 6;   // [5:0.1:10]

// Radius of backplate finish in mm (5mm recommended)
finish_backplate = 5;  // [1:0.1:8]

// X-Offset of hotend mounting point in mm (0mm recommended)
x_offset_hotend = -16;  // [-8:0.1:8]
x_offset_hotend2 = 16;  // [-8:0.1:8]

// Radius of hotend mounting point in mm (5mm recommended)
finish_hotend_mount = 5;  // [0:0.1:8]

// Fan holder offset in z-direction in mm (printer coordinate system - up/down)
z_offset_fan_holder = 0;  // [-3:0.1:10]

// Fan holder offset in x-direction in mm (printer coordinate system - left/right)
x_offset_fan_holder = -10;  // [-10:0.1:3]

// Fan holder offset in y-direction in mm (printer coordinate system - back/forth)
y_offset_fan_holder = 0; // [-10:0.1:6]

/* [Hidden] */
// Circle resolution
$fn= render_mode ? 10 : 50;

// Get extension of building plate to the left based on fan holder position
bp_left_extension = (!include_fan_holder) ? 0 : max(0,3.2+(-x_offset_fan_holder));
bp_right_extension = bp_left_extension;

// Merge z offset fan and hotend length
z_offset_fan_holder_merge = (74-hotend_height) + z_offset_fan_holder;

// Get extension of building plate to the bottom based on fan holder position
bp_bottom_extension = (!include_fan_holder) ? 0 : max(0,0-z_offset_fan_holder_merge);

if(render_mode){
	translate([0,100,30])
		rotate([90,0,45])
		text("Render Mode");
	translate([0,100,10])
		rotate([90,0,45])
		text("Text will disapear", size = 7);
	translate([0,100,0])
		rotate([90,0,45])
		text("with render mode 'off'!", size = 7);
}

Backplate();

// Backplate
module Backplate(){
	difference(){
		union(){
			translate([-2-bp_left_extension,-bp_bottom_extension,0]){
				roundedRect([67+bp_left_extension+bp_right_extension,84+bp_bottom_extension,thickness_backplate], finish_backplate);
            }
			MountingpointE3D(16+x_offset_hotend,37.24,13.75);
			MountingpointE3D(16+x_offset_hotend2,37.24,13.75);
			if(include_fan_holder) {
				FanHolder2(x_offset_fan_holder-3,z_offset_fan_holder_merge, -y_offset_fan_holder, false);
				mirror(0,1,0)
                    FanHolder2(0-bp_left_extension-67-x_offset_fan_holder-6,z_offset_fan_holder_merge, -y_offset_fan_holder, true);
			}
			if(include_sensor_holder) {
				sensorHolder(65+x_offset_sensor,25+z_offset_sensor,20+y_offset_sensor,sensor_diameter,sensor_holder_height,sensor_holder_wall_thickness);
			}
		}
		ScrewHolesBackplate();
		ScrewHolesBelt();
		if(zip_tie_holes_backplate) {
			ZiptieHoles();
		}
	}
}
module FanHolder2(offset_x, offset_y, offset_z){
	thickness = 6;
	y_lower_screw = 9.5;
	z_lower_screw = 62.5;
	difference(){
		translate([offset_x-0.1, offset_y, offset_z])
			difference(){
				union(){
					difference(){
						union(){
							hull(){
								FanHolder_Shape([0,0,0],thickness,1,7.5,7.5,offset_y>=9.5? offset_y-9.5 : 0);
							}
							// Support
							FanHolder_Support();
						}
						hull(){
							FanHolder_Shape([0-0.1,6,-15],thickness+0.2,0.1,2,10,30);
						}
					}
					// Rounded inner edge
					inner_radius = 1;
					FanHolder_Shape([0,6,-15],thickness,inner_radius,3,10,30);
					// infill between rounded edges
					translate([inner_radius,0,0]) rotate([0,90,0]) linear_extrude(height = thickness-inner_radius*2) projection() rotate([0,-90,0]) FanHolder_Shape([0,6,-15],thickness,inner_radius,3,10,30);
				}
				// Add screw holes
				translate([-0.1,y_lower_screw,z_lower_screw])
					rotate([0,90,0])
					cylinder(h=thickness+0.2, r=1.25);
				translate([-0.1,y_lower_screw+41,z_lower_screw-41])
					rotate([0,90,0])
					cylinder(h=thickness+0.2, r=1.25);
				// Zip tie hole fan holder
				if(zip_tie_hole_fan_holder){
					hull(){
						translate([-0.1,65,13])
							rotate([0,90,0])
							cylinder(h=thickness+0.2, r=0.75);
						translate([-0.1,65-2.7,13+2.7])
							rotate([0,90,0])
							cylinder(h=thickness+0.2, r=0.75);
					}
				}
			}
		// Cut too long bottom elements
		translate([-500,-500,-500]) cube([1000,1000,500]);
	}
}
module FanHolder_Support(){
	thickness = 3;
	width = 10;

	/* [Sensor Holder] }}} */
translate([0,0.3,0])
	difference(){
		union(){
			difference(){
				union(){
					hull(){
						translate([28,5,-33])
							rotate([0,-14,0])
							cylinder(h=100, r=thickness/2);
						translate([28,5+width-thickness,-33])
							rotate([0,-14,0])
							cylinder(h=100, r=thickness/2);
					}
					translate([4.6,5-thickness/2,40])
						rotate([0,-14,0])
						cube([5,width,15], centering=false);
				}
				difference(){
					translate([7,1,40])
						rotate([-90,0,0])
						cylinder(h=width+5, r=2.9);
					translate([7,1,30])
						rotate([0,-14,0])
						cube([10,width+5,10], centering=false);
				}
			}
			angle2 = 180;
			angle1 = 14;
			start = 5;
			end = 5+width-thickness;
			for(y_stop = [start , end]) {
				// bend
				translate([7,y_stop,40])
					rotate([90,0,0])
					difference() {
						// torus
						rotate_extrude()
							translate([1.2 + thickness/2, 0, 0])
							circle(r=thickness/2);
						// lower cutout
						rotate([0, 0, angle1])
							translate([-50 * (((angle2 - angle1) <= 180)?1:0), -100, -50])
							cube([100, 100, 100]);
						// upper cutout
						rotate([0, 0, angle2])
							translate([-50 * (((angle2 - angle1) <= 180)?1:0), 0, -50])
							cube([100, 100, 100]);
					}
			}
			// infill between rounded edges
			translate([0,5,0]) rotate([-90,0,0]) linear_extrude(height = width-thickness/2*2) projection() rotate([90,0,0]) {
				// bend
				translate([7,start,40])
					rotate([90,0,0])
					difference() {
						// torus
						rotate_extrude()
							translate([1.2 + thickness/2, 0, 0])
							circle(r=thickness/2);
						// lower cutout
						rotate([0, 0, angle1])
							translate([-50 * (((angle2 - angle1) <= 180)?1:0), -100, -50])
							cube([100, 100, 100]);
						// upper cutout
						rotate([0, 0, angle2])
							translate([-50 * (((angle2 - angle1) <= 180)?1:0), 0, -50])
							cube([100, 100, 100]);
					}
			};
		}
		translate([-4.2,0,0])
			cube([10,20,100]);
	}
}
module FanHolder_Shape(offset,thickness,radius,bend1,bend2,reduceHeight = 0){
	bend_radius = bend1 - radius*2;
	bend_radius2 = bend2 - radius*2;
	// Leave like this
	angle_1 = 0;
	angle_2 = 135;
	angle_3 = 180;
	length_1 =75;
	length_2 =80-(reduceHeight/cos(angle_2-90));
	length_3 =20+reduceHeight;
	start = (0+radius);
	end  = (thickness-radius);
	union(){
		for(x_stop = [start , end]) {
			translate([offset[0]+x_stop,10+offset[1],60+offset[2]])
				rotate([90,0,-90])
				union() {
					// lower arm
					rotate([0, 0, angle_1])
						translate([bend_radius + radius, 0.02, 0])
						rotate([90, 0, 0])
						cylinder(r=radius, h=length_1+0.04);
					// middle arm
					rotate([0, 0, angle_2])
						translate([bend_radius + radius, -0.02, 0])
						rotate([-90, 0, 0])
						cylinder(r=radius, h=length_2+0.04);
					// upper arm
					translate([-sin(angle_2)*length_2+ cos(angle_2)*(bend_radius - bend_radius2),cos(angle_2)*length_2+ sin(angle_2)*(bend_radius - bend_radius2),0])
						rotate([0, 0, angle_3])
						translate([bend_radius2 + radius, -0.02, 0])
						rotate([-90, 0, 0])
						cylinder(r=radius, h=length_3+0.04);
					// bend
					difference() {
						// torus
						rotate_extrude()
							translate([bend_radius + radius, 0, 0])
							circle(r=radius);
						// lower cutout
						rotate([0, 0, angle_1])
							translate([-50 * (((angle_2 - angle_1) <= 180)?1:0), -100, -50])
							cube([100, 100, 100]);
						// upper cutout
						rotate([0, 0, angle_2])
							translate([-50 * (((angle_2 - angle_1) <= 180)?1:0), 0, -50])
							cube([100, 100, 100]);
					}
					// bend2
					translate([-sin(angle_2)*length_2 + cos(angle_2)*(bend_radius - bend_radius2),cos(angle_2)*length_2 + sin(angle_2)*(bend_radius - bend_radius2),0])
						difference() {
							// torus
							rotate_extrude()
								translate([bend_radius2 + radius, 0, 0])
								circle(r=radius);
							// lower cutout
							rotate([0, 0, angle_2])
								translate([-50 * (((angle_3 - angle_2) <= 180)?1:0), -100, -50])
								cube([100, 100, 100]);
							// upper cutout
							rotate([0, 0, angle_3])
								translate([-50 * (((angle_3 - angle_2) <= 180)?1:0), 0, -50])
								cube([100, 100, 100]);
						}
				}
		}
	}
}
module ZiptieHoles(){
	//translate([62-6.5,63,thickness_backplate-5+0.1]) ZiptieHole();
	translate([17.5,84-6.5,thickness_backplate-5+0.1]) rotate([0,0,90]) ZiptieHole();
	translate([49,84-6.5,thickness_backplate-5+0.1]) rotate([0,0,90]) ZiptieHole();
}
module ZiptieHole(){
	ZiptieWidth = 5;
	ZiptieHeight = 1.5;
	ZiptieBendRadius = 2.5;
	union(){
		difference(){
			translate([ZiptieBendRadius,0,ZiptieBendRadius])
				rotate([-90,0,0])
				cylinder(h=ZiptieWidth, r=ZiptieBendRadius, center=false);
			translate([ZiptieBendRadius,-1,0]) cube([ZiptieBendRadius+1,ZiptieWidth+2,ZiptieBendRadius*2.1], center=false);
			translate([0,-1,ZiptieBendRadius]) cube([ZiptieBendRadius*2.1,ZiptieWidth+2,ZiptieBendRadius+1], center=false);
			translate([ZiptieBendRadius,-1,ZiptieBendRadius])
				rotate([-90,0,0])
				cylinder(h=ZiptieWidth+2, r=ZiptieBendRadius-ZiptieHeight, center=false);
		}
		translate([ZiptieBendRadius-0.01,0,0]) cube([6.5-ZiptieBendRadius+1,ZiptieWidth,ZiptieHeight], center=false);
		translate([0,0,ZiptieBendRadius-0.01]) cube([ZiptieHeight,ZiptieWidth,5-ZiptieBendRadius+1], center=false);
	}
}
module MountingpointE3D(x_pos,y_pos,dh){
	width = 30;
	height = 12.68;
	height_upper_ring_hotend = 3.8;
	height_ring_rinse = 5.88;
	translate([x_pos,y_pos,thickness_backplate-0.01])
		difference(){
			union() {
				roundedPlateau(width,height,finish_hotend_mount);
				cube([width,height,dh], center=false);
			}
			// Screw holes
			translate([4,height/2,0.1])
				cylinder(h=dh, r=2.83/2, center=false);
			translate([width-4,height/2,0.1])
				cylinder(h=dh, r=2.83/2, center=false);
			// Mounting clip
			translate([width/2,-1,dh])
				rotate([-90,0,0])
				cylinder(h=height-height_ring_rinse-height_upper_ring_hotend+1, r=8.17, center=false);
			translate([width/2,height-height_upper_ring_hotend,dh])
				rotate([-90,0,0])
				cylinder(h=height_upper_ring_hotend+1, r=8.17, center=false);
			translate([width/2,-1,dh])
				rotate([-90,0,0])
				cylinder(h=height+2, r=6, center=false);
		}
}
module ScrewHolesBelt(){
	// Generate screw holes for belt attachment
	color("LightSeaGreen"){
		translate([5.437,43.51,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
		translate([11.94,43.51,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
		translate([11.94,32.535,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
		translate([50.014,43.51,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
		translate([50.014,32.535,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
		translate([56.517,43.51,-1])
			cylinder(h=thickness_backplate,   r=2.7/2, center=false);
	}
}
module ScrewHolesBackplate(){
	// Generates holes for mountingplate
	// top left mounting point
	ScrewHolesLinearSlide(6.28,53.66);
	// top right mounting point
	ScrewHolesLinearSlide(37.68,53.66);
	// bottom mounting point
	ScrewHolesLinearSlide(21.96,7.7);
}
module ScrewHolesLinearSlide(x, y){
	// define position of bottom right screwhole and the other ones are adapted correspondingly
	ScrewHole(x, y);
	ScrewHole(x, y+24.19);
	ScrewHole(x+18.04, y+24.19);
	ScrewHole(x+18.04, y);
}
module ScrewHole(x, y){
	translate([x,y,-1])
		color("LightSteelBlue")
		union() {
			cylinder(h=thickness_backplate+2,   r=4.3/2, center=false);
			translate([0,0,4])
				cylinder(h=8, r=6.7/2, center=false);
			translate([0,0,11.9])
				cylinder(h=15, r1=6.7/2, r2=0, center=false);
		}
}
module roundedPlateau(dx,dy,h){
	// Generates plateau of height h with rounded edges reaching tangential to the ground
	translate([-h,-h,0])
		difference(){
			cube([dx+2*h, dy+2*h,h], center=false);
			translate([0,-1,h])
				rotate([-90,0,0])
				cylinder(h=dy+2*h+2, r=h, center=false);
			translate([dx+2*h,-1,h])
				rotate([-90,0,0])
				cylinder(h=dy+2*h+2, r=h, center=false);
			translate([-1,0,h])
				rotate([0,90,0])
				cylinder(h=dx+2*h+2, r=h, center=false);
			translate([-1,dy+2*h,h])
				rotate([0,90,0])
				cylinder(h=dx+2*h+2, r=h, center=false);
		}
}
module roundedRect(size, radius){
	x = size[0];
	y = size[1];
	z = size[2];
	// Difference is used for cutting of part generated by spheres
	difference(){
		hull() {
			// place 4 cylinders and spheres in  the corners, with the given radius
			translate([(radius), (radius), 0])
				cylinder(h=z-radius, r=radius);
			translate([(radius), (radius), z-radius])
				sphere(r=radius);
			translate([(x)-(radius), (radius), 0])
				cylinder(h=z-radius, r=radius);
			translate([(x)-(radius), (radius), z-radius])
				sphere(r=radius);
			translate([(radius), (y)-(radius), 0])
				cylinder(h=z-radius, r=radius);
			translate([(radius), (y)-(radius), z-radius])
				sphere(r=radius);
			translate([(x)-(radius), (y)-(radius), 0])
				cylinder(h=z-radius, r=radius);
			translate([(x)-(radius), (y)-(radius), z-radius])
				sphere(r=radius);
		}
		translate([0,0,-(z+radius)*2]) cube([x,y,(z+radius)*2], center=false);
	}
}
module sensorHolder(x,y,z,dia,thickness,wall){
	difference(){
		union(){
			hull(){
				translate([x,y,z])
					rotate([90,0,0])
					cylinder(r=dia/2+wall, h=thickness);
				// Position on left in carriage
				translate([50,y,wall/2+0.1])
					rotate([90,0,0])
					cylinder(r=wall/2, h=thickness);
				// Position on right in carriage
				translate([60,y,wall/2+0.1])
					rotate([90,0,0])
					cylinder(r=wall/2, h=thickness);
			}
		}
		translate([x,y+1,z])
			rotate([90,0,0])
			cylinder(r=dia/2, h=thickness+2);
	}
}
