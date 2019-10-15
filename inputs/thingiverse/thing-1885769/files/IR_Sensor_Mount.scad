/* [Global Options] */

//There are two ways to mount this, adjustable and fixed. Adjustable can be used for prototyping how it needs to be, but fixed is the recommended option
type = "fixed"; //[fixed, adjustable]

//The total length of the print, usually the length of the hotend minus a small amount. Default value is good for J-Head MK IV-B with a groovemount on a Ultimate Greg's Wade's extruder ( http://www.thingiverse.com/thing:961630 )
hotend_length = 50;

//The resolution to use when rendering holes
resolution = 20;

//If the output should be rendered how it's supposed to be mounted or how it should be printed
render_type = "printed"; //[printed, mounted]

/* [Attachment] */

//The mounting hole to the extruder block, you shouldn't need to modify this
attachment_mount_hole = 5.4;
//The height of the screw mount to the extruder block
attachment_mount_height = 10;
//The thickness of the attachment point to both the extruder block and the sensor board
attachment_thickness = 5;
//The width of the entire attachment
attachment_width = 8;
//The offset from the edges of the internal slide hole. Unused for fixed
attachment_slide_offset = 10;
//The width of the internal slide hole, unused for fixed
attachment_hole_width = 3.2;

/* [Sensor Mount] */
//The mounting holes for the sensor board. Specification is M2.5 screws. Set to exact value so the screws can grip the plastic
sensor_hole = 2.5;
//The width of the sensor board. Taken from the spec sheet
sensor_width = 24;
//The height of the sensor board. Taken from the spec sheet
sensor_height = 17.62;
//The depth of the sensor board
sensor_depth = 2;
//The width of the entire mount
sensor_mount_width = 30;
//The height of the entire mount
sensor_mount_height = 20;

// The thickness of the sensor board mount. On fixed this is the same as the attachment thickness and thus this variable has no effect
sensor_mount_thickness = 8;

// Using the bottom-left of the sensor board, the x of the left hole. Gotten from the spec sheet
sensor_lefthole = 2.7;
// Using the bottom-left of the sensor board, the x of the right hold. Gotten from the spec sheet
sensor_righthole = 21.11;
//Using the bottom-left of the sensor board, the y of both holes. Gotten using the spec sheet
sensor_hole_y = 14.92;
//The width of the attachment point. Unused in fixed
sensor_mount_attach_width = 10;
//The height of the attachment point. Unused in fixed
sensor_mount_attach_height = 8;

/* [Hidden] */
//I use this section for mainly modifying variables used in customizer to variables I used while designing
preview_tab = "";
render_print = render_type == "printed";

//sensor_hole_locations = [[2.7, 14.92], [21.11, 14.92]];
sensor_hole_locations = [[sensor_lefthole, sensor_hole_y], [sensor_righthole, sensor_hole_y]];
sensor_mount_hole = attachment_hole_width;
sensor_mount_depth = sensor_mount_thickness;

$fn = resolution;

if(type == "adjustable"){
if(render_print){
	//Render it how it should be printed
	translate([5, 0, sensor_mount_depth])
	rotate([-90, 0, 0])
	highlight("Sensor Mount")
	sensor_mount();
	
	translate([-5, 0, 0])
	rotate([90, 0, 180])
	highlight("Attachment")
	attachment();
} else {
	//Render it how it should be mounted
	translate([-sensor_mount_width/2, -sensor_mount_depth, 0])
	highlight("Sensor Mount")
	sensor_mount();

	rotate([0, 180, 0])
	translate([-attachment_width/2, 2, -hotend_length-sensor_mount_attach_height/2-sensor_mount_height+sensor_mount_hole*2])
	highlight("Attachment")
	attachment();
}
} else if(type == "fixed"){
	sensor_mount_depth = attachment_thickness;
	if(render_print){
		v2();
	} else {
		translate([0, 0, hotend_length/2])
		rotate([-90, 0, 0])
		translate([attachment_width/2, -hotend_length/2, -attachment_thickness/2])
		v2();
	}
} else echo("Error, invalid type");

module v2(){
	rotate([90, 0, 180])
	highlight("Attachment")
	union(){
	translate([0, attachment_thickness, 0])
		difference(){
			cube([attachment_width, attachment_mount_height, attachment_thickness]); 
			translate([attachment_width/2, attachment_mount_height/2, attachment_thickness/2])
			cylinder(center=true, d=attachment_mount_hole, h=attachment_thickness*2);
	}
	cube([attachment_width, attachment_thickness, hotend_length-sensor_mount_height]);
}
	translate([(sensor_mount_width-attachment_width)/2, hotend_length, attachment_thickness])
	rotate([90, 180, 0])
	highlight("Sensor Mount")
	difference(){
		cube([sensor_mount_width, attachment_thickness, sensor_mount_height]);
		translate([(sensor_mount_width-sensor_width)/2, 0, 0]){
			translate([0, -sensor_depth, -sensor_height])
			cube([sensor_width, sensor_depth*2, sensor_height*2]);
			rotate([90, 0, 0]){
				translate([sensor_hole_locations[0][0], sensor_hole_locations[0][1], -attachment_thickness/2*3])
				cylinder(d=sensor_hole, h=2*sensor_mount_depth);
				
				translate([sensor_hole_locations[1][0], sensor_hole_locations[1][1], -attachment_thickness/2*3])
				cylinder(d=sensor_hole, h=2*sensor_mount_depth);
			}
		}
	}
}

module attachment(){
	translate([0, attachment_thickness, 0])
	difference(){
		cube([attachment_width, attachment_mount_height, attachment_thickness]); 
		translate([attachment_width/2, attachment_mount_height/2, attachment_thickness/2])
		cylinder(center=true, d=attachment_mount_hole, h=attachment_thickness*2);
	}
	
	difference(){
		cube([attachment_width, attachment_thickness, hotend_length]);
		rotate([90, 0, 0])
		translate([attachment_width/2, hotend_length/2, -attachment_thickness/2])
		hull(){
			length = hotend_length - attachment_slide_offset;
			translate([0, length/-2, 0]){
				translate([0, attachment_thickness, 0])
				cylinder(d=attachment_hole_width, h=attachment_thickness*2, center=true);
				translate([0, length, 0])
				cylinder(d=attachment_hole_width, h=attachment_thickness*2, center=true);
		}
	}
}
	
	
}

module sensor_mount(){
	difference(){
		cube([sensor_mount_width, sensor_mount_depth, sensor_mount_height]);
		translate([(sensor_mount_width-sensor_width)/2, 0, 0]){
			translate([0, -sensor_depth, -sensor_height])
			cube([sensor_width, sensor_depth*2, sensor_height*2]);
			rotate([90, 0, 0]){
				translate([sensor_hole_locations[0][0], sensor_hole_locations[0][1], -sensor_mount_depth/2*3])
				cylinder(d=sensor_hole, h=2*sensor_mount_depth);
				
				translate([sensor_hole_locations[1][0], sensor_hole_locations[1][1], -sensor_mount_depth/2*3])
				cylinder(d=sensor_hole, h=2*sensor_mount_depth);
			}
		}
	}
	
	translate([(sensor_mount_width-sensor_mount_attach_width)/2, 0, sensor_mount_height])
	difference(){
		cube([sensor_mount_attach_width, sensor_mount_depth, sensor_mount_attach_height]);
		rotate([90, 0, 0])
		translate([sensor_mount_attach_width/2, sensor_mount_attach_height/2, -sensor_mount_depth/2])
		cylinder(d=sensor_mount_hole, h=2*sensor_mount_depth, center=true);
	}
}

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") children(0);
  } else {
    children(0);
  }
}