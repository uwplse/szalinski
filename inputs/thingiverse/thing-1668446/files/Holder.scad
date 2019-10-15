/* [Assembly] */

// Is the capsule holder an assemblable thing (true) or not (false)
is_assemblable = 1; // [1:true, 0:false]
// Is the capsule holder a starting piece (true) or an end/middle piece (false)
is_starter = 1; // [1:true, 0:false]
// Is the capsule holder an end piece (true) or a starting/middle piece (false)
is_end = 0; // [1:true, 0:false]

/* [Size & look] */

// Should this piece have a bottom box to grab the capsules (false) or is it just an extension tower (true)
tower_only = 0; // [1:true, 0:false]
// How many caps in total should the holder contain?
nb_caps = 4;

/* [Capsule Info] */

// Height of the capsule
capsule_height = 37;
// Radius of the lid of the capsule
capsule_cap_diameter = 55;
// Radius of the capsule without the lid
capsule_cap_under_diameter = 51;

/* [Other] */

// Size of the clips (should not be modified unless you see there is a problem with the clips)
clips_thickness = 3;

/* [Hidden] */

assemblable = is_assemblable == 1;
starter = assemblable && (is_starter == 1);
end = assemblable && (is_end == 1) && !starter;

module clip_male(height){
	rotate([0,0,90]){
	cube([clips_thickness,clips_thickness,height]);
	translate([clips_thickness + (clips_thickness/2.0) ,0 , height/2.0]) cube([clips_thickness,2*clips_thickness,height], center = true);
	}
}

module clip_female(height){
	rotate([0,0,90]){
	translate([0, -0.25, 0])cube([clips_thickness, clips_thickness + 0.5 , height]);
	translate([clips_thickness - 0.5, -(clips_thickness + 0.25), 0]) cube([clips_thickness + 1,(2*clips_thickness) + 0.5,height]);
	}
}

module chemney_by_nb_caps(nb_caps){
	size_z = (capsule_height + 0.2) * (nb_caps);
	chemney_by_size(size_z);
}

module chemney_by_size(height){
	translate([ (capsule_cap_diameter + 5) /2.0, (capsule_cap_diameter + 5) /2.0 , 0]){
	difference(){
		translate([0,0,height/2.0])difference(){
			cube([capsule_cap_diameter + 5, capsule_cap_diameter + 5, height], center = true);
			cylinder(r = capsule_cap_diameter/2.0 + 0.5, h=height, center = true, $fn = 200);
			translate([2.5,0,0])cube([capsule_cap_diameter , capsule_cap_diameter / 4.0, height], center = true);
		}

		if(assemblable || starter){ //add clip holes
			translate([0, -(capsule_cap_diameter + 5) / 2.0, 0]){
				translate([(capsule_cap_diameter + 25) / 4.0 ,0,0])clip_female(height);
				translate([-(capsule_cap_diameter + 25) / 4.0 ,0,0])clip_female(height);
			}
		}
	}
	if(assemblable || end){ //add clips
		translate([0, (capsule_cap_diameter + 5) / 2.0, 0]){
			translate([(capsule_cap_diameter + 25) / 4.0 ,0,0])clip_male(height);
			translate([-(capsule_cap_diameter + 25) / 4.0 ,0,0])clip_male(height);
		}
	}
	}
}



chemney_by_nb_caps(nb_caps - (-1*(tower_only-1)));
// and now for the base
if (tower_only == 0){
translate([0,0, -(capsule_height + 15)])translate([(capsule_cap_diameter +5)/2.0, (capsule_cap_diameter +5)/2.0, (capsule_height + 15)/2.0])difference(){
	cube([capsule_cap_diameter +5, capsule_cap_diameter +5, capsule_height + 15], center = true);

	translate([0,0,(capsule_height + 12.5)/2.0])
		cylinder(r = (capsule_cap_diameter + 1) /2.0, h=3, center = true, $fn = 200);
	translate([(capsule_cap_diameter  + 1) / 2.0, 0 , (capsule_height + 12.5)/2.0])
		cube([capsule_cap_diameter + 1, capsule_cap_diameter + 1, 3], center = true);

	translate([0,0,5/2.0])
		cylinder(r = (capsule_cap_under_diameter) /2.0, h=capsule_height + 10, center = true, $fn = 200);
	translate([(capsule_cap_under_diameter) / 2.0, 0 , 5/2.0])
		cube([capsule_cap_under_diameter, capsule_cap_under_diameter, capsule_height + 10], center = true);
}
}
