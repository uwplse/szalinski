/////VARIABLES/////

stemHeight=110; //[90:Short, 110:Medium, 130:Tall]

rimThickness=80; //[77:Thin, 80:Medium, 83:Thick]

/////RENDERS/////////////////////////////////////////////////////////////
rotate_extrude(convexity=10, $fn=100)

mirror([1,0,0])
rotate([0,0,90])
translate([2.5,0,0])
union()
{
//body
rotate(90,[0,0,0])
difference()
{
//base
square([stemHeight,50]);
//extended base
translate([80,5,0])
square(50);
//top cutout
translate([rimThickness,50,0])
    circle(45, $fn=100);
//bottom cutout
translate([-15,47,0])
    circle(45, $fn=100);
}
//bottom ball
translate([0,2.4,0])
circle(2.2, $fn=50);
//top ball
translate([stemHeight,2.5,0])
circle(2.5, $fn=50);
}