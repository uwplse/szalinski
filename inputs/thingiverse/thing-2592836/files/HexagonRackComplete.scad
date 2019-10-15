

  wallwidth = 1;
    radius = 10;
    height = 13;
    countX = 10;
    countY = 10;

    union() {
        for (j = [0 : countX - 1]) {
            for(i = [0 : countY - 1]) {
      
                 translate([((radius) * 2 - wallwidth) * sin(60) * j, (radius * 2 - wallwidth) * i + ( (j % 2) * (radius - wallwidth / 2)), 0]) {
                    
                    difference() {
 //                       linear_extrude(height) {
                            difference(){
                                Hexagon(A=radius,h=height);
                                Hexagon(A=(radius - wallwidth),h=height);
                            }
    //                    }

                        translate([0,0,-height * 1/3])difference() {
//                            linear_extrude(height) {
                                Hexagon(A=radius,h=height);
  //                          }
                            
                           translate([0,0,height])rotate([0,45,0])cube([height, radius*2,height], center=true);
                        }
                    }
                }
            }
        }
    }   
    
    
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
			#cylinder(r=A,h=h+1,center=false,$fn=150);
			%cylinder(r=R,h=h+1,center=false,$fn=150);
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
				#cylinder(r=A,h=h+1,center=false,$fn=150);
				%cylinder(r=R,h=h+1,center=false,$fn=150);
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
					#cylinder(r=A,h=h+1,center=false,$fn=150);
					%cylinder(r=R,h=h+1,center=false,$fn=150);
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
					%cylinder(r=R,h=h+1,center=false,$fn=150);
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
		cylinder(r=R,h=h,$fn=N,center=false);
	}
	else
	{
		// 2D primitive h=0
		circle(r=R,$fn=N,center=false);
	}
}

// 6 sides
module Hexagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=6,A=A,R=R,S=S,h=h,debug=debug);}
