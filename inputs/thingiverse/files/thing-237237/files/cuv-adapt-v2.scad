//design and code by emanresu (http://www.thingiverse.com/Emanresu)


//CUSTOMIZER VARIABLES

//cuvette adaptor width (mm)
adaptor_x=12.5;
//cuvette adaptor length (in beampath dimention) (mm)
adaptor_y=12.5;
//cuvette adaptor height (mm)
adaptor_z=45;
//thickness of material at the base of the adaptor (mm)
bottom_thick=4;
//width of adaptor window (mm)
adaptor_window_width=6.5;
//outer thickness of cuvette in beampath dimention (assumes cuvette is full width of adaptor)
cuvette_y=3.7;

/* [Hidden] */

//Set openSCAD resolution
$fa=1;
$fs=0.5;


  /////////////
 // Modules //
/////////////

module holder_body() {
	// body...
	cube(size=[adaptor_x, adaptor_y, adaptor_z], center=true);
}

module adaptor_window_width() {
	// body...
	translate([0, 0, adaptor_window_width/2]) {
		cube(size=[adaptor_window_width, adaptor_y+1, adaptor_z], center=true);
	}
	translate([0, 0, -(adaptor_z-adaptor_window_width)/2]) {
		rotate([90, 00, 00]) {
			cylinder(r=adaptor_window_width/2, h=adaptor_y+1, center=true);
		}
	}	
}

module cuvette_cutout() {
	// body...
	cube(size=[adaptor_x+1, cuvette_y, adaptor_z], center=true);
}


  //////////////////
 // Control Code //
//////////////////

difference() {
	holder_body();
	translate([0, 0, bottom_thick]) {
		adaptor_window_width();
		cuvette_cutout();
	}
}
