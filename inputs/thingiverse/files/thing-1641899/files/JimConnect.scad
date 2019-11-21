// Original concept and design by biludavis http://www.thingiverse.com/thing:202491
// Parametricly recreated in OpenSCAD by Jim Shank
// 2016-07-27   -Initial release in SCAD
// 2016-08-01   -Broke out variables into customizer friendly sections 
// 2016-08-04   -Refactored repeatable code into modules
//              -Converted cable stops to wedges (used atan(), very fancy)
// 2016-08-17   -Fixed Magsafe2 cable stop positioning and size calculations
// 2016-08-29   -Added logic to adjust the cable channel height based on cablestop existence
//              -Getting away from camelCase in favor of underscore_seperation

//use <ruler.scad> 
// preview[view:north west, tilt:top]

/* [Settings] */
// If you are having problems with ABS curling
add_helper_discs = "no"; //[yes:Add Helper Discs,no:No Helper Discs]
// Magsafe 2 dimensions

magsafe_width = 17.15;
magsafe_height = 5.85;
magsafe_depth = 10.8;

// Thunderbolt 1 dimensions

tb1_width = 10.85;
tb1_height = 7.95;
tb1_depth = 16;

// Thunderbolt 2 dimensions

tb2_width = 11.7;
tb2_height = 8.5;
tb2_depth = 17.5;

// USB dimensions

usb_width = 15.44;
usb_height = 8.1;
usb_depth = 20;

//%ruler(length = 30); //, t=[tb1_center+cablestop_width/2,body_thickness/2,-(tb1_height/2)], r=[0,0,180]);

/* [Cable Stops (Advanced)] */

tb1_fillet = 1.5;
tb1_endstop_depth = 0.5;
tb1_endstop_height = 0.9;

tb2_fillet = 1.5;
tb2_endstop_depth = 0.5;
tb2_endstop_height = 0.9;

usb_fillet = 0.2;
usb_endstop_depth = 0.5;
usb_endstop_height = 0.9;

magsafe_fillet = 2;
magsafe_endstop_depth = 0.2;
magsafe_endstop_height = 0.7;

magsafe_light_hole_offset = 5.3;
magsafe_light_hole_radius = 1.5;
// Endstops are small stoppers at the end of the connector channel
// that keep the cable from pulling through

endstop_depth = 0.5;
endstop_width = 6;
endstop_height = 0.2;
// Cable stops keep the cable from backing out

cablestop_width = 4;
cablestop_depth = 2.25;
cablestop_height = 0.4;
cablestop_clearance = 0.1;

/* [Port Offsets (Advanced)] */
magsafe_to_tb1_offset = 18.12;
tb1_to_tb2_offset = 14;
tb2_to_usb_offset = 15.9;

/* [Hidden] */
// Connector holder body settings
body_height = 12; //default 12
body_thickness = 18.5;
side_thickness = 3; //default 3
body_fillet = 1.5;

// Adjust this to 0.01 to preview correctly in OpenSCAD
render_fix = 0.01;

// Width of the connector body is a sum of all of the connector offsets + the side thicknesses
body_width = side_thickness+(magsafe_width/2)+magsafe_to_tb1_offset+tb1_to_tb2_offset+tb2_to_usb_offset+(usb_width/2)+side_thickness;
magsafe_center = -(body_width/2 - side_thickness-magsafe_width/2);
tb1_center = magsafe_center + magsafe_to_tb1_offset;
tb2_center = tb1_center + tb1_to_tb2_offset;
usb_center = tb2_center + tb2_to_usb_offset;

// Main Method
rotate([90,180,0]) { // Align for printing
    translate([0,-(body_thickness/2),0]) {
        body();
        endstops();
        cablestops();
        if (add_helper_discs == "yes") {
            // upper left
            draw_helper_discs();
            // lower left
            mirror([1,0,0]) {
                draw_helper_discs();
            }
            // upper right
            mirror([0,0,1]) {
                draw_helper_discs();
            }
            // lower right
            mirror([1,0,0]) {
                mirror([0,0,1]) {
                    draw_helper_discs();
                }
            }
        }
    }
}
module body() { // Main body with cable head channels
    difference() {
        // Draw the connector body
        roundedcube([body_width,body_thickness,body_height], radius = body_fillet, apply_to = "y", center = true);
        // Offset magsafe hole
        translate([magsafe_center,0,0]) {
        // Draw magsafe connector
            echo("Actual magsafe dimentions W:", magsafe_width, " D:", body_thickness + render_fix, " H:", magsafe_height);
           roundedcube([magsafe_width,body_thickness + render_fix,magsafe_height],radius = magsafe_fillet, apply_to = "y", center = true);
        }
        //Magsafe charging indicator light hole
        translate([magsafe_center,body_thickness/2-magsafe_light_hole_offset,magsafe_height/2+(body_height/2-magsafe_height/2)/2]) {
           cylinder(h=body_height/2-magsafe_height/2+render_fix,r1=magsafe_light_hole_radius, r2=magsafe_light_hole_radius, center = true, $fn=30);
        }
        // TB1 connector channel
        draw_cable_channel(tb1_center, tb1_width, tb1_height, tb1_depth, tb1_fillet, "TB1");
        // TB2 connector channel
        draw_cable_channel(tb2_center, tb2_width, tb2_height, tb2_depth, tb2_fillet, "TB2");
        // USB connector channel
        draw_cable_channel(usb_center, usb_width, usb_height, usb_depth, usb_fillet, "USB");
        // Grips
        draw_grip(); // right grip
        mirror(1,0,0) {
            draw_grip(); // left grip
        }
    }
}

module endstops() { //End stops keep the cable from coming out the Macbook end
    color("blue") {
        // Magsafe Endstop - This one is special since we don't increase the cable height to accomidate the cable stop
        translate([magsafe_center,body_thickness/2 - magsafe_endstop_depth/2,-(magsafe_height/2-magsafe_endstop_height/2)]) {
            cube([magsafe_width, magsafe_endstop_depth, magsafe_endstop_height], center = true);
        }
        // TB1 Endstop
        draw_endstop(tb1_center, tb1_endstop_height, tb1_endstop_depth, tb1_height, tb1_width);
        // TB2 Endstop
        draw_endstop(tb2_center, tb2_endstop_height, tb2_endstop_depth, tb2_height, tb2_width);
        // USB Endstop
        draw_endstop(usb_center, usb_endstop_height, usb_endstop_depth, usb_height, usb_width);
    }
}
module cablestops() {// Cable stops in the middle to keep the cable from backing out
    color("green") {
        // Magsafe2 Cable Stop
        translate([magsafe_center,body_thickness/2-magsafe_endstop_depth-magsafe_depth-cablestop_depth/2,-(magsafe_height/2)+cablestop_height/2]) {
            difference() {
                cube([cablestop_width, cablestop_depth, cablestop_height], center = true);
                translate([0,0,cablestop_height/2 + .2]) rotate([atan(cablestop_height/(cablestop_depth)),0,0]) cube([cablestop_width + render_fix, cablestop_depth + 1, cablestop_height + .4], center = true);
            }
        }
        // TB1 Cable Stop
        draw_cablestop(tb1_center, tb1_endstop_depth, tb1_height, tb1_depth);
        // TB2 Cable Stop
        draw_cablestop(tb2_center, tb2_endstop_depth, tb2_height, tb2_depth);
        // USB Cable Stop
        draw_cablestop(usb_center, usb_endstop_depth, usb_height, usb_depth);
    }
}
// Helper Modules
module draw_helper_discs() { // Corner discs for ABS prints that tend to lift at the edges
    translate([body_width/2,body_thickness/2-.1,body_height/2]) {
        rotate([90,0,0]) {
            cylinder(h=0.2,r1=3, r2=3, center = true, $fn=30);
        }
    }
}
module draw_cable_channel(channel_center, cable_width, cable_height, cable_depth, cable_fillet, cable_name) {
    //TODO - Logic to size connector height based on cablestop presense 
    channel_depth = endstop_depth+cable_depth;
           
    //Offset hole
    translate([channel_center,0,0]) {
        // Draw connector channel
        if ( body_thickness >= channel_depth) {
        // increase the height of the channel to accommodate the cablestop
            echo("Actual ", cable_name, " dimentions W:", cable_width, " D: ", body_thickness + render_fix, " H: ", cable_height+cablestop_height-cablestop_clearance);
            roundedcube([cable_width,body_thickness + render_fix,cable_height+cablestop_height-cablestop_clearance],radius = cable_fillet, apply_to = "y",center = true);
        }
        else {
            // don't increase the height of the channel to accommodate the cablestop
             echo("Actual ", cable_name, " dimentions W:", cable_width, " D: ", body_thickness + render_fix, " H: ", cable_height);
            roundedcube([cable_width,body_thickness + render_fix,cable_height],radius = cable_fillet, apply_to = "y",center = true);
        }
    }           
}
module draw_endstop(center, endstop_height, endstop_depth, connectorHeight, connectorWidth) {
    translate([center,body_thickness/2 - endstop_depth/2,-(connectorHeight/2)+endstop_height/2-cablestop_height/2]) {
            cube([connectorWidth, endstop_depth, endstop_height], center = true);
    }
}  

module draw_cablestop(center, endstop_depth, connectorHeight, connectorDepth ) {
    cablestop_offset = endstop_depth+connectorDepth+cablestop_depth;
        // Trim the depth of the cablestop if it would overhang the connector body
        if (cablestop_offset - body_thickness > 0) {
            cablestopOffset = cablestop_offset - body_thickness;
            translate([center,body_thickness/2-endstop_depth-connectorDepth-cablestop_depth/2+cablestopOffset/2,-(connectorHeight/2)+cablestop_clearance/2]) {
                difference() {
                    cube([cablestop_width, cablestop_depth-cablestopOffset, cablestop_height], center=true);
                    translate([0,0,cablestop_height/2]) rotate([atan(cablestop_height/(cablestop_depth-cablestopOffset)),0,0]) cube([cablestop_width + render_fix, cablestop_depth, cablestop_height], center=true);
                }
            }
        } 
        else { // if there is no overhang
            translate([center,body_thickness/2-endstop_depth-connectorDepth-cablestop_depth/2,-(connectorHeight/2)+cablestop_clearance/2]) {
                difference() {
                    cube([cablestop_width, cablestop_depth, cablestop_height], center=true);
                    translate([0,0,cablestop_height/2]) rotate([atan(cablestop_height/(cablestop_depth)),0,0]) cube([cablestop_width+render_fix, cablestop_depth+1, cablestop_height], center=true);
                }
            }
             
        }
}

module draw_grip() {
    hull() {
            translate([body_width/2,0,0])
                cube([.5,8,7], center = true);
            translate([body_width/2-1,0,0])
                cube([.5,7,6], center = true);
    }
}
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") { //roundedcube by Daniel Upshaw https://danielupshaw.com/openscad-rounded-corners/
    $fs = 0.01;
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

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
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}
   