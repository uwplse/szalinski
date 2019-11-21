/*

Adapter for bike light to rack
Gian Pablo Villamil
May 30, 2011

*/

// TODO: Print again, testing the -1.5 change in release dimple.

bracket_height = 20.3;
tongue_width = 17;
tongue_thickness = 3;
base_width = 12.5;
base_thickness = 2.5;
side_thickness = 2.5;

plate_thickness = 3;
plate_width = 100;
plate_height = 20.3;

hole_dia = 5.8 ;
hole_sep = 50 ;

module plate() {
	difference() {
		union() {
			cube(size= [hole_sep, plate_thickness, plate_height], center = true);
			translate ([hole_sep/2,0,0]) rotate (a = 90, v = [1,0,0]) 
				cylinder(h = plate_thickness, r = plate_height/2, center = true);
			translate ([-hole_sep/2,0,0]) rotate (a = 90, v = [1,0,0]) 
				cylinder(h = plate_thickness, r = plate_height/2, center = true);
			translate ([hole_sep/2+plate_height/4,0,-plate_height/4])
				cube(size = [plate_height/2,plate_thickness,plate_height/2],center = true);
			translate ([-(hole_sep/2+plate_height/4),0,-plate_height/4])
				cube(size = [plate_height/2,plate_thickness,plate_height/2],center = true);

		}
		translate ([hole_sep/2,0,0]) rotate (a = 90, v = [1,0,0]) 
			cylinder(h = plate_thickness+2, r = hole_dia/2, center = true);
		translate ([-hole_sep/2,0,0]) rotate (a = 90, v = [1,0,0]) 
			cylinder(h = plate_thickness+2, r = hole_dia/2, center = true);
	};
};

module bracket() {
	difference(){
		translate([-(tongue_width+(side_thickness *2))/2,0,0])
		cube(size = [tongue_width+(side_thickness * 2),plate_thickness+tongue_thickness+base_thickness, bracket_height], center = false);
		translate([-tongue_width/2,2.5,0])
		cube(size = [tongue_width, tongue_thickness, bracket_height], center=false);
		translate([-base_width/2,0,0])
		cube(size = [base_width, base_thickness, bracket_height], center=false);
	};
};

module release() {
	union() {
		translate([-3.5,-plate_thickness/2,0])
		#cube(size = [7, plate_thickness, 10], center = false);
		translate([0,-1.5,8.33]) rotate(a = 45, v = [1,0,0])
		cube(size = [4,2,2], center = true);
		translate([0,plate_thickness/2,12]) rotate(a = 90, v = [1,0,0])
		cylinder(h = plate_thickness, r = 6);
	};
}


union() {
plate();
translate([0,-7,-plate_height/2])
bracket();}
translate([0,0,10])
release();
