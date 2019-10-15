//use <..\salvador_richter_primitives.scad>

seg = 35;       // [30:1:50]
depth = 40;     // [30:1:50]
dia_marker = 20;// [10:1:30]
n_marker = 4;   // [1:1:10]
wall = 3;       // [2:0.1:5]

difference()
{
    height = n_marker*dia_marker + (n_marker+1)*wall;
    r_corner = wall/2;
    $fn=40;
    
    // the flat parts, starting at center folding one by one
    union()
    {
        rounded_cube([wall,depth,height], rCorner=r_corner, dimensions=2);
        translate([0,depth-wall,0]) 
            rounded_cube([seg,wall,height], rCorner=r_corner, dimensions=2);
        translate([seg-wall,0,0]) 
            rounded_cube([wall,depth,height], rCorner=r_corner, dimensions=2);
        translate([seg-wall,0,0]) 
            rounded_cube([seg,wall,height], rCorner=r_corner, dimensions=2);
        translate([2*(seg-wall),0,0]) 
            rounded_cube([wall,depth,height], rCorner=r_corner, dimensions=2);
        translate([2*(seg-wall),depth-wall,0]) 
            rounded_cube([seg,wall,height], rCorner=r_corner, dimensions=2);
    }
    // the drills for the marker
    for(z = [dia_marker/2+wall:dia_marker+wall:height-(dia_marker/2+wall)])
        translate([2*wall,depth/2,z]) rotate([0,90,0]) cylinder(d=dia_marker, h=3*seg);
}

/*
 * cube with rounded edges and corners, depends on param dimensions
 * outerCube is [X,Y,Z]
 * rCorner is the radius of the edges rounding
 * dimensions 2:   4 edges rounded
 * dimensions 3: all edges rounded corners as well
 */
module rounded_cube(outerCube, rCorner, dimensions=3)
{
    hull()
    {
        for(xPos = [rCorner,outerCube[0]-rCorner])
        {
            for(yPos = [rCorner,outerCube[1]-rCorner])
            {
                if(dimensions==2)
                {
                    translate([xPos,yPos,0]) cylinder(r=rCorner, h=outerCube[2]);
                }
                if(dimensions==3)
                {
                    for(zPos = [rCorner,outerCube[2]-rCorner])
                    {
                        translate([xPos,yPos,zPos]) sphere(r=rCorner);
                    }
                }
            }
        }
    }
}
