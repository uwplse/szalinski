include <keyring.scad>;

module galatianstar(outer, inner, height)
{

	function side_from_diag(di) = sqrt(pow(di,2)/2);
	dimensions = [side_from_diag(outer), side_from_diag(outer), height];
	d2 = [side_from_diag(inner), side_from_diag(inner), height];

	module star(dimensions, height){
		cube(dimensions, center=true);
		rotate(45, 0) cube(dimensions, center=true);
		translate([(outer/2+1.5),0,0]) keyring(3,5,height);
	}

	difference(){
		star(dimensions, height);
		translate([0,0,(height/2)]) star(d2, height);
	}
	translate([(outer/2+1.5),0,0]) keyring(3,5,height);
}



galatianstar(30, 25,3);



