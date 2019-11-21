
// Whistle building guide: http://www.ggwhistles.com/howto/
// v6 - thin walls (0.64mm), small window 3x6mm
// v7 - thicker walls (0.96mm), larger window 5x8mm
// v8 - thin walls (0.96mm), larger window 5x8mm, beefed up window ares
// v9 - like v8 but opening sides of windway - definitely seems less harsh on the transition to 2nd octave
// v10 - start rigging for customizer
// v11 - Nip top front corners of mouthpiece
// v12 - tuning tweak, add 25 cents (1.5%) by shortening end turn equivalent length by ~2mm ea (in 268mm reference pipe)
// v13 - resequence hole removal to include endTurns, add hole bolsters
// v14 - vertically offset large holes to prevent overhangs

facets        = 120*1;   // 20 for fast, 120 for printing, 180 appears to crash?

// preview[view:north west, tilt:top diagonal]

// Whistle type Soprano, Alto, or Low
voiceType     = 1;  // [0:Soprano, 1:Alto, 2:Low]

// 0-4, different meanings in different voiceTypes                 
key           = 0;  // [0,1,2,3,4]

// Amount to vary from standard tune length (0.97 is ~50 cents sharp)
detune        = 1.0; // [0.88:0.001:1.14]

// Thickening above windway, reduces thermal effects
wwRoof        = 1.6;    // [0:0.01:5.0]

// Windway height (mm)
wwHeight      = 1.12;   // [0.5:0.01:5.0]

// Bottom of windway is this far below top of lip
wwUnderlip    = 0.56;   // [-1:0.01:2]

// Top of lip is this high above top of bore (also, lip is this thick)
lipEdge       = 0.28;   // [0.08:0.01:2]

// Pipe wall thickness (mm) recommend minimum 0.64 in PLA-Hyper, 0.84 in ABS-High
wall          = 0.84; // [0.28:0.01:2]

// Is the window tuned for easy 2nd octaves, easy 1st, or inbetween?
windowType    = 4; // [0:2nd Oct, 1:Mid 2nd Oct, 2:Mid, 3:Mid 1st Oct, 4:1st Oct, 5: Long]

// Window width, as a fraction of bore diameter, wider=louder narrower can have a more pure tone
winBoreRatio  = 0.62; // [0.33:0.01:0.75]

// Windway length (mm) including window, make longer for lower voice Types
windwayLength = 25; // [15:1:50]

// Mouthpiece offset (mm) changes length of first pipe
mpOfs         = 6; // [-20:0.1:100]

// Radius of hanger hole (mm)
hangerRad     = 2;  // [0:0.01:3]

// Number of finger holes to cut
nHoles        = 3; // [0:1:6]

// Sometimes the bottom hole needs a vertical tweak
tweak         = -2.6; // [-5.0:0.1:0.0]

makersMark    = "MangoCats";

lipAngle      = 3*1;    // In degrees
windowDepth   = 3*1;    // Extra cut beneath the window (to clip the round edges)
hyp           = 30*1;   // arbitrary hypotenuse length for lip cuts
tuneLengths   = [[238,252,268,304,350],  // Eb E D C Bb Sopranos
                 [290,309,331,355,402],  // C Bb B A G Altos
                 [452,484,514,544,614]]; // F Eb E D C Lows
keyLabel      = [["E" ,"E_","D" ,"C" ,"B_"],
                 ["C" ,"B_","B" ,"A" ,"G" ],
                 ["F" ,"E" ,"E_","D" ,"C" ]];
                 
tuneLength    = tuneLengths[voiceType][key] * detune;


windowLengths = [[ 3.0, 3.5, 4.0, 4.5, 5.0, 5.5 ],
                 [ 4.0, 4.5, 5.0, 5.5, 6.0, 6.5 ],
                 [ 6.0, 7.0, 8.0, 9.0,10.0,11.0 ]];
                 
windowLength  = windowLengths[voiceType][windowType];
totalLength   = tuneLength+windowLength;

bores         = [13,
                 17,
                 22];
bore          = bores[voiceType];

thick         = bore+2*wall;
turn          = thick;

wwWidthLip    = bore*winBoreRatio;
fippleBevels  = [0,
                 0.707*1.75,
                 0.707*2.5  ];  
fippleBevel   = fippleBevels[voiceType];
turnLength    = (bore+wall)*1.500;             // Equivalent length for length tune
endLength     = (2*bore+3*wall)*1.250+thick;   // Equivalent length for length tune

mpLength      = windwayLength-windowLength;
mpRamp        = mpLength;
segments      = 3*1;
sLength       = totalLength-turnLength*(segments-1)-endLength; // Length of the straight pipes
octagonSide   = 0.41*1; // how thick to make the support fillers - to match the octagon
octagonRadius = (bore+2*wall)/2;
wwWidthMouth  = (octagonRadius-1)*2;

extra         = 1*1;    // Visible "extra" material to finish cuts
tiny          = 0.01*1; // To bridge gaps between touching pieces
// 3x + thick = sLength  
// x = (sLength - thick)/3
mpo           = thick*octagonSide+mpOfs; // +53.2435; // Mouthpiece offset - backs the mouthpiece out of the folds
//fracts        = [  (sLength - turn)/(3*sLength)       + mpo/totalLength, 
//                   (sLength - turn)/(3*sLength)       - mpo/(2*totalLength), 
//                  ((sLength - turn)/3 + turn)/sLength - mpo/(2*totalLength)];
fracts        = [ 1/3 + mpo/totalLength, 
                  1/3 - mpo/(2*totalLength), 
                  1/3 - mpo/(2*totalLength)];
ofs           = [ 0.0, 
                  fracts[0]-fracts[1],
                  fracts[0]-fracts[1] ];
turnOfsZ      = [ fracts[0], 
                  fracts[0]-fracts[1],
                  fracts[0]-fracts[1]+fracts[2] ];
turnRot       = [ 270,
                  90 ];

holeDia       = [[[  7, 8, 4, 6, 6, 5 ],
                  [  8, 8, 4, 6, 6, 5 ],
                  [  7, 8, 5, 6, 6, 5 ],
                  [  6, 7, 4, 6, 6, 5 ],
                  [  7, 8, 5, 7, 6, 6 ]],
                 [[  8, 9, 5, 7, 8, 7 ],
                  [ 10,10, 6, 7, 7, 6 ],
                  [  7, 8, 6, 7, 8, 7 ],
                  [  7, 8, 6, 7, 7, 7 ],
                  [  7, 9, 6, 7, 8, 7 ]],
                 [[  9,12, 8, 9,10, 9 ],
                  [  9,12, 8, 9,10, 8 ],
                  [  9,12, 8, 9,10, 8 ],
                  [  9,12, 8, 9,10, 9 ],
                  [  9,13, 9, 9,10, 9 ]]];
                  
holePos       = [[[ 200,177,159,137,117, 96 ],
                  [ 212,187,168,145,124,102 ],
                  [ 225,199,181,154,134,114 ],
                  [ 250,224,205,181,155,133 ],
                  [ 290,258,237,207,181,156 ]],
                 [[ 238,211,192,164,142,120 ],
                  [ 259,229,210,177,153,130 ],
                  [ 271,241,220,189,163,137 ],
                  [ 294,264,241,206,179,155 ],
                  [ 332,296,272,233,203,177 ]],
                 [[ 366,330,302,260,225,195 ],
                  [ 394,357,326,280,244,213 ],
                  [ 423,380,349,299,261,226 ],
                  [ 450,406,375,322,282,245 ],
                  [ 511,463,427,367,325,284 ]]];

echo("tuneLength "  ,tuneLength   );
echo("sLength "     ,sLength      );
echo("bore "        ,bore         );
echo("windowWidth " ,wwWidthLip   );
echo("windowLength ",windowLength );

rotate([0, 0,180])
  mirror()
    translate([-sLength/5,0,thick/2])
      rotate([0,270,180])
        whistle();

module whistle()
{ difference()
    { pipes();
        
      union()
        { hanger();
          # label();
        }
    }
  mouthpiece();
}

module label()
{ font1 = "Baloo Bhai"; // here you can select other font type
    
  textDepth = wall;
  fontSizes=[4,5,6];
  fontSize=fontSizes[voiceType];
  ofss=[1.8,2.3,2.8];
  ofs=ofss[voiceType];

  translate ([thick/2+2,ofs,turnOfsZ[1]*sLength+textDepth-thick])
    rotate ([0,180,0])
      rotate ([0,0,180])
        linear_extrude(height = textDepth+extra )
          text( "v14", font = font1, size = fontSize, direction = "ltr", spacing = 1 );

  translate ([thick/2+0.5,-thick/2*octagonSide+textDepth,turnOfsZ[1]*sLength-thick+0.5])
    rotate ([90,0,0])
      linear_extrude(height = textDepth+extra )
        text( keyLabel[voiceType][key], font = font1, size = fontSize, direction = "ltr", spacing = 1 );
}

module hanger()
{ $fn=facets;
//  translate([octagonRadius*3-hangerRad,thick/2,turnOfsZ[2]*sLength-hangerRad])
  translate([-hangerRad*2,thick/2,thick+turnOfsZ[0]*sLength-hangerRad])
    rotate([90,0,0])
      linear_extrude( height=thick )
        circle( hangerRad );
}

module endPieceOuter( n=2 )
{ $fn=facets;
  epo = (turnOfsZ[n]-ofs[n])*sLength;
  // flatEndOuter( epo );
  roundEndOuter( epo );
}

module endPieceInner( n=2 )
{ $fn=facets;
  epo = (turnOfsZ[n]-ofs[n])*sLength;
  // flatEndInner( epo );
  roundEndInner( epo );
}

module flatEnd( epo=0 )
{ // First corner
  translate([octagonRadius*3-thick*2,0,epo])  
    rotate([0,270,90])
      corner();
   
   translate([thick/2-thick*2,0,epo+thick/2])
     rotate([0,90,0])     
       pipe();
    
  // Last Corner      
  translate([thick/2-thick*2,0,epo+thick]) 
    rotate([0,270,0])
      rotate([0,270,270])
        corner( 1 );
}

module roundEndOuter( epo=0 )
{ translate([-octagonRadius*3,0,epo])
    rotate([0,270,90])
      difference()
        { rotate_extrude()
            translate([octagonRadius*3,0,0])
              flatSideOctagon( octagonRadius );
        
          union()
            { translate([-thick,0,0])
                cube([2*thick,4*thick+extra,thick+extra],center=true);
            
              translate([thick/2,(thick*2+extra)/2,0])
                cube([thick*4+extra,thick*2+extra,thick+extra],center=true);
            }        
        }
    
  // Corner for straight exit      
  //translate([thick/2-thick*2,0,epo+2*thick]) 
  //  rotate([0,270,0])
  //    rotate([0,270,270])
  //      corner( 1 );
        
   // Side exit pipe     
   translate([-5*thick/2+tiny,0,epo+3*thick/2])
     rotate([0,90,0])     
       pipeOuter();
}

module roundEndInner( epo=0 )
{ translate([-octagonRadius*3,0,epo])
    rotate([0,270,90])
      difference()
        { rotate_extrude()
            translate([octagonRadius*3,0,0])
              circle( bore/2 );
            
          translate([-thick,0,0])
            cube([2*thick,4*thick+extra,thick+extra],center=true);
            
          translate([thick/2,(thick*2+extra)/2,0])
            cube([thick*4+extra,thick*2+extra,thick+extra],center=true);
        }
    
  // Corner for straight exit      
  //translate([thick/2-thick*2,0,epo+2*thick]) 
  //  rotate([0,270,0])
  //    rotate([0,270,270])
  //      corner( 1 );
        
   // Side exit pipe     
   translate([-5*thick/2+tiny,0,epo+3*thick/2])
     rotate([0,90,0])     
       pipeInner();
}

module corner( fill=0 )
{ difference()
    { union()
        { rotate_extrude()
            translate([octagonRadius,0,0])
              flatSideOctagon( octagonRadius );
            
           if ( fill > 0 )
             translate([thick/2,0,0])
               cube([thick+2*tiny,2*thick,thick*octagonSide],center=true);
        }
        
      union()
        { rotate_extrude()
            translate([octagonRadius,0,0])
              circle( bore/2 );
            
          translate([-thick/2,0,0])
            cube([thick,2*thick+extra,thick+extra],center=true);
            
          translate([thick/2,(thick+extra)/2,0])
            cube([thick+extra,thick+extra,thick+extra],center=true);
        }
    }
}

module endTurn( n=0 )
{ $fn=facets;
  echo( "endTurn ",n," toz ",turnOfsZ[n] );
  difference()
    { endTurnOuter( n );
       
      endTurnInner( n );
    }
} 

module endTurnOuter( n=0 )
{ $fn=facets;
  translate([octagonRadius,0,(turnOfsZ[n]-ofs[n])*sLength])  
  rotate([0,turnRot[n],90])
    difference()
      { union()
          { rotate_extrude()
              translate([octagonRadius,0,0])
                flatSideOctagon( octagonRadius );
                
            if (( n == 1 ) || ( n == 0 ))  
              translate([thick/2,thick/2,0])
                cube([thick,thick,thick*octagonSide],center=true);
          }
          
        translate([-thick/2,0,0])
          cube([thick,2*thick+extra,thick+extra],center=true);
      }
} 

module endTurnInner( n=0 )
{ $fn=facets;
  translate([octagonRadius,0,(turnOfsZ[n]-ofs[n])*sLength])  
  rotate([0,turnRot[n],90])
    difference()
      { rotate_extrude()
          translate([octagonRadius,0,0])
            circle( bore/2 );
          
        translate([-thick/2,0,0])
          cube([thick,2*thick+extra,thick+extra],center=true);
      }
} 

module pipeBaseOffset( n = 0 )
{ translate([(bore+2*wall)*n,0,ofs[n]*sLength])
    children();
}

module pipes()
{ $fn=facets;
  difference()
    { union()
        { for (n=[0:segments-1])
            { echo( "pipe ",n," ofs ",ofs[n]," fract ",fracts[n], " end ", ofs[n]+fracts[n] );
              pipeBaseOffset( n )
                union()
                  { if (( n == 0 ) && ( winBoreRatio > octagonSide ))
                      pipeOuter( pipeLength=fracts[n]*sLength, beef=1, segment=n );
                     else
                      pipeOuter( pipeLength=fracts[n]*sLength, beef=0, segment=n );
                    if ( n < (segments-1) )
                      endTurnOuter(n);
                    if ( n == (segments-1) )
                      endPieceOuter(n);
                  }
            }
          holeBolsters();  
        }

      union()
        { for (n=[0:segments-1])
            { pipeBaseOffset( n )
                union()
                  { if (( n == 0 ) && ( winBoreRatio > octagonSide ))
                      pipeInner( pipeLength=fracts[n]*sLength, beef=1, segment=n );
                     else
                      pipeInner( pipeLength=fracts[n]*sLength, beef=0, segment=n );
                    if ( n < (segments-1) )
                      endTurnInner(n);
                    if ( n == (segments-1) )
                      endPieceInner(n);
                    if ( n == 0 )
                      # window();
                  }
            }
          # holes();
        }
    }
}

module pipeOuter( pipeLength=thick, beef=0, segment=0 )
{ $fn=facets;
  translate( [0,0,-tiny] )  // repair seams at pipe ends?
  union()
    { linear_extrude( height=pipeLength+tiny*2 )
        flatSideOctagon( octagonRadius );
      if ( beef )
        windowBeef();
    }
}

module pipeInner( pipeLength=thick, beef=0, segment=0 )
{ $fn=facets;
  translate( [0,0,-tiny] )  // repair seams at pipe ends?
  linear_extrude( height=pipeLength+tiny*2 )
    circle( bore/2 );
}

module windowBeef()
{ // Bigger octagon around the window, then taper slowly 
  echo("Where's the beef?");
  top = -(bore/2+lipEdge);
  mid = top + (octagonRadius-wwWidthLip/2);
  bot = -top;
      linear_extrude( height=windowLength )
        polygon(points=[[ wwWidthLip/2 , top ],
                        [-wwWidthLip/2 , top ],
                        [-octagonRadius, mid ],
                        [-octagonRadius, 0   ],
                        [ octagonRadius, 0   ],
                        [ octagonRadius, mid ]],
                paths =[[0,1,2,3,4,5,0]] );
    
  translate([0,0,windowLength])
    difference()
      { exLen=fracts[0]*sLength-windowLength;
        union()
          { stage1=-octagonRadius/top;
            ht1=exLen/8.5;  // Need a formula for lip angle and thickness
            linear_extrude( height=ht1, scale=[1.0,stage1] )
              polygon(points=[[ wwWidthLip/2 , top ],
                              [-wwWidthLip/2 , top ],
                              [-octagonRadius, mid ],
                              [-octagonRadius, bot ],
                              [ octagonRadius, bot ],
                              [ octagonRadius, mid ]],
                      paths =[[0,1,2,3,4,5,0]] );
          
            translate([0,0,ht1])  
              linear_extrude( height=(exLen-ht1), scale=[1.0,tiny] )
              polygon(points=[[ wwWidthLip/2 , top*stage1 ],
                              [-wwWidthLip/2 , top*stage1 ],
                              [-octagonRadius, mid*stage1 ],
                              [-octagonRadius, bot*stage1 ],
                              [ octagonRadius, bot*stage1 ],
                              [ octagonRadius, mid*stage1 ]],
                      paths =[[0,1,2,3,4,5,0]] );
          }
          
        linear_extrude( height=exLen )
          polygon(points=[[-octagonRadius, 0         ],
                          [-octagonRadius, bot+extra ],
                          [ octagonRadius, bot+extra ],
                          [ octagonRadius, 0         ]],
                  paths =[[0,1,2,3,0]] );
      }
}

module hole( holeRad=3 )
{ rotate([90,0,0])
    linear_extrude( height=thick )
      circle(holeRad);
}

module bolster( bolsterRad=3 )
{ rotate([90,0,0])
    linear_extrude( height=bore/2+wall )
      circle(bolsterRad);
}

module holeChamfer( holeRad=3 )
{ rotate([90,0,0])
    linear_extrude( height=wall,scale=1.414 )
      circle(holeRad);
}

module holeOffset( holeN=0 )
{ holeLoc = windowLength + holePos[voiceType][key][holeN] * detune;
  holeSz  = holeDia[voiceType][key][holeN]+2*wall;
  if ( holeN < 3 )
    { pipeN = 2;
      pipeLen = fracts[2]*sLength; // in 3rd pipe
      holeOfs = totalLength - endLength - holeLoc; // Offset from the end of the pipe segment
        
      // Quick and dirty for test, need circular offset location for X and Y when holeOfs < 0
      oSide = octagonSide * octagonRadius * 2;
      vOff = ( holeSz  > oSide ) ? 
           ((( holeOfs < 0 ) ? tweak : 0) + (holeSz - oSide)/2 ) : 
            (( holeOfs < 0 ) ? tweak : 0);
      echo( "hole ",holeN,pipeLen,holeOfs,vOff );
      pipeBaseOffset( pipeN )
        translate([vOff,0,pipeLen-holeOfs])
          children();
    }
  if ( holeN >= 3 )
    { pipeN = 1; // in 2nd pipe
      holeOfs = totalLength - (endLength+fracts[2]*sLength+turnLength) - holeLoc; // Offset from the end of the pipe segment
      echo( "hole ",holeN,holeOfs );
      pipeBaseOffset( pipeN )
        translate([0,0,holeOfs])
          children();
    }
}

module holes()
{ for (n=[0:nHoles-1])
    { holeRad = holeDia[voiceType][key][n]/2;
      holeOffset( n )
        hole( holeRad );
      holeOffset( n )
        translate([0,-bore/2-wall/2,0])
          holeChamfer( holeRad );
    }
}

module holeBolsters()
{ for (n=[0:nHoles-1])
    { bolsterRad = holeDia[voiceType][key][n]/2 + 2*wall;
        holeOffset( n )
          bolster( bolsterRad );
    }
}

module window()
{ translate([-wwWidthLip/2,-(bore/2+lipEdge),0])
    rotate([0,-90,180])
      linear_extrude( height=wwWidthLip )
        polygon(points=[[-extra      ,-windowDepth],
                        [windowLength+sin(90-lipAngle)*hyp,-windowDepth],
                        [windowLength+sin(90-lipAngle)*hyp,-lipEdge-cos(90-lipAngle)*hyp],
                        [windowLength,-lipEdge],
                        [windowLength,0           ],
                        [windowLength+sin(90-lipAngle)*hyp, cos(90-lipAngle)*hyp],
                        [-extra, cos(90-lipAngle)*hyp ]],
                paths =[[0,1,2,3,4,5,6,0]] ); 
}


module mouthpiece()
{ rotate([180,0,180])
    { difference()
        { union()
            { linear_extrude( height=mpLength )
                flatSideOctagon( octagonRadius );
                
              translate([0,0,0])  
                linear_extrude( height=mpLength )
                  polygon(points=[[-octagonRadius, 0                    ],
                                  [-octagonRadius, -octagonRadius-wwRoof],
                                  [ octagonRadius, -octagonRadius-wwRoof],
                                  [ octagonRadius, 0                    ]],
                paths =[[0,1,2,3,0]] ); 
            }   
            
           # union()
            { ramp();
              windway();
              bevel();
              mpLabel();
              corners();
            }
        }
    }
}

// clipping off unnecessary material that is occasionally a problem when
// printing the first layer
module corners()
{ ccSize = (octagonRadius - wwWidthLip/2)*2;

  mirror()
  translate([octagonRadius,-(octagonRadius+wwRoof),0])  
    rotate([30,45,90])
        cube([ccSize*2,ccSize/2,ccSize*2],center=true);

  translate([octagonRadius,-(octagonRadius+wwRoof),0])  
    rotate([30,45,90])
        cube([ccSize*2,ccSize/2,ccSize*2],center=true);
}

module mpLabel()
{ font1 = "Baloo Bhai"; // here you can select other font type
    
  textDepth = wall/2;

  translate ([textDepth-octagonRadius,-octagonRadius+2,mpLength-2])
    rotate ([0,90,0])
      rotate ([0,180,180])
        linear_extrude(height = textDepth+extra )
          text( makersMark, font = font1, size = 2, direction = "ltr", spacing = 1 );

}

module ramp()
{ rotate([0,270,0])
    translate([0,-thick/2,-(thick+extra)/2])
      linear_extrude( height=thick+extra )
        polygon(points=[[mpLength+extra ,thick+extra               ],
                        [mpLength+extra ,wwHeight+wwRoof-wwUnderlip],
                        [mpLength       ,wwHeight+wwRoof-wwUnderlip],
                        [mpLength-mpRamp,thick                     ],
                        [mpLength-mpRamp,thick+extra               ]],
                paths =[[0,1,2,3,4,0]] );
}

module windway()
{ translate([0,-(bore/2+lipEdge-wwUnderlip),0])
    rotate([90,0,0])
      linear_extrude( height=wwHeight )
        polygon(points=[[ wwWidthLip/2  , 0              ],
                        [ wwWidthLip/2  , -extra         ],
                        [-wwWidthLip/2  , -extra         ],
                        [-wwWidthLip/2  , 0              ],
                        [-wwWidthMouth/2, mpLength       ],
                        [-wwWidthMouth/2, mpLength+extra ],
                        [ wwWidthMouth/2, mpLength+extra ],
                        [ wwWidthMouth/2, mpLength       ]],
                paths =[[0,1,2,3,4,5,6,7,0]] );
}

module bevel()
{ rotate([270,0,0])
    rotate([0,90,0])
      translate([bore/2+lipEdge-wwUnderlip,0,-wwWidthLip/2])
        linear_extrude( height=wwWidthLip )
          polygon(points=[[ -fippleBevel  ,  0           ],
                          [ -fippleBevel  ,  extra       ],
                          [  extra        ,  extra       ],
                          [  extra        , -fippleBevel ],
                          [  0            , -fippleBevel ]],
                  paths =[[0,1,2,3,4,0]] );

}

module flatSideOctagon( r = 10 )
{ rotate([0,0,22.5])
    Octagon( A = r );
}
    

//============================================================
// OpenSCAD
// Regular Convex Polygon Library
// Last Modified : 2015/10/28
//============================================================
/*

	Definition

	N = Number of Side N >=3
	A = apothem
		radius of inside circle
	R = circumradius
		Radius of outside circle
	S = Side
		Lenght of a side

	Build polygon with the Apothem :
	N and A is known
	Need to calculate S then R
	use $fn

	Build Polygon with Circumradius
	N and R known
	use $fn

	Build Polygon with Side
	N and S Known
	Need to calculate R and optionaly A
	use $fn	

	TO DO
    Control result

	For more information :
	http://en.wikipedia.org/wiki/Regular_polygon

*/

	// A = apothem - it's a RADIUS !
	// For a bolt of 4 inches spécify A=2*inch
	//Polygon(N=7,A=2*inch,h=0);	// 4 inches radius Polygon
	//Polygon(N=7,A=49.8365,h=0);
	//Trigon(A=50,h=10);			// N=3
	//Dodecagon(A=50,h=0);			// N=12

    //rotate([0,0,360/7/2])
	//Nonagon(R=55.3144,h=10,debug=true);

	//Polygon(N=6,A=60,h=0,debug=false);
	//Polygon(N=6,A=60,h=5,debug=true);

//------------------------------------------------------------
// Polygon : 
//------------------------------------------------------------
module Polygon(N=3,A=0,R=0,S=0,h=0,debug=false)
{
	N = ( N < 3 ? 3 : N );

	angle = 360/N;
	angleA = angle/2;

	if (debug)
	{
		echo("N = ", N);
		echo("A = ", A);
		echo("S = ", S);
		echo("R = ", R);
	}

	if ( A > 0 )		// if A assign R and S
	{
        S = 2 * A * tan(angleA);							// assign
		//R = (S/2) / sin(angleA);						// no assign ???
		R = ( A * tan(angleA) ) / sin(angleA);		// asign
		_Build_Polygon(N=N,R=R,h=h);
		if (debug)
		{
			echo("aN = ", N);
			echo("aA = ", A);
			echo("aS = ", S);
			echo("aR = ", R);
			#cylinder(r=A,h=h+1,center=true,$fn=150);
			%cylinder(r=R,h=h+1,center=true,$fn=150);
		}
	}
	else
	{
		if ( S > 0 )		// if S assign R and A
		{
			R = (S/2) / sin(angleA);			// assign
			A = S / ( 2 * tan(angleA) );		// assign
            _Build_Polygon(N=N,R=R,h=h);
			if (debug)
			{
				echo("sN = ", N);
				echo("sA = ", A);
				echo("sS = ", S);
				echo("sR = ", R);
				#cylinder(r=A,h=h+1,center=true,$fn=150);
				%cylinder(r=R,h=h+1,center=true,$fn=150);
			}
		}
		else
		{
			if ( R == 0 )		// default
			{
				S = 2 * R * sin(angleA);			// no assign ???
				A = S / ( 2 * tan(angleA) );		// no assign ???
				_Build_Polygon(N=N,h=h);
				if (debug)
				{
					echo("0N = ", N);
					echo("0A = ", A);
					echo("0S = ", S);
					echo("0R = ", R);
					#cylinder(r=A,h=h+1,center=true,$fn=150);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}
			}
			else		// build with R
			{
				S = 2 * R * sin(angleA);
				A = S / ( 2 * tan(angleA) );			// no assign ???
				//A = R * ( sin(angleA) / tan(angleA) )	// no assign ???
				_Build_Polygon(N=N,R=R,h=h);
				if (debug)
				{
					echo("rN = ", N);
					echo("rA = ", A);
					echo("rS = ", S);
					echo("rR = ", R);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}
			}
		}
	}

	if (debug)
	{
		echo("fN = ", N);
		echo("fA = ", A);
		echo("fS = ", S);
		echo("fR = ", R);
	}
}

//------------------------------------------------------------
// Build
//------------------------------------------------------------
module _Build_Polygon(N=3,R=1,h=0)
{
	if (h > 0)
	{
		// 3D primitive h>0
		cylinder(r=R,h=h,$fn=N,center=true);
	}
	else
	{
		// 2D primitive h=0
		circle(r=R,$fn=N,center=true);
	}
}

//------------------------------------------------------------
// Building lots from N=3, N=N+1
// http://en.wikipedia.org/wiki/Polygon
//------------------------------------------------------------

// 3 sides
module Trigon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=3,A=A,R=R,S=S,h=h,debug=debug);}

module Triangle(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=3,A=A,R=R,S=S,h=h,debug=debug);}

// 4 sides
module Tetragon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

module Quadrilateral(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

module Quadrangle(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

// 5 sides
module Pentagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=5,A=A,R=R,S=S,h=h,debug=debug);}

// 6 sides
module Hexagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=6,A=A,R=R,S=S,h=h,debug=debug);}

// 7 sides
module Heptagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=7,A=A,R=R,S=S,h=h,debug=debug);}

// 8 sides
module Octagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=8,A=A,R=R,S=S,h=h,debug=debug);}

// 9 sides
module Enneagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=9,A=A,R=R,S=S,h=h,debug=debug);}

module Nonagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=9,A=A,R=R,S=S,h=h,debug=debug);}

// 10 sides
module Decagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=10,A=A,R=R,S=S,h=h,debug=debug);}

// 11 sides
module Handecagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=11,A=A,R=R,S=S,h=h,debug=debug);}

// 12 sides
module Dodecagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=12,A=A,R=R,S=S,h=h,debug=debug);}

//=========================================================
