use <text_on.scad>
// preview[view:west]

// Make a mold or a solid snowman
mold      = 0; // [0:Snowman,1:Mold]

// Rendering speed, smooth may take hours for the mold.
fast      = 0; // [0:Smooth,1:Fast]

// Which piece of the mold will be rendered
piece     = 0; // [0,90,180,270]

// Relative size of snowman head
top       = 1.0; // [0.1:0.01:10.0]

// Relative size of snowman torso
mid       = 1.5; // [0.1:0.01:10.0]  

// Relative size of snowman bottom
bot       = 2.1; // [0.1:0.01:10.0]

// Relative size of snowman flat spot
flat      = 0.5; // [0.0:0.01:10.0]  

// Degree to which segments overlap 0 = none
overlap   = 0.25; // [0.0:0.01:1.0]   

// Relative size of pour funnel hole
pour      = 0.33; // [0.1:0.01:10.0] 

// Actual size of pour funnel opening (mm)
pourOpen  = 25.4;  

// Desired final height of snowman (mm)
height    = 151.6; 

// Radius of dimple features (mm)
dimpleRad = 0.75;

dimpleRot = 1*45.0;

// Label that goes on the back/bottom
makerMark = "mangocats.com";

makerFont = 5.8;
scHt      = top + bot - flat + (bot+2*mid+top) * ( 1-overlap ); // Scale height
scFact    = height/scHt;  // Scale factor to make actual height 
extra     = 1*0.1;   // Arbitrary extension to prevent minimal fragments
shell     = 1*2.0;   // Shell thickness
jacket    = 1*10.0;  // Water jacket thickness
rodD      = 1*3.0;   // Support rod diameter
rodS      = 1*9.0;   // Support rod spacing
boltD     = 1*7.0;   // Hole for 1/4-20 hardware
boltI     = 1*8.0;   // Inset for hardware holes from edges
hexDepth  = 1*5.0;   // Inset of hex head holder
hexSize   = 1*6.25;  // a little oversized for 7/16", a snug fit when printed
wall      = 1*2.0;   // Minimum mold wall thickness
moldW     = boltD/2+wall*2;    // Mold outer wall minimum thickness
below     = jacket+wall+shell; // Material below the XY plane (and above "height")
moldS     = wall*2;                         // Mold slicing wall thickness
blockR    = bot*scFact+jacket+moldW;        // "radius" of the block
blockH    = height + below + jacket + wall; // height of the block
throat    = top*scFact+below+extra;         // pour throat length
cornerR   = 1*6.0;                          // Radius of corner rounding circle
cornerI   = cornerR*0.707+1.0;              // Inset of corner rounding circle
footR     = 1*15.0;                         // Radius of the foot sphere
footH     = footR*0.29289;                  // How far foot extends beyond face, 45 degree max print overhang
whhR      = 1*11.5;                         // Wick Holder Holder gap radius
whhG      = 1*0.9;                          // Wick Holder Holder gap thickness
whhO      = 1*3.0;                          // Wick Holder Holder overlap radius
whhT      = 1*0.6;                          // Wick Holder Holder overlap thickness

$fn=(fast > 0.5) ? 16 : 149;

if ( mold > 0.5 )
  { quarterBlock(piece);
  }
if ( mold <= 0.5 )
 { snowman();  
 }
 
module quarterBlock( rot=0.0 )
{ difference()
    { translate( [0,0,blockR/2] )
        rotate( [0,90,0] )
          translate( [-blockR/2,-blockR/2,below-blockH/2] )
            rotate( -rot )
              intersection()
                { blockWithCavities();
                  rotate( rot )
                     translate( [0,0,-below-footH-extra] )
                      linear_extrude( blockH+2*(footH+extra) )
                        square( blockR+extra );
                }
       quarterCuts();
    }         
}
    
module blockWithCavities()
{ difference()
    { union()
        { difference()
            { block();
              snowmanJacket();
              snowman();
              waterHole();
            }
          moldWalls();
          pourSleeve();
          rods();  
          feet();
          if ( piece==0 )
            wickHolderHolder();
        }
      boltHoles();
      snowmanPour();
    }
}

module moldWalls()
{ difference()
    { translate( [0,0,-below] )
        { linear_extrude( blockH )
            square( [blockR*2, moldS], center=true );
    
          linear_extrude( blockH )
            square( [moldS, blockR*2], center=true );
        }
      snowman();
      snowmanPour();  
    }
}

module block()
{ difference()
    { translate( [0,0,-below] )
        linear_extrude( blockH )
          square( blockR*2, center=true );
      edgeCuts();
    }
}

module wickHolderHolder()
{ translate( [0,0,-extra] )
    difference()
      { linear_extrude( whhG + whhT + extra, scale = 0.66666666666667 )
          circle( (whhR + whhO) * 1.5 );
        linear_extrude( whhG + extra )
          circle( whhR + whhO );  
        linear_extrude( whhG + whhT + extra * 2 )
          circle( whhR );  
      }
}

module quarterCuts()
{ translate( [ blockH/2+extra/2,-blockR/2,0] )
    rotate( [0,90,180] )
      translate( [0,0,below+extra/2] )
        edgeCutter();  
    
  translate( [-blockH/2-extra/2, blockR/2,blockR] )
    rotate( [180,90,180] )
      translate( [0,0,below+extra/2] )
        rotate( [0,0,90] )
          edgeCutter();  
    
  translate( [ blockH/2, blockR/2,0] )
    shortEdgeCutter();  
  translate( [-blockH/2, blockR/2,0] )
    rotate( 90 )
      shortEdgeCutter();  
  translate( [-blockH/2,-blockR/2,0] )
    rotate( 180 )
      shortEdgeCutter();  
  translate( [ blockH/2,-blockR/2,0] )
    rotate( 270 )
      shortEdgeCutter();  

  translate( [ blockH/2,0,0] )
    shortEndCutter();
  translate( [-blockH/2,0,0] )
    rotate( [0,90,0] )
      shortEndCutter();
  translate( [-blockH/2,0,blockR] )
    rotate( [0,180,0] )
      shortEndCutter();
  translate( [ blockH/2,0,blockR] )
    rotate( [0,270,0] )
      shortEndCutter();

}

module edgeCuts()
{ translate( [-blockR,-blockR,0] )
    rotate( 180 )
      edgeCutter();
    
  translate( [ blockR, blockR,0] )
    edgeCutter();
    
  translate( [-blockR, blockR,0] )
    rotate( 90 )
      edgeCutter();
    
  translate( [ blockR,-blockR,0] )
    rotate( 270 )
      edgeCutter();
}

module shortEndCutter()
{ rotate( [270,0,0] )
    translate( [0,0,-blockR] )
      shortEdgeCutter();  
}    

module shortEdgeCutter()
{ intersection()
    { edgeCutter();
      translate( [0,0,-below-extra] )
        linear_extrude( blockH+extra*2 )
          square( cornerR*0.83, center=true );
    }
}

module edgeCutter()
{ translate( [0,0,-below-extra/2] )
    linear_extrude( blockH+extra )
      translate( [-cornerI,-cornerI] )
        difference()
          { square( cornerR );
            circle( cornerR );
          }
}

module boltHoles()
{ boltHoleSet();
  rotate( 90 )
    translate( [0,0,-boltD-wall] )
      boltHoleSet();
}

module boltHoleSet()
{ boltHolePair();
  translate( [0,0,height] )
    boltHolePair();
}

module boltHolePair()
{ translate( [boltI-blockR,blockR+extra/2,boltI-jacket/2] )
    boltHole( flip=1 );
  translate( [blockR-boltI,blockR+extra/2,boltI-jacket/2] )
    boltHole( flip=0 );
}

module boltHole( flip=0 )
{ rotate( [90,0,0] )
    union()
      { linear_extrude( blockR*2+extra )
          circle(boltD/2);
        translate( [0,0,(flip > 0.5) ? blockR*2+extra:0] )
          Hexagon( h=hexDepth, A=hexSize );
      }
}

module rods()
{ intersection()
    { rodMask();
      rodSets();
    }
}

module rodSets()
{ rodSet();
  rotate( 90 )
    { rodSet();
      rotate( 90 )
        { rodSet();
          rotate( 90 )
            rodSet();
        }
    }
}
module rodSet()
{ extraGap = ( fast > 0.5 ) ? rodS*2 : 0;
    
  for ( x = [wall+rodD:rodS+extraGap:blockR] )
    for ( z = [wall+rodD-jacket:rodS*2*sin(60)+extraGap:height+jacket] )
      translate( [x,0,z] ) 
        rod();
  for ( x = [wall+rodD+rodS*0.5:rodS+extraGap:blockR] )
    for ( z = [wall+rodD-jacket+rodS*sin(60):rodS*2*sin(60)+extraGap:height+jacket] )
      translate( [x,0,z] ) 
        rod();    
}

module rod()
{ $fn=16;
  rotate( [90,0,0] )
    linear_extrude( blockR )
      circle(rodD/2);
}

module rodMask()
{ difference()
    { snowman( (jacket+extra)/scFact );
      snowman( (shell-extra)/scFact );
    }
}   
    
module snowmanJacket()
{ difference()
    { snowman( jacket/scFact );
      snowman( shell/scFact );
    }
}   

module snowmanShell()
{ difference()
    { snowman( shell/scFact );
                
      snowman();
    }
}   

module feet()
{ translate( [ 0,0,-below ] )
    footSet();
  translate( [ 0,0,blockH-below ] )
    rotate( [180,0,0] )
      footSet();
}

module footSet()
{ footI = footR * 0.8;
  translate( [ blockR-footI, blockR-footI,0] )
    foot();
  translate( [-blockR+footI, blockR-footI,0] )
    foot();
  translate( [-blockR+footI,-blockR+footI,0] )
    foot();
  translate( [ blockR-footI,-blockR+footI,0] )
    foot();    
  translate( [ footI, blockR/2,0 ] )
    foot();
  translate( [-footI, blockR/2,0 ] )
    foot();
  translate( [ footI,-blockR/2,0 ] )
    foot();
  translate( [-footI,-blockR/2,0 ] )
    foot();
  translate( [ blockR/2, footI,0 ] )
    foot();
  translate( [ blockR/2,-footI,0 ] )
    foot();
  translate( [-blockR/2, footI,0 ] )
    foot();
  translate( [-blockR/2,-footI,0 ] )
    foot();
}

module foot()
{ translate( [0,0,extra] )
    difference()
      { translate( [0,0,footR-footH-extra] )
          sphere( footR );
        linear_extrude( footR*2 )
          square( (footR+extra)*2, center=true );  
      }
    
}

module waterHole()
{ translate( [0,0,-below-extra] )
    linear_extrude( jacket/2 )
      circle(wall+pourOpen/2);
}

module pourSleeve()
{ difference()
    { union()
        { translate( [0,0,blockH-below-throat] )  
            linear_extrude( throat )
              circle(pour*scFact+wall);
          translate( [0,0,blockH-below+extra] )
            rotate( [180,0,0] )  
              linear_extrude( pourOpen/2+wall*1.414,scale=0.0 )
                circle(pourOpen/2+wall*1.414);
        }
      snowman();  
      snowmanPour();
    }
}

module snowmanPour()
{ translate( [0,0,blockH-below-throat] )  
    linear_extrude( throat )
      circle(pour*scFact);
  
  translate( [0,0,blockH-below+extra] )
    rotate( [180,0,0] )  
      linear_extrude( pourOpen/2,scale=0.0 )
        circle(pourOpen/2);
}
    
module snowman( puff=0.0 )
{ scale( scFact )
    difference()
      { translate ( [0,0,bot-flat] )
          { difference()
              { sphere( bot + puff );
                if ( puff==0.0 )
                  { bottomDimples();
                    # rotate( [0,90,dimpleRot] )
                      text_on_sphere( makerMark, r=bot, size=makerFont/scFact, extrusion_height=1/scFact, spacing=1.02, center=true, rounded=true, font="Liberation Bold" );
                  }  
              }
            translate ( [0,0,(bot+mid) * (1-overlap) ] )
              { difference()
                  { sphere( mid + puff );
                    if ( puff==0.0 )
                      torsoDimples();
                  }
                translate ( [0,0,(mid+top) * (1-overlap) ] )
                  difference()
                    { sphere( top + puff );
                      if ( puff==0.0 )
                        faceDimples();
                    }
              }
          }
        translate( [0,0,-flat-puff-extra] )
          linear_extrude( flat+extra )
            circle( bot + puff );
      }
}

module bottomDimples()
{ rotate( dimpleRot )
  union()
    { rotate( [ 45,0,0] )
        dimple(bot);
    }
}

module torsoDimples()
{ rotate( dimpleRot )
  union()
    { dimple(mid);
        
      rotate( [ 20,0,0] )
        dimple(mid);
        
      rotate( [-20,0,0] )
        dimple(mid);
    }
}

module faceDimples()
{ rotate( dimpleRot )
  union()
    { dimple(top); // Nose
    
      rotate( [20,0,15] ) // Left Eye
        dimple(top);

      rotate( [20,0,-15] ) // Right Eye
        dimple(top);

      rotate( [-21,0,0] ) // Mouth
        dimple(top);
    
      rotate( [-19.5,0, 9.7] )
        dimple(top);
    
      rotate( [-19.5,0,-9.7] )
        dimple(top);
    
      rotate( [-15,0, 18] )
        dimple(top);
    
      rotate( [-15,0,-18] )
        dimple(top);
    }
}

module dimple( part=1.0 )
{ $fn=16;
  sdr = dimpleRad/scFact;
  translate( [0,part,0] )
    sphere( sdr );
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

// 6 sides
module Hexagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=6,A=A,R=R,S=S,h=h,debug=debug);}
