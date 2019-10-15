//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//Generates two symmetric spool bearings/axel adapters/what have you
//spacer can be used to center the spool on a specific axel,
//or to simply keep the bearing/axel adapter from sliding into the spool


//CUSTOMIZER VARIABLES


//diameter of spool hole (mm)
spool_hole_diameter=31.5;

//distance bearing sticks into spool hole (mm)
spool_hole_depth=15;

//diameter of the axle (mm)
axel_diameter=10.4;

//height of spacer (mm) (useful for centering a spool) 
spacer=12.7;
//e.g. 0 = no spacer; 10 = a 10mm extension of a wider diameter

//extra diameter of spacer (mm)
spacer_diameter=10;
//(e.g. 0 = spool_hole_diameter; 10 = spool_hole_diameter + 10)

//closest distance between bearings on platform (mm)
separation=2;

/* [Hidden] */

//set openSCAD resolution
$fa=1;
$fs=1;


  //////////////////
 // Control Code //
//////////////////

//Right bearing
translate([-spool_hole_diameter/2-5-separation/2, 0, 0]) {
	difference() {
		union() {
			//spacer/end cap
			cylinder(r=spool_hole_diameter/2+5, h=spacer, center=false);
			//spool contact
			translate([0, 0, spacer]) cylinder(r=spool_hole_diameter/2, h=spool_hole_depth/2, center=false);
		}
		//axel hole
		translate([0, 0, -1]) cylinder(r=axel_diameter/2, h=(spacer+spool_hole_depth/2+2), center=false);
	}
}

//Left bearing
translate([spool_hole_diameter/2+5+separation/2, 0, 0]) {
	difference() {
		union() {
			//spacer/end cap
			cylinder(r=spool_hole_diameter/2+5, h=spacer, center=false);
			//spool contact
			translate([0, 0, spacer]) cylinder(r=spool_hole_diameter/2, h=spool_hole_depth/2, center=false);
		}
		//axel hole
		translate([0, 0, -1]) cylinder(r=axel_diameter/2, h=(spacer+spool_hole_depth/2+2), center=false);
	}
}






