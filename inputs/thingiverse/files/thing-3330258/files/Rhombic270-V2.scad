
sz=30;
sa=sz*1.5;
tw = 240;
rounding=2;

 
/////////////////////////////////////////////////////////
// module for making a rhombic dodecahedron /////////////

// here VeryWetPaint has the elegant idea to contruct the 
// Rhombic Dodecahedron by intersecting six rectangular solids 

 module rhomb()
{
    minkowski()
    {
        // take six rectangular solids and intersect them
        intersection()
        {
            rotate([45,0,0])  cube(size=[sa,sz,sz],center=true );
            rotate([-45,0,0]) cube(size=[sa,sz,sz],center=true );

            rotate([0,45,0])  cube(size=[sz,sa,sz],center=true );
            rotate([0,-45,0]) cube(size=[sz,sa,sz],center=true );

            rotate([0,0,45])  cube(size=[sz,sz,sa],center=true );
            rotate([0,0,-45]) cube(size=[sz,sz,sa],center=true );
        }

        // this sphere rounds all of the edges with Minkowski sum
        sphere(r=rounding,$fn=16);
    }
}




module spiral()
{
    PI=3.14159265;
    // generate arc points with radius 20 using list comprehension syntax
    points = [ for (a = [0 : 10 : 270])  [ a*PI/180*sin(a), a*PI/180*cos(a) ] ];
    // use concat() to add one point in the center
    polygon(concat(points, [[0, 0]]));
}

module spiralQuarterCut()
{
    dia=sz/2;
    linear_extrude( height=sa+2, center=true, twist=tw, slices=64 )
    //difference()
    {
        //circle(r=sz);
        difference()
        {
            scale(dia) spiral();
            rotate([0,0,-90]) scale(dia) spiral();
        }
    }
}

// a rotate to make it sit flat
rotate([45,0,0])
//difference()
intersection()
{
    rhomb();
    spiralQuarterCut();
}