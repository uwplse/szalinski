use <utils/build_plate.scad>

sides = 4; //[3:20]
segments = 8; //[3:100]
mesh_quality = 3; //[3:20]

tube_diameter = 3; 
width_of_band = 10; //[0:50]
height_of_band = 10; //[0:100]
inside_diameter = 60; //[0:200]

rotate_all_sides_angle = 0; 
full_twists_per_rotation = 0; 
tube_offset_per_segment = 0; //[-15:15]

segment_twist_variation_angle = 0; //[0:180]
segment_twist_variation_periods = 2; //[1:20]

face_twist_variation_angle = 0; //[0:180]
face_twist_variation_periods = 2; //[1:20]

face_rotational_variation_angle = 0;//[0:90]
face_rotational_variation_periods = 2; //[1:20]

segment_spacing_variation_angle = 0;//[0:90]
segment_spacing_variation_periods = 2; //[1:20]

z_shift_length = 0;
z_shift_period = 2; //[1:20]

radial_shift_length = 0;
radial_shift_periods = 2; //[1:20]

scale_segment_variation_max = 1;
scale_segment_variation_min = 1;
scale_segment_variation_periods = 4; //[1:20]

level_of_solid_fill = "hollow"; //[hollow,partial fill,solid fill]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

dist_from_center = inside_diameter/2+width_of_band/2+tube_diameter/2;

translate([0,0,-(height_of_band+tube_diameter)/2])
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

union(){
	for (i=[0:segments-1]){
		if (level_of_solid_fill == "partial fill"){
			color("FireBrick")
			makeNSidedBlock(sides,
								 	tube_diameter,
									width_of_band,
									height_of_band,
									360/segments*i,
									dist_from_center,
									i);
		}
		else {
			color("FireBrick")
			makeNSidedTube(sides,
								 	tube_diameter,
									width_of_band,
									height_of_band,
									360/segments*i,
									dist_from_center,
									i);
		}
		if (level_of_solid_fill == "solid fill"){
			color("Red")
			connectTubesSolid(sides,
								 tube_diameter,
								 width_of_band,
								 height_of_band,
								 360/segments*i,
								 360/segments*(i+1),
								 dist_from_center,
								 tube_offset_per_segment,
								 segments,
								 i);
		}
		else {
			color("Red")
			connectTubes(sides,
								 tube_diameter,
								 width_of_band,
								 height_of_band,
								 360/segments*i,
								 360/segments*(i+1),
								 dist_from_center,
								 tube_offset_per_segment,
								 segments,
								 i);
		}
	}
}

module connectTubes(sides,tubeDiameter,width,height,angleStart,angleStop,distFromCenter,twist,segments,j){
	for (i=[0:sides-1]){
		hull(){
			translate([0,0,zShift(i+twist,j+1)])
			rotate([0,0,angleStop+rotateAmt(i+twist,j+1)])
			translate([0,distFromCenter+radialShift(i+twist,j+1),0])
			translate([0,scaleBand(i+twist,j+1)*width/2*cos(twistAmt(i+twist,j+1)),scaleBand(i+twist,j+1)*height/2*sin(twistAmt(i+twist,j+1))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
			translate([0,0,zShift(0,j)])
			rotate([0,0,angleStart+rotateAmt(i,j)])
			translate([0,distFromCenter+radialShift(i,j),0])
			translate([0,scaleBand(i,j)*width/2*cos(twistAmt(i,j)),scaleBand(i,j)*height/2*sin(twistAmt(i,j))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
		}
	}
}

module makeNSidedTube(sides,tubeDiameter,width,height,angle,distFromCenter,j){
	translate([0,0,zShift(0,j)])
	for (i=[0:sides-1]){
		hull(){
			rotate([0,0,angle+rotateAmt(i,j)])
			translate([0,distFromCenter+radialShift(i,j),0])
			translate([0,scaleBand(i,j)*width/2*cos(twistAmt(i,j)),scaleBand(i,j)*height/2*sin(twistAmt(i,j))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
			rotate([0,0,angle+rotateAmt(i+1,j)])
			translate([0,distFromCenter+radialShift(i+1,j),0])
			translate([0,scaleBand(i+1,j)*width/2*cos(twistAmt(i+1,j)),scaleBand(i+1,j)*height/2*sin(twistAmt(i+1,j))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
		}
	}
}

module connectTubesSolid(sides,tubeDiameter,width,height,angleStart,angleStop,distFromCenter,twist,segments,j){
	hull(){
		for (i=[0:sides-1]){
			translate([0,0,zShift(i+twist,j+1)])
			rotate([0,0,angleStop+rotateAmt(i+twist,j+1)])
			translate([0,distFromCenter+radialShift(i+twist,j+1),0])
			translate([0,scaleBand(i+twist,j+1)*width/2*cos(twistAmt(i+twist,j+1)),scaleBand(i+twist,j+1)*height/2*sin(twistAmt(i+twist,j+1))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
			translate([0,0,zShift(0,j)])
			rotate([0,0,angleStart+rotateAmt(i,j)])
			translate([0,distFromCenter+radialShift(i,j),0])
			translate([0,scaleBand(i,j)*width/2*cos(twistAmt(i,j)),scaleBand(i,j)*height/2*sin(twistAmt(i,j))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
		}
	}
}

module makeNSidedBlock(sides,tubeDiameter,width,height,angle,distFromCenter,j){
	translate([0,0,zShift(0,j)])
	hull(){
		for (i=[0:sides-1]){
			rotate([0,0,angle+rotateAmt(i,j)])
			translate([0,distFromCenter+radialShift(i,j),0])
			translate([0,scaleBand(i,j)*width/2*cos(twistAmt(i,j)),scaleBand(i,j)*height/2*sin(twistAmt(i,j))])
			sphere(r=tubeDiameter/2,$fn = mesh_quality,center=true);
		}
	}
}

function twistAmt(side,segment) = 
	rotate_all_sides_angle
	+ 360*side/sides
	+ full_twists_per_rotation*360*segment/segments
	+ segment_twist_variation_angle/2*cos(segment_twist_variation_periods*360*segment/segments) 
	+ face_twist_variation_angle/2*cos(face_twist_variation_periods*360*side/sides);

function rotateAmt(side,segment) = 
	face_rotational_variation_angle/2*cos(face_rotational_variation_periods*360*side/sides)
	+ segment_spacing_variation_angle/2*cos(segment_spacing_variation_periods*360*segment/segments);

function zShift(side,segment) = z_shift_length/2*cos(z_shift_period*360*segment/segments);

function radialShift(side,segment) = radial_shift_length/2*cos(radial_shift_periods*360*segment/segments);

function scaleBand(side,segment) = (scale_segment_variation_max+scale_segment_variation_min)/2+(scale_segment_variation_max-scale_segment_variation_min)/2*cos(scale_segment_variation_periods*360*segment/segments);


