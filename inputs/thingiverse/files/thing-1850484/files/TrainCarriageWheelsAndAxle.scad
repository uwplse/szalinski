
$fn=120;
gap            =  0.3;
spacing        =  1.0;
radius         = 10.0;
treadWidth     =  4.0;
hubDepth       =  5.0;
hubThickness   =  1.0;
pbThickness    =  2.0;
pbGap          =  0.6;
pbAngleOuter   = 30.0;
pbAngleInner   = 45.0;
axleDiameter   =  5.0;
axleExtraLen   =  2.0;
track          = 25.4;
extra          =  0.1*1;
hitchLength    =  9.0;
hitchEnd       =  9.0;
magGap         =  0.15;
magWidth       =  6.25;
magLength      =  6.25;
magDepth       =  7.0;
magSetback     =  1.0;
carriageWidth  = 19.0;
carriageLength = 76.3;
carriageThickness = 8;
  pbOD   = axleDiameter + (pbGap+pbThickness) * 2;
  pbID   = pbOD - pbThickness*2;
  pbTopXO = cos( pbAngleOuter ) * pbOD/2;
  pbTopYO = sin( pbAngleOuter ) * pbOD/2;
  pbBotXO = pbTopXO + cos( 90-pbAngleOuter ) * pbOD/2 + tan( pbAngleOuter ) * pbOD/2;
  pbTopXI = cos( pbAngleInner ) * pbOD/2;
  pbTopYI = sin( pbAngleInner ) * pbOD/2;
  pbBotXI = pbTopXI + cos( 90-pbAngleInner ) * pbOD/2 + tan( pbAngleInner ) * pbOD/2;


wheelSet();
axles();
carriage();

module carriage()
{ pbExtraThickness = (pbOD - pbID)/2;
  translate( [-carriageLength/2,-carriageWidth/2-axleDiameter*2-spacing*4,0] )
  union()
    { translate ([pbBotXO,0,carriageThickness-pbExtraThickness]) 
        rotate( [0,0,180] )
          pillowBlock();
    
      translate ([carriageLength-pbBotXO,0,carriageThickness-pbExtraThickness]) 
        pillowBlock();
    
      linear_extrude( carriageThickness )
        polygon(points=[[0, -carriageWidth/2],
                        [0,  carriageWidth/2],
                        [carriageLength, carriageWidth/2],
                        [carriageLength,-carriageWidth/2]],
                paths =[[0,1,2,3,0]] );
        
      hitch();
      translate( [carriageLength,0,0] )
        rotate( [0,0,180] )
          hitch();
    }
}

module hitch()
{ difference()
    { linear_extrude( carriageThickness )
        polygon(points=[[           0, -carriageWidth/2],
                        [           0,  carriageWidth/2],
                        [-hitchLength,       hitchEnd/2],
                        [-hitchLength,      -hitchEnd/2]],
                paths =[[0,1,2,3,0]] );
        
      translate( [-hitchLength+magSetback,0,-extra] )      
        linear_extrude( magDepth+extra )
          polygon(points=[[                      0, -magWidth/2.0 - magGap ],
                          [                      0,  magWidth/2.0 + magGap ],
                          [ magLength + 2.0*magGap,  magWidth/2.0 + magGap ],
                          [ magLength + 2.0*magGap, -magWidth/2.0 - magGap ]],
                  paths =[[0,1,2,3,0]] );
    }    
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

module axles()
{ axle();
  translate( [0,-axleDiameter-spacing,0] )
    axle();
}

module axle()
{ hubHole    = hubDepth-hubThickness;
  axleLength = track-treadWidth+hubHole*2+axleExtraLen;
  translate( [-axleLength/2, -axleDiameter/2-spacing, axleDiameter/2] )
    rotate( [0,90,0] )
      rDisc( r=axleDiameter/2, h=axleLength, b=1.0 );
}

// 4 wheels
module wheelSet()
{ wheelPair();
    
  translate( [0,radius*2+spacing,0] )
    wheelPair();
}

module wheelPair()
{ translate( [ radius+spacing/2,radius,0] )
    wheel();
  
  translate( [-radius-spacing/2,radius,0] )
    wheel();
}

module wheel()
{ difference()
    { hubRadius = axleDiameter/2+gap + hubThickness;
      union()
        { rDisc( r=radius   , h=treadWidth, b=treadWidth/3   );
          rDisc( r=hubRadius, h=hubDepth  , b=hubThickness/2 );
        }
      translate( [0,0,-extra] )
        linear_extrude( hubDepth-hubThickness+gap+extra )
          circle(r=axleDiameter/2+gap);  
    }
}

module rDisc(r=10,h=5,b=1)
{ hull()
    { rotate_extrude() 
        translate([r-b,b,0]) 
          circle(r = b); 
          
      rotate_extrude() 
        translate([r-b, h-b, 0]) 
          circle(r = b);
    }
}