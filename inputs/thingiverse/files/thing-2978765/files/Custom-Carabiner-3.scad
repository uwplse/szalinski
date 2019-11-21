// Title: Key Carabiner 
// V3: https://www.thingiverse.com/thing:2978765
// Author: https://www.thingiverse.com/Bikecyclist

// V2: https://www.thingiverse.com/thing:57174
// Author: http://www.thingiverse.com/Jinja
// Last Updated Date: 05-12-13

// V1: https://www.thingiverse.com/thing:38291
// Author: http://www.thingiverse.com/Jinja
// Date: 17/12/2012

/////////// START OF PARAMETERS /////////////////

// the first (smaller) radius
radius1 = 6;    

// the second (larger) radius
radius2 = 11;

// the distance between the centers of the radii
length = 36;    

// the thickness of the body
width = 6; 

// the height of the body
height = 6;     

// the width of the gap that cuts the body
gap = 0.39;     

// the mm width of the bevelled edge
rounded = 1;

/////////// END OF PARAMETERS /////////////////

$fs=0.3*1;
$fa=5*1; //smooth
//$fa=20*1; //rough

bevel = rounded / sqrt(2);
// small finite distance, ensures proper meshing - no need to change this
epsilon = 0.01;

difference ()
{
    loop (radius1, radius2, width, height, length);

	translate([-length, radius2, 0])
        rotate([0, 45, - 45 - atan((radius2 - radius1)/length)])
        {
            cube([height*2, length, gap]);
            cube([gap, length, height*2]);
        }
}


module loop (r1, r2, w, h, l)
{
    ring_section (r1, w, h, 180 - 2 * atan((r2 - r1)/l));

    translate ([-l, 0, 0])
        rotate ([0, 0, 180])
            ring_section (r2, w, h, 180 + 2 * atan((r2 - r1)/l));

    for (i = [-1, 1])
        hull ()
        {
            rotate ([0, 0, -i * atan((r2 - r1)/l)])
                translate ([0, i * (r1 + w/2), 0])
                    rotate ([90, 0, 90 + (i - 1) * 90])
                        linear_extrude (epsilon, convexity = 10)
                            xsection (w, h);
                
            translate ([-l, 0, 0])
                rotate ([0, 0, -i * atan((r2 - r1)/l)])
                    translate ([0, i * (r2 + w/2), 0])
                        rotate ([90, 0, 90 + (i - 1) * 90, 0, 90])
                            linear_extrude (epsilon, convexity = 10)
                                xsection (w, h);
        }
}

module ring_section (r, w, h, a)
{
    difference ()
    {
        rotate ([0, 0, -a/2])
            rotate_extrude (angle = 360, convexity = 10)
                translate ([r + w/2, 0])
                    xsection (w, h);
        
        if (a <= 180)
        {
            for (i = [-1, 1])
                rotate ([0, 0, i * (-90 + a/2)])
                    translate ([-r - w, 0, 0])
                        cube ([2 * (r + w + epsilon), 2 * (r + w + 2 * epsilon), 2 * h], center = true);
        }
        else
        {
            for (i = [-1, 1])
                rotate ([0, 0, i * (-90 + a/2)])
                    translate ([-r - w, i * (r + w + 2 * epsilon)/2, 0])
                        cube ([2 * (r + w + epsilon), (r + w + 2 * epsilon), 2 * h], center = true);
        }
    }
}

module xsection (w, h)
{
    polygon ([
        [-w/2 + bevel, -h/2],
        [-w/2, -h/2 + bevel],
        [-w/2, h/2 - bevel],
        [-w/2 + bevel, h/2],
        [w/2 - bevel, h/2],
        [w/2, h/2 - bevel],
        [w/2, -h/2 + bevel],
        [w/2 - bevel, -h/2],
    ]);
}