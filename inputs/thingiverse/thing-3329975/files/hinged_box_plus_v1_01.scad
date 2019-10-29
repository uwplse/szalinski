
// v1.01 2019-01-09

$fn = 50;

// Determines whether it's a hinged box or not. 0 or 1.
makeHinge = 1;

// Determines whether there is a notch that makes it easier to open the box. 0 or 1.
makeNotch = 1;

// Width of box
width = 40.0;

// Depth of box
depth = 60.0;

// ATTN: If bottomHeight != topHeight then you will need base layer supports
// Bottom interior space is bottomHeight - wallThickness + lipHeight
bottomHeight = 14.0;

// ATTN: If bottomHeight != topHeight then you will need base layer supports
 // Must be >= wallThickness + lipHeight
topHeight = 6.0;

// wall, floor, and ceiling thickness.
wallThickness = 2.0;

// Height of the lip
lipHeight = 2.0;

hingeOuter = 3.0;
hingeInner = 1.0;
fingerSize = 7.0;

hingeInnerSlop = .4;
hingeFingerSlop = .1;

fingerLength = hingeOuter/1.65;

topFingerSize = fingerSize;
pos = -depth/2;

z = 0;

lipSlop = 0.1;

// as a fraction of wall thickness
lipThicknessFraction = 0.5; 

notchWidth = depth/2.0;
notchHeight = 2.0;
notchDepth = wallThickness/2.0;

gap = 0.02; // slop between top and bottom 


module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}



// half open
//debugClosedPercent=50;

// almost shut. test closure clearance.
//debugClosedPercent=98.5;

// closed.
//debugClosedPercent=100;

// print with value of 0;
debugClosedPercent=0;


////////////////////////////////////////////////
////////////////////////////////////////////////


if ( bottomHeight != topHeight )
{
    echo("<font color='red'>This will need base layer supports because the top and bottom are different
    heights and you have a hinge.</font>");
}

lipThickness = wallThickness - ( wallThickness * lipThicknessFraction );
angle = debugClosedPercent/100*(-180);

if (angle != 0 ) 
{
    rotate_about_pt( [ 0, angle, 0 ], 0, [0,0,bottomHeight]) top();
//   translate([0, 0, bottomHeight * 2]) rotate([0,printAngle,0]) top();
} 
else 
{
    if ( makeHinge == 0 )
        translate([0, 0, topHeight - bottomHeight ]) top();
    else
        translate([0, 0, 0]) top();
}

bottom();

module bottom() 
{
	union() 
    {
		// main box and cutout
		difference() 
        {

            union()
            {
                // main box
                translate([-width - fingerLength, -depth/2, 0]) 
                {
                    cube([width,depth,bottomHeight]);
                }

                // lip cavity
				translate([ -width - fingerLength + lipThickness + lipSlop/2 ,
				            -depth/2 + lipThickness + lipSlop/2,
                            0]) 
                {
                    cube([  width - 2*(lipThickness ) - lipSlop,
                            depth - 2*(lipThickness ) - lipSlop,
                            bottomHeight + lipHeight]);
                }
            }



            // main cavity
            translate([ (-width - fingerLength) + wallThickness, 
                        -depth/2 + wallThickness, 
                        wallThickness]) 
            {
                cube([  width - (wallThickness * 2), 
                        depth - (wallThickness * 2), 
                        bottomHeight + lipHeight ]);
            }
			

            if ( makeNotch )
            {
			            // notch
                translate([-width - fingerLength, -notchWidth/2, bottomHeight - notchHeight]) 
                {
                    cube([notchDepth, notchWidth, notchHeight]);
                }

                // if no hinge, make a notch on other side as well
                if ( !makeHinge )
                {
                    translate([ 0 - fingerLength - notchDepth, -notchWidth/2, bottomHeight - notchHeight]) 
                    {
                        cube([notchDepth, notchWidth, notchHeight]);
                    } 
                }
            }		
		}


        if ( makeHinge )
        {
            difference() 
            {
                hull() 
                {
                    translate([0,-depth/2,bottomHeight]) 
                    {
                        rotate([-90,0,0]) 
                        {
                            cylinder(r = hingeOuter/2, h = depth);
                        }
                    }

                    translate([-fingerLength - .5, -depth/2,bottomHeight - hingeOuter])
                    {
                        cube([.1,depth,hingeOuter- 1]);
                    }

                    translate([-fingerLength, -depth/2,bottomHeight-.1])
                    {
                        //cube([fingerLength,depth,.1]);
                    }

                    translate([0, -depth/2,bottomHeight])
                    {
                        rotate([0,45,0]) 
                        {
                            cube([hingeOuter/2,depth,.01]);
                        }
                    }
                }
                // finger cutouts

                for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) 
                {
                    translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) 
                    {
                        cube([fingerLength*2,fingerSize + hingeFingerSlop,bottomHeight*2]);
                    }
                }
            }

            // center rod
            translate([0, -depth/2, bottomHeight]) 
            {
                rotate([-90,0,0]) 
                {
                    cylinder(r = hingeInner /2, h = depth);
                }
            }
        }
	}
}
	



module top() 
{
	union() 
    {
		difference() 
        {

            // main box
             translate([fingerLength, -depth/2, bottomHeight-topHeight]) 
             {
                 cube([width,depth,topHeight - gap]);
             }
			
	
            union()
            {
                translate([ fingerLength + wallThickness,
                            -depth/2 + wallThickness,
                            wallThickness + bottomHeight - topHeight]) 
                {
                    cube([  width - (wallThickness) * 2, 
                            depth - (wallThickness) * 2, 
                            topHeight]);
                }

            	// lip
    			translate([ fingerLength + lipThickness,
				            -depth/2 + lipThickness,
				            bottomHeight - lipHeight - gap - lipSlop])
                {
					cube([  width - 2*(lipThickness),
					        depth - 2*(lipThickness),
					        lipHeight + gap + lipSlop ]);
				}
            }
		}

        if ( makeHinge )
        {
            difference() 
            {
                hull() 
                {
                    translate([0,-depth/2,bottomHeight]) 
                    {
                        rotate([-90,0,0]) 
                        {
                            cylinder(r = hingeOuter/2, h = depth);
                        }
                    }

                    translate([fingerLength, -depth/2,bottomHeight - hingeOuter - 0])
                    {
                        cube([.1,depth,hingeOuter - .5]);
                    }

                    translate([-fingerLength/2, -depth/2,bottomHeight-.1])
                    {
                        cube([fingerLength,depth,.1]);
                    }

                    translate([0, -depth/2,bottomHeight])
                    {
                        rotate([0,45,0]) 
                        {
                            cube([hingeOuter/2,depth,.01]);
                        }
                    }
                }
                // finger cutouts
                for  (i = [-depth/2:fingerSize*2:depth/2 + fingerSize]) 
                {
                    translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) 
                    {
                        cube([fingerLength*2,fingerSize + hingeFingerSlop,bottomHeight*2]);
                    }
                    if (depth/2 - i < (fingerSize * 1.5)) 
                    {
                        translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) 
                        {
                            cube([fingerLength*2,depth,bottomHeight*2]);
                        }
                    }
                }

                // center cutout
                translate([0, -depth/2, bottomHeight]) 
                {
                    rotate([-90,0,0]) 
                    {
                        cylinder(r = hingeInner /2 + hingeInnerSlop, h = depth);
                    }
                }
            }
		}
	}
}
