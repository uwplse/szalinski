outer_r = 4.0; // mm
width = 1.0; // mm
inner_r = 2.0; // mm

$fa = 1.0;
$fs = 0.1;

difference()
{
    cylinder(h=width, r=outer_r, center=true);
    cylinder(h=width+1.0, r=inner_r, center=true);
}