thickness=10;
outer_r=20;
knob_r=15;
bolt_r=3.5;
wall_thickness=3;
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
				translate([(outer_r+bolt_r+wall_thickness)*sin(120),(outer_r+bolt_r+wall_thickness)*cos(120),0])cylinder(r=knob_r+wall_thickness,h=thickness);
				translate([(outer_r+bolt_r+wall_thickness)*sin(240),(outer_r+bolt_r+wall_thickness)*cos(240),0])cylinder(r=knob_r+wall_thickness,h=thickness);
				translate([(outer_r+bolt_r+wall_thickness)*sin(360),(outer_r+bolt_r+wall_thickness)*cos(360),0])cylinder(r=knob_r+wall_thickness,h=thickness);
			}

			translate([(outer_r+bolt_r+wall_thickness)*sin(120),(outer_r+bolt_r+wall_thickness)*cos(120),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
			translate([(outer_r+bolt_r+wall_thickness)*sin(240),(outer_r+bolt_r+wall_thickness)*cos(240),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
			translate([(outer_r+bolt_r+wall_thickness)*sin(360),(outer_r+bolt_r+wall_thickness)*cos(360),-wall_thickness])cylinder(r=knob_r,h=thickness+wall_thickness*2);
		}
	cylinder(r=outer_r,h=thickness);
	}
}