//
// Parametric Label Holder for Drawers and Cupboards
//
// The label holder can be configured for different paper label
// sizes. It can be made as a glue-on holder using the whole of
// its back or only a part of it for attaching a double-sided
// adhesive tape, or it can be made as a screw-on holder, either
// using flat-headed screws or conical-headed screws (eg. SPAX).
//
// Remarks:
//
// Example parameters for Leitz 1900/1901 labels:
//  - LabelWidth     = 62;
//  - LabelHeight    = 22;
//  - LabelThickness = 0.5;
//
// Choose the label thickness so that the label sits firmly but
// the printer can manage to keep front and back apart.
//
// Choose the wall thickness so that it is a multiple of your
// printer's nozzle width (most printers use 0.4mm nozzles).
//
// When using screw mounts, choose a wall-thickness that adds
// to the stability (especially when using a power screwdriver
// to mount the label holders).
//
// Print upright with ground supports.
// Print with supports when printing a screw-on holder.
//
// TODO:
//   - Option to have a top frame (requires print with supports)
//     Might add a nice look to the whole thing
//   - Bug fixes (yes, there still may be some of those critters)
//   - Option for "clip-on" label holders (eg. heavy-duty racks)
//   - Round front edges on all designs for smoother look
//   - Smoothen egdes on label window
//   - Optional: Make label window a trapezoid
//

LabelWidth     = 62;        // Width of paper label
LabelHeight    = 22;        // Height of paper label
LabelThickness = 0.5;       // Thickness of paper label
WallThickness  = 1.2;       // Thickness of label holder walls

UseScrews      = false;     // Are we using screws to mount it ?

ScrewDiameter  = 4.0;       // Which type of screws are we using ?
FlatheadScrew  = true;
HeadDiameter   = 6.0;
HeadHeight     = 2.0;       // for conical screw heads

// For thicker double-sided tape and/or tape that cannot cover the
// total height of the label holder, it might be nice to cut out a
// small rail in the back for the tape...
TapeWidth      = 25.0;      // Width of double-sided tape
TapeThickness  = 0.0;       // Thickness of double-sided tape

// The following are optional configurational parameters.
// You will probably not have to change those.
FrameBorder    = 3.0;       // Width of window frame
Padding        = 0.2;       // Extra padding for paper label

// Private Data
// Don't change anything below here except you're me!
OuterBoxWidth     = WallThickness * 2.0 + Padding * 2.0 + LabelWidth;
OuterBoxHeight    = WallThickness + Padding + LabelHeight;
OuterBoxThickness = WallThickness * 2.0 + Padding * 2.0 + LabelThickness;

// for smooth geometry...
$fs = 0.1;
$fa = 5;


module screw_head() {       // seating for a screw (if any)
    if( FlatheadScrew ) {
        translate( [ 0, 0, -(OuterBoxThickness / 2.0) ] )
            cylinder( WallThickness, 
                      d = HeadDiameter, 
                      center = true );
    } else {
        translate( [ 0, 0, -(OuterBoxThickness - HeadHeight) ] )
            cylinder( HeadHeight,
                      d1 = HeadDiameter, 
                      d2 = ScrewDiameter,
                      center = true );
    }
}


module screw_hole() {       // channel for a screw to fit through (if any)
    translate( [ OuterBoxHeight / 4.0, 0, 0 ] )
        union () {
            cylinder( OuterBoxThickness, 
                      d = ScrewDiameter, 
                      center = true );
            screw_head();
        }
}


module screw_mount() {      // half-cylinder with hole for screw-on
    rotate( [ 90, 0, 0 ] )  // mounting (if any)
        difference() {                      // There's no need to cut off
            cylinder( OuterBoxThickness,    // half of the cylinder since
                      d = OuterBoxHeight,   // the extra will be removed
                      center = true );      // by the label and window
            screw_hole();                   // boxes...
        }
}


module screw_mounts() {     // place screw mount plates on both sides
    if( UseScrews ) {       // (if any screws used)
        SideOffset = LabelWidth / 2.0 + WallThickness + Padding;
        translate( [ SideOffset, 0, 0 ] )
            screw_mount();
        translate( [ -SideOffset, 0, 0 ] )
            rotate( [ 0, 180, 0 ] )
                screw_mount();
    }
}


module label_box() {        // space where the paper label slides in
    //
    // TODO:
    //   - Check formulas for bugs as this looks a bit as if there
    //     may be some (translate)...
    //
    translate( [ 0, 
                 0, 
                 WallThickness ] )
        cube( [ Padding * 2.0 + LabelWidth,
                Padding * 2.0 + LabelThickness,
                Padding + LabelHeight ], center = true );
}


module label_window() {     // front bezel - what is visible of the
    //                      // paper label
    // TODO:
    //   - Add option for having a top frame
    //   - Check formulas for bugs as this looks a bit as if there
    //     may be some (tanslate, cube)...
    //
    translate( [ 0, 
                 WallThickness / 2.0 + Padding + LabelThickness / 2.0, 
                 WallThickness + FrameBorder / 2 ] )
        cube( [ LabelWidth - FrameBorder * 2.0,
                WallThickness + Padding,
                LabelHeight - FrameBorder ], center = true );
}


module tape_rail() {        // when using glue-on method, this is where
    if( !UseScrews &&       // the double-sided adhesive tape is placed
        (TapeThickness > 0) &&
        (TapeWidth > 0) && (TapeWidth < OuterBoxHeight) ) {
        BackOffset = (WallThickness + Padding + LabelThickness / 2.0) - (TapeThickness / 2.0);
        translate( [ 0, -BackOffset, 0 ] )
            cube( [ OuterBoxWidth,
                    TapeThickness,
                    TapeWidth ], center = true );
    }
}


difference() {              // main body
    union() {
        // outer box
        cube( [ OuterBoxWidth,
                OuterBoxThickness,
                OuterBoxHeight ], center = true );
        screw_mounts();
    }
    union() {
        label_box();
        label_window();
        tape_rail();
    }
}
