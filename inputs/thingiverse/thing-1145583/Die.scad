cube_size=30;
corner_resolution=90;
dot_resolution=45;

//////////////////////////////////////////////////
//////////////////////////////////////////////////

difference(){
	block();
	faces();
}
module faces(){
    // one
	translate([0, 0, 0.5*cube_size]){
		dot();
	}
    // two
    translate([cube_size/5, 0.5*cube_size, 0]){
        dot();
    }
    translate([-cube_size/5, 0.5*cube_size, 0]){
        dot();
    }
    // three
    translate([0.5*cube_size, cube_size/5, cube_size/5]){
        dot();
    }
    translate([0.5*cube_size, 0, 0]){
        dot();
    }
    translate([0.5*cube_size, -cube_size/5, -cube_size/5]){
        dot();
    }
    // four
    translate([-0.5*cube_size, -cube_size/5, cube_size/5]){
        dot();
    }
    translate([-0.5*cube_size, cube_size/5, cube_size/5]){
        dot();
    }
    translate([-0.5*cube_size, -cube_size/5, -cube_size/5]){
        dot();
    }
    translate([-0.5*cube_size, cube_size/5, -cube_size/5]){
        dot();
    }
    // five
    translate([0, -0.5*cube_size, 0]){
        dot();
    }
    translate([-cube_size/5, -0.5*cube_size, cube_size/5]){
        dot();
    }
    translate([cube_size/5, -0.5*cube_size, cube_size/5]){
        dot();
    }
    translate([cube_size/5, -0.5*cube_size, -cube_size/5]){
        dot();
    }
    translate([-cube_size/5, -0.5*cube_size, -cube_size/5]){
        dot();
    }
    // six
    translate([cube_size/5, 0, -0.5*cube_size]){
        dot();
    }
    translate([-cube_size/5, 0, -0.5*cube_size]){
        dot();
    }
    translate([cube_size/5, cube_size/5, -0.5*cube_size]){
        dot();
    }
    translate([cube_size/5, -cube_size/5, -0.5*cube_size]){
        dot();
    }
    translate([-cube_size/5, cube_size/5, -0.5*cube_size]){
        dot();
    }
    translate([-cube_size/5, -cube_size/5, -0.5*cube_size]){
        dot();
    }
}
module dot(){
    sphere(r=cube_size/10, $fn=dot_resolution);
}
module block(){
	intersection(){
		cube([cube_size, cube_size, cube_size], center=true);
		sphere(r=sqrt(2*(pow(0.5*cube_size, 2))), $fn=corner_resolution);
	}
}