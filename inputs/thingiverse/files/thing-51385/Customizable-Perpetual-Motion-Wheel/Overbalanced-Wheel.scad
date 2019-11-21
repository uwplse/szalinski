//Overbalanced wheel
$fn = 50;
mode = "preview"; //[preview, print]
num_of_holes = 8; //[3:9]
//Change size of wheel, other dependent parts change too.
wheel_size = 50; //[20:100]
wheel_thickness = 10; //[5:20]
fizz = 0.1;
fizzz = fizz*2;
rot = 360/num_of_holes;
dikte = wheel_size/10;

start();

module start(){
	if (mode == "print"){
		 color("green") wheel();
		translate([-wheel_size*1.8,-wheel_size*.5,dikte]) rotate(-90,[1,0,0]) color("blue") stand();
		translate([-wheel_size*1.8,wheel_size*1.3,0]) color("red") weights();
	} else {
		translate([0,-wheel_thickness/2,wheel_size + wheel_size/10]) rotate(90,[1,0,0]) color("green") wheel();
		color("blue")  stand();
	}
}

module weights(){
	for (nr=[1:num_of_holes]){
		translate([dikte*2.5*nr,0,0]) weight();
	}
}

module weight(){
	cylinder(wheel_thickness/2-fizzz,dikte,dikte);
	translate([0,0,wheel_thickness/2]) cylinder(wheel_thickness+fizzz*2, dikte/2, dikte/2);
	translate([0,0,wheel_thickness/2+wheel_thickness]) cylinder(wheel_thickness/2-fizzz,dikte,dikte);
}

module stand(){
	//vertical
	translate([-dikte,0,0]) cube([dikte*2,dikte,wheel_size + wheel_size/10]);
	//hangert
	translate([0,dikte,wheel_size + wheel_size/10]) rotate(90,[1,0,0]) cylinder(wheel_thickness*2+dikte+fizz,wheel_size/10,wheel_size/10);
	//tegenhouder
	translate([0,dikte,wheel_size + wheel_size/10]) rotate(90,[1,0,0]) cylinder(wheel_thickness/2+dikte+fizz,wheel_size/7,wheel_size/7);
	//horizontal
	trans_x = (wheel_size + wheel_size/10)/2;
	translate([-trans_x,0,0]) cube([wheel_size + wheel_size/10,dikte,dikte]);
	//pootjes
	translate([-trans_x,-(wheel_thickness*2.5)+fizz,0]) cube([dikte,wheel_thickness*2.5,dikte]);
	translate([trans_x - dikte,-(wheel_thickness*2.5)+fizz,0]) cube([dikte,wheel_thickness*2.5,dikte]);
}

module wheel(){
	difference(){
		cylinder(wheel_thickness, wheel_size, wheel_size);
		//Holes
		for (nr=[1:num_of_holes]){
			rotate(rot*nr,[0,0,1]) translate([0,wheel_size/1.75,0]) hole();
		}
		//Center
		translate([0,0,-fizz]) cylinder(wheel_thickness+fizzz,wheel_size/9.3+fizz,wheel_size/9.3+fizz);
	}
}

module hole(){
	difference(){
		translate([0,0,-fizz]) cylinder(wheel_thickness+fizzz, wheel_size/3, wheel_size/3);
		translate([0,-wheel_size/2,-fizzz]) cube([wheel_size,wheel_size,wheel_size]);
	}
}