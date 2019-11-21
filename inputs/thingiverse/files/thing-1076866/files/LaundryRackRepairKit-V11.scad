//
// LAUNDRY RACK REPAIR KIT, V1.1
// FMMT666(ASkr) 10/2015
//

//
// Fix a wire - save a rack.
//
//


//
// - All units in [mm].
//
// - Intentionally no "Thingiverse Customizer" variable descriptions in here.
//   These would only clutter the source...
//
// - Usually (TM), you only need to modify the two parameters
//     * lrDiaFrame, the diameter of the outer frame, to where the "wires" are
//                   attached to and
//     * lrDiaWire,  the diameter of the wires.
//
// - Fairly big wire diameters might lead to a hole in the frame clamp's back.
//   In that case, you can either increase 'wcDia' or reduce 'wcOffsetY'.
//   The latter will determine the depth of the hole for the wire in the
//   frame clamp. Use MODE 3 to watch that effect.
//
// - The rest shouldn't be that hard to understand.
//   Good luck :-)



// ===============================================================================
// laundry rack parameters (used to cut the holes)
//
lrDiaFrame =            14.7;  // diameter of the rack's frame, add ~0.5mm
lrDiaWire =              3.3;  // diameter of the wires, add ~0.7mm

/* [HIDDEN] */

// ===============================================================================
// wire clamp parameters
//
clFrameLen =            13.0;  // length of the tube around the frame
clFrameAsymmetric =        1;  // 0/1; if 1 (def.) the frame clamp will be asymmetric
clCutoutRest =           1.0;  // cutout bottom, but with a slightly smaller diameter
clCutoutAngle =         15.0;  // angle of the cutout
clCutoutChamferOffsZ =   2.0;  // chamfered cutout edges; set by trial and error ;-)
wcLen =                 40.0;  // length of the tube around the wire
wcDia =                  7.8;  // thickness of the wire tube
wcBlockHeight =         10.0;  // height of the block with the nuts
wcOffsetY =    -lrDiaFrame/3;  // y offset of the wire (cut the hole a little deeper)
wcOffsetZshape =         3.0;  // optical tuning to match the shape of the "cantilever"

// ===============================================================================
// nut/screw parameters
//
nutDia =                 6.0;  // nut diameter, wrench size
nutSlotHeight =          3.2;  // height of the nut's slot 
nutPosListY =      [ 20,35 ];  // y positions of where to place nuts
scrDia =                 3.8;  // diameter of screw
scrDiaHead =             6.0;  // diameter of screw head
scrOffsZ =               3.0;  // additional space between screw head and nut

//
// CHOOSE MODE HERE
//
//   0 = PART IN PRINTING POSITION
//   1 = PART
//   2 = PART WITH FRAME AND WIRE
//   3 = EDIT
//   4 = EDIT, NUT SLOT
//
MODE = 0;





// ===============================================================================
// ===============================================================================
// ===============================================================================
// NO CHANGES BELOW HERE (HOPEFULLY =)
CP = 150;                               // "CYLINDER PRECISION" ($fn parameter)
ZPOSWIRE = lrDiaFrame/2 + lrDiaWire/2;  // z position of the wire
LGREEN = [0.8,1,0.7];
// Reminder:
// Minimum diameter of wcDia, for no holes on the opposing side of the nut slots:
//   wcDiaMin = 2 * ( layerHeight + 3.47mm ) | for a std. 3mm nut (6mm)
// universal:
//   wcDiaMin = 2 * ( n*layerHeight + 1.155 * ( nutDia / 2 ) )

// ===============================================================================


if( MODE == 0 )
{
  if( clFrameAsymmetric == 1 )
  {
    rotate([0,-90,0])
    translate([wcDia/2,0,0])
    MakePart();
  }
  else
  {
    // emergency printing position (requires support structures)
    rotate([0,-90,0])
    translate([clFrameLen/2,0,0])
    MakePart();
  }
}
else if( MODE == 1 )
{
  MakePart();
}
else if( MODE == 2 )
{
  MakePart();
  FrameAndWire();
}
else if( MODE == 3 )
{
  ChamferCutout();
  Cutout();
  FrameAndWire();
  CutSlotsAndHoles();
  color( LGREEN, 0.5 )  
  CompleteClampRaw();
}
else if( MODE == 4 )
{
  NutSlot( nutDia, nutSlotHeight, 20 );
}


// ===============================================================================
// ===
module MakePart()
{
  difference()
  {
    // the raw clamp
    color( LGREEN, 1.0 )  
    CompleteClampRaw();
    
    // cut the frame and wire holes
    FrameAndWire();
    // cut the slots and vertical holes
    CutSlotsAndHoles();
    
    // cut the cutout and chamfer it
    Cutout();
    ChamferCutout();
  }
}


// ===============================================================================
// ===
module ChamferCutout()
{
  // chamfer the cutout edges
  rotate( [clCutoutAngle, 0, 0] )
  translate( [ 0, 0, -1.5 * ZPOSWIRE + clCutoutChamferOffsZ ] )
  rotate( [ 45,0,0 ] )
  cube([ 2*clFrameLen + 2, lrDiaFrame - clCutoutRest, lrDiaFrame - clCutoutRest ],
    center = true);
}


// ===============================================================================
// ===
module Cutout()
{
  // cutout
  rotate( [clCutoutAngle, 0, 0] )
  translate( [ 0, 0, -1.5 * ZPOSWIRE ] )
  cube([ 2*clFrameLen, lrDiaFrame - clCutoutRest, 3*ZPOSWIRE ], center = true);
}


// ===============================================================================
// ===
module FrameAndWire()
{
  // the rack and wire
  color([0.2,0.2,0.2])
  LaundryRack();
}


// ===============================================================================
// ===
module CutSlotsAndHoles()
{
  // nut slots and holes
  for( y = nutPosListY )
  {
    // the slots, incl. the screw head holes (bottom)
    translate( [ 0, y, -nutSlotHeight + ZPOSWIRE - wcDia/2 ] )
    NutSlot( nutDia, nutSlotHeight, 20 );
    
    // the holes for the screw (top)
    translate( [ 0, y, -2*ZPOSWIRE ] )
    cylinder( r = scrDia/2, h = 3*ZPOSWIRE, $fn = CP );
  }
}


// ===============================================================================
// ===
module CompleteClampRaw()
{
  union()
  {
    // the big tube for the frame
    //color( LGREEN, 0.5 )
    FrameTube();

    // the "cantilever" clamp for the wire
    //color( LGREEN, 0.5 )
    WireClampNew();
  }
}



// ===============================================================================
// ===
module WireClampNew()
{
  hull()
  {
    // far y, top
    translate( [0, wcLen, ZPOSWIRE] )
    sphere( r = wcDia/2, $fn = CP );
    // far y, bot
    translate( [0, wcLen, ZPOSWIRE - wcBlockHeight] )
    sphere( r = wcDia/2, $fn = CP );
    // center, top
    translate( [0, 0, ZPOSWIRE] )
    sphere( r = wcDia/2, $fn = CP );
    // center, bot
    translate( [0, 0, -ZPOSWIRE + wcOffsetZshape ] )
    sphere( r = wcDia/2, $fn = CP );
  }//END hull
}


// ===============================================================================
// ===
module WireClamp()
{

  // qubic part on bottom
  translate( [ -wcDia/2, 0, ZPOSWIRE - wcBlockHeight ] )
  cube( [wcDia, wcLen, wcBlockHeight ] );
  // round part on top
  translate( [0, 0, ZPOSWIRE ] )
  rotate( [-90, 0, 0] )
  cylinder( r = wcDia/2, h = wcLen, $fn = CP );
}


// ===============================================================================
// ===
module FrameTube()
{
  if( clFrameAsymmetric == 1 )
  {
    translate([ clFrameLen/2 - wcDia/2, 0, 0 ])
    rotate( [0, 90, 0] )
    cylinder( r = ZPOSWIRE + wcDia/2, h = clFrameLen, center = true, $fn = CP );
  }
  else
  {
    rotate( [0, 90, 0] )
    cylinder( r = ZPOSWIRE + wcDia/2, h = clFrameLen, center = true, $fn = CP );
  }
    
}

// ===============================================================================
// ===
module FrameTubeHole()
{
  rotate( [0, 90, 0] )
  cylinder( r = lrDiaFrame/2, h = clFrameLen + 2, center = true, $fn = CP );
}


// ===============================================================================
// ===
module NutSlot( wrenchSize, height, length )
{
  // Saves a little space, because it enteres the material
  // with a flat side.

  union()
  {
    // sink hole for the screw's head
    translate([0,0,-4*ZPOSWIRE - scrOffsZ])
    cylinder( r = scrDiaHead/2, h = 4*ZPOSWIRE+0.1, $fn = CP );
    
    hull()
    {
      translate([ length, 0, 0])
      rotate([0,0,0])
      NutCut( wrenchSize, height );

      rotate([0,0,0])
      NutCut( wrenchSize, height );
    }//END hull
  }//END union
}


// ===============================================================================
// ===
module NutCut( wrenchSize, height )
{
  cylinder( r = 0.5 * wrenchSize * 1.155, h = height, $fn = 6 );
}





// ===============================================================================
// ===
module LaundryRack()
{
  // wire
  translate( [0, wcOffsetY, lrDiaFrame/2 + lrDiaWire/2 ] )
  rotate( [-90, 0, 0] )
  cylinder( r = lrDiaWire/2, h = 100, $fn = CP );
  
  // frame
  rotate( [0, 90, 0] )
  cylinder( r = lrDiaFrame/2, h = 100, center = true, $fn = CP );
}






