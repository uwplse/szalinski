//Screwcup Generator for OpenSCAD v2
//by Hunter Frerich - Jul 2015


//CUSTOMIZER VARIABLES

//set slightly bigger than your nozzle size, 0 for a lid or straight cup
wall_thickness=1.0;

//set to 0 for a lid
cup_height=40.0;

//add 3x wall thickness for a lid
cup_diameter=60.0;

//height of one turn
thread_pitch=12;

//how many turns to make the top and bottom chamfer, also sets minimum (lid) height
turns_to_lock=0.7;

//reduce this if print fails
thread_depth=0.75;

//quality
quality=60;

//////////////////////////////////////////////////

screwcup (thread_pitch, cup_height, quality, cup_diameter, wall_thickness,turns_to_lock);

//////////////////////////////////////////////////

module screwcup(pitch, height, qual, male, wall, chamf) 
{


union()	{

if (2*chamf*pitch >= height){ 

///make top chamfer when height less than both chamfers///

translate([0,0,chamf*pitch-0.001])
linear_extrude(height = chamf*pitch, center = false, convexity = 10, twist = -(360*chamf*pitch/pitch), $fn = qual, scale=((male+1*wall)/male) , slices=chamf*pitch*100/pitch)
translate([thread_depth*((male+0.6*wall)/male), 0, 0])
circle(r = (male/2));

}

else {

///normal make top chamfer///

translate([0,0,height-(chamf*pitch)-0.002])
rotate([0,0,(360*((height-2*(chamf*pitch)))/pitch)])
linear_extrude(height = chamf*pitch, center = false, convexity = 10, twist = -(360*chamf*pitch/pitch), $fn = qual, scale=((male+1*wall)/male) , slices=chamf*pitch*100/pitch)
translate([thread_depth*((male+0.6*wall)/male), 0, 0])
circle(r = ((male/2)));

}

///make center///

translate([0,0,chamf*pitch-0.001])
linear_extrude(height = height-2*(chamf*pitch), center = false, convexity = 10, twist = -(360*((height-2*(chamf*pitch)))/pitch), $fn = qual, scale=(1) , slices=(height-2*(chamf*pitch))*100/pitch)
translate([thread_depth, 0, 0])
circle(r = (male/2));

///make bottom chamfer///

translate([0,0,chamf*pitch])
rotate([180,0,0])
linear_extrude(height = chamf*pitch, center = false, convexity = 10, twist = -(360*((chamf*pitch))/pitch), $fn = qual, scale=((male-1.35*wall)/male), slices=chamf*pitch*100/pitch)
translate([thread_depth, 0, 0])
circle(r = ((male/2)));
		
		}
}

/////////////////////////////////////////////////


