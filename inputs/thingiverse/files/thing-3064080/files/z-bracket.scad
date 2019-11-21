use <scad-utils/morphology.scad>

$fn = 100;
wall = 3;
width = 30;
length = 40;
height = 44; // 43.2mm

difference()
{
    rotate([90,0,0])
    {
        // z-shaped bracket
        translate([0,0,wall])
        linear_extrude(height=width, convexity=5) rounding(r=0.7) fillet(r=0.7)
        {
            polygon(points=[
                [0,0],[length,0],
                [length,height],[2*length,height],
                [2*length,height+wall],[length-wall,height+wall],
                [length-wall,wall],[0,wall]
            ]);
        }
    }

    // countersunk woodscrew hole
    rotate([0,0,90]) translate([-(width+2*wall)/2,-(length-wall)/2,-0.5]) cylinder(r1=1.5,r2=4,h=wall+1);
}
