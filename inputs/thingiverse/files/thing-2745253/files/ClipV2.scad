/* [Rod Clip] */
// Matching the rod diameter
inside_diameter=25;
// Thickness of the whole clip
clip_thickness=2;
// Spring-in of clip ends to snap on the rod
clip_end_distance=2;
//Hight of the whole clip
clip_hight=10;
/* [Razor Holder] */
//Length of the holding arms
holder_length=20;
//Space beween holding arms
holder_space=10;
//Depht of the cavity
holder_depht=0.5; //[0.1:0.1:0.8]

rotate([180,0,0])
difference() {
   	union(){
	cylinder(clip_hight,inside_diameter/2+clip_thickness,inside_diameter/2+clip_thickness, center=true);
	translate([(holder_length+inside_diameter/2+clip_thickness)/2,0,0])
		cube([holder_length+inside_diameter/2+clip_thickness,holder_space+clip_thickness*2,clip_hight],true);	
	}
    union(){
	cylinder(clip_hight+2,inside_diameter/2,inside_diameter/2, center=true);
	translate([(inside_diameter/2+clip_thickness)/-2,0,0])
		cube([inside_diameter/2+clip_thickness,inside_diameter-clip_end_distance*2,clip_hight+2],true);
	translate([holder_length/2+inside_diameter/2+clip_thickness+0.5,0,0])
		cube([holder_length+1,holder_space,clip_hight+2],true);
	translate([holder_length/2+inside_diameter/2+clip_thickness-(clip_thickness/4),0,-clip_hight/2])
		resize(newsize=[holder_length-clip_thickness/2,holder_space*10,clip_hight*holder_depht*2]) sphere(r=10);
	}
}

