//Socket wrench (customizable)
//Mateo Marquez
//November 3rd, 2014

// resolution of model
$fs=0.1;

// size of drive hex nut (diameter)
nut_size = 6;
// size of bolt (diameter)
bolt_size = 2;

//Main
side_one(nut_size);
translate([15,-12.5,0]) {
	rotate([0, 0, 90]) {
		side_two(nut_size);
	}
}


//Side Number One
module side_one(nut_size) {
	difference(){
		cube([5, 30, 15], center = true);	
		translate([2.5,0,0]) {
			difference(){
				rotate([0, 90, 0]) {
					hexagon(nut_size, 4);
					bolt(bolt_size);
				}
			}
		}
	}
}

//Side Number Two
module side_two(nut_size) {
	difference(){
		cube([5, 30, 15], center = true);	
		translate([2.5,0,0]) {
			difference(){
				rotate([0, 90, 0]) {
					hexagon(nut_size, 4);
					bolt(bolt_size);
				}
			}
		}
	}
}


//Bolt
module bolt(bolt_size){
	rotate([0, 0, 0]) {
		cylinder(r=bolt_size, h=20, center = true);
	}
}

//Hexagon
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}