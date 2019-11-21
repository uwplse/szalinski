
bolt_hole=4; //[1:10]

washer_outer_diameter=5; //[1:20]

washer_thickness=2;


difference(){
	cylinder(r= washer_outer_diameter ,h= washer_thickness ,center=true,$fn=40);

	cylinder(r= bolt_hole ,h= washer_thickness + 2 ,center=true,$fn=40);
}