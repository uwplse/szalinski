/* [Main] */

// The tilt angle of the mount
topTiltAngle = 45; // [0:90]

// How thick is your printer's frame?
frameThickness = 4; // [1:20]

// What is the height of the frame? (Bolts holes will be placed at the bottom to help it clamp on)
frameZ = 40; // [1:100]

// Should a support brace be added? (recommended)
addBrace=1; // [0:false,1:true]

// Should it include the 4 hole Carriage Mount?
carriage_mount=1; // [0:false,1:true]

//Horizontal Spacing 1 (0 to disable)
horizontal_spacing_1=30; // [0:100]

//Horizontal Spacing 2 (0 to disable)
horizontal_spacing_2=50; // [0:100]

//Horizontal Spacing 3 (0 to disable)
horizontal_spacing_3=0; // [0:100]

// The hole size for the horizontal spacing holes.
horizontal_spacings_dia=3.25; // [2:0.05:8]

// The nut size for the nut recesses, set to 0 to disable.
horizontal_spacings_nut_size=5.8; // [3:0.05:13]



//////////////////////////////////////////////////////
// END USER EDITABLE
//////////////////////////////////////////////////////

/* [Hidden] */

horizontal_spacings=[horizontal_spacing_1,horizontal_spacing_2,horizontal_spacing_3];
$fn=30;
carriage_hole_spacing = carriage_mount ? 23 : 0;
carriage_hole_dia = 4.25;
body_width_padding = 8;
body_width = max(max(horizontal_spacings), carriage_hole_spacing)+max(carriage_hole_dia, horizontal_spacings_dia)+body_width_padding;
tiltAngle = min(max(topTiltAngle, 0), 90);
if(tiltAngle!= topTiltAngle) {
    echo(str("<b><font color='red'>Changed topTiltAngle from ", topTiltAngle, " to ", tiltAngle,"</font></b>"));
}

tilt_hdist = triangle_AAS_c(90, 90-tiltAngle, 18 + max(carriage_hole_spacing, 0) + 5);
tilt_vdist = triangle_AAS_b(90, 90-tiltAngle, 18 + max(carriage_hole_spacing, 0) + 5);

union() {
	difference() {
		union() {
			cube([body_width, frameThickness + 8, frameZ + 20]);
            if(addBrace && 180-tiltAngle > 0) {
                difference() {
                    translate([0, -tilt_hdist + frameThickness + 8, 0])
                        cube([
                            (body_width_padding/2)-1.5,
                            tilt_hdist,
                            tilt_vdist+frameZ + 20
                        ]);
                    
                    translate([-0.1, frameThickness + 8, frameZ + 20]) rotate([tiltAngle,0,0]) rotate([0,0,0]) cube([(body_width_padding/2)-1, 18 + max(carriage_hole_spacing, 0) + 5, tilt_hdist*2]);
                    
                    translate([(body_width_padding/2)-1-0.1, 0, 0]) rotate([0,0,180])rotate([-(90-triangle_SAS_A(tilt_hdist-(frameThickness + 8), 90, tilt_vdist+frameZ + 20)),0,0]) rotate([0,0,0]) cube([(body_width_padding/2)-1, tilt_hdist*5, triangle_SAS_b(frameZ + 20, 180-tiltAngle, 18 + max(carriage_hole_spacing, 0) + 5)]);
                }
            }
			translate([body_width,frameThickness+8,frameZ + 20]) rotate([180+tiltAngle,0,0]) rotate([0,180,0]) difference() {
				cube([body_width, 5, 18+max(carriage_hole_spacing, 0) + 5]);
                if(carriage_hole_spacing != undef && carriage_hole_spacing > 0) {
                    translate([(body_width/2)-(carriage_hole_spacing/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=carriage_hole_dia/2);
                    translate([(body_width/2)+(carriage_hole_spacing/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=carriage_hole_dia/2);
                    translate([(body_width/2)-(carriage_hole_spacing/2), 11.1, 18+carriage_hole_spacing]) rotate([90, 0, 0])cylinder(h=11.2, r=carriage_hole_dia/2);
                    translate([(body_width/2)+(carriage_hole_spacing/2), 11.1, 18+carriage_hole_spacing]) rotate([90, 0, 0])cylinder(h=11.2, r=carriage_hole_dia/2);
                }
                if(len(horizontal_spacings) == undef && horizontal_spacings > (horizontal_spacings_dia*2) + 1) {
                    // this is a single number
                    if(
                        carriage_hole_spacing == undef || 
                        carriage_hole_spacing <= 0 || 
                        horizontal_spacings >= (carriage_hole_spacing + carriage_hole_dia + horizontal_spacings_dia + 2) || 
                        horizontal_spacings <= (carriage_hole_spacing - carriage_hole_dia - horizontal_spacings_dia - 2)
                    ) {
                        // it can fit on the same line as the bottom holes 
                        translate([(body_width/2)-(horizontal_spacings/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                        translate([(body_width/2)+(horizontal_spacings/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                        
                        translate([(body_width/2)-(horizontal_spacings/2), 11.1-7.3, 18]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                        translate([(body_width/2)+(horizontal_spacings/2), 11.1-7.3, 18]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                    } else {
                        // it needs to move up so it can not interfer with the carriage holes
                        translate([(body_width/2)-(horizontal_spacings/2), 11.1, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                        translate([(body_width/2)+(horizontal_spacings/2), 11.1, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                        
                        translate([(body_width/2)-(horizontal_spacings/2), 11.1-7.3, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                        translate([(body_width/2)+(horizontal_spacings/2), 11.1-7.3, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                    }
                } else if(len(horizontal_spacings) > 0) {
                    for(i = horizontal_spacings) {
                        if(i > 0) {
                            if(
                                carriage_hole_spacing == undef || 
                                carriage_hole_spacing <= 0 || 
                                i >= (carriage_hole_spacing + carriage_hole_dia + horizontal_spacings_dia + 2) || 
                                i <= (carriage_hole_spacing - carriage_hole_dia - horizontal_spacings_dia - 2)
                            ) {
                                // it can fit on the same line as the bottom holes 
                                translate([(body_width/2)-(i/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                                translate([(body_width/2)+(i/2), 11.1, 18]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                                
                                translate([(body_width/2)-(i/2), 11.1-7.3, 18]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                                translate([(body_width/2)+(i/2), 11.1-7.3, 18]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                            } else {
                                // it needs to move up so it can not interfer with the carriage holes
                                translate([(body_width/2)-(i/2), 11.1, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                                translate([(body_width/2)+(i/2), 11.1, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])cylinder(h=11.2, r=horizontal_spacings_dia/2);
                                
                                translate([(body_width/2)-(i/2), 11.1-7.3, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                                translate([(body_width/2)+(i/2), 11.1-7.3, 18+(carriage_hole_spacing/2)]) rotate([90, 0, 0])hexagon(horizontal_spacings_nut_size, 2.6);
                            }
                        }
                    }
                }
			}
		}
		translate([-0.1,4,-0.1]) cube([body_width + 0.2, frameThickness, frameZ + 15 + 0.1]);
	
		// M5 screw holes
		translate([11,frameThickness + 8 + 0.1,7.5+(5.5/2)]) rotate([90,0,0]) cylinder(h=frameThickness + 8 + 0.2, r=5.5/2);
		translate([body_width-11,frameThickness + 8 + 0.1,7.5+(5.5/2)]) rotate([90,0,0]) cylinder(h=frameThickness + 8 + 0.2, r=5.5/2);

	}
    
    if(addBrace && tiltAngle > 15) {
       translate([0, 4+frameThickness, (frameZ + 20) - triangle_AAS_c(90, tiltAngle, motor_length-0.2)]) cube([body_width, triangle_AAS_b(90, tiltAngle, motor_length-0.2), 4]);
    }
	
}

function sum_of_angles_rule(A,B) = (180-(A+B));
function law_of_sines_get_side(A,B,b) = (b*sin(A))/sin(B);
function law_of_sines_get_angle(a,B,b) = asin((a*sin(B))/b);
function law_of_cosines_get_side(b,A,c) = sqrt(pow(b,2)+pow(c,2)-2*b*c*cos(A));

function triangle_AAS_b(A,B,a) = law_of_sines_get_side(B,A,a);
function triangle_AAS_c(A,B,a) = law_of_sines_get_side(sum_of_angles_rule(A,B),A,a);

function triangle_SAS_b(c,B,a) = law_of_cosines_get_side(c,B,a);
function triangle_SAS_A(c,B,a) = (c < a ? sum_of_angles_rule(triangle_SAS_C(c,B,a),B) : law_of_sines_get_angle(a,B,triangle_SAS_b(c,B,a)) );
function triangle_SAS_C(c,B,a) = (a < c ? sum_of_angles_rule(triangle_SAS_A(c,B,a),B) : law_of_sines_get_angle(c,B,triangle_SAS_b(c,B,a)));

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}