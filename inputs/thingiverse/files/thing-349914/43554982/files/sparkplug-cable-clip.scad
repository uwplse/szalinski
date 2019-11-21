// in mm
dia=7.85;

count=4;

// in mm
spacing=1.2;

// in mm
border=2;

// percent of wire that extends beyond clip
reveal=18;

// in mm

// in mm
thickness=2.5;

/* [hidden] */
tab_size=(dia*(100-reveal)/100)+border;
tab_hole=tab_size-(border*2);

module clip_thing() {
	tab_thickness=thickness;//border;
	difference() {
		cube([tab_size,tab_size,tab_thickness]);
		translate([tab_hole/2,border,-1]) cube([tab_hole,tab_hole,tab_thickness+2]);
	}
}

union() {
	translate([-tab_size,0,0]) clip_thing();
	translate([(count*dia)+((count-1)*spacing)+(border*2),0,0]) clip_thing();

	difference() { // the clip
		cube([(count*dia)+((count-1)*spacing)+(border*2),(dia*(100-reveal)/100)+(border),thickness]); // the body
		translate([(border+(dia/2)),((dia/2)*(100-reveal)/100),0]) for(x=[0:count-1]){ // the wires
			translate([x*(dia+spacing),0,-1]) cylinder(r=dia/2,h=thickness+2,$fn=16); // a wire
			echo("wire min clip width=",(dia*(100-reveal)/100));
			translate([(x*(dia+spacing))-((dia*(100-reveal)/100)/2),-dia,-1]) cube([(dia*(100-reveal)/100),dia,thickness+2]); // cut off sharp edges
		}
	}
}