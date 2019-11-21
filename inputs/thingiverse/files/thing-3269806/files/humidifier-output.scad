$fn=30;
nothing=0.01;
wall=0.8;
cylH=20;
cylR=37/2;
fanW=80;
fanH=20;
jetH=20;
poleW=5;
gap=3;
printTop=1;
printBottom=1;

if(printTop){
	size=fanW+2*poleW+2*nothing;
	difference(){
		output();		
		translate([-size/2,-size/2,fanH+cylR+poleW-size]) cube([size,size,size]);
	}
}

if(printBottom){
	size=fanW+2*poleW+2*nothing;
	difference(){
		output();		
		translate([-size/2,-size/2,fanH+cylR+poleW]) cube([size,size,size]);
	}
}


module output(){
	tube();
	difference(){
		manifold();
		translate([cylR-jetH/4+gap/2,-fanW/2,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) cube([fanW,gap,jetH]);
		translate([-(cylR-jetH/4)+gap/2,-fanW/2,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) cube([fanW,gap,jetH]);
	}
}


module manifold(){
	difference(){
		union(){
			funnel();
//			//triangles
//			//translate([-cylR,fanW/2,0]) rotate([0,-90,90]) triangle(width=1.8*cylR,height=fanW );
//			rotate([0,0,180]) translate([-cylR,fanW/2,0]) rotate([0,-90,90]) triangle(width=1.8*cylR,height=fanW );
//
//		translate([-cylR,fanW/2,0]) rotate([0,-90,90]) triangleHole(width=1.8*cylR,height=fanW );

			
			//poles
			translate([-cylR,fanW/2,cylR+poleW]) cube([2*cylR,poleW,fanH+jetH]);
			translate([-cylR,-fanW/2-poleW,cylR+poleW]) cube([2*cylR,poleW,fanH+jetH]);



			//jets
			translate([cylR-jetH/4,0,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) jet(width=fanW,height=jetH);
			translate([-(cylR-jetH/4),0,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) jet(width=fanW,height=jetH);
		}

		//triangle holes
		//translate([-cylR,fanW/2,0]) rotate([0,-90,90]) triangleHole(width=1.8*cylR,height=fanW );
		//rotate([0,0,180]) translate([-cylR,fanW/2,0]) rotate([0,-90,90]) triangle(width=1.8*cylR,height=fanW );

//		//pole holes
		translate([-cylR+wall,fanW/2+wall,cylR+poleW]) cube([2*cylR-2*wall,poleW-2*wall,fanH+jetH-wall]);
		translate([-cylR+wall,-fanW/2-poleW+wall,cylR+poleW]) cube([2*cylR-2*wall,poleW-2*wall,fanH+jetH-wall]);
		//translate([-cylR+wall,fanW/2+wall,wall]) cube([poleW-2*wall,poleW-2*wall,1.8*cylR+fanH+jetH-2*wall]);
//		translate([-cylR+wall,-fanW/2-poleW+wall,wall]) cube([poleW-2*wall,poleW-2*wall,1.8*cylR+fanH+jetH-2*wall]);
//		translate([cylR-poleW+wall,fanW/2+wall,wall]) cube([poleW-2*wall,poleW-2*wall,1.8*cylR+fanH+jetH-2*wall]);
//		translate([cylR-poleW+wall,-fanW/2-poleW+wall,wall]) cube([poleW-2*wall,poleW-2*wall,1.8*cylR+fanH+jetH-2*wall]);
		
		//jet holes
		translate([cylR-jetH/4,0,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) jetHole(width=fanW,height=jetH);
		translate([-(cylR-jetH/4),0,fanH+jetH/2+cylR+poleW]) rotate([0,0,90]) jetHole(width=fanW,height=jetH);
	}

}

module triangle(width = 10, height = 5){
	difference(){
		translate([width/3,0,0]) cylinder(h=height, d=width/.75, $fn=3);
		translate([-nothing,0,-nothing]) cube([width,width,height+2*nothing]);
	}
}

module triangleHole(width = 10, height = 5){
	difference(){
		translate([width/3-wall,0,wall]) cylinder(h=height-2*wall, d=(width-3*wall)/.75, $fn=3);
		translate([-nothing,0,-nothing]) cube([width,width,height+2*nothing]);
	}
}

module tube(){
	translate([0,0,-cylH]) difference(){
		cylinder(h=cylH, r=cylR);
		translate([0,0,-nothing]) cylinder(h=cylH+2*nothing, r=cylR-wall);
	}
}

module jet(width = 100, height = 10){
	difference(){
		translate([-width/2,0,0]) rotate([0,90,0]) scale([1,0.5,1]) cylinder(h=width,r=height/2);
	}
}

module jetHole(width = 100, height = 10){
	difference(){
		translate([-width/2-wall*1.5,0,0]) rotate([0,90,0]) scale([1,0.5,1]) cylinder(h=width+3*wall,r=height/2-2*wall);
	}
}

module funnel(){
	difference(){
		hull(){
			difference(){
				cylinder(h=nothing, r=cylR);
				translate([-cylR,-cylR-wall,0]) cube([2*cylR,cylR,2*nothing]);
			}
			translate([-cylR,fanW/2,cylR+poleW]) cube([2*cylR,poleW,nothing]);		
		}
		
		hull(){
			difference(){
				cylinder(h=nothing, r=cylR-wall);
				translate([-cylR,-cylR+wall,0]) cube([2*cylR,cylR,2*nothing]);
			}
			translate([-cylR+wall,fanW/2+wall,cylR+poleW]) cube([2*cylR-2*wall,poleW-2*wall,nothing]);		
		}
	}

	difference(){
		hull(){
			difference(){
				cylinder(h=nothing, r=cylR);
				translate([-cylR,wall,0]) cube([2*cylR,cylR,2*nothing]);
			}
			translate([-cylR,-fanW/2-poleW,cylR+poleW]) cube([2*cylR,poleW,nothing]);
		}

		hull(){
			difference(){
				cylinder(h=nothing, r=cylR-wall);
				translate([-cylR,-wall,0]) cube([2*cylR,cylR,2*nothing]);
			}
			translate([-cylR+wall,-fanW/2-poleW+wall,cylR+poleW]) cube([2*cylR-2*wall,poleW-2*wall,nothing]);
		}
	}
}