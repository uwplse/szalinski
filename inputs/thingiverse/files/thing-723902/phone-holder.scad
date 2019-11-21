// Internal width of holder - your phone/tablet's width, plus 2 or so (mm)
holder_width = 64;
// "Internal" height of the holder (mm). Can be as short or tall as you want.
holder_height = 42.75;
// Internal depth of the dock - your phone/tablet's depth + a mm or so
holder_depth = 11;
// Depth of the plug hole in mm
hole_width = 18;
// Width of the plug hole in mm
hole_depth = 9;
// Left / right side wall thickness in mm
side_thickness = 1;
// Thickness of back plate in mm.
back_thickness = 2;
// Thickness of front plate in mm.
front_thickness = 1;
// Thickness of bottom plate in mm.
bottom_thickness = 1;
// Radius of pieces that make up the semicircles that hold the phone in place (mm).
retainer_piece_radius = 6;
// Radius of the mounting indentations, mm.
indentation_radius = 4;
// Depth of the mounting indentations, mm.
indentation_depth = 1.5;
// Mounting screw radius, mm.
hole_radius = 1.5;
// Distance of mounting indents from top, mm
mount_point_from_top = 5;
// Distance of mounting indents from sides, mm.
mount_point_from_side = 5;
// The name to print.
name = "Joe";
// Thickness of name, mm.
name_thickness = 1.5;
// Distance from bottom of dock to bottom of name, mm.
name_bottom_height = 15;
exterior_width = holder_width + (2*side_thickness);
exterior_depth = holder_depth + back_thickness + front_thickness;
exterior_height = holder_height + bottom_thickness;
// To appease OpenSCAD. Please don't modify.
fudge = .01;

module corePiece() {
    difference() {
        cube([exterior_width,exterior_depth,exterior_height]);
        /* Hollow it out */
        translate([side_thickness,0,bottom_thickness]){
            cube([holder_width, holder_depth+front_thickness, holder_height]);
        }
        /* Put in the cord hole */
        translate([(exterior_width - hole_width) / 2,(holder_depth - hole_depth),0]){
            cube([hole_width,hole_depth,(holder_depth - hole_depth)]);
        }
    }
}

module retainerSection() {
    translate([retainer_piece_radius * -0.5,0,0]){
        rotate([90,180,0]){
            intersection() {
                cylinder(r=retainer_piece_radius,h=front_thickness);
                translate([-retainer_piece_radius,-retainer_piece_radius,0]){
                    cube([retainer_piece_radius*0.5,2 * retainer_piece_radius,front_thickness]);
                }
            }
        }
    }
}

module retainer() {
    pieceHeight = 2 * sqrt(.75 * (pow(retainer_piece_radius,2)));
    echo(str("Piece height: ",pieceHeight));
    numPieces = floor((holder_height - bottom_thickness) / pieceHeight);
    echo(str("PIECES: ",numPieces));
    for (pieceNum = [0 : (numPieces - 1)]){
        echo(str("PIECENUM: ",pieceNum));
        translate([side_thickness,front_thickness,bottom_thickness + ((1 + (2 * pieceNum)) *(pieceHeight/2))]){
            retainerSection();
        }
        translate([(side_thickness*2)+holder_width-side_thickness,front_thickness,bottom_thickness + ((1 + (2 * pieceNum)) *(pieceHeight/2))]){
            rotate([0,180,0]){
                retainerSection();
            }
        }
    }
}

module name() {
    x_offset = (exterior_width/2) - (3.3 * len(name));
    translate([x_offset,holder_depth + front_thickness + name_thickness,name_bottom_height]){
        rotate([90,0,0]){
            linear_extrude(height=name_thickness) {
                text(name);
            }
        }
    }
}

module mountingThingy(){
    rotate([-90,0,0]){
        union() {
            cylinder(r=indentation_radius,h=indentation_depth,$fn=15);
            cylinder(r=hole_radius,h=(back_thickness+(2 *fudge)),$fn=15);
        }
    }
}

module mountingThingies(){
    union() {
        translate([indentation_radius + mount_point_from_side,holder_depth+front_thickness-fudge,-indentation_radius + (exterior_height - mount_point_from_top)]){
            mountingThingy();
        }
        translate([-indentation_radius + (holder_width - mount_point_from_side),holder_depth+front_thickness-fudge,-indentation_radius + (exterior_height - mount_point_from_top)]){
            mountingThingy();
        }
    }
}


union() {
    difference(){
       corePiece();
       name();
       mountingThingies();
    }
    retainer();
}