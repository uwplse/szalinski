/*

Adapter for bike light to rack
Gian Pablo Villamil
May 30, 2011

*/

bracket_height = 22.25;
tongue_width = 20.6;
tongue_thickness = 3;
base_width = 15.5;
base_thickness = 2.5;
side_thickness = 2.5;

plate_thickness = 3;
plate_width = 100;
plate_height = 20.3;

hole_dia = 5.8 ;
hole_sep = 82 ;

// these are the dimensions of the rack bracket I have mm
rack_bracket_width = 15.365; 
rack_bracket_thick = 2.465; 
slop = 5; // mm amount of tolerance for printing

giant_dimension = 1000; 

// these were copied from my corner reflector T-style mount
m4_nut_height = 3.2; // global
module m4_nut_hole(){
    $fn = 6; // hex nut
    // see https://www.engineersedge.com/hardware/standard_metric_hex_nuts_13728.htm
    // for dimensions
    nut_height = 3.3; // max height allowed in spec
    //nut_width = 7.0; // max distance between flats
    nut_width = 8.08; // max distance between peaks
    cylinder( h = nut_height, r1 = nut_width/2, r2 = nut_width/2 );
    
}//end m4_nut_hole
//m4_nut_hole();

module m4_thru_hole(){
    m4_diam = 4; //mm
    $fn=100;
    cylinder( h =giant_dimension, r = m4_diam/2, center = true ); 
} //end m4_thru_hole

module m4_nut_and_thru(){
  translate([ 0,0,-m4_nut_height ]){
    m4_nut_hole();
}
m4_thru_hole();  
}// end m4_nut_and_thru
// dimensions of the extra material for bolt old and nuts

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

module bracket_thick() {
    
    // these are the dimensions for the slot that the rack bracket will fit into
    slot_width = rack_bracket_width + slop; 
    slot_height = bracket_height;
    slot_thick = rack_bracket_thick; 
    
    wing_thickness = 5; // mm
    
    bracket_thickness = 5; // mm used dims from corner reflector design
    
    total_thick = slot_thick + m4_nut_height + bracket_thickness ; 
    total_width = slot_width + 2*wing_thickness ; 
    total_height = slot_height; 
    
    translate( [ 0, 0, 1] )
    difference() {
        
        // this is the main outer shape
        translate( [-total_width/2, 0, -total_height/2 ]  )
        cube( [ total_width, total_thick, total_height  ] );      
    
        // this is the cutout
        translate( [ -slot_width/2, total_thick-slot_thick, -slot_height/2 ] )
        cube( [ slot_width, slot_thick, slot_height ]); 
        
        
    } // end difference 
    
}; //end bracket_thick

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
		translate([0,-1.25,10]) rotate(a = 45, v = [1,0,0])
		cube(size = [4,2,2], center = true);
		translate([0,plate_thickness/2,12]) rotate(a = 90, v = [1,0,0])
		cylinder(h = plate_thickness, r = 6);
	};
}



difference() {
    
union() {
//plate();
bracket_thick(); 
translate([0,-7,-plate_height/2])
bracket();
translate([0,0,10])
release();} // end union

translate( [0, -base_thickness, 0] )
rotate( [90, 0, 0] )
m4_nut_and_thru(); 
}
//end difference
