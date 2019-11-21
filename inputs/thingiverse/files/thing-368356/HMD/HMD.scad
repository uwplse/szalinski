//Screen Length
screen_width = 131; //[1:250]
//Screen Width
screen_height = 74; //[1:170]
//Screen Cavity Height
screen_cavity_height = 18; //[4:100]
//Lens Cup Height
lens_height = 29; //[4:100]
//Lens Radius
lens_radius = 25.7;//[2:100]
//IPD
IPD = 64;//[45:85]
//Screen Opening Height
back_opening_height = 14;//[0:96]
//Wall Thickness
wall_thickness = 2;//[1:5]
//Screw Hole Radius
screw_radius = 1;//[0:5]
//Screw Hole Depth
screw_depth = 2;//[0:5]

translate([0,0,screen_height+(2*wall_thickness)]) rotate([-90,0,0]) difference(){
difference(){
//Right Lens Cavity
difference(){
	//Left Lens Cavity
	difference(){
		//Right Lens Outer
		union(){
			//Left Lens Outer
			union(){
				//Backdoor
				difference(){
					//Screen Cavity
					difference(){
						cube([screen_width+(wall_thickness*2),screen_height+(wall_thickness*2),screen_cavity_height+(wall_thickness*2)]);
						translate([wall_thickness,wall_thickness,wall_thickness]) cube([screen_width,screen_height,screen_cavity_height]);
					}
					translate([wall_thickness,-0.1,wall_thickness]) cube([screen_width,wall_thickness+0.2,back_opening_height]);
				}
				translate([(screen_width/2)-(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness,screen_cavity_height+wall_thickness]) cylinder(lens_height,lens_radius+5+wall_thickness,lens_radius+wall_thickness);
			}
			translate([(screen_width/2)+(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness,screen_cavity_height+wall_thickness]) cylinder(lens_height,lens_radius+5+wall_thickness,lens_radius+wall_thickness);
		}
		translate([(screen_width/2)-(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness,screen_cavity_height+wall_thickness-0.1]) cylinder(lens_height+0.2,lens_radius+5,lens_radius);
	}
	translate([(screen_width/2)+(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness,screen_cavity_height+wall_thickness-0.1]) cylinder(lens_height+0.2,lens_radius+5,lens_radius);
}

translate([(screen_width/2)+(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness-lens_radius+1,screen_cavity_height+wall_thickness+lens_height-screw_depth]) rotate([90,0,0])  cylinder(5,screw_radius,screw_radius, $fn = 10);
}
translate([(screen_width/2)-(IPD/2)+wall_thickness,(screen_height/2)+wall_thickness-lens_radius+1,screen_cavity_height+wall_thickness+lens_height-screw_depth]) rotate([90,0,0])  cylinder(5,screw_radius,screw_radius, $fn = 10);
}