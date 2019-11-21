
// Inner radius of the loops
innerRadius = 5;

// Outer radius of the loops
outerRadius = 7;

// Width of the entire spring
width=30;

// Number of loop pairs
loops=5;

// Height of the spring
height=7;

// Number of segments in curves
$fn=20;

linear_extrude(height)
difference()
{
    union()
    {
        for(i=[0:loops])
        {
            translate([i*(outerRadius-(outerRadius-innerRadius)/2)*2,0,0])
            {
                square([outerRadius,width-outerRadius*2],center=true);
                translate([0,width/2-outerRadius,0])
                    circle(d=outerRadius);
                translate([outerRadius-(outerRadius-innerRadius)/2,-(width/2-outerRadius),0])
                    circle(d=outerRadius);
            }
        }
    }
    union()
    {
        for(i=[0:loops])
        {
            translate([i*(outerRadius-(outerRadius-innerRadius)/2)*2,0,0])
            {
                square([innerRadius,width-outerRadius*2],center=true);
                translate([0,width/2-outerRadius,0])
                    circle(d=innerRadius);
                translate([outerRadius-(outerRadius-innerRadius)/2,-(width/2-outerRadius),0])
                    circle(d=innerRadius);
                translate([outerRadius-(outerRadius-innerRadius)/2,0,0])
                    square([innerRadius,width-outerRadius*2],center=true);
            }
        }
        translate([loops*(outerRadius-(outerRadius-innerRadius)/2)*2,0,0])
        {
            translate([outerRadius,0,0])
                square([outerRadius,width],center=true);
            translate([outerRadius-(outerRadius-innerRadius)/2,-width+outerRadius,0])
                square([outerRadius,width],center=true);
        }
    }
}