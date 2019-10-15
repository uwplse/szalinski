/* [Global] */
table_height = 23;
clipper_thickness = 5; 
hole_radius = 3;

/* [Hidden] */
printable = 1;
mo = 0.01;

rotate([printable?90:0,0,0])
clipper();

module clipper() {
	difference() {
		union(){
			cube(table_height + clipper_thickness);

			difference(){
				translate([hole_radius+2, (table_height + clipper_thickness*2  )/2, table_height + clipper_thickness])
				rotate([90,0,0])
					cylinder(h=clipper_thickness,r=hole_radius+2);

				translate([hole_radius+2, (table_height + clipper_thickness*2  )/2 +mo , table_height + clipper_thickness])
				rotate([90,0,0])
					cylinder(h=clipper_thickness+2*mo,r=hole_radius);
			}
		}


		translate([-mo+clipper_thickness/2,-mo,clipper_thickness/2])
			cube([table_height+clipper_thickness + 2*mo,table_height+clipper_thickness + 2*mo,table_height]);
	}
}

