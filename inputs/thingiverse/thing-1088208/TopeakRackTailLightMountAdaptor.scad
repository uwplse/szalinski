/*

Topeak Bike Rack License Plate to Tail Light Mount Adaptor v0.9
Rob Meyer
Oct 21, 2015

Modified from http://www.thingiverse.com/thing:8947/
Adapter for bike light to rack
Gian Pablo Villamil
May 30, 2011

Topeak bike rack license plate mount:
	Total width: 59.0mm
	Total height: 14.50mm
	center-to-center hole distance: 50.0mm
	rounded corner radius: 

Standard chinese tail light slide track:
	inside groove width: 20.6mm
	outside groove width: 15.5mm
	track height:
	wall thickness: 

*/
$fn = 50;
overlap = 0.01; // negligible amount necessary to make unions and differences render properly

bracket_height = 20.3;
tongue_width = 20.6;
tongue_thickness = 3;
base_width = 15.5; // How large the "outside" groove track is. Should be less than tongue_width by 2x the desired wall thickness
base_thickness = 2.5;
side_thickness = 2.5;

plate_thickness = 3;
plate_width = 100;
plate_height = bracket_height;

hole_dia = 5.8 ;
hole_sep = 49.0 ; // Topeak

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
	union() {
		difference(){
			translate([-(tongue_width+(side_thickness *2))/2,0,0])
				cube(size = [tongue_width+(side_thickness * 2),plate_thickness+tongue_thickness+base_thickness, bracket_height], center = false);
			translate([-tongue_width/2+overlap/2,2.5,-overlap/2])
				cube(size = [tongue_width+overlap, tongue_thickness+overlap, bracket_height+overlap], center=false);
			translate([-base_width/2,-overlap/2,-overlap/2])
				cube(size = [base_width+overlap, base_thickness+overlap, bracket_height+overlap], center=false);
		};

		translate([-tongue_width/2-overlap/2, base_thickness-overlap/2, 0])
			cube(size = [tongue_width+overlap*2, plate_thickness+overlap, plate_thickness], center=false);
	};
};

module release() {
	union() {
		translate([-3.5,-plate_thickness/2,0])
		#cube(size = [7, plate_thickness, 10], center = false);
		translate([0,-1.25,10]) rotate(a = 45, v = [1,0,0])
		cube(size = [4,2,2], center = true);
		translate([0,plate_thickness/2,12]) rotate(a = 90, v = [1,0,0])
		cylinder(h = plate_thickness, r = 6);
	};
}

rotate(a=90, v=[-1,0,0])
{
	union()
	{
		plate();
		translate([0,-7,-plate_height/2])
			bracket();
	}
}
//translate([0,0,10])
//release();
