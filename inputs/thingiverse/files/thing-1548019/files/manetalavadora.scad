
$fn =100;
legHeigth = 9;

// legs
translate ([-11,0,legHeigth/2]){
	Leg();
	
}
translate ([11,0,legHeigth/2]){
		mirror([1,0,0])
			Leg();
}

// legs union
translate ([-11,10-legHeigth/2,1])
 minkowski(){
	cube ([22,4,2]);
rotate([0,-90,0])
	cylinder(r=0.5,h=1);
}

translate ([-21,32-legHeigth,10])
cube ([42,10,3]);

difference(){
translate ([21,10+32-legHeigth,-12])
scale([1,2,1])
rotate([0,-90,0])
	difference(){
	intersection (){
		cylinder(42,25,25);

		cube (420);
	}

	translate ([0,2,0])
	cylinder(42,22,22);

	}
translate ([-50,0,-100])
cube ([100,100,100]);
}

module Leg(){

	rotate([0,-90,0])
		translate ([0,0,-5/2]){
			difference (){
				union(){
					translate ([-legHeigth/2,0,0]){
						difference(){
							cube ([legHeigth,16-legHeigth/2,5]);
							translate ([legHeigth,16-legHeigth/2,0])
								cylinder (5,legHeigth/2,legHeigth/2);
						}		
						translate ([0,5,-3])
							cube ([legHeigth/2,27-legHeigth/2,8]);

					}
					cylinder (5,legHeigth/2,legHeigth/2);
					cylinder (10,6.5/2,6.5/2);
				}
				cylinder (10,4.1/2,4.1/2);
			}
	translate ([-legHeigth/2,32-legHeigth,-10])
		cube([10,5,15]);
		}

	
}