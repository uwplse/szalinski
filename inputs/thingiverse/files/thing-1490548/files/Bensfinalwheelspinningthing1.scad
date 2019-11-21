outer_diameter=50;
wall_thickness=2;
thickness=5;
spokes=3;
spoke_thickness=16;
spoke_width=3;
hub_thickness=16;
axle=7;

//	How many to make?
//########################################################
number_x=4;	// Along the x-axis
number_y=2;	// Along the y-axis
//########################################################

//outer_diameter=50, axle=4, spokes=3, wall_thickness=2, thickness=5, spoke_thickness=thickness/2, spoke_width=5, hub_thickness=4

$fn=200;


module wheel()
{






difference()
{

union()
{

//########################################################
// Outer Ring
//########################################################


//########################################################
// Hub
//########################################################

cylinder(r=axle/2+wall_thickness, h=hub_thickness );

//########################################################
// Spokes
//########################################################
//cylinder(r=0.30*outer_diameter, h=2 );

for (i=[0:spokes-1])
{

rotate([0,0,(360/spokes)*i])
translate([-spoke_width/2,0,0])
cube([spoke_width,outer_diameter/2-wall_thickness,spoke_thickness]);


}

// Axle Hole.
}
translate([0,0,-1])
cylinder(r= axle/2, h=hub_thickness+2);
}
}

//#######################################################
//	Make some!
//#######################################################


for (i=[0:number_x-1], j=[0:number_y-1])
{
translate([i*(outer_diameter+wall_thickness),j*(outer_diameter+wall_thickness),0])
wheel();
}

{

//cylinder(r=0.30*outer_diameter, h=2 );

}