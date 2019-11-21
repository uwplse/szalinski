cupDia        = 73;
lipThick      = 0.6;
lipHeight     = 19;
shoulderDepth = 3;
baseHeight    = 4;
lampRad       = 9;
whExtraRad    = 3;
cupRad        = cupDia/2 - lipThick;
lampHeight    = 47;
bowlGap       = cupRad - lampRad;
overlap       = 25;
taperHeight   = cupRad + shoulderDepth - lampRad;
wireDia       = (lampRad - 3) / 2;
whHeight      = 40;
whThick       = 2;

$fn = 120;

echo("bowlGap: ", bowlGap );

assembly();

module assembly()
{ translate( [0,0,whHeight] )
    difference()
      { union()
          { base(); 
            lip(); 
          }
        cavity();
        baseTaper();
        wireHoles();
      }
  wireHouse();
}

module wireHouse()
{ difference()
    { linear_extrude( whHeight )
        circle( d = (whExtraRad + lampRad + lipThick) * 2 );
      linear_extrude( h=whHeight, scale=0.5 )
        circle( d = (whExtraRad + lampRad - whThick) * 2 );
    }
}
  
module wireHoles()
{ linear_extrude( lampHeight + taperHeight-overlap )
    { translate( [ wireDia/2+1,0,0] )
        circle( d=wireDia );
      translate( [-wireDia/2-1,0,0] )
        circle( d=wireDia );
    }
}
  
module baseTaper()
{ rotate_extrude()
    polygon(points=[[ lampRad + lipThick + whExtraRad     , 0           ],
                    [ lampRad + lipThick + taperHeight    , taperHeight ],
                    [ lampRad + lipThick + taperHeight + 1, taperHeight ],
                    [ lampRad + lipThick + taperHeight + 1, 0           ],
                    [ lampRad + lipThick + whExtraRad     , 0           ]],
              paths =[[0,1,2,3,4,0]] );
}  

module cavity()
{ translate( [0,0,taperHeight-overlap] )
   rotate_extrude()
    union()
      { intersection()
          { translate( [lampRad,sqrt(2) * lampHeight,0] )
              scale( [ 1,sqrt(2) * lampHeight/bowlGap,1 ] )
                circle( d = (bowlGap * 2) );
            polygon(points=[[           lampRad, -1          ],
                            [           lampRad,  lampHeight ],
                            [ bowlGap + lampRad,  lampHeight ],
                            [ bowlGap + lampRad, -1          ]],
              paths =[[0,1,2,3,0]] );
          }
        polygon(points=[[       0, 0          ],
                        [ lampRad, 0          ],
                        [ lampRad, lampHeight ],
                        [       0, lampHeight ]],
                paths =[[0,1,2,3,0]] );
      }
}

module lip()
{ linear_extrude( lampHeight + taperHeight-overlap )
    circle( d = cupDia );
}

module base()
{ linear_extrude( lampHeight - lipHeight + taperHeight-overlap )
    circle( d = cupDia + shoulderDepth * 2 );
}


// Waffle like cuts to make removal from build plate easier
texDepth      =   2;
texLine       =   1;
texC2C        =   5;
texWidth      = texC2C/sin(60)-texLine;

module texture( w=100, d=100, h=1 )
{ vo = sin(60)*2;
  for ( i = [0:texC2C:w/2] )
    for ( j = [-d/2:texC2C*vo:d/2] )
      translate( [i,j,0] )
        textureCone( h );
  for ( i = [0+texC2C/2:texC2C:w/2] )
    for ( j = [-d/2+texC2C*vo/2:texC2C*vo:d/2] )
      translate( [i,j,0] )
        textureCone( h );
    
  for ( i = [0:-texC2C:-w/2] )
    for ( j = [-d/2:texC2C*vo:d/2] )
      translate( [i,j,0] )
        textureCone( h );
  for ( i = [-texC2C/2:-texC2C:-w/2] )
    for ( j = [-d/2+texC2C*vo/2:texC2C*vo:d/2] )
      translate( [i,j,0] )
        textureCone( h );
}

module textureCone( h=1 )
{ translate( [0,0,-0.001] )
    linear_extrude( height=h,scale=0.5 )
      polygon(points=[[cos(030)*texWidth/2,sin(030)*texWidth/2 ],
                      [cos(090)*texWidth/2,sin(090)*texWidth/2 ],
                      [cos(150)*texWidth/2,sin(150)*texWidth/2 ],
                      [cos(210)*texWidth/2,sin(210)*texWidth/2 ],
                      [cos(270)*texWidth/2,sin(270)*texWidth/2 ],
                      [cos(330)*texWidth/2,sin(330)*texWidth/2 ]],
              paths =[[0,1,2,3,4,5,0]] );
    
}
