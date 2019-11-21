// Pipe hanger 
//John Finch 2-6-14


//User Inputs
inner_dia=16; 		//large inner hole
wall=3;  			//wall thickness of loop
tab_length=20; 		//mounting tab length
tab_thickness=5;		//mounting tab thickness
clip_width=10; 		//height of loop along Z axis
mount_hole_dia=4.5;	//screw hole diameter
opening=1;			//1 for a gap in loop, 0 for a solid loop
opening_width=14;	//opening width if enabled
center_to_wall_dist = 50.8; //Distance from center of support to wall
fillet_radius = 8;  //radius of fillet where support meets wall tabs


//end of user inputs
lightening_length = center_to_wall_dist - inner_dia/2-2*wall-tab_thickness;
lightening_width = inner_dia;
lightening_angle = atan(lightening_width/lightening_length);
cross_length = sqrt(lightening_length*lightening_length+lightening_width*lightening_width);

fn=20;


difference(){

	union(){
  	//place outer ring
	cylinder(h=clip_width,r1=inner_dia/2+wall,r2=inner_dia/2+wall,$fn=fn);

	//place mounting tabs
	translate([center_to_wall_dist-tab_thickness,-(inner_dia+2*wall+2*tab_length)/2,0])
	cube([tab_thickness,inner_dia+2*wall+2*tab_length,clip_width]);

	//place lower cube
	translate([0,-inner_dia/2-wall,0])
	cube([center_to_wall_dist,inner_dia+2*wall,clip_width]);

	//Place fillet cubes
	translate ([center_to_wall_dist-tab_thickness-fillet_radius,inner_dia/2+wall,0])
	cube([fillet_radius,fillet_radius,clip_width]);
	
	translate ([center_to_wall_dist-tab_thickness-fillet_radius,-inner_dia/2-wall-fillet_radius,0])
	cube([fillet_radius,fillet_radius,clip_width]);

	}

//cut fillet radai
translate ([center_to_wall_dist-tab_thickness-fillet_radius,inner_dia/2+wall+fillet_radius,0])
cylinder(h=clip_width,r1=fillet_radius, r2=fillet_radius,$fn=fn);

translate ([center_to_wall_dist-tab_thickness-fillet_radius,-inner_dia/2-wall-fillet_radius,0])
cylinder(h=clip_width,r1=fillet_radius, r2=fillet_radius,$fn=fn);

//Cut major lighting rectangle
translate([inner_dia/2+wall,-inner_dia/2,0])

cube([center_to_wall_dist - inner_dia/2-2*wall-tab_thickness,inner_dia,clip_width]);


//cut inner hole
cylinder(h=clip_width,r1=inner_dia/2,r2=inner_dia/2,$fn=fn);

//cut hole in mounting tab 1
translate([center_to_wall_dist-tab_thickness*1.01,-(inner_dia/2+wall+tab_length*3/4),clip_width/2])
rotate([0,90,0])
cylinder(h=tab_thickness*1.05,r1=mount_hole_dia/2,r2=mount_hole_dia/2,$fn=fn);

//cut hole in mounting tab 2
translate([center_to_wall_dist-tab_thickness*1.01,(inner_dia/2+wall+tab_length*3/4),clip_width/2])
rotate([0,90,0])
cylinder(h=tab_thickness*1.05,r1=mount_hole_dia/2,r2=mount_hole_dia/2,$fn=fn);

//slice ring
rotate([0,0,-90])
if (opening == 1)
	{
	translate([-(inner_dia/2+wall),-opening_width/2,0])
	cube([inner_dia/2,opening_width,clip_width]);
	}
}

//add strengthening bars to lightning hole
translate([inner_dia/2,inner_dia/2,0])
rotate([0,0,-lightening_angle])
cube([cross_length+2*wall,wall,clip_width]);

