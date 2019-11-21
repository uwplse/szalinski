// Which one would you like to see?
part = "fan"; // [fan,turbine,axel,Print all]

//axel_length=25: // [10:100]

number_of_blades = 6; // [2:24]
//cylinder_size = 10; // [1:100]
//number_of_wedges=8; // [2:12]


//

la=axel_length;

use <MCAD/involute_gears.scad>


print_part();

module print_part() {
	if (part == "fan") {
		form_fan();
	} else if (part == "turbine") {
		form_turbine();
	}else if (part == "axel") {
		form_axel();
	}else if (part == "Print all") {
		form_all();
	}
}



module form_fan() {
	guts();
}

module form_turbine() {
	turb();
}

module form_axel() {
	scale ([3/4*.425,3/4*.425,3/4*.425]) makeEm();
}

module form_fountain() {
	scale([4,4,4]) rotate ([90,0,0]) fount();
}

module form_float() {

	build_float_many();
	
}

module form_leo_bear() {
	leo_bear();
}

module form_all() {

}

module form_whole() {
//	form_turbine() ;
//	form_flountain();
//	form_float();

// Demonstrate how to make meshing bevel gears.
test_bevel_gear_pair();
}

// turbine

// variables

holeSize=5; // in mm for final print
bladeNum=number_of_blades;
// end of variables

module barr() {
	union() {
	translate ([20,10]) circle (r=10);
	scale ([]) square(20);
	}
}

module barrelSpace() {
	//	translate ([0,0,-10]) cylinder (r=32, h=10);
		translate ([0,0,-10]) rotate_extrude() barr();
		translate ([0,0,-50]) cylinder (r=holeSize*1.5, h=70); 
	}

module guts() {
	intersection() {
	translate ([0,0,10]) barrelSpace();
	//translate ([0,1.5,0]) rotate ([90,0,0])  rotate_extrude(height=3) barr();
		difference () {
			union() {
				for (i = [0:bladeNum]) {
					 rotate ([0,0,360/bladeNum*i]) scale ([1,8/bladeNum,1]) fanBlade(); 
					}
				cylinder (r=12, h=20);
				} 
			cylinder (r=holeSize*1.2, h=70, $fa=60);
	}
}
}
module fanBlade() {
	difference () {
		union() {
		translate ([0,1.5,0]) rotate ([90,0,0])  linear_extrude(height=3) barr();
		scale ([1.5,.8,1]) rotate ([0,90,-10]) translate ([-10,1,10]) sphere (8, $fa=16); // 12 -- 72
}
			scale ([1.43,.7,1]) rotate ([0,90,-10]) translate ([-10,5,10]) sphere (8, $fa=24); // 8 -- 72
			translate ([0,4.5,0]) rotate ([90,0,0])  linear_extrude(height=3) barr();
			rotate ([0,0,25]) translate ([16,-27.5-bladeNum/8,15]) cube(31, center=true);
}
 
}

module turbine (offset) {
		translate ([offset-2,101,0]) rotate ([90,0,0]) cylinder (r=10, h=100);
		translate ([-44,0,0]) rotate ([90,0,90]) translate ([-20,0,-offset*2])  cylinder (r=10, h=88);
		translate ([0,0,-117]) cube (200, center=true);
		barrelSpace ();

	}

module tb1(offt) {
	difference () {
		scale ([.55,.55,1]) translate ([-10,20,-100]) cube (200, center=true);
		translate ([-64,80,-50]) cylinder (r=60, h=60);
		scale ([1,1,1]) turbine(offt);
	}
}

module pegs() {
	cylinder (r=holeSize*1.1, h=45, $fa=60);
}

module turb() {
color ([.5,.5,1]) tb1(22);
color ("salmon") translate ([-130,0,0]) mirror() tb1(22); 
 difference() {
	color ([.6,1,.6]) translate ([0,0,-10]) scale ([.95,.95,.93]) guts();
	 translate ([0,0,-10]) cylinder (r=holeSize*1.2, h=70, $fa=60);
	}
}

module cir1() {
	circle(10);
}

module cir2() {
	translate ([0,10,0]) sphere(r, $fa=1);
	intersection () {
		union () {
			translate ([0,10,0])  cylinder (r=r, h=10);
			rotate ([0,0,60]) translate ([0,10,0])  cylinder (r=r, h=20);
			}
		cylinder (r=2*r, h=20);
		}
	}
					

module axelh1(l,w) {
	rotate ([0,180,0]) translate ([0,0,1]) cylinder (r1=.1, r2=w/1.15, h=15, $fa=1);
	rotate ([0,180,0]) translate ([0,0,16]) cylinder (r=w/1.15,  h=15);
	rotate ([0,180,0]) translate ([0,0,31]) scale ([1,1,-1]) cylinder (r1=w, r2=.1, h=l, $fa=60);
	rotate ([0,180,0]) translate ([0,0,31]) cylinder (r=w,  h=l, $fa=60);
}

module axelWhole(l,w) {
// union {
	axelh1(l,w);
	translate ([0,0,-(2*l+45)]) scale ([1,1,-1]) axelh1(l,w);
//	}
}

l=sin(60)*20;
r=l/2;

module braces1() {
	difference() {
		union() {
			translate([-20,0,-50]) scale([.5,2,12]) cube(10, center=true);
			translate([0,0,20]) scale([4.5,4.5,3]) cube(10, center=true);
			translate([0,0,-115]) scale([4.5,4.5,3]) cube(10, center=true);
		}
	circsDual();
	translate ([0,0,-116]) cylinder (r=8, h=136);
	}
}

module circs() {
	intersection () {
		union() {
			cir2();
			rotate ([0,0,120]) cir2();
			rotate ([0,0,240]) cir2();
		}
		translate ([0,0,-13]) cylinder (r1=4*r, r2=.1, h=40);
	}
}

module circsDual() {
	circs();
	translate ([0,0,-(2*l+60)]) scale ([1,1,-1]) circs();
}

module makeEm() {
	color ("light blue") circsDual();
	color ("light green")  axelWhole(25,10); 
		braces1();
}