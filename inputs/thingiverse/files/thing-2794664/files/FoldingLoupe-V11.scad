//
// FOLDING LOUPE, V1.0
// FMMT666(ASkr) 12/2015
//

//
// The travelling lensed human.
//
//


//
// - All units in [mm].
//


// ===============================================================================
// lens fitting parameters
//
lhLensType =               2;  // 1 = biconvex, 2 = plano-convex (EXPERIMENTAL)
lhLensDia =             38;//36.3;  // diameter of lens + little extra space (*2*)
lhLensThickMin =         5.8;  // the Z thickness of the lens, minimum
lhLensThickMax =         8.8;  // the Z thickness of the lens, maximum
lhFrameThickness =       0.8;  // the XY thickness of the frame around the lens (*1*)

lhFrameLensSlotType =      2;  // cut the slot with: 1 = fake lens, 2 = cylinder
lhFrameLensSlotDepth =   0.8;  // depth of the slot that holds the lens (*1*)
lhFrameLensSlotThick =   2.8;  // Z thickness of the lens, outer; measured at "lhFrameLensDepth"

lhFrameLensOffsetZ=        0;  // shift lens up/down
lhFrameHeightExtra =     1.2;  // make the frame a little higher than the lense (scratch free)

lhFramePivotDia =       10.0;  // diameter of the pivot point
lhFramePivotDistExtra = -3.0;  // distance of pivot; def is "lhLensDia", add/sub xtra value
lhFramePivotHoleDia =    7.0;  // diameter of the pivot's hole

lhFrameHandleDia =       3.0;  // diameter of the handle; 0 for none
lhFrameHandleFlat =      0.4;  // flatten the top/bottom of the handle
lhFrameHandleAngle =   -30.0;  // fine tune the angle of the handle

// ===============================================================================
// lens clamp parameters
//
lcThickness =            0.8;  // thickness of the lens clamp (*1*)
lcExtraThickness =      -0.1;  // make the clamp ring a little larger (>0) or smaller (<0)
lcExtraHeight =         -0.4;  // make the clamp ring a little higher (>0) or shorter (<0)

// ===============================================================================
// cover parameters (all)
//
cpThickness =            0.8;  // thickness of top/bottom
cpSpacing =              0.2;  // spacing between the fitting and cover
cpFrameThickness =       1.2;  // SLIDE COVER: thickness of the frame
cpFrameSpacing =         0.2;  // SLIDE COVER: more lateral space for fitting inside cover
cpFrameOverhang =        0.6;  // SLIDE COVER: create an overhang to form a latch


// (*1*) ideally a multiple of nozzle diameter
// (*2*) suggesting ca. 1/2 of nozzle size


// ===============================================================================
// CHOOSE MODE HERE
//
//   0 = EDIT LENS ONLY
//   1 = EDIT FITTING
//   2 = EDIT FITTING WITH CLAMP
//   3 = EDIT CLAMP
//   4 = EDIT SIMPLE COVER (AND FITTING)
//   5 = EDIT SLIDE COVER
//
//   9 = PRESENTATION MODE
//
//  10 = PRINT FITTING
//  11 = PRINT CLAMP
//  12 = PRINT SIMPLE COVER
//  13 = PRINT SLIDE COVER
//
MODE = 9;



// ===============================================================================
// ===============================================================================
// ===============================================================================
// NO CHANGES BELOW HERE (HOPEFULLY =)
CP = 150;

// ===============================================================================




if( MODE == 0 )
{
  FakeLens( lhLensType );
}
else if( MODE == 1 )
{
  LensFitting( lhFrameLensSlotType );
}
else if( MODE == 2 )
{
  LensFitting( lhFrameLensSlotType );
  LensClamp();
}
else if( MODE == 3 )
{
  LensClamp();
}
else if( MODE == 4 )
{
  SimpleCover();
}
else if( MODE == 5 )
{
  %LensFitting( lhFrameLensSlotType );
  SlideCover();
}
else if( MODE == 9 )
{
  distPivot = lhLensDia + lhFramePivotDistExtra;

  translate([ distPivot, 0, 0])
  rotate([0,0,110])
  translate([ -distPivot, 0, 0])
  union()
  {
    LensFitting( lhFrameLensSlotType );
    LensClamp();
	FakeLens( lhLensType );
  }
  
  SlideCover();
}
else if( MODE == 10 )
{
  translate([ 0, 0, (lhLensThickMax + lhFrameHeightExtra)/2 ])
  LensFitting( lhFrameLensSlotType );
}
else if( MODE == 11 )
{
  rotate([ 180, 0, 0 ])
  translate([ 0, 0, - (lhLensThickMax + lhFrameHeightExtra)/2 - lcExtraHeight ])
  LensClamp();
}
else if( MODE == 12 )
{
  translate([ 0, 0, cpThickness/2 ])
  difference()
  {
    LensFittingBody( cpThickness );
    PivotPinHole();
  }
}
else if( MODE == 13 )
{
  r1 = lhLensDia/2 + lhFrameThickness + cpFrameSpacing + cpFrameThickness;
  r2 = lhFramePivotDia/2 + cpFrameThickness + cpFrameSpacing;
  di = lhLensDia + lhFramePivotDistExtra;
  
  alpha = asin( (r1-r2)/di );
  
  rotate([ -90, 0, 0 ])
  translate([ 0, -r1, 0 ])
  rotate([ 0, 0, alpha ])
  SlideCover();
}



// ===============================================================================
// ===
module SlideCover( )
{
  xPivot = lhLensDia + lhFramePivotDistExtra;
  hCoverHeight = lhLensThickMax + lhFrameHeightExtra + 2*cpThickness + 2*cpSpacing;
  hInCutHeight = lhLensThickMax + lhFrameHeightExtra + 2*cpSpacing;

  difference()
  {
    // the cover
	CoverHull( cpFrameThickness + cpFrameSpacing, hCoverHeight );
    // cut inside (lens fitting)
    CoverHull( cpFrameSpacing, hInCutHeight );
    // make the front open
    translate([ 1.5*lhLensDia + lhFramePivotDia/2 + lhFrameThickness
                  - lhFrameThickness - cpFrameSpacing + cpFrameOverhang,
                -lhLensDia - lhFrameThickness,
                0])
    cube([ 4*lhLensDia + lhFramePivotDia + 2*lhFrameThickness,
            2*lhLensDia + 2*lhFrameThickness,
            lhLensThickMax + lhFrameHeightExtra + 2*cpSpacing], center = true);
    // hole for the pin
    PivotPinHole();
    // allow opening up to 180°
    translate([ xPivot, 0, 0])
    rotate([0,0,180])
    translate([ -xPivot, 0, 0])
    CoverHull( cpFrameSpacing, hInCutHeight );
    
  }
}



// ===============================================================================
// ===
module CoverHull( offsetXY, sizeZ)
{

  translate([ 0, 0, -sizeZ/2 ])
  linear_extrude( sizeZ )
  offset( r = offsetXY )
  projection( cut = true )
  LensFittingBody( cpThickness );  

}

// ===============================================================================
// ===
module SimpleCover( )
{
  LensFitting( lhFrameLensSlotType );

  translate([ 0, 0, - (lhLensThickMax + lhFrameHeightExtra + cpThickness )/2 - cpSpacing  ])
  difference()
  {
    LensFittingBody( cpThickness );
    PivotPinHole();
  }
  
  %translate([ 0, 0, (lhLensThickMax + lhFrameHeightExtra + cpThickness )/2 + cpSpacing  ])
  difference()
  {
    LensFittingBody( cpThickness );
    PivotPinHole();
  }
}



// ===============================================================================
// ===
module LensClamp( )
{
  color([0,0,1])
  resize([ lhLensDia + lcExtraThickness, lhLensDia + lcExtraThickness, 0 ])
  LensClampRaw();
}


// ===============================================================================
// ===
module LensClampRaw( )
{
  difference()
  {
    // the clamp as a disk
    cylinder( d = lhLensDia, h = (lhLensThickMax + lhFrameHeightExtra)/2 + lcExtraHeight,
              $fn = CP );
    // cut a hole hole in the middle
    translate([0,0,-1])
    cylinder( d = lhLensDia - 2*lhFrameLensSlotDepth,
              h = (lhLensThickMax + lhFrameHeightExtra)/2 +2 + lcExtraHeight, $fn = CP );
    // cut the botton to match the lens
    CutSlot( lhFrameLensSlotType );
  }
}

// ===============================================================================
// ===
module LensFitting( type )
{
  if( lhFrameHandleDia > 0.0 )
  {
    union()
    {
      Handle();
      LensFittingClean( type );
    }
  }
  else
    LensFittingClean( type );
}


// ===============================================================================
// ===
module LensFittingClean( type )
{
    difference()
    {
      LensFittingRaw();
      CutSlotAboveTop( type );
    }
}


// ===============================================================================
// ===
module Handle( type )
{
  hLift = ( lhLensThickMax + lhFrameHeightExtra ) / 2;
  hMove = -( lhLensDia + lhFrameHandleDia ) / 2;
  
  rotate([ 0, 0, lhFrameHandleAngle])
  hull()
  {
    translate([ 0, hMove, hLift ])
    CutSphere( lhFrameHandleDia, lhFrameHandleFlat );

    translate([ 0, hMove, -hLift ])
    rotate([180,0,0])
    CutSphere( lhFrameHandleDia, lhFrameHandleFlat );
  }
}


// ===============================================================================
// ===
module CutSphere( dia, flat )
{
  difference()
  {
    translate([ 0, 0, -dia/2 + flat ])
    sphere( d = dia, $fn = CP/3 );

    translate([ 0, 0, dia/2 + 1 ])
    cube( dia + 2, center = true );
  }
 
}



// ===============================================================================
// ===
module CutSlotAboveTop( type )
{
  color([0,1,0])
  hull()
  {
    translate([ 0, 0, 2*lhLensThickMax + 2*lhFrameHeightExtra ])
    CutSlot( 2 );
    CutSlot( type );
  }
}


// ===============================================================================
// ===
module CutSlot( type )
{
  if( type == 1 )
  {
    // cut with fake lens
    color([0,1,0])
    FakeLens( lhLensType );
  }
  else
  {
    // cut with cylinder
    if( lhLensType == 1 )
    {
      // bivonvex lenses have the cylindrical slot in the (Z) middle
      color([0,1,0])
      cylinder( d = lhLensDia, h = lhFrameLensSlotThick, center = true, $fn = CP );
    }
    else
    {
      // plano-convex lenses need the slot further up
      color([0,1,0])
      translate([ 0, 0, -lhLensThickMax/2 + lhFrameLensOffsetZ + lhFrameHeightExtra/2])
      cylinder( d = lhLensDia, h = lhFrameLensSlotThick, center = false, $fn = CP );
    }
      
  }// END "cut with cylinder"
  
}



// ===============================================================================
// ===
module LensFittingRaw()
{
  difference()
  {
    LensFittingBody( lhLensThickMax + lhFrameHeightExtra );
    // cut a hole in the middle
    cylinder( d = lhLensDia - 2*lhFrameLensSlotDepth,
              h = lhLensThickMax + lhFrameHeightExtra + 1, center = true, $fn = CP);
    // cut a hole for the pivot
    PivotPinHole();
  }// END difference
}



// ===============================================================================
// ===
module PivotPinHole()
{
  translate([ lhLensDia + lhFramePivotDistExtra, 0, 0 ])
  cylinder( d = lhFramePivotHoleDia,
            h = 2*lhLensThickMax + 2*lhFrameHeightExtra + 2*cpThickness + 2*cpSpacing + 2,
            center=true, $fn=CP );
}



// ===============================================================================
// ===
module LensFittingBody( height )
{
  hull()
  {
    cylinder( d = lhLensDia + 2*lhFrameThickness, h = height, center = true, $fn = CP );
      
    translate([ lhLensDia + lhFramePivotDistExtra, 0, 0] )
    cylinder( d = lhFramePivotDia, h = height, center = true, $fn = CP );

  }
}



// ===============================================================================
// === old version
/*module FakeLens( type )
{
  if( type == 1 )
  {
    translate([ 0, 0, lhFrameLensOffsetZ ])
    color([1,1,1], alpha = 0.3)
    resize([ 0, 0, lhLensThickMax ])
    sphere( d = lhLensDia, $fn=CP);
  }
  else if( type == 2 )
  {
    translate([ 0, 0, lhLensThickMax/2 + lhFrameLensOffsetZ ])
    color([1,1,1], alpha = 0.3)
    difference()
    {
      resize([ 0, 0, 2*lhLensThickMax ])
      sphere( d = lhLensDia, $fn=CP);
      
      translate([ 0, 0, lhLensDia/2 + 1 ])
      cube( lhLensDia + 2, center = true );
    }
  }
  
}*/

module FakeLens( type )
{
  color([0,0.8,1], alpha = 0.5)	
  if( type == 1 ) //biconvex
  {
	b = (lhLensThickMax - lhLensThickMin)/2;
	curveRadius = (pow(lhLensDia/2,2)+b*b)/(2*b);
    translate([ 0, 0, lhFrameLensOffsetZ ])
	intersection(){
		translate([0,0,-curveRadius+lhLensThickMax/2]) sphere( r = curveRadius, $fn=CP);
		translate([0,0, curveRadius-lhLensThickMax/2]) sphere( r = curveRadius, $fn=CP);
		translate([0,0,-lhLensThickMax/2]) cylinder(r = lhLensDia/2, h=lhLensThickMax , $fn=CP);
	}
  }
  else if( type == 2 )//plano-convex
  {
	b = (lhLensThickMax - lhLensThickMin);
	curveRadius = (pow(lhLensDia/2,2)+b*b)/(2*b);
    color([1,1,1], alpha = 0.3)
    translate([ 0, 0, lhFrameLensOffsetZ ])
	intersection(){
		translate([0,0,-curveRadius+lhLensThickMax/2]) sphere( r = curveRadius, $fn=CP);
		translate([0,0,-lhLensThickMax/2]) cylinder(r = lhLensDia/2, h=lhLensThickMax , $fn=CP);
	}
  }
  
}


