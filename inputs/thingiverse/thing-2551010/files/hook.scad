wall = 3;       // [2:0.5:5]
depth = 15;     // [5:1.0:30]
monitor = 26;   // [5:0.5:50]
hook = 15;      // [5:1.0:100]
width = 20;     // [5:1.0:50]
hook_type="simple"; // [simple,side]
print_orientaion="no"; // [yes,no]

choose();

module choose()
{
    if(hook_type=="simple")
    {
        simple();
    }
    else
    {
        if(print_orientaion=="yes")
        {
            translate([0,0,width+depth+hook]) rotate([0,90,0]) side_hook();
        }
        else
        {
            side_hook();
        }
    }
}

module simple()
{
    r_corner = wall/2;
    $fn=20;
    
    rounded_cube([wall,depth+wall,width], rCorner=r_corner, dimensions=2);
    translate([0,depth,0]) rounded_cube([monitor+2*wall,wall,width], rCorner=r_corner, dimensions=2);
    translate([monitor+wall,0,0]) rounded_cube([wall,depth+wall,width], rCorner=r_corner, dimensions=2);
    translate([monitor+wall,0,0]) rounded_cube([hook+2*wall,wall,width], rCorner=r_corner, dimensions=2);
    translate([monitor+2*wall+hook,0,0]) rounded_cube([wall,depth+wall,width], rCorner=r_corner, dimensions=2);
}

module side_hook()
{
    r_corner = wall/2;
    $fn=20;
    
    difference()
    {
        rounded_cube([width+depth+hook,monitor+2*wall,depth], rCorner=r_corner, dimensions=3);
        translate([0,wall,-wall]) cube([width+depth+hook,monitor,depth]);
        hook_cut();
    }
    hook();
}

module hook()
{
    r_corner = wall/2;
    $fn=20;

    difference()
    {
        intersection()
        {
            rounded_cube([width+depth+hook,monitor+2*wall,depth], rCorner=r_corner, dimensions=3);
            hook_cut();
        }
        translate([0,0,wall]) hook_cut();
    }
}

module hook_cut()
{
    s=depth/2+wall;
    translate([depth/2+hook,2*monitor,depth]) tri_angle(s, -s, 3*monitor, direction=2);
    translate([depth/2,2*monitor,depth]) tri_angle(-s, -s, 3*monitor, direction=2);
    translate([depth/2-0.001,-monitor,depth/2-wall]) cube([hook+0.002,3*monitor,s]);
}

/*
 * rectangular tri angle, with height
 * directions 1-3: the rect angle is located at coordinates 0,0,0
 * direction 0: default, legacy, the rect angle is at x,0
 * negative values changes direction
 * direction 1: xy
 * direction 2: xz
 * direction 3: yz
 */
module tri_angle(a, b, wall, direction=0)
{
    myPoints=[
    [[0,0],[a,0],[a,b]],
    [[0,0],[a,0],[0,b]],
    [[0,0],[a,0],[0,b]],
    [[0,0],[a,0],[0,b]]
    ];
    myRotate=[
    [0,0,0],
    [0,0,0],
    [90,0,0],
    [90,0,90]
    ];
    
    rotate(myRotate[direction])
        linear_extrude(height = wall) 
            polygon( points=myPoints[direction]);
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
