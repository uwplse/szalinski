// Copyright (c) 2014 by Jean-Louis Paquelin (jlp6k).
// This work is licensed under the Creative Commons Attribution
// Partage dans les Mêmes Conditions 3.0 France License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/fr/
// CC-BY-SA

// Created 2014-03-30
// Last modified 2015-01-04

// dimensions are set in millimeters

// The aluminum profiles are concrete screeds (aka mason rules).
// They are cheap simple rectangular-section aluminum profiles with one inner wall.

/* [Global] */

// View the carriage fully or partially assembled or view individual parts
View = 0; // [0: assembled_carriage, 1: assembled_carriage_with_plates, 2: assembled_wheel_support, 3: assembled_frame, 4: parts]
// Show the profile (the screed) in assembled views 
Show_Profile = 1; // [0: no, 1: yes]
// Choose which individual parts to render
Part = 0; // [0: frame, 1: wheel_support, 2: adjustment_screw_saddle, 3: adjustment_screw_bracket, 4: side_1_panel, 5: side_2_panel]
// Enable 2D projection / laser cutting path
In_2D = 0; // [0: no, 1: yes]

// Nuts, washers, ... dimensions are usually related to the basic diameter of the screw
// see: http://www.metrication.com/engineering/fastener.html

/* [Material] */
Material_Thickness = 6;
// Space necessary around any hole/cut in the material to keep material strength
Material_Clearance = 5;

Screed_Section_D1 = 100;
Screed_Section_D2 = 18;
// Only for display purpose
Screed_Thickness = 1;

/* [Carriage] */
Carriage_Length = 0;
Carriage_Wheel_Box_Length = 150;
// Number of wheels along rail axis. In most case, it's 2 or 3.
Carriage_Wheel_Number = 3;

/* [Wheels] */
Bearing_Inner_Diameter = 8;
Bearing_Outer_Diameter = 22;
Bearing_Width = 7;

Axle_Diameter = Bearing_Inner_Diameter;
Axle_Nut_Inscribed_Diameter = 12.8;
Axle_Nut_Thickness = 6.4;
Axle_Washer_Thickness = 1.7;
Axle_Washer_Outer_Diameter = 16;

Adjustment_Screw_Diameter = 6;
Adjustment_Screw_Nut_Inscribed_Diameter = 9.6;
Adjustment_Screw_Nut_Thickness = 4.8;

/* [Sides] */
Side_Screw_Diameter = 6;
Side_Screw_Nut_Inscribed_Diameter = 9.6;
Side_Screw_Nut_Thickness = 4.8;

Free_Mounting_Screw_Diameter = 6;
// Free_Mounting_Screw_Spacing - Free_Mounting_Screw_Diameter >= Material_Clearance
Free_Mounting_Screw_Spacing = 20; 

/* Clearance */
Small_Clearance = 0.1;
Large_Clearance = 1;

view(View, Show_Profile);

// CSG_Clearance is used to get plain CSG differences and unions with interpenetrating elements
// any small value should be good and this should be leaved unchanged in most case
CSG_Clearance = Small_Clearance;

module view(view, show_profile) {
    echo("Outer Carriage Size X = ", carriage_section_D1());
    echo("Outer Carriage Size Y = ", carriage_length());
    echo("Outer Carriage Size Z = ", carriage_section_D2());
    
    if((Free_Mounting_Screw_Spacing - Free_Mounting_Screw_Diameter) < Material_Clearance)
        echo("Free Mounting Screw Spacing is to small");

    if(view == 1) {
        assembled_carriage_with_plates();
        
        if(show_profile == 1)
            color("lightgrey")
                screed(Screed_Section_D1, Screed_Section_D2, Screed_Thickness, 2 * carriage_length());

    } else if(view == 2) {
        assembled_wheel_support();
    } else if(view == 3) {
        assembled_frame();
    } else if(view == 4) {
        parts(Part, In_2D);
    } else {
        assembled_carriage();
     
        if(show_profile == 1)
            color("lightgrey")
                screed(Screed_Section_D1, Screed_Section_D2, Screed_Thickness, 2 * carriage_length());
    }
}

module assembled_carriage() {
    process_rectangular(Screed_Section_D1, Screed_Section_D2) {
        translate([wheel_support_height() / 2 + Large_Clearance, 0, 0])
            assembled_wheel_support();
    }
    
    for(framePos = [-1, +1])
        translate([0,
                   framePos * (carriage_length() / 2 - (carriage_frame_width() / 2 + Material_Clearance)), 
                   0])
            rotate([90, 0, 0])
                assembled_frame();
}

module flat_pack() {
    spacing = 10;
    
    carriage_frame();
    
    translate([0, (carriage_section_D2() + wheel_support_height()) / 2 + spacing, 0]) {
        rotate([0, 0, 90])
            wheel_support();
    
        translate([carriage_length() / 2 - wheel_support_width() / 2,
                   wheel_support_height() + spacing,
                   0]) {
            rotate([0, 0, 90])
                wheel_saddle();
            
            translate([-wheel_support_width(), 0, 0])
                rotate([0, 0, 90])
                    wheel_adjustment_bracket();
        }
    }
/*
    // side plates
    assign(rectangularData = rectangular(carriage_section_D1(), carriage_section_D2())) {
        assign(width = rectangularData[0][0])
            translate([0, -((carriage_section_D2() + width) / 2) - spacing, 0])
                mountingPlate(width, 0);

        assign(width = rectangularData[1][0])
            translate([(carriage_section_D2() + carriage_section_D1()) / 2 + spacing, 0, 0])
                rotate([0, 0, 90])
                    mountingPlate(width, 1);
    }
*/
}

module parts(part, in_2d) {
    if(in_2d == 0) {
        parts_aux(part);
    } else if(in_2d == 1) {
        projection()
            parts_aux(part);
    }
}

module parts_aux(part) {
// part = 0: frame
// part = 1: wheel_support
// part = 2: adjustment_screw_saddle
// part = 3: adjustment_screw_bracket
// part = 4: side_1_panel
// part = 5: side_2_panel

    if(part == 0) {
        carriage_frame();
    } else if(part == 1) {
        wheel_support();
    } else if(part == 2) {
        wheel_saddle();
    } else if(part == 3) {
        wheel_adjustment_bracket();
    } else if(part == 4) {
      assign(rectangularData = rectangular(carriage_section_D1(), carriage_section_D2()))
          assign(width = rectangularData[0][0])
              mountingPlate(width, 0);
    } else if(part == 5) {
      assign(rectangularData = rectangular(carriage_section_D1(), carriage_section_D2()))
          assign(width = rectangularData[1][0])
              mountingPlate(width, 1);
    }
}

/*** carriage frame ***************************************************/
module assembled_frame() {
    for(framePos = [-1, +1])
        translate([0, 0, framePos * (carriage_frame_width() - Material_Thickness) / 2])
            carriage_frame();

    // adjustement bracket
    rotate([90, 0, 0])
        process_rectangular(Screed_Section_D1, Screed_Section_D2)
            translate([wheel_support_height() - Material_Clearance, 0, 0])
                rotate([0, 90, 0])
                    rotate([0, 0, 90])
                        wheel_adjustment_bracket();

    // adjustment screw
    color("lightgrey")
        rotate([90, 0, 0])
            process_rectangular(Screed_Section_D1, Screed_Section_D2, side = [1, 2]) {
                translate([wheel_support_height() - Material_Clearance, 0, 0])
                    rotate([0, 90, 0])
                        rotate([0, 0, 90]) {
                            translate([0, 0, Material_Clearance + Material_Thickness])
                                bolt(Adjustment_Screw_Diameter,
                                     carriage_frame_height(),
                                     Adjustment_Screw_Nut_Inscribed_Diameter,
                                     Adjustment_Screw_Nut_Thickness);
                            translate([0, 0, -Material_Thickness - Material_Clearance + Adjustment_Screw_Nut_Thickness])
                                rotate([0, 0, 30])
                                    nut(Adjustment_Screw_Diameter, Adjustment_Screw_Nut_Inscribed_Diameter, Adjustment_Screw_Nut_Thickness);
                        }
                            
                
            }
}

function carriage_section_D1() =
    Screed_Section_D1 + 2 * (Large_Clearance + carriage_frame_height());

function carriage_section_D2() =
    Screed_Section_D2 + 2 * (Large_Clearance + carriage_frame_height());

function carriage_frame_height() =
    wheel_support_height() +                                             // wheel support
        Side_Screw_Nut_Thickness + Small_Clearance + Material_Clearance; // side mount

function carriage_length() =
    carriage_wheel_box_length() + carriage_ends_length(); // wheel box + carriage ends

function carriage_ends_length() =
    2 * carriage_frame_width() + 2 * Material_Clearance;

function carriage_frame_width() = 
    2 * Material_Thickness +                                   // frame
    Adjustment_Screw_Nut_Inscribed_Diameter + Small_Clearance; // vertical adjustment screw

function wheel_track_per_side(sideSize) =
    (sideSize < Bearing_Width) ?
        0 : (sideSize >= 2 * wheel_support_overall_width()) ?
            2 : 1;
    
function adjustment_bracket_tenon_width() =
    max((wheel_support_width() - 2 * Material_Thickness) / 2,
        Material_Clearance);

module carriage_frame() {
    difference() {
        cube([carriage_section_D1(), carriage_section_D2(), Material_Thickness], center = true);
        
        // screed imprint
        cube([max(Screed_Section_D1 + 2 * Large_Clearance,
                  wheel_track_per_side(Screed_Section_D1) * wheel_support_width()),
              max(Screed_Section_D2 + 2 * Large_Clearance,
                  wheel_track_per_side(Screed_Section_D2) * wheel_support_width()),
              Material_Thickness + CSG_Clearance], center = true);
              
        // cuts
        assign(slotHeight = Large_Clearance + wheel_support_height() / 2)
            rotate([90, 0, 0]) {
                process_rectangular(Screed_Section_D1, Screed_Section_D2) {
                    // slots for the wheel support
                    for(wheelSupportSide = [-1, +1])
                        translate([slotHeight / 2, 0, wheelSupportSide * (wheel_support_width() - Material_Thickness) / 2])
                            cube([slotHeight,
                                  Material_Thickness + CSG_Clearance,
                                  Material_Thickness], // 1 /////////////////////////////////////
                                  center = true);
                }
                process_rectangular(Screed_Section_D1, Screed_Section_D2) {
                    // adjustement bracket mortises
                    translate([wheel_support_height() - Material_Clearance, 0, 0])
                        cube([Material_Thickness,
                              Material_Thickness + CSG_Clearance,
                              adjustment_bracket_tenon_width()], center = true);
                }
            }
    
    rotate([90, 0, 0])
        assign(rectangularData = rectangular(carriage_section_D1(), carriage_section_D2()))
            for(i = [0:len(rectangularData) - 1])
                translate(rectangularData[i][1])
                    rotate(rectangularData[i][2])
                        assign(width = rectangularData[i][0])
                            for(side = [-1, +1])
                                translate([-(Side_Screw_Nut_Thickness + Small_Clearance) / 2 -
                                               Material_Clearance,
                                            0,
                                            side * (width / 2 -
                                                (Side_Screw_Nut_Thickness + Small_Clearance) -
                                                2 * Material_Clearance -
                                                (Side_Screw_Nut_Inscribed_Diameter + Small_Clearance) / 2)])
                                    // side mounting screw
                                    union() {
                                        translate([(Material_Clearance - Large_Clearance) / 2, 0, 0])
                                            cube([Material_Clearance + Side_Screw_Nut_Thickness + Small_Clearance + Large_Clearance + CSG_Clearance,
                                                  Material_Thickness + CSG_Clearance,
                                                  Side_Screw_Diameter + Small_Clearance], center = true);
                                        cube([Side_Screw_Nut_Thickness + Small_Clearance,
                                              Material_Thickness + CSG_Clearance,
                                              Side_Screw_Nut_Inscribed_Diameter + Small_Clearance], center = true);
                                    }
    }
}

function rectangular(D1, D2) =
    [[D1, [0, 0, D2 / 2], [0, -90, 0]],
     [D2, [D1 / 2, 0, 0], [0, 0, 0]],
     [D1, [0, 0, -D2 / 2], [0, 90, 0]],
     [D2, [-D1 / 2, 0, 0], [0, 180, 0]]];

module process_rectangular(D1, D2, side = [1, 2, 3, 4]) {
    // without any rotation, D1 is along X axis, D2 is along Z axis

    assign(rectangularData = rectangular(D1, D2))
        for(index = [0:len(side) - 1])
            assign(width = rectangularData[side[index] - 1][0],
                   translation = rectangularData[side[index] - 1][1],
                   rotation = rectangularData[side[index] - 1][2])
                translate(translation)
                    rotate(rotation)
                        if(wheel_track_per_side(width) == 1)
                            child();
                        else
                            for(track = [-1, +1])
                                translate([0, 0, track * (width / 2 - wheel_support_overall_width() / 2)])
                                    child();
}

module wheel_adjustment_bracket() {
    difference() {
        union() {
            // bracket
            cube([carriage_frame_width() - 2 * Material_Thickness,
                  wheel_support_width() - 2 * Material_Thickness,
                  Material_Thickness], center = true);

            // tenon
            cube([carriage_frame_width(),
                  adjustment_bracket_tenon_width(),
                  Material_Thickness], center = true);

        }

        // adjustment screw hole
        cylinder(r = Adjustment_Screw_Diameter / 2, h = Material_Thickness + CSG_Clearance, center = true, $fn = 50);

    }
}

/*** wheel support ****************************************************/
module assembled_wheel_support() {
    for(wheelSupportPos = [-1, +1]) {
        translate([0, 0, wheelSupportPos * (wheel_support_width() - Material_Thickness) / 2])
            wheel_support();
    }

    // draw wheels
    color("lightgrey")
        for(wheel = [1:Carriage_Wheel_Number]) {
            translate([-(wheel_support_height() / 2) + (Bearing_Outer_Diameter / 2) - Large_Clearance,
                       wheel_axle_position(wheel),
                       0]) {
                // the wheel
                bearing(Bearing_Inner_Diameter, Bearing_Outer_Diameter, Bearing_Width);
                // wheel axle
                threadedRod(Axle_Diameter, wheel_support_width() + 2 * (Axle_Nut_Thickness + Large_Clearance));
                
                for(wheelAxleSide = [-1, +1]) {
                    translate([0, 0, wheelAxleSide * (wheel_support_width() + Axle_Nut_Thickness) / 2])
                        // nuts on both ends of the axle
                        nut(Axle_Diameter, Axle_Nut_Inscribed_Diameter, Axle_Nut_Thickness);
                        // washers
                        // ????
                }
            }
        }
        
    // adjustement screw saddles
    for(framePos = [-1, +1])
        rotate([0, 90, 0])
            translate([0,
                       framePos * (carriage_length() / 2 - Material_Clearance - carriage_frame_width() / 2),
                       -wheel_support_height() / 2 + Material_Thickness / 2 + Material_Clearance])
                wheel_saddle();
}

function carriage_wheel_box_length() =
    max(Carriage_Wheel_Box_Length,
        Carriage_Wheel_Number * Bearing_Outer_Diameter +   // space for the wheels
            (Carriage_Wheel_Number + 1) * Large_Clearance, // carriage ends
        Carriage_Length - carriage_ends_length());

function wheel_support_width() =
    2 * Material_Thickness +
    ceil((max(Bearing_Width,
              2 / sqrt(3) * Adjustment_Screw_Nut_Inscribed_Diameter) + Small_Clearance -
          Bearing_Width) / Axle_Washer_Thickness) * Axle_Washer_Thickness +
    Bearing_Width;
    
function wheel_support_overall_width() =
    // wheel_support_width() + all mounting hardware (nuts, ...)
    wheel_support_width() + 2 * (Axle_Nut_Thickness + Large_Clearance);
    
function wheel_support_height() =
    max(Bearing_Outer_Diameter,
        2 * Material_Clearance + Axle_Diameter,
        2 * Material_Clearance + 2 * Material_Thickness + Adjustment_Screw_Nut_Thickness);

function wheel_axle_position(wheel) =
    (Carriage_Wheel_Number == 1) ?
        0 :
        (wheel == 1) ?
            -carriage_wheel_box_length() / 2 + Large_Clearance + Bearing_Outer_Diameter / 2 :
            wheel_axle_position(1)
                + (wheel - 1) * (carriage_wheel_box_length() - 2 * Large_Clearance - Bearing_Outer_Diameter) / (Carriage_Wheel_Number - 1); 

function saddle_tenon_width() =
    max((carriage_frame_width() - 2 * Material_Thickness) / 2,
        Material_Clearance);

module wheel_support() {
    difference() {
        cube([wheel_support_height(),
              carriage_length(),
              Material_Thickness], center = true);
        
        // axles holes
        for(wheel = [1:Carriage_Wheel_Number]) {
            translate([-(wheel_support_height() / 2) + (Bearing_Outer_Diameter / 2) - Large_Clearance,
                       wheel_axle_position(wheel),
                       0])
                cylinder(r = Bearing_Inner_Diameter / 2, h = Material_Thickness + CSG_Clearance, center = true, $fn = 50);
        }
        
        // frame mounting slots
        assign(frameCenterPosition = carriage_length() / 2 - Material_Clearance - carriage_frame_width() / 2) {
            
            for(framePos = [-1, +1]) {
                translate([wheel_support_height() / 4 + CSG_Clearance / 2,
                           framePos * frameCenterPosition,
                           0])
                    // slots for the two frame parts
                    for(inout = [-1, +1])
                        translate([0, inout * (carriage_frame_width() - Material_Thickness) / 2, 0])
                            cube([wheel_support_height() / 2 + CSG_Clearance,
                                  Material_Thickness, // 1 /////////////////////////////////////
                                  Material_Thickness + CSG_Clearance], center = true);      
                    
                // adjustement screw saddle mortises
                translate([-wheel_support_height() / 2 + Material_Thickness / 2 + Material_Clearance,
                           framePos * frameCenterPosition,
                           0])
                    cube([Material_Thickness,
                          saddle_tenon_width(),
                          Material_Thickness + CSG_Clearance], center = true);
            }
        }
    }
}

module wheel_saddle() {
    union() {
        // saddle
        cube([wheel_support_width() - 2 * Material_Thickness,
              carriage_frame_width() - 2 * Material_Thickness,
              Material_Thickness], center = true);

        // tenon
        cube([wheel_support_width(),
              saddle_tenon_width(),
              Material_Thickness], center = true);

    }
}

/*** mounting plates **************************************************/
module assembled_carriage_with_plates() {
    assembled_carriage();
    
    assign(rectangularData = rectangular(carriage_section_D1(), carriage_section_D2()))
        for(i = [0:len(rectangularData) - 1])
            translate(rectangularData[i][1])
                rotate(rectangularData[i][2])
                    assign(width = rectangularData[i][0])
                        rotate([0, 90, 0])
                            translate([0, 0, Material_Thickness / 2]) {
                                // side plate
                                mountingPlate(width, (i % 2));
                              
                                // side mounting screws
                                color("lightgrey")
                                    assign(firstHolePosition = (carriage_wheel_box_length() + Material_Thickness) / 2)
                                        for(side = [-1, +1],
                                            frontBack = [-firstHolePosition,
                                                         +firstHolePosition,
                                                         -firstHolePosition - carriage_frame_width() + Material_Thickness,
                                                         +firstHolePosition + carriage_frame_width() - Material_Thickness])
                                            translate([side * (width / 2 -
                                                           (Side_Screw_Nut_Thickness + Small_Clearance) -
                                                           2 * Material_Clearance -
                                                           (Side_Screw_Nut_Inscribed_Diameter + Small_Clearance) / 2),
                                                       frontBack,
                                                       0]) {
                                                translate([0, 0, -Side_Screw_Nut_Thickness / 2])
                                                    bolt(Side_Screw_Diameter,
                                                         Side_Screw_Nut_Thickness + Material_Thickness + Material_Clearance + Large_Clearance / 2,
                                                         Side_Screw_Nut_Inscribed_Diameter,
                                                         Side_Screw_Nut_Thickness);
                                                translate([0, 0, -Material_Clearance - Material_Thickness + Large_Clearance / 2])
                                                    rotate([0, 0, 30])
                                                        nut(Side_Screw_Diameter, Side_Screw_Nut_Inscribed_Diameter, Side_Screw_Nut_Thickness);
                                  }
                            }
    
}

function side_plate_length() =
    carriage_length() +
        max(0, (Side_Screw_Diameter + Small_Clearance - Material_Thickness) / 2); // adds some length if side screw diameter is greater than material thickness

module mountingPlate(width, overlap) {
    difference() {
        cube([width + (overlap == 1 ? 2 * Material_Thickness : 0),
              side_plate_length(),
              Material_Thickness], center = true);
              
        // adjustment screws
        process_rectangular(width - 2 * (Large_Clearance + carriage_frame_height()), 0, side = [1])
            rotate([0, 90, 0])
                for(frontBack = [-1, +1])
                    translate([0, frontBack * (carriage_wheel_box_length() + carriage_frame_width()) / 2, 0])
                    cylinder(r = (Side_Screw_Diameter + Small_Clearance) / 2, h = Material_Thickness + CSG_Clearance, center = true, $fn = 50);
        
        
        // mounting holes
        assign(firstHolePosition = (carriage_wheel_box_length() + Material_Thickness) / 2) {
            for(side = [-1, +1],
                frontBack = [-firstHolePosition,
                             +firstHolePosition,
                             -firstHolePosition - carriage_frame_width() + Material_Thickness,
                             +firstHolePosition + carriage_frame_width() - Material_Thickness])
                translate([side * (width / 2 -
                               (Side_Screw_Nut_Thickness + Small_Clearance) -
                               2 * Material_Clearance -
                               (Side_Screw_Nut_Inscribed_Diameter + Small_Clearance) / 2),
                           frontBack,
                           0])
                    cylinder(r = (Side_Screw_Diameter + Small_Clearance) / 2,
                             h = Material_Thickness + CSG_Clearance,
                             center = true, $fn = 50);

            // free mounting holes
            assign(xWidth = width - 2 * Material_Clearance,
                   yWidth = 2 * firstHolePosition - (Side_Screw_Diameter + Small_Clearance) - 2 * Material_Clearance) {

//                %cube([xWidth, yWidth, Material_Thickness + CSG_Clearance], center = true);

                assign(xCount = floor((xWidth - Free_Mounting_Screw_Diameter) / (2 * Free_Mounting_Screw_Spacing)),
                       yCount = floor((yWidth - Free_Mounting_Screw_Diameter) / (2 * Free_Mounting_Screw_Spacing))) {
                    for(xIndex = [0:xCount], yIndex = [0:yCount], sx = [-1, +1], sy = [-1, +1])
                        // Note: center hole is hollowed four times
                        translate([xIndex * sx * Free_Mounting_Screw_Spacing,
                                   yIndex * sy * Free_Mounting_Screw_Spacing,
                                   0])
                            cylinder(r = (Free_Mounting_Screw_Diameter + Small_Clearance) / 2,
                                 h = Material_Thickness + CSG_Clearance,
                                 center = true, $fn = 30);
                }
            }
        }
    }
}

/*** hardware *********************************************************/
module screed(screed_section_d1, screed_section_d2, screed_thickness, screed_length) {
    union() {
        difference() {
            cube([screed_section_d1,
                  screed_length,
                  screed_section_d2],
                 center = true);
            cube([screed_section_d1 - (2 * screed_thickness),
                  screed_length + 1,
                  screed_section_d2 - (2 * screed_thickness)],
                 center = true);
        }
        cube([screed_thickness,
              screed_length,
              screed_section_d2],
             center = true);
    }
} 

module threadedRod(threaded_rod_diameter, threaded_rod_length) {
    cylinder(h = threaded_rod_length, r = threaded_rod_diameter / 2, center = true, $fn = 100);
}

module bearing(bearing_inner_diameter, bearing_outer_diameter, bearing_width) {
    difference() {
        cylinder(h = bearing_width, r = bearing_outer_diameter / 2, center = true, $fn = 100);
        cylinder(h = bearing_width + 1, r = bearing_inner_diameter / 2, center = true, $fn = 100);
    }
}

module nut(inner_diameter, outer_inscribed_diameter, thickness) {
    nut_circumcircle_radius = outer_inscribed_diameter / sqrt(3);

    difference() {
        cylinder(h = thickness, r = nut_circumcircle_radius, center = true, $fn = 6);
        cylinder(h = thickness + 1, r = inner_diameter / 2, center = true, $fn = 100);
    }
}

module bolt(thread_diameter, thread_length, outer_inscribed_nut_diameter, nut_thickness) {
    nut_circumcircle_radius = outer_inscribed_nut_diameter / sqrt(3);
    
    union() {
        // thread
        cylinder(h = nut_thickness + thread_length, r = thread_diameter / 2, center = true, $fn = 100);
        
        // head
        translate([0, 0, thread_length / 2])
            cylinder(h = nut_thickness, r = nut_circumcircle_radius, center = true, $fn = 6);
    }
}
