/* [Heights of piece] */
inner_top_height = 10; // Height that cover upper furniture foot
inner_bottom_height = 10; // Height that cover lower furniture foot

/* [Feet dimensions] */
inner_width = 15;
inner_length = 25;

/* [Other dimensions] */
border_size = 2; //Size of border: Total size of piece will be inner_width/length + 2*border_size
junction_size = 3; // Size of the junction between the two pieces

/* [Stand of the upper Ragrund dimension] */

stand_height = 2; 
stand_radius = 7;


/* [Hidden] */

total_width = inner_width + border_size*2;
total_length = inner_length + border_size*2;
total_height = inner_top_height + inner_bottom_height + junction_size;
	
cylinder_radius = (1/2*sqrt(pow(inner_width,2) + pow(inner_length,2)) + border_size);

difference() {
	//Round corners
	union() {
		translate([0, border_size, 0]) cube ([total_width, inner_length, total_height]);
		translate([border_size, 0, 0]) cube ([inner_width, total_length, total_height]);
		translate([border_size, border_size, 0]) cylinder (h = total_height, r=border_size, $fn=500);            
		translate([inner_width+border_size, border_size, 0]) cylinder (h = total_height, r=border_size, $fn=500);        
		translate([inner_width+border_size, inner_length+border_size, 0]) cylinder (h = total_height, r=border_size, $fn=500);        
		translate([border_size, inner_length+border_size, 0]) cylinder (h = total_height, r=border_size, $fn=500);

	}
	
	
	//Bottom removal
	translate([border_size, border_size, -10]) {
		cube([inner_width, inner_length, inner_bottom_height+10]);
	}
	
	//Top removal
	translate([border_size, border_size, inner_bottom_height + junction_size]) {
		union() {
			translate([0,0,stand_height]) cube([inner_width, inner_length, inner_top_height+10]);
			translate([inner_width/2,inner_length/2,2.5 + stand_height/2]) cylinder(h = 5+stand_height, r= stand_radius, center = true, $fn=100);
		}
	}
	
}
