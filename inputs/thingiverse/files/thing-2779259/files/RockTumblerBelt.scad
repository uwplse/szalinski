/*
Round Beld generator
by Bob Marchese
*/

// Belt thickness
t = 3;

// Pulley #1 radius (mm)
p1 = 35; 

// Pulley #2 radius (mm)
p2 = 10;

// Distance between axels
d = 75;

// Cross Section
cross_section = "circle"; // [circle,octagon]

/* [Hidden] */
$fn=96;
PI=3.14159265358979323846;
function belt_length(R, r, d) = 2*d + PI*(R+r) + (R-r)*(R-r)/d;

// compute the radius for printing
pr = belt_length(p1,p2,d)/(2*PI);
echo(str("computed belt lenght is ", belt_length(p1,p2,d)));

// generate the torus
if (cross_section == "circle") 
{
    echo(str("rotate_extrude() translate([",pr,",0,0]) circle(r=",t/2,");"));
    rotate_extrude() translate([pr,0,0]) circle(r=t/2);
}
else
{
    echo(str("rotate_extrude() translate([",pr,",0,0]) rotate([0,0,22.5]) circle(r=",t/2,",$fn=8);"));
    rotate_extrude() translate([pr,0,0]) rotate([0,0,22.5]) circle(r=t/2, $fn=8);
}
