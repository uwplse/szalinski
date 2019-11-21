
$fn=120*1;
gap               =   0.3*1;
spacing           =   3.0*1;
cornerDepth       =   1.5*1;
axleDiameter      =   8.0*1;
pbThickness       =   9.0*1;
pbGap             =   0.5*1;
pbAngleOuter      =   0.0*1;
pbAngleInner      =  30.0*1;
  pbOD   = axleDiameter + (pbGap+pbThickness) * 2;
  pbID   = pbOD - pbThickness*2;
  pbTopXO = cos( pbAngleOuter ) * pbOD/2;
  pbTopYO = sin( pbAngleOuter ) * pbOD/2;
  pbBotXO = pbTopXO + cos( 90-pbAngleOuter ) * pbOD/2 + tan( pbAngleOuter ) * pbOD/2;
  pbTopXI = cos( pbAngleInner ) * pbOD/2;
  pbTopYI = sin( pbAngleInner ) * pbOD/2;
  pbBotXI = pbTopXI + cos( 90-pbAngleInner ) * pbOD/2 + tan( pbAngleInner ) * pbOD/2;
extra             =  0.1*1;
thin              =  0.01*1;
bearingSpacing    = 130.0; //[90:1:200]
carriageWidth     =  10.7*1;
carriageLength    = bearingSpacing + pbOD;  // 3" = 76.2mm, 2.5" = 63.5
carriageThickness =   9.0*1;
plateThickness    =   7.0*1;
plateGap          =   0.2*1;
plateWidth        =  25.0*1;
plateCtoC         =  56.0; //[31:1:150]
plateCapHeight    =   9.5*1;
plateCapWidth     =   8.0*1;
plateLength       = plateCtoC + plateCapWidth*2 + plateGap;
carriageHeight    = carriageThickness+plateThickness+pbOD;
nCarriages        =     2; //[0:1:4]
nPlates           =     2; //[0:1:4]

for( n = [0:3] )
  { if ( n < nCarriages )
      translate( [0,n*(carriageHeight+spacing),0] )
        carriage();
  }

for( n = [1:4] )
  { if ( n <= nPlates )
      translate( [0,n*(-plateWidth-spacing),0] )
        plate();
  }


module carriage()
{ translate( [-carriageLength/2,pbOD+carriageThickness,carriageWidth/2] )
  rotate( [90,0,0] )
  difference()
    { union()
        { translate ([pbBotXO,0,carriageThickness]) 
            rotate( [0,0,180] )
              pillowBlock();
    
          translate ([carriageLength-pbBotXO,0,carriageThickness]) 
            pillowBlock();
    
          linear_extrude( carriageThickness )
            chamferedRectangle( top   = -carriageWidth/2,
                                bot   =  carriageWidth/2,
                                left  =  0,
                                right =  carriageLength,
                                cc    =  cornerDepth      );
            
          underCarriage();  
        }
        
      corners();
        
      # carriageLabel();
    }
}

module underCarriage()
{ endLength   = carriageWidth + 2*cornerDepth;
  underLength = (carriageLength - plateWidth+plateGap - (plateWidth+plateGap+endLength)*2)/2;
  underStart  = endLength + plateWidth + plateGap;
    
  translate( [0,0,-plateThickness] )
    linear_extrude( plateThickness+extra )
      chamferedRectangle( top   = -carriageWidth/2,
                          bot   =  carriageWidth/2,
                          left  =  0,
                          right =  endLength,
                          cc    =  cornerDepth      );

  translate( [0,0,-plateThickness] )
    linear_extrude( plateThickness+extra )
      chamferedRectangle( top   = -carriageWidth/2,
                          bot   =  carriageWidth/2,
                          left  =  carriageLength-endLength,
                          right =  carriageLength,
                          cc    =  cornerDepth      );
    
  translate( [0,0,-plateThickness] )
    linear_extrude( plateThickness+extra )
      chamferedRectangle( top   = -carriageWidth/2,
                          bot   =  carriageWidth/2,
                          left  =  underStart,
                          right =  underStart+underLength,
                          cc    =  cornerDepth      );

  translate( [0,0,-plateThickness] )
    linear_extrude( plateThickness+extra )
      chamferedRectangle( top   = -carriageWidth/2,
                          bot   =  carriageWidth/2,
                          left  =  underStart+plateWidth+plateGap+underLength,
                          right =  underStart+plateWidth+plateGap+underLength*2,
                          cc    =  cornerDepth      );
}

module carriageLabel()
{ font1 = "Baloo Bhai"; // here you can select other font type
    
  translate ([carriageLength/2-9,-3,carriageThickness-1.5])
    linear_extrude( 2 )
      text( str(bearingSpacing), font = font1, size = 6, direction = "ltr", spacing = 1 );
}

module pillowBlock()
{ translate( [0,carriageWidth/2,pbOD/2] )
  rotate( [90,0,0] )
  difference()
    { union()
        { linear_extrude( carriageWidth )
            polygon(points=[[ pbTopXO, pbTopYO],
                            [-pbTopXI, pbTopYI],
                            [-pbBotXI, -pbOD/2],
                            [ pbBotXO, -pbOD/2]],
                    paths =[[0,1,2,3,0]] );
            
          linear_extrude( carriageWidth )
            circle( r=pbOD/2 );
        }
        
      translate( [0,0,-extra/2] )
        linear_extrude( carriageWidth+extra )
          circle( r=pbID/2 );
    }       
}

module chamferedRectangle( top=1, bot=2, left=1, right=2, cc=0.1 )
{ polygon( points=[[ left+cc, top   ],
                   [right-cc, top   ],
                   [right   , top+cc],
                   [right   , bot-cc],
                   [right-cc, bot   ],
                   [ left+cc, bot   ],
                   [ left   , bot-cc],
                   [ left   , top+cc]],
           paths =[[0,1,2,3,4,5,6,7,0]] );
}

module corners()
{ cornerPair();
  translate( [carriageLength,0,0] )
    rotate( [0,0,180] )
      cornerPair();
}

module cornerPair()
{ translate( [0,-carriageWidth/2,0] )
    corner();
    
  translate( [0,carriageWidth/2,0] )
    rotate( [0,0,270] )
      corner();
}

module corner( l=carriageThickness + pbOD )
{ translate( [0,0,-extra] )
    linear_extrude( l + extra*2 )
      polygon(points=[[-thin,-thin ],
                      [-thin,cornerDepth],
                      [cornerDepth,-thin]],
                    paths =[[0,1,2,0]] );
}
          
module plate()
{ translate( [-plateLength/2,0,0] )
    difference()
      { union()
          { linear_extrude( plateThickness )
              chamferedRectangle( top   =  0,
                                  bot   =  plateWidth,
                                  left  =  0,
                                  right =  plateLength,
                                  cc    =  cornerDepth  );
        
            cap();
            translate( [plateCapWidth+plateGap+carriageWidth,0,0] )
              cap();
            translate( [plateLength-plateCapWidth,0,0] )
              cap();
            translate( [plateLength-2*plateCapWidth-plateGap-carriageWidth,0,0] )
              cap();
          }
        translate( [plateLength,0,0] )
          rotate( [0,270,0] )  
            corner( plateLength );    
          
        translate( [0,plateWidth,0] )
          rotate( [0,270,180] )  
            corner( plateLength );    
         
        translate( [0,plateWidth,0] )   
          rotate( [90,0,0] )  
            corner( plateWidth );    
          
        translate( [plateLength,0,0] )   
          rotate( [90,0,180] )  
            corner( plateWidth );
          
        # plateLabel();
      }
}

module plateLabel()
{ font1 = "Baloo Bhai"; // here you can select other font type
  fontSize = ( plateCtoC < 50 ) ? 6 : 8;
  leftShift = ( plateCtoC <= 46 ) ? plateCapWidth + 0.6 : plateLength/2-fontSize*3/4;
   
  translate ([ leftShift,plateWidth/2-fontSize/2,plateThickness-1.5])
    linear_extrude( 2 )
      text( str(plateCtoC), font = font1, size = fontSize, direction = "ltr", spacing = 1 );
}

module cap()
{ difference()
    { linear_extrude( plateCapHeight+plateThickness )
        chamferedRectangle( top   =  0,
                            bot   =  plateWidth,
                            left  =  0,
                            right =  plateCapWidth,
                            cc    =  cornerDepth  );
      union()
        { translate( [0,0,plateCapHeight+plateThickness] )
            rotate( [270,0,0] )
              corner( plateWidth );
            
          translate( [plateCapWidth,plateWidth,plateCapHeight+plateThickness] )
            rotate( [270,0,180] )
              corner( plateWidth );
        }
    }
      
}
