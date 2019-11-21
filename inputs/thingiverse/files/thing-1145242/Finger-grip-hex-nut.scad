// The size of your nut (measured over the flats)
nut_size = 8;
// Tolerace added for the nut to fit properly
tolerance = 0.1; //[0:None, 0.1:Normal, 0.2:Extra, 0.3:Loose, 0.4:Extreme]
// Height of the object
height = 6; //[1:1:50]
// The outermost diameter
outer_diameter = 15; //[5:1:100]
// The number of tags on the outside
number_of_tags = 12; //[6:1:100]



difference() {
	body();
	nut();
}

module body(){
	intersection(){
		difference(){
			union(){
				cylinder(height, d=outer_diameter-outer_diameter*PI/number_of_tags/4, $fn=number_of_tags*4);
				tags();
			}
			gaps();
		}
		union(){
			cylinder(height/6, d1=outer_diameter-outer_diameter*PI/number_of_tags/4, d2=outer_diameter+outer_diameter*PI/number_of_tags/4, $fn=number_of_tags*4);
			translate([0, 0, height/6])
			cylinder(height*2/3, d=outer_diameter+outer_diameter*PI/number_of_tags/4, $fn=number_of_tags*4);
			translate([0, 0, height*5/6])
			cylinder(height/6, d1=outer_diameter+outer_diameter*PI/number_of_tags/4, d2=outer_diameter-outer_diameter*PI/number_of_tags/4, $fn=number_of_tags*4);
		}
	}
}

module nut(){
	translate([0,0,-1])
	cylinder_outer(height+2, nut_size/2+tolerance/2, 6);
}

module gaps(){
	for(i=[360/(number_of_tags*2):360/number_of_tags:360]){
		translate([cos(i)*(outer_diameter-outer_diameter*PI/number_of_tags/4)/2, sin(i)*(outer_diameter-outer_diameter*PI/number_of_tags/4)/2, -1])
		cylinder(height+2, d=(outer_diameter-outer_diameter*PI/number_of_tags/4)*PI/number_of_tags/2, $fn=number_of_tags*4);
		}
}

module tags(){
	for(i=[0:360/number_of_tags:360]){
		translate([cos(i)*(outer_diameter-outer_diameter*PI/number_of_tags/4)/2, sin(i)*(outer_diameter-outer_diameter*PI/number_of_tags/4)/2, 0])
		cylinder(height, d=(outer_diameter-outer_diameter*PI/number_of_tags/4)*PI/number_of_tags/2, $fn=number_of_tags*4);
		}
}

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}