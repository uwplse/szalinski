//All units in mm.

//Total height of the holder.
total_height=50; //[0:100]

//Diameter of the pen. 
pen_diameter=10; //[5:50]

//Diameter of the magnets. Must not be larger than the pen diameter!
magnet_diameter=10; //[1:20]

//Height of the magnets. This also changes the thickness of the back wall.
magnet_height=1; //[1:20]

//Calculate outer wall (2mm)
outer_diameter=pen_diameter+4;

rotate([0,0,-90])
difference()
{
difference()
{
linear_extrude(height=total_height,convexity=10)
union()
{
circle(r=(outer_diameter/2), $fn=64);
translate([-(outer_diameter/2),0,0])
square([outer_diameter,magnet_height+(outer_diameter/2)]);
}


translate([0,0,2])
linear_extrude(height=total_height,convexity=10)
circle(r=(pen_diameter/2)+0.5, $fn=64);
}

translate([0,outer_diameter/2,(magnet_diameter/2)+2])
rotate([-90,0,0])
cylinder(h=magnet_height+1,r=(magnet_diameter/2)+0.25,$fn=32);

translate([0,outer_diameter/2,total_height-((magnet_diameter/2)+2)])
rotate([-90,0,0])
cylinder(h=magnet_height+1,r=(magnet_diameter/2)+0.25, $fn=32);

}

