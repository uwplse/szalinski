//
// Bike Bottle Mount, V1.0
// 5/2013, FMMT666(ASkr)
//
//
// NOTES:
//
//  - The "preferred printing position" (enabled if "PUTINPRINTPOS = 1") requires
//    that "clampExtTop" equals "frameExtTop".
//    Otherwise you'll need to enable support structures in your printing app.
//    Also pay attention to the angle (and position) of the "triangular cutout"
//    parameters ("clampCut..." variables).
//    Use "SHOWCUTOUTS = 1" for a better view.
// 
//  - "SHOWCUTOUTS" set to 1 turns on visibility for some cutting objects.
//    Use this while tuning the parameters until everything makes sense, but
//    disable it for export.
//
//  - For a flat frame/wall/whatever mount, set "frameDia = 0".
//
//  - The bottle mount can be fixed with an arbitrary amount of screws or zip ties.
//    Screw parameters start with "screw", the zip tie variant can be tuned
//    with all the "zip" parameters.
//    The "zip tie tunnel" can be radial or linear.
//    Notice that the radial type only makes sense if "frameDia" is in the range
//    of "frameMountWidth". Use "SHOWCUTOUTS = 1" to see what's going on.
//    Turn on/off screws by setting "screwNumber".
//    The zip tie tunnels can be activated by setting "zipType" to either "1" (linear)
//    or "2" (radial). A "0" turns this featrue off.
//
//  - Pay attention to the difference between:
//      "frameMountDepth" - "screwHeadLen" - "frameNutHeight"
//    This is the amount of material left between the screw head (or washer)
//    and the frame of the bike. If the sum of "screwHeadLen" and "frameNutHeight" is
//    equal or exceeds "frameMountDepth", the only thing you'll get is a big hole.
//    I recommend at remaining thickness of at least 2mm. E.g.:
//
//      mount      height  of     height of     remaining
//                 screw head     frame nut     material
//       13mm   -     6mm      -    5mm      =     2mm
//
//  - The "frameRingCut" cuts away an additional amount of material.
//    Useful if any other clamp is in the way.
//    It is highly recommended to turn on "SHOWCUTOFFS" while modifying the ring's
//    parameters.
//    NOTE: The "frameRing" cutout is only useful if "frameDia" > 0.
//
//  - Don't panic...
//


SHOWCUTOUTS =          0;     // >>> SET TO 0 FOR EXPORT <<< show cutouts: 0/1
PUTINPRINTPOS =        0;     // enable preferred printing pos.

bottleDia =           64.0;   // diameter of the bottle

clampLen =           120.0;   // length of the bottle clamp
clampExtTop =          0.0;   // length extension (top)
clampExtBot =         10.0;   // length extension (bot)
clampThick =           3.0;   // thickness of material around bottle
clampSlot =           20.0;   // width of the clamp slot
clampBotDia =         40.0;   // diameter of the hole in the bottom
clampCutAngle =      -10.0;   // angle of the triangular cutout
clampCutOffZ =         5.0;   // z offset position of triangular cutout
clampCutOffX =         5.0;   // x offset position of triangular cutout

frameDia =            29.0;   // diameter of the frame
frameMountWidth =     24.0;   // width of the frame mount
frameMountDepth =     15.5;   // depth of the frame mount ( > screwHeadLen! )
frameExtTop =          0.0;   // length extension of frame mount (top)
frameNutDia =         11.0;   // diameter of the frame's nut
frameNutHeight =       6.0;   // height of the frame's nut

frameRingCutHeight =  35.0;   // frame ring cutout height
frameRingCutThick =    3.0;   // frame ring cutout thickness ( <0 for off )
frameRingCutOffZ =    30.0;   // frame ring cutout z position

screwNumber =          2;     // number of screws
screwDistance =       64.5;   // distance of the screws
screwLowerHeight =    17.0;   // z position of the lowest of the screw
screwDia =             6.0;   // diameter of the screw
screwHeadDia =        13.0;   // diameter of the screw's head or washer
screwHeadLen =         7.0;   // length of the screw head (sink length)

zipType =              0;     // 0 = off, 1 = linear, 2 = radial
zipNumber =            3;     // number of zip tie tunnels
zipDistance =         40.0;   // distance of zip tie tunnels
zipLowerHeight =      10.0;   // z position of the lowest of the zip tie tunnels
zipWidth =             4.0;   // width of the zip tie tunnel
zipHeight =            3.0;   // height of the zip tie tunnel
zipRadius = frameDia/2+frameMountDepth/2;   // radius of the zip tie tunnel
zipOffX =             -0.0;   // additional x offset of the tunnel

CYLPREC =            100;     // cylinder and sphere resolution ($fn param.)


//============================================================================
// NO CHANGES BELOW HERE (hopefully)






if( PUTINPRINTPOS )
{
  translate( [0,0,clampLen+clampExtTop] )
  rotate( [0,180,0] )
  BikeBottleMount();
}
else
  BikeBottleMount();



module BikeBottleMount()
{
difference()
{
  union()
  {
    difference()
    {
      union()
      {
        // ===== OUTER CYLINDER
        translate( [0,0,-clampExtBot] )
        cylinder(r=bottleDia/2+clampThick,h=clampLen+clampExtTop+clampExtBot,$fn=CYLPREC);

        // ===== FRAME MOUNT
        translate( [-bottleDia/2-frameMountDepth-frameDia/2,-frameMountWidth/2,0] )
        cube([frameMountDepth+frameDia/2+bottleDia/2,frameMountWidth,clampLen+frameExtTop] ); 

        // ===== BOTTOM SPHERE
        translate( [0,0,-clampExtBot] )
        sphere( r = bottleDia/2 + clampThick, $fn=CYLPREC );
      } // END union

      // ===== TRIANGULAR CUTOUT
      translate( [clampCutOffX,0,clampLen/2+clampCutOffZ] )
      rotate( [90,-clampCutAngle,0] )
      if( SHOWCUTOUTS )
        % TriCut( clampLen/3, bottleDia+2*clampThick+2, bottleDia, clampLen);
      else
        TriCut( clampLen/3, bottleDia+2*clampThick+2, bottleDia, clampLen);

      // ===== INNER CYLINDER CUTOUT
      translate( [0,0,-1-clampExtBot] )
      cylinder( r=bottleDia/2,h=clampLen+clampExtTop+clampExtBot+frameExtTop+2,$fn=CYLPREC);

      // ===== INNER SPHERE CUTOUT
      translate( [0,0,-clampExtBot] )
      sphere( r = bottleDia/2, $fn=CYLPREC );

      // ===== BOTTOM SPHERE HOLE CUTOUT
      translate( [0,0,-bottleDia-clampExtBot] )
      if( SHOWCUTOUTS )
        %cylinder( r = clampBotDia/2, h= bottleDia+clampExtBot,$fn=CYLPREC);
      else
        cylinder( r = clampBotDia/2, h= bottleDia+clampExtBot,$fn=CYLPREC);

    } // END difference

  } // END union

  // ===== CYLINDRICAL FRAME CUTOUT
  translate( [ -bottleDia / 2 - frameMountDepth - frameDia / 2, 0, -1 ] )
  cylinder( r = frameDia/2, h = clampLen + frameExtTop + 2, $fn=CYLPREC);

  // ===== CYLINDRICAL FRAME RING CUTOUT
  translate( [ -bottleDia / 2 - frameMountDepth - frameDia / 2, 0, frameRingCutOffZ ] )
  if( SHOWCUTOUTS )
  {
    %rotate_extrude( $fn = CYLPREC )
    {
      polygon( [ [ 0, 0],
               [ frameDia/2, 0],
               [ frameDia/2 + frameRingCutThick, frameRingCutThick ],
               [ frameDia/2 + frameRingCutThick, frameRingCutThick + frameRingCutHeight ],
               [ frameDia/2, 2*frameRingCutThick + frameRingCutHeight ],
               [ 0, 2*frameRingCutThick + frameRingCutHeight ] ] );
    }
  }
  else
  {
    rotate_extrude( $fn = CYLPREC )
    {
      polygon( [ [ 0, 0],
               [ frameDia/2, 0],
               [ frameDia/2 + frameRingCutThick, frameRingCutThick ],
               [ frameDia/2 + frameRingCutThick, frameRingCutThick + frameRingCutHeight ],
               [ frameDia/2, 2*frameRingCutThick + frameRingCutHeight ],
               [ 0, 2*frameRingCutThick + frameRingCutHeight ] ] );
    }
  }


  // ===== SLOT  
  translate( [0,-clampSlot/2,-bottleDia/2-clampExtBot-5] )
  cube( [bottleDia,clampSlot,clampLen+bottleDia/2+clampExtTop+clampExtBot+10] );

  // ===== SCREW HEAD CUTOUT
  if( screwNumber > 0 )
  {
    if( SHOWCUTOUTS )
    {
      for( i = [ 0 : screwNumber-1 ] )
      { 
        translate( [0,0,i*screwDistance] )
        %ScrewCutout();
      }
    }
    else
    {
      for( i = [ 0 : screwNumber-1 ] )
      { 
        translate( [0,0,i*screwDistance] )
        ScrewCutout();
      }
    }
  } // END if screwNumber > 0

  // ===== ZIP TIE TUNNELS
  if( zipNumber > 0 )
  {
    for( i = [0:zipNumber-1] )
    {
      if( zipType == 1 )
      {
        translate( [zipOffX,0,i*zipDistance] )
        if( SHOWCUTOUTS )
           %ZipTieLinear( );
        else
           ZipTieLinear( );
      }
      else
      {
        if( zipType == 2 )
        {
          translate([-bottleDia/2-frameMountDepth-frameDia/2+zipOffX,0,zipLowerHeight+i*zipDistance])
          if( SHOWCUTOUTS )
            %ZipTieRadial();
          else
            ZipTieRadial();
        }
      }
    } // END for
  } // END if zipNumber > 0


} // END difference
} // END module







module ZipTieLinear()
{
  translate( [ -bottleDia/2 - frameMountDepth/2, 0, zipLowerHeight ] )
  rotate( [90,0,0] )
  linear_extrude( height = 2*frameMountWidth, center = true, $fn=CYLPREC )
  translate( [-zipHeight/2, -zipWidth/2 ] )
  polygon( [ [ 0, 0 ],
          [ zipHeight / 2, -zipHeight / 2],
          [ zipHeight , 0 ],
          [ zipHeight , zipWidth ],
          [ zipHeight / 2, zipWidth + zipHeight / 2 ],
          [ 0, zipWidth ] ] );
}


module ZipTieRadial()
{
  rotate_extrude( $fn=CYLPREC )
  translate( [zipRadius,0,0] )
  translate( [-zipHeight/2, -zipWidth/2 ] )
  polygon( [ [ 0, 0 ],
          [ zipHeight / 2, -zipHeight / 2],
          [ zipHeight , 0 ],
          [ zipHeight , zipWidth ],
          [ zipHeight / 2, zipWidth + zipHeight / 2 ],
          [ 0, zipWidth ] ] );
}



module ScrewCutout()
{
  // ===== SCREW HEAD (OR WASHER)
  translate( [-bottleDia/2-screwHeadLen,0,screwLowerHeight] )
  rotate( [0,90,0] )
  cylinder( r = screwHeadDia/2, h = bottleDia/2, $fn=CYLPREC);

  // ===== SCREW
  translate( [-bottleDia/2-frameDia/2-frameMountDepth-1,0,screwLowerHeight] )
  rotate( [0,90,0] )
  cylinder( r = screwDia/2, h = bottleDia/2+frameDia/2+frameMountDepth+1, $fn=CYLPREC);

  // ===== FRAME NUT
  translate( [ -bottleDia/2-frameMountDepth+frameNutHeight,0,screwLowerHeight] )
  rotate( [0,-90,0] )
  cylinder( r = frameNutDia/2, h = frameNutHeight + 20, $fn=CYLPREC);

}



module Tube( diaIn, diaOut, length)
{
  difference()
  {
    cylinder( r = diaOut/2, h = length, $fn=CYLPREC );
    translate( [0,0,-1] )
    cylinder( r = diaIn/2, h = length +2, $fn=CYLPREC );
  }
}



module TriCut( dias, width, len, dist )
{

  translate( [0,0,-width/2] )
  hull()
  {
    translate( [len,dist/2,0] )
    cylinder( r = dias/2, h = width, $fn=CYLPREC);

    translate( [len,-dist/2,0] )
    cylinder( r = dias/2, h = width, $fn=CYLPREC);

    cylinder( r = dias/2, h = width, $fn=CYLPREC);
  }
}