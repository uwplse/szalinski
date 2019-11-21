thickness=20;
outer_r=45;
knob_r=35;
bolt_r=4.6;
wall_thickness=6;
square_ratio=1.5;


union(){
	difference(){
		cylinder(r=bolt_r+wall_thickness,h=thickness);
		intersection(){
			translate([0,0,wall_thickness])cylinder(r=bolt_r,h=thickness);
			translate([-square_ratio*.5*bolt_r,-bolt_r*2,wall_thickness])cube([square_ratio*bolt_r,bolt_r*4,thickness]);
		}
	}
	intersection(){
		difference(){
			union(){
				difference(){
					cylinder(r=outer_r,h=thickness);
					translate([0,0,wall_thickness])cylinder(r=outer_r-wall_thickness,h=thickness);
					}
				translate([(outer_r+bolt_r+wall_thickness)*sin(90),(outer_r+bolt_r+wall_thickness)*cos(90),0])cylinder(r=knob_r+wall_thickness,h=thickness);
				translate([(outer_r+bolt_r+wall_thickness)*sin(180),(outer_r+bolt_r+wall_thickness)*cos(180),0])cylinder(r=knob_r+wall_thickness,h=thickness);
				translate([(outer_r+bolt_r+wall_thickness)*sin(270),(outer_r+bolt_r+wall_thickness)*cos(270),0])cylinder(r=knob_r+wall_thickness,h=thickness);
				translate([(outer_r+bolt_r+wall_thickness)*sin(360),(outer_r+bolt_r+wall_thickness)*cos(360),0])cylinder(r=knob_r+wall_thickness,h=thickness);
			}

			translate([(outer_r+bolt_r+wall_thickness)*sin(90),(outer_r+bolt_r+wall_thickness)*cos(90),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
			translate([(outer_r+bolt_r+wall_thickness)*sin(180),(outer_r+bolt_r+wall_thickness)*cos(180),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
			translate([(outer_r+bolt_r+wall_thickness)*sin(270),(outer_r+bolt_r+wall_thickness)*cos(270),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
			translate([(outer_r+bolt_r+wall_thickness)*sin(360),(outer_r+bolt_r+wall_thickness)*cos(360),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
		}
	cylinder(r=outer_r,h=thickness);
	}
}
