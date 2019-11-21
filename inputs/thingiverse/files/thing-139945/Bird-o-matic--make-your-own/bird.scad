// Better use "fast" when tuning your bird, then "hi" to print it
precision="low"; // [low,med,hi]

// Length of the beak
beak_length= 15; // [0:50]
// Ratio relative to the head size
beak_size= 100; // [20:100]
// Width of the beak tip (0 is pointy)
beak_width= 0; // [0:25]
// Shape of the beak tip (lowest is flat)
beak_roundness= 10; // [10:200]

// Head diameter
head_size=22; // [10:40]
// Horizontal distance from head to main body
head_to_belly=32; // [-20:50]
// Size of the eyes
eye_size=0; // [0:20]
// Head lateral offset
head_lateral_offset=4; // [-15:15]
// Head vertical height
head_level=32; // [0:80]
// Head horizontal rotation
head_yaw=10; // [-45:45]
// Head vertical rotation (positive is upwards)
head_pitch=9; // [-80:45]

// How long is the front body
belly_length=60; // [10:100]
// Belly section size
belly_size=40; // [20:60]
// Additional fatness ratio
belly_fat=90; // [50:150]

// Distance from main body center to bottom center
belly_to_bottom=25; // [1:50]
// Bottom diameter
bottom_size=25; // [5:50]

// Tail length
tail_length= 50; //[0:100]
// How large is the tail
tail_width= 22; // [1:50]
// Tail horizontal rotation
tail_yaw=-5; // [-45:45]
// Tail vertical angle (positive is upwards)
tail_pitch=40; // [-45:90]
// How round is the tail (lowest is flat)
tail_roundness=80; // [10:200]

// How to cut the base of the object (-1 to disable, then use your own slicer options)
base_flat= 50; // [-100:100]

$fa= ( precision=="low" ? 10 : ( precision=="med" ? 5 : 3) );
$fs= ( precision=="low" ? 8 : ( precision=="med" ? 3 : 1.8) );
total_len= beak_length+head_to_belly+belly_to_bottom+tail_length;

module chained_hull()
{
	for(i=[0:$children-2])
		hull()
			for(j=[i,i+1])
				child(j);
}

module skull()
{
	sphere(r=head_size/2);
}

module head()
{
	skull();
	if(eye_size>1)
		for(y=[-1,+1])
			scale([1,y,1])
				rotate([50,-40,0])
					translate([0,0,head_size/2-eye_size/8])
						scale([1,1,0.5])
							sphere(r=eye_size/2, $fs=1);

	scale([1, beak_size/100, beak_size/100])
		hull()
		{
			skull();
			rotate([0,15,0])
				translate([-beak_length-head_size/2,0,0])
					scale([beak_roundness/100,1,1])
						cylinder(r=beak_width?beak_width:0.1,h=0.1); // nose
		}
}

translate([0,0,bottom_size/2])
difference()
{
	translate([-head_to_belly,0,0])
	union()
	{
		translate([0,head_lateral_offset,head_level])
			rotate([0,head_pitch,head_yaw])
				head();

		chained_hull()
		{
			translate([0,head_lateral_offset,head_level])
				sphere(r=head_size/2);

			translate([head_to_belly,0,0])
				scale([belly_length/belly_size,belly_fat/100,1])
					sphere(r=belly_size/2);

			translate([head_to_belly+belly_to_bottom,0,0])
					sphere(r=bottom_size/2);

			if(tail_length && tail_width && tail_roundness)
			translate([head_to_belly+belly_to_bottom,0,0])
				rotate([0,-tail_pitch,tail_yaw])
					translate([tail_length,0,0])
						scale([tail_roundness/100,1,1])
							cylinder(r=tail_width,h=0.1);
		}
	}
	if(base_flat!=-100)
		translate([-total_len*5,-total_len*5,belly_size*(-1.5 + base_flat/200) ])
			cube([total_len*10,total_len*10,belly_size]);
}
