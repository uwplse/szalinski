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
// Kudos to:
//   - mbrembati for his idea to turn it into a handle and his improvements to
//     the customizer interface.
//
//
// $Id: Parametric_Labelholder.scad,v 1.6 2019/10/21 09:13:34 tneuer Exp tneuer $
//
// $Log: Parametric_Labelholder.scad,v $
// Revision 1.6  2019/10/21 09:13:34  tneuer
// Added assertion for parameters.
//
// Revision 1.5  2019/10/16 15:59:36  tneuer
// Bugfix: Conical screws where misaligned when rendering the stand-off
// handle variant.
//
// Revision 1.4  2019/10/16 15:34:27  tneuer
// Changed design of grip to make it look more appealing and perhaps
// also a bit stronger.
//
// Revision 1.3  2019/10/15 15:59:08  tneuer
// Merged code from mbrembati (Improvements to the customizer interface plus
// stand-off handle type), bug-fixes and code cleanup.
//
// Revision 1.2  2019/10/15 11:07:35  tneuer
// Added optional handle. The handle is only available for the screw-on
// variant of the label holder as the glue-on variant might not hold as
// good on the labelled compartment.
//
// Revision 1.1  2019/10/15 11:01:15  tneuer
// Initial revision
//
//

/* [ Main Dimensions ] */
// Width of paper label (mm)
LabelWidth     = 62;
// Height of paper label (mm)
LabelHeight    = 22;
// Thickness of paper label (mm)
LabelThickness = 0.5;
// Thickness of label holder walls (mm)
WallThickness  = 1.2;
// Are we using screws to mount it ?
UseScrews      = 0; // [0:false, 1:true]

/* [ Screw-On Variant ] */
// Diameter of screw used (mm)
ScrewDiameter  = 4.0;
// Are you using a flat headed screw (true) or conical (false) ?
FlatheadScrew  = 0; // [0:false, 1:true]
// Diameter of screw head (mm)
HeadDiameter   = 6.0;
// Head height for conical screw heads (mm)
HeadHeight     = 2.0;
// Type of handle
HandleType     = 2;  // [0:none, 1:grip, 2:stand-off]
// Stand-off for using as handle (type=2) (mm)
SpacerHeight   = 15; // [0:50]

/* [ Glue-On Variant ] */
// For thicker double-sided tape and/or tape that cannot cover the
// total height of the label holder, it might be nice to cut out a
// small rail in the back for the tape...
// Width of double-sided tape (mm)
TapeWidth      = 25.0;
// Thickness of double-sided tape (mm)
TapeThickness  = 0.0;

/* [ Optional Parameters ] */
// The following are optional configurational parameters.
// You will probably not have to change those.
// Width of window frame (mm)
FrameBorder    = 3.0;
// Extra padding for paper label (mm)
Padding        = 0.2;


// Private Data
// Don't change anything below here except you're me!

/* [Hidden] */
// for smooth geometry...
$fs = 0.1;
$fa = 5;

function OuterBoxWidth() = WallThickness * 2.0 + Padding * 2.0 + LabelWidth;
function OuterBoxHeight() = WallThickness + Padding + LabelHeight;
function OuterBoxThickness() = WallThickness * 2.0 + Padding * 2.0 + LabelThickness;
function GripOffset() = OuterBoxHeight()-(LabelHeight/2-(FrameBorder+WallThickness));
function StandOff() = HandleType == 2 ? SpacerHeight : 0;


module screw_head() {       // seating for a screw (if any)
    if( FlatheadScrew ) {
        translate( [ 0, 0, -(OuterBoxThickness()/2.0 + StandOff()/2.0 - WallThickness/2.0) ] )
            cylinder( WallThickness, 
                      d = HeadDiameter, 
                      center = true );
    } else {
        translate( [ 0, 0, -(OuterBoxThickness()/2.0 + StandOff()/2.0 - HeadHeight/2.0) ] )
            cylinder( HeadHeight,
                      d1 = HeadDiameter, 
                      d2 = ScrewDiameter,
                      center = true );
    }
}


module screw_hole() {       // channel for a screw to fit through (if any)
    translate( [ OuterBoxHeight() / 4.0, 0, StandOff() / 2 ] )
        union () {
            cylinder( OuterBoxThickness()+StandOff(), 
                      d = ScrewDiameter, 
                      center = true );
            screw_head();
        }
}


module screw_mount() {      // half-cylinder with hole for screw-on
    rotate( [ 90, 0, 0 ] )  // mounting (if any)
        difference() {
            translate( [ 0, 0, StandOff() / 2 ] )
                cylinder( OuterBoxThickness() + StandOff(),
                        d = OuterBoxHeight(),
                        center = true );
            if( HandleType == 2 ) {
                translate( [-OuterBoxHeight() / 2, 0, StandOff() / 2 ] )
                    cube( [ OuterBoxHeight(), 
                            OuterBoxHeight(),
                            OuterBoxThickness() + StandOff() ], center = true );
            }
            screw_hole();
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


module grip() {
    if( HandleType == 1 &&  // Would we like to have a handle as well ?
        UseScrews  ) {      // Only with screw-on for strength
        translate( [ 0, 0, -GripOffset() ] )
            rotate( [ 0, 90, 0 ] )
                difference() {
                    union() {
                        translate( [ 0, 0, OuterBoxWidth() / 2 - 10 ] )
                            sphere( d = 20 );
                        cylinder( h = OuterBoxWidth() - 20, d = 20, center = true );
                        translate( [ 0, 0, -(OuterBoxWidth() / 2 - 10) ] )
                            sphere( d = 20 );
                    }
                    union() {
                        translate( [ 0, 0, OuterBoxWidth() / 2 - 10 ] )
                            sphere( d = 20 - WallThickness*2 );
                        cylinder( h = LabelWidth-20, d = 20-WallThickness*2, center = true );
                        translate( [ 0, 0, -(OuterBoxWidth() / 2 - 10) ] )
                            sphere( d = 20 - WallThickness*2 );
                        translate( [ 5, 0, 0 ] )
                            cube( [ 10, 20, OuterBoxWidth() ], center = true );
                        translate( [ -5, -(5 + OuterBoxThickness() / 2) , 0 ] )
                            cube( [ 10, 10, OuterBoxWidth() ], center = true );
                    }
                }
    }
}


module label_box() {        // space where the paper label slides in
    translate( [ 0, 
                 0, 
                 WallThickness ] )
        cube( [ Padding * 2.0 + LabelWidth,
                Padding * 2.0 + LabelThickness,
                Padding + LabelHeight ], center = true );
}


module label_window() {     // front bezel - what is visible of the
    translate( [ 0,         // paper label
                 WallThickness / 2.0 + Padding + LabelThickness / 2.0, 
                 WallThickness + FrameBorder / 2 ] )
        cube( [ LabelWidth - FrameBorder * 2.0,
                WallThickness + Padding,
                LabelHeight - FrameBorder ], center = true );
}


module tape_rail() {        // when using glue-on method, this is where
    if( !UseScrews &&       // the double-sided adhesive tape is placed
        (TapeThickness > 0) &&
        (TapeWidth > 0) && (TapeWidth < OuterBoxHeight()) ) {
        BackOffset = (WallThickness + Padding + LabelThickness / 2.0) - (TapeThickness / 2.0);
        translate( [ 0, -BackOffset, 0 ] )
            cube( [ OuterBoxWidth(),
                    TapeThickness,
                    TapeWidth ], center = true );
    }
}


if( UseScrews ) {
    assert( ScrewDiameter > 0.5,
            "ScrewDiameter too small for UseScrews." );
    assert( OuterBoxHeight() / 2.0 > HeadDiameter,
            "HeadDiameter too large." );
    if( FlatheadScrew ) {
        assert( OuterBoxThickness() > HeadHeight,
                "HeadHeight too large." );
    }
}

difference() {              // main body
    union() {
        // outer box
        cube( [ OuterBoxWidth(),
                OuterBoxThickness(),
                OuterBoxHeight() ], center = true );
        screw_mounts();
        grip();
    }
    union() {
        label_box();
        label_window();
        tape_rail();
    }
}
