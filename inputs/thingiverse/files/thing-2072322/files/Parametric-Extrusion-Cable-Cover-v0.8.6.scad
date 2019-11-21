// Parametric Extrusion Cable Cover
// Created by Bill Gertz (billgertz) on 21 January 2017
// Version 0.8.6
//
// Version  Author          Change
// -------  -------------   ----------------------------------------------------------------------------
//  0.6.0   billgertz       Developed core body and tab modules
//
//  0.6.1   billgertz       First beta realease, vertical cable relief only
//
//  0.7.0   billgertz       Second beta release, added horizontal relief model
//
//  0.7.1   billgertz       Fixed horizonatal relief model
//
//  0.7.2   billgertz       Added tab tip trim
//
//  0.7.3   billgertz       Added auto body length, this is best for vertical
//                          strain relief as it makes the body level with the
//                          top of the extrusion
//
//  0.7.4   billgertz       Tab parameter tuning
//
//  0.8.0   billgertz       Added circular and wedge tab seperation types
//
//  0.8.1   billgertz       Reduced tab clip due to breakage, modified vertical
//                          hollowing for capsule due to breakthrough
//
//  0.8.2   billgertz       Added solid tab, reduced undersizing for better fit
//                          First Thingiverse release, kindly report problems
//
//  0.8.3   billgertz       Added extrusion overrides and console mailto: report
//
//  0.8.4   billgertz       Added error message on too large diameter
//
//  0.8.5   billgertz       Added trimming up center part of vertical cover tabs
//                          Fixed circular style tab
//
//  0.8.6   billgertz       Fixed circular tab type, again!
//                          Added fishtail style tabs to allow maximum clearance
//                          for wire bundle to fit under tabs in a slot
//
// Customizer View
// preview[view:south, tilt:top diagnol]
//
// Local Variables and Calculations //////////////////////////////////////

/* [General] */
// Diameter of cable bundle (mm)
diameter = 10;              // [10:40]
// Level body top with extrusion (in vertical orientation)
auto_length = "no";         // [yes, no]
// Length of relief body if auto not set (mm)
body_length = 25;           // [10:60]
// Orientation of cable cover tabs (horizontal/vertical)
orientation = "horizontal"; // [horizontal, vertical]
// T-slot extrusion type (string)
extrusion = "40!FelixRobotics"; // [10!MakerBeam:MakerBeam 10mm,15!OpenBeam:OpenBeam 15mm,20!AluTP:AluTP 20x20mm (I52020),20!MiSumi:MiSumi 20x20mm (HFS5 Series),30!MiSumi:MiSumi 30x30mm (HFS6 Series),40!FelixRobotics:Felix Printer 40x40mm,40!MiSumi:MiSumi 40x40mm (HFS8 Series)]
// Tab gap finish type (wire/ solid/ wedge/ circular/ square) see: Advanced for more tab settings
tab_type = "fishtail";          // [fishtail, solid, wedge, circular, square]

/* [Manual Extrusion] */
// See instrucions on Thingiverse page: 
// Manufacturer name (optional)
_manufacturer = "";
// Extrusion name or series (required)
_name = "";
// Size (mm)
_nominal_size = 40.0;       // [25.3:1 inch,37.95:1.5 inch,10.0:10 mm,15.0:15 mm,20.0:20 mm,30.0:30 mm,40.0:40 mm,50.0:50 mm]
// Slot width (mm)
_slot_width = 8.0;          // [4.0:0.1:12.0]
// Slot depth (mm)
_slot_depth = 2.0;          // [1.0:0.1:8.0]

/* [Advanced] */
// Mount plate thickness (mm)
wall_thickness = 2;         // [1.5:Thin - 1.5mm,2.0:Typical - 2.0mm,2.5:Thick - 2.5mm,3.0:Very Thick - 3.0mm]
// Tab width (mm)
tab_width = 5;              // [2:Tiny - 2.0mm,3:Small - 3.0mm,5:Typical - 5.0mm,7:Large - 7.0mm,10:Huge - 10.0mm] 
// Tab clip overhang (mm)
tab_clip = 0.5;             // [0.3:Small - 0.3mm,0.5:Typical - 0.5mm,0.7:Large - 0.7mm]
// Tab thickness (mm)
tab_thickness = 3.0;        // [2.5:Thin - 2.5mm,3.0:Typical - 3.0mm,4.0:Thick - 4.0mm,5.0:Very Thick - 5.0mm]
// Length to blunt tab point (mm)
tab_trim = 2.2;             // [1.0:Sliver - 1.0mm,1.5:Nip - 1.5mm,2.2:Typical - 2.2mm,3.1:Chunk - 3.1mm,4.2:Huge - 4.2mm,5.5:Mammoth - 5.5mm]
// Trim vertical cover tabs interior at %diameter (percent)
center_trim_percent = 65;   // [0:5:85]
// Line segments per full circle
resolution = 90;            // [30:Rough - 30 seg/circle,60:Coarse - 60 seg/circle,90:Fine - 90 seg/circle,180:Smooth - 180 seg/circle,360:Insane - 360 seg/circle]
// Undersize for fit (mm)
undersize = 0.1;            // [0:0.1:1]

/* [Hidden] */
// T-slot extrusion to slot width and wall thickness vector (add your's here)
extrusion_vector = [
                        ["10!MakerBeam",     10.0,  3.0,  1.0],
                        ["15!OpenBeam",      15.0,  3.2,  1.5],
                        ["20!AluTP",         20.0,  5.0,  1.8],
                        ["20!MiSumi",        20.0,  5.0,  2.0],
                        ["30!MiSumi",        30.0,  8.0,  2.0],
                        ["40!FelixRobotics", 40.0,  8.4,  4.2],
                        ["40!MiSumi",        40.0, 10.0,  5.5],
                   ];

// nudge for artifact reduction and complete manifolds (mm)
nudge = .05;
// radius (mm)
radius = diameter/2;
// length calculate if auto_length set otherwise use given value
length = auto_length == "yes" ? extrusionSize(extrusion)/2 + radius: body_length;
// turn center trim percentage into number (mm)
center_trim = diameter*center_trim_percent/100;
// resoulution (segments per unit circle)
$fn = resolution;

// Create mailto: notification if manual extrusion used
if (_name != "") {
    echo(str("Please copy and paste the following line (exclude the ECHO: and leading and tailing double quotes) into a browser to mail your extrusion details to socofablab@gmail.com"));
    echo(str("mailto:socofablab@gmail.com?subject=Extrusion%20Project%20-%20", _name, "&body=%7B%0A%22Name%22%3A%20%22", _name, "%22%2C%0A%22Manufacturer%22%3A%20%22", _manufacturer, "%22%2C%0A%22Size%22%3A%20", _nominal_size, "%2C%0A%22Width%22%3A%20", _slot_width, "%2C%0A%22Depth%22%3A%20", _slot_depth, "%0A%7D"));
}

if (diameter + wall_thickness*2 >= length) {
    echo(str("ERROR - Diameter > Body Length, try again with smaller diameter"));
    translate([-85, 0])
        text("ERROR - Diameter > Body Length", size = 8, font = "Liberation Sans:style=Bold");
    translate([-35, -10])
        text("try again with smaller diameter", size = 8, font = "Liberation Sans:style=Bold");
} else {

    Body(
        orientation,      // direction of relief body (string)
        extrusion,        // extrusion type (string)
        length,           // length of the strain relief body (mm)
        radius,           // radius of strain relief cable bundle (mm)
        wall_thickness,   // wall thickness of strain relief (mm)   
        tab_width,        // extrusion mounting tab width (mm)
        tab_thickness,    // extrusion mounting tab thickness (mm) 
        tab_trim,         // length from top of tap apex to trim (mm)
        tab_type          // tab seperation type (string)
    );

}

function extrusionSize(size) =
    _name != "" ?
        _nominal_size : search([size], extrusion_vector)[0] == undef ?
            0: extrusion_vector[ search([size], extrusion_vector)[0] ] [1];

function extrusionGap(size) =
    _name != "" ?
        _slot_width : search([size], extrusion_vector)[0] == undef ?
            0: extrusion_vector[ search([size], extrusion_vector)[0] ] [2];
        
function extrusionThickness(size) =
    _name != "" ?
        _slot_depth : search([size], extrusion_vector)[0] == undef ?
            0: extrusion_vector[ search([size], extrusion_vector)[0] ] [3];

module Body(orientation, extrusion, length, radius, thickness, tab_width, tab_thickness, tab_trim, tab_type) {

    difference() {

        union() {

            difference() {

                // create Capsule and Interface rough clay
                
                translate(v = [length/4 - 2*thickness, 0, length/2 + thickness]) cube(size = [radius + length/2 + 6*thickness, radius + 8*thickness, length + 2*thickness], center = true);
    
                // clean up Interface face and hollow out the Capsule 
                if (orientation == "vertical") {
                    translate(v = [radius - thickness, -radius - thickness - nudge, -nudge]) cube(size = [radius*4, (radius + thickness + nudge)*2, length + nudge*2]);
                } else {
                    translate(v = [radius + thickness, -radius - thickness - nudge, -nudge]) cube(size = [radius*4, (radius + thickness + nudge)*2, length + nudge*2]);
                }
                translate(v = [0, 0, -nudge - thickness]) Capsule(length + nudge, radius, length);
                
            }

            // add Tabs to face of Interface
            if (orientation == "vertical") {
                translate(v = [radius - thickness, 0 , length - radius]) Tab(extrusion, (radius + thickness)*2, tab_thickness, tab_clip, tab_trim, tab_type);
            } else {
                translate(v = [radius + thickness, 0 , length/2]) rotate(a = [90, 0, 0]) Tab(extrusion, length, tab_thickness, tab_clip, tab_trim, tab_type);
            }
            
        }
  
        // hollow out Interface and trim Tabs
        
        if (orientation == "vertical") {
            translate(v = [radius/4, 0, -nudge])
            Interface(length - thickness, radius, tab_width=tab_width/2, offset=length);
        } else {
            height = extrusionGap(extrusion) - undersize*2;
            
            // make circular hollow in Interface
            translate(v = [radius + length/2 + nudge, 0, length - radius - min(length/2 - radius, tab_width)])
                rotate(a = [0, 90, 0]) translate(v = [0, 0, -radius/2]) cylinder(h = radius + length - nudge, r = radius, center = true);
 
            // seperate the outside edge Tabs if not solid or fishtail style
            if (tab_type != "solid" && tab_type != "fishtail") {
                translate(v = [radius*2 + thickness - nudge, 0, (length - radius)/2 - thickness - nudge])
                    cube(size = [height*2 + nudge*2, height - tab_thickness*2, length - radius - thickness*2 + nudge*2], center=true);
            }
            
        }
        
        // clean up remaining sides 
        difference() {
            translate(v = [-length, -length, -length/2]) cube(length*2);
            
            union() {
                Capsule(length, radius + thickness);
                Interface(length, radius + thickness, offset=length*2);
            }
            
        }
        
        // finally cleanup tabs
        
        if (orientation == "vertical") {
            translate(v = [radius - thickness, -center_trim/2, 0]) cube(size = [(radius + thickness + nudge)*2, center_trim, length + radius + thickness + nudge]);
        } else {
            // trim lower tab to specified tab width
            translate(v = [radius + thickness, -radius - thickness - nudge, tab_width]) cube(size = [(radius + thickness + nudge)*2, (radius + thickness + nudge)*2, length - tab_width*2]);
        }
        
            
    
    }
    
}

module Capsule(length, radius, extra=0) {

    union() {
        translate(v = [0, 0, (length - radius - extra)/2]) cylinder(h = length - radius + extra, r = radius, center = true);
        translate(v = [0, 0, length - radius]) sphere(r = radius);
    }

}

module Interface(length, radius, tab_width=0, offset=0, extra=0) {
    
    union() {
    
        difference() {
            translate(v = [0, 0, (length - radius)/2]) cube(size = [(radius + offset)*2 + nudge, radius*2 - tab_width, length - radius], center = true);
            translate(v = [-radius, 0, (length - radius + nudge)/2]) cube(size = [(radius + nudge)*2, (radius + nudge)*2, length - radius + nudge*2], center = true);
            translate(v = [-radius, 0, (length - radius + nudge)/2]) cube(size = [radius, (radius + nudge)*2, length - radius + nudge*2], center = true);
        }
        
        translate(v = [(radius + offset)/2, 0, length - radius]) rotate(a = [0, 90, 0]) cylinder(h = radius + offset + nudge, r = radius - tab_width/2, center = true);
        
    }
    
}

module Tab(extrusion, length, thickness, tab_clip, trim, type) {
    
    depth = extrusionGap(extrusion) - undersize*2;
    height = extrusionThickness(extrusion);
    clip = tab_clip - undersize;
    
    translate(v = [height/2 - nudge*2, 0, 0])
    
        difference() {
        
            // create tab body
            union() {
    
                cube(size = [height, length, depth - undersize], center=true);
                rotate(a = [90, 0, 0]) translate(v = [height/2 + depth/(2*sqrt(3)) + clip/2 - nudge, 0, 0]) cylinder(h = length, r = depth/sqrt(3) + clip, center = true, $fn=3);
            }
        
            // remove center portion
            if (tab_type == "square") {
                translate(v = [3*height/2 - nudge, 0, 0]) cube(size = [height*4, length + nudge*2, depth - 2*thickness - undersize], center=true);
            } else if (tab_type == "wedge") {
                
                // inside tip finish
                translate(v = [height/2 + depth/2 - nudge, -length/2 - nudge, -depth/2 + thickness + undersize]) cube(size = [height*2, length + nudge*2, depth - 2*thickness - undersize]);
                
                // inside seperation wedge
                translate(v = [height/2 + depth/2, -length/2 - nudge, -depth/2 + thickness + undersize/2])
                    mirror(v = [1, 0, 0]) intersection() {
                        rotate(a = [0, -6, 0]) translate(v = [-height*2, 0, 0]) cube(size = [height*4, length + nudge*2, depth - 2*thickness - undersize]);
                        rotate(a = [0, 6, 0]) translate(v = [-height*2, 0, 0]) cube(size = [height*4, length + nudge*2, depth - 2*thickness - undersize]);
                    }
                    
            } else if (tab_type == "circular") {
                tab_radius = depth/2 - thickness - undersize/2;
                
                //semicircular bit at bottom of seperator
                translate(v = [-tab_radius/2 - nudge, 0, 0]) rotate(a = [90, 0, 0]) cylinder(h = length + nudge*2, r = tab_radius, center=true);
                
                // square bit above
                translate(v = [3*height/2 + 3*tab_radius/2 - nudge, 0, 0]) cube(size = [height*4, length + nudge*2, depth - 2*thickness - undersize], center=true);
            } else if (tab_type == "fishtail") {
                // trim tip at height + thickenss
                translate(v = [height/2 + thickness, 0, 0]) rotate(a = [90, 0, 0]) cylinder(h = length + nudge*2, r = depth/(2*sqrt(2)), center=true);
            }
            
            // trim tip as requested
            translate(v = [height + 2*depth/sqrt(3) - trim, 0, 0]) cube(size = [height*2, length*2, length*2], center=true);
 
        
        }
    
}