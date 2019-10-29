$fn=50 ;

stick_d=8.45 ; //7.20 + .45
stick_h=22 ;
ring_d=39.2 ;
ring_wall=3 ;
ring_h=3 ;
num_arms=3 ;


module stick(){
	hull(){
		hull(){
			translate([0,0,5])cylinder(d=stick_d,h=6);
			translate([10,-10,5])cylinder(d=stick_d,h=6);
		}
		hull(){
			cylinder(d=stick_d-1,h=5);
			translate([10,-10,0])cylinder(d=stick_d-2,h=6);
		}
	}
}

module stick2(){
	translate([0,0,0])cylinder(d=stick_d,h=stick_h+.3);
}

module frame(){
	difference(){
		hull(){
			cylinder(d=ring_d,h=.3);
			translate([0,0,ring_h])cylinder(d=ring_d+3,h=.3);
		}
		hull(){
			translate([0,0,-.1])cylinder(d=ring_d-ring_wall,h=.3); //lower ring
			translate([0,0,ring_h+.1])cylinder(d=ring_d+3-ring_wall,h=.3); // upper ring
		}
	}
	
	step=360/num_arms;
	for (i = [0:step:360]) { //Generates the arms
		rotate([0,0,i]){
			hull(){
				translate([0,-ring_wall/2,0])cube([ring_d/2,ring_wall,.3]); //lower
				translate([0,-ring_wall/2,ring_h])cube([ring_d/2,ring_wall,.3]); //upper
				translate([0,-ring_wall/2,stick_h-.3])cube([5,ring_wall,.3]); //upper
				//translate([0,-ring_wall/2,10])rotate([0,20,0])cube([ring_d/2+2,ring_wall,.3]); //upper
			}
		}
	}
	cylinder(d=stick_d+ring_wall,h=stick_h); //Center Cill
}

difference(){
	frame();
	translate([0,0,-.1])rotate([0,0,-15])stick2();
}

