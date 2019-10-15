// preview[view:south west, tilt:top diagonal]
//Height of object to be mounted (mm)
bracket_height = 35.5;

//mm
body_length = 80;

//mm
body_width = 20;

//mm
shelf_width =20;

//mm
shelf_thickness = 5;

number_of_screws=3; //[0:10]

//Overall length of your screws (mm)
screw_length = 12;

//mm
screw_diameter = 4;

//mm
screw_head_diameter = 12;

//mm
layer_height=0.2;

/* [Hidden] */
fl_rad = (body_width/2) / 1.618;
smooth = 100;


module bracket(){
	hull() {
		cylinder (r=body_width/2, h=bracket_height, $fn=smooth);
		translate ([0, body_length-body_width, 0]) cylinder (r=body_width/2, h=bracket_height, $fn=smooth);
	}
}

module flange() {
	translate([0, 0, -shelf_thickness]) hull() {
		cylinder (r=body_width/2, h=shelf_thickness, $fn=smooth);
		translate ([fl_rad - shelf_width + (body_width * -0.5), 0, 0]) {
			cylinder (r=fl_rad, h=shelf_thickness, $fn=smooth);
			translate ([0, (body_length - body_width), 0]) cylinder (r=fl_rad, h=shelf_thickness, $fn=smooth);
		}
		translate ([0, (body_length - body_width) ,0]) cylinder (r=body_width/2, h=shelf_thickness, $fn=smooth);
	}
}

module screws() {
	screwgap = (body_length - body_width) / (number_of_screws-1);
	if (number_of_screws > 1) {
		union(){
			for (i = [0 : number_of_screws-1]) {
				translate ([0, i * screwgap, -shelf_thickness-1]) cylinder(r=screw_head_diameter*0.6, h=(bracket_height+shelf_thickness)-(screw_length/3)-layer_height+1, $fn=smooth);
				translate ([0, i * screwgap, bracket_height-screw_length/3]) cylinder(r=screw_diameter*0.6, h=screw_length/3+1, $fn=smooth);
			}
		}
	} else {
		translate ([0, (body_length - body_width)/2, -shelf_thickness-1]) cylinder(r=screw_head_diameter/2, h=(bracket_height+shelf_thickness)-(screw_length/3)-layer_height+1, $fn=smooth);
		translate ([0, (body_length - body_width)/2, bracket_height-screw_length/3]) cylinder(r=screw_diameter/2, h=screw_length/3+1, $fn=smooth);
	}
}

difference() {
	union() {
		bracket();
		flange();
	}
	if (number_of_screws > 0) { screws(); }
}