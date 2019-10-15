//parameters -----------------------------------------------
tube_diameter=110;
insert_length=25;
wall_thickness=3;

filter_diameter=120;
filter_thickness=5;
filter_number_of_rings=5;

//fine setting ---------------------------------------------
$fn=2000;

//calculations ---------------------------------------------
tube_radius=tube_diameter/2;
filter_radius=filter_diameter/2;

//design ---------------------------------------------------


//FILTER
// init vars for filter rings
ring_radius=(tube_diameter)/((filter_number_of_rings+2)*2)/2;
holder_length=tube_radius*2-wall_thickness;
//INSERT
union(){
	difference(){
		translate([0,0,filter_thickness])
		cylinder(insert_length,tube_radius,tube_radius,center = false);
		cylinder(insert_length+10,tube_radius-wall_thickness,tube_radius-wall_thickness,center = false);	
	}

	// rings starting from center

	//center spot
	cylinder(filter_thickness,ring_radius,ring_radius,center = false );
	//filter holder
	
	translate([-holder_length/2,-ring_radius/2,0]) cube([holder_length,ring_radius,(filter_thickness*2)]);
	translate([-ring_radius/2,-holder_length/2,0]) cube([ring_radius,holder_length,(filter_thickness*2)]);

	// rings
	for(i=[(ring_radius+ring_radius):(ring_radius+ring_radius):tube_radius]){
		//translate([0,i,0]) cube(ring_radius);
		difference(){
			cylinder(filter_thickness,i,i,center = false);
			cylinder(filter_thickness,(i-ring_radius),(i-ring_radius),center = false);
		}

	}
	// external ring

	difference(){
		cylinder(filter_thickness,filter_radius,filter_radius,center = false);
		cylinder(filter_thickness,tube_radius,tube_radius,center = false);
	}
}





