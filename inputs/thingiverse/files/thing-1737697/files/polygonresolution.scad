myfn=128;
r=0.1;
h=0.1;
s=100;

step = 360/myfn;

function circleline(r) = 
	[ for (a=[0 : step : 360 - step]) [ cos(a) * r, sin(a) * r ] ];

function twoD2threeD(V,z) = [ for (v=V) [v[0], v[1], z] ];
    
function scale2D(V,s) = [ for (v=V) [v[0]*s, v[1]*s] ];

scale(s)
{
    // An the middle a simple cylinder:
    cylinder(r=r, h=h/2, $fn=myfn);
    // Behind it a rotated rectangle:
    translate([0,0.3,0])
    {
        rotate_extrude($fn=myfn)
        {
            square([r,h]);
        }
    }
    // On the left side a polyhedron:
    translate([-0.3, 0, 0])
    {
        V=concat(
            twoD2threeD(circleline(r, myfn),0),
            [[0,0,0]],
            twoD2threeD(circleline(r, myfn),h*2),
            [[0,0,h*2]]
            
        );
        F=concat(
            [ for (i=[0 : myfn-1]) [myfn,i,(i<myfn-1)?(i+1):0] ], // floor
            [ for (i=[0 : myfn-1]) [myfn+1+myfn,(i<myfn-1)?(i+1+myfn+1):myfn+1,i+myfn+1] ], // top
            [ for (i=[0 : myfn-1]) [i,i+myfn+1,(i<myfn-1)?(i+1):0] ], // side, lower left triangles
            [ for (i=[0 : myfn-1]) [i+myfn+1,(i<myfn-1)?(i+myfn+2):myfn+1,(i<myfn-1)?(i+1):0] ] // sides, upper right triangles
        );
        polyhedron(V,F);
    }
    // an extruded circle on the right side:
    translate([0.3, 0, 0])
    {
        linear_extrude(height=0.1)
        {
            circle(r=r, $fn=myfn);
        }
    }
    // The problem occurs only with polygon, to be seen in the front:
    translate([0, -0.3, 0])
    {
        linear_extrude(height=0.1)
        {
            V=circleline(r, myfn);
                polygon(V, convexity=2);
        }
    }
    // And it has nothing to do with the resolution of floats, as you can see on the rigth side of it:
    // The same vector with elements multiplied by 10 and scaled 0.1 is better:
    translate([0.3, -0.3, 0])
    {
        linear_extrude(height=0.1)
        {
            V=scale2D(circleline(r, myfn),10);
            scale(0.1)
                polygon(V, convexity=2);
        }
    }
}
