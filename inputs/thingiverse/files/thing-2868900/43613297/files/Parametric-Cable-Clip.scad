// Shape of the object the clip attaches to?
shape=0; // [0:rectangle, 1:circle, 2:open_rectangle]
// Size of the object the clip attaches to (mm)
clipSize = 25.4;
// Relative size of the main opening of the clip
mainOpeningWidthPercent = 0.85;
// Diameter of the cable/tube/hose/round thing going in the other side (mm)
cableDiameter = 10.0;
// Size of opening on cable clip loop (mm) (smallest size opening that cable can fit through) - if unsure, try cableDiameter-1mm for small cables
cableOpeningWidth = 6.0;
// Height/length/thickness of the clip (mm)
height = 13.0;
// Wall thickness of the clip (mm)
thickness = 2;
// Add a hole on the side for screwing or riveting onto things? (mm)
holeDiameter=5;
// Create internal tabs for clipping into aluminum extrusion?
internalTabs=0; // [0:no, 1:yes]
// Depth of tabs for clipping into aluminum extrusion (mm)
tabDepth = 1.0;
// Width of tabs (mm)
tabWidth = 2.5;
// Additional clearance to add to internal openings (mm)
clearance = 0.2;

module rect_base() {
    union() {
        difference() {
            square([clipSize + 2*clearance + 2*thickness, clipSize + 2*clearance + 2*thickness], center=true);
            square([clipSize + 2*clearance, clipSize + 2*clearance], center=true);
            translate([-clipSize/2, 0]) square([clipSize + 2*clearance, mainOpeningWidthPercent * clipSize + 2*clearance], center=true);
        }
        
        if (internalTabs == 1) {
            translate([0, clipSize/2 + clearance - tabDepth/2]) square([tabWidth, tabDepth], center=true);
            translate([0, -clipSize/2 - clearance + tabDepth/2]) square([tabWidth, tabDepth], center=true);
        }
    
        translate([clipSize/2 + 2*clearance + thickness + cableDiameter/2, 0]) circle(cableDiameter/2 + clearance + thickness, 50);
        translate([(clipSize/2 + 2*clearance + thickness + cableDiameter/2) - (cableDiameter/2 + thickness)/2, 0]) square([(cableDiameter/2 + thickness), min(cableDiameter, clipSize) + 2*clearance + 2*thickness], center=true);
    }
}

module circle_base() {
    union() {
        difference() {
            union() {
                circle(clipSize/2 + clearance + thickness, 50);
                translate([((cableDiameter/2 + clipSize/2) + thickness)/2, 0]) square([(cableDiameter/2 + clipSize/2) + thickness, min(cableDiameter, clipSize) + 2*clearance + 2*thickness], center=true);
            }
            circle(clipSize/2 + clearance , 50);
            translate([-clipSize/2, 0]) square([clipSize + 2*clearance, mainOpeningWidthPercent * clipSize + 2*clearance], center=true);
        }
        
        if (internalTabs == 1) {
            translate([0, clipSize/2 + clearance - tabDepth/2]) square([tabWidth, tabDepth], center=true);
            translate([0, -clipSize/2 - clearance + tabDepth/2]) square([tabWidth, tabDepth], center=true);
        }
        
        translate([clipSize/2 + 2*clearance + thickness + cableDiameter/2, 0]) circle(cableDiameter/2 + clearance + thickness, 50);   
    }
}

difference() {
    linear_extrude(height=height) {
        if (shape == 0) {
            difference() {
                rect_base();
                translate([clipSize/2 + 2*clearance + thickness + cableDiameter/2, 0]) circle(cableDiameter/2 + 2*clearance, 50);
                if (cableOpeningWidth > 0) {
                    translate([(clipSize/2 + 2*clearance + thickness + cableDiameter/2) + (cableDiameter/2 + 2*clearance + thickness)/2, 0]) square([cableDiameter/2 + 2*clearance + thickness, cableOpeningWidth + 2*clearance], center=true);
                }
            }
        } else if (shape == 1) {
            difference() {
                circle_base();
                translate([clipSize/2 + 2*clearance + thickness + cableDiameter/2, 0]) circle(cableDiameter/2 + 2*clearance, 50);
                if (cableOpeningWidth > 0) {
                    translate([(clipSize/2 + 2*clearance + thickness + cableDiameter/2) + (cableDiameter/2 + 2*clearance + thickness)/2, 0]) square([cableDiameter/2 + 2*clearance + thickness, cableOpeningWidth + 2*clearance], center=true);
                }
            }
        } else if (shape == 2) {
            difference() {
                rect_base();
                translate([clipSize/2 + 2*clearance + thickness + cableDiameter/2, 0]) circle(cableDiameter/2 + 2*clearance, 50);
                if (cableOpeningWidth > 0) {
                    translate([(clipSize/2 + 2*clearance + thickness + cableDiameter/2) - (cableDiameter/2 + 2*clearance + thickness)/2, 0]) square([cableDiameter/2 + 2*clearance + thickness, cableOpeningWidth + 2*clearance], center=true);
                }
            }
        }
    }
    
    if (holeDiameter > 0) {
        translate([0, (clipSize + 2*clearance + 2*thickness + 2)/2, height/2]) rotate(a=[90, 0, 0]) linear_extrude(height=(clipSize + 2*clearance + 2*thickness + 2)) {
            circle(holeDiameter/2, 50);
        }
    }
}