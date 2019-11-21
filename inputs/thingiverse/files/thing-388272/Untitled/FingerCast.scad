diameter_1 = 15;
diameter_2 = 20;
diameter_3 = 25;

segment_1 = 20;
segment_2 = 25;

angle = 20;

wall = 1;


radius_hole_1_segement_1 = 0;
radius_hole_2_segement_1 = 6;

radius_hole_1_segement_2 = 5;
radius_hole_2_segement_2 = 8;

radius_hole_middle = 8;

$fn=30;

fingercast();

module fingercast(){
	difference(){
		hollowfinger();

			rotate([0,90,0])
					translate([0,0,-diameter_3*4])
						cylinder(r=radius_hole_middle, h=diameter_3*4);
	}
}


module hollowfinger(){
	difference(){
		finger(diameter_1/2,diameter_2/2,diameter_3/2,wall, true,radius_hole_1_segement_1,radius_hole_2_segement_1,radius_hole_1_segement_2,radius_hole_2_segement_2);
		finger(diameter_1/2,diameter_2/2,diameter_3/2);
	}
}

module finger(r_1,r_2,r_3,add=0, holes=false, hole1_seg1, hole2_seg1, hole1_seg2, hole2_seg2){
	//Segment 1
	translate([0,0,-segment_1])
		segement(r_1 + add, r_2 + add, segment_1, holes, hole1_seg1, hole2_seg1);
	//Segment 2
	rotate([0,angle,0])
		segement(r_2 + add, r_3 + add,segment_2, holes, hole1_seg2, hole2_seg2);

	//Segmentlinkage
	hull(){
		cylinder(r=r_2 + add, h=0.001);

	rotate([0,angle,0])
		cylinder(r=r_2 + add, h=0.001);
	}	
}


module segement(a,b,h,holes, hole1, hole2){
	difference(){
		cylinder(r1=a, r2=b, h=h);

		if(holes){
			if(hole1 > 0)
			translate([0,0,h/2])
				rotate([0,90,0])
					translate([0,0,-h*2])
						cylinder(r=hole1, h=h*4);


			if(hole2 > 0)
			translate([0,0,h/2])
				rotate([90,0,0])
					translate([0,0,-h*2])
						cylinder(r=hole2, h=h*4);
		}
	}
}


