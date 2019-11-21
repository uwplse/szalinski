module flatstuff()
{
translate([11,0,0])square([33,22]);
translate([11,11,0]) circle(11);
}
linear_extrude(height = 75) flatstuff();