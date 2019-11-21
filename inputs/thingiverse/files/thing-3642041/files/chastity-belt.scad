/* [General] */
clearance = 0.5;
distance_front_to_back = 200;
material_thicknesses = 4;
lock_type = "padlock v1"; //[none, padlock v1]
bolt_width = 10;

/* [Waist Band] */
waist_band_distance_center_to_side = 200;
waist_band_angle = 110; //[90:135]
waist_band_width = 20;
waist_band_middle_position = 0.5; //[0:0.01:1]
waist_band_front_curve_factor = 0.5; //[0.01:0.01:2]
waist_band_back_curve_factor = 0.5; //[0:0.01:2]

/* [Crotch Band] */
crotch_band_distance_center_to_bottom = 200;
crotch_band_width = 40;
crotch_band_middle_position = 0.6; //[0:0.01:1]
crotch_band_front_curve_factor = 0.25; //[0.01:0.01:2]
crotch_band_back_curve_factor = 0.75; //[0.01:0.01:2]

/* [Front Modification] */
front_modification = "none"; //[none, male v1, female v1]
front_modification_position = 0.5; //[0:0.01:1]
front_modification_size_1 = 40;
front_modification_size_2 = 40;
front_modification_size_3 = 40;

/* [Back Modification] */
back_modification = "none"; //[none, hole v1]
back_modification_position = 0.5; //[0:0.01:1]
back_modification_size_1 = 40;
back_modification_size_2 = 40;
back_modification_size_3 = 40;

chastity_belt();

module chastity_belt() {
	//front_connector();
	//back_connector();
	rotate([-90,0,0]) crotch_band_raw();
	rotate([waist_band_angle-90,0,0]) waist_band_raw();
	rotate([-waist_band_angle-90,0,0]) waist_band_raw();
}

function 2d_cubic_bezier(p0,p1,p2,p3,fn=15) =
	[for(s=[0:fn]) let(t=s/fn) [for(i=[0,1]) pow(1-t,3)*p0[i]+3*pow(1-t,2)*t*p1[i]+(1-t)*3*pow(t,2)*p2[i]+pow(t,3)*p3[i]]];

function 2d_cubic_bezier_derivation(p0,p1,p2,p3,fn=15) =
	[for(s=[0:fn]) let(t=s/fn) [for(i=[0,1]) 3*pow(1-t,2)*(p1[i]-p0[i])+6*(1-t)*t*(p2[i]-p1[i])+3*pow(t,2)*(p3[i]-p2[i])]];
	
module polygon_cubic_bezier(p0,p1,p2,p3,w,fn=15) {
	c = 2d_cubic_bezier(p0,p1,p2,p3,fn);
	d = 2d_cubic_bezier_derivation(p0,p1,p2,p3,fn);
	polygon(concat(
		[for(s=[0:fn])    [for(i=[0,1]) c[s][i]+w/2*(i?-1:1)*d[s][i?0:1]/sqrt(pow(d[s][0],2)+pow(d[s][1],2))]],
		[for(s=[fn:-1:0]) [for(i=[0,1]) c[s][i]+w/2*(i?1:-1)*d[s][i?0:1]/sqrt(pow(d[s][0],2)+pow(d[s][1],2))]]
	));
}

module crotch_band_raw() {
	middle_position = distance_front_to_back*(crotch_band_middle_position-0.5);
	linear_extrude(crotch_band_width, center=true) {
		translate([-distance_front_to_back/2, waist_band_width/4]) square([material_thicknesses, waist_band_width/2], center=true);
		polygon_cubic_bezier(
			[-distance_front_to_back/2,waist_band_width/2],
			[-distance_front_to_back/2,crotch_band_distance_center_to_bottom/2],
			[middle_position-crotch_band_back_curve_factor*distance_front_to_back,crotch_band_distance_center_to_bottom],
			[middle_position,crotch_band_distance_center_to_bottom],
			material_thicknesses
		);
		polygon_cubic_bezier(
			[middle_position,crotch_band_distance_center_to_bottom],
			[middle_position+crotch_band_front_curve_factor*distance_front_to_back,crotch_band_distance_center_to_bottom],
			[distance_front_to_back/2,crotch_band_distance_center_to_bottom/2],
			[distance_front_to_back/2,waist_band_width/2],
			material_thicknesses
		);
		translate([distance_front_to_back/2, waist_band_width/4]) square([material_thicknesses, waist_band_width/2], center=true);
	}
}

module waist_band_raw() {
	middle_position = distance_front_to_back*(waist_band_middle_position-0.5);
	linear_extrude(waist_band_width, center=true) {
 		translate([-distance_front_to_back/2, crotch_band_width/4]) square([material_thicknesses, crotch_band_width/2], center=true);
		polygon_cubic_bezier(
			[-distance_front_to_back/2,crotch_band_width/2],
			[-distance_front_to_back/2,waist_band_distance_center_to_side/2],
			[middle_position-waist_band_back_curve_factor*distance_front_to_back,waist_band_distance_center_to_side],
			[middle_position,waist_band_distance_center_to_side],
			material_thicknesses
		);
		polygon_cubic_bezier(
			[middle_position,waist_band_distance_center_to_side],
			[middle_position+waist_band_front_curve_factor*distance_front_to_back,waist_band_distance_center_to_side],
			[distance_front_to_back/2,waist_band_distance_center_to_side/2],
			[distance_front_to_back/2,crotch_band_width/2],
			material_thicknesses
		);
		translate([distance_front_to_back/2, crotch_band_width/4]) square([material_thicknesses, crotch_band_width/2], center=true);
	}
}
