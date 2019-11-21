use <write/Write.scad>

//per eye. Values from 2 to -2 in mm -> 67.5-59.5mm IPD.
ipd_incrase=2;
// - number of facets used to generate an arc.
model_resolution=360;


$fn=model_resolution;

difference() {
	translate([-25,-25,0]) adapter();
	translate([-25,-25,0]) 
		rotate(-120,[0,0,1]) 
			translate([30,0,0]) 
				mirror([0,1,0]) 
					write("L",t=1,h=4,center=true);
};

difference() {
	translate([25,25,0]) mirror([0,1,0]) adapter();
	translate([25,25,0]) 
		rotate(120,[0,0,1]) 
			translate([30,0,0]) 
				mirror([1,0,0]) 
					write("R",t=1,h=4,center=true);
};



module ring(o_d,i_d,h) {
	difference(){
		cylinder(h=h,d=o_d);
		cylinder(h=h,d=i_d);
	};
};

module tab() {
	translate([-2.5,-3.45,0]) {
		translate ([5,0,0])
			rotate (-90,[0,1,0])
				linear_extrude(height = 5, center = false, convexity = 10)
					polygon(
						points=[
							[0,0],
							[0,6.9],
							[1.5,6.9],
							[2.1,3.45],
							[1.5,0]
						],
						paths=[[0,1,2,3,4]]
					);
		translate([0,3.45,1.9])
			rotate(90,[0,1,0])
				scale([0.5,1,1])
					cylinder(h=5, d=1.2);
		};
};

module tab_set() {
	intersection(){
		cylinder(h=5,d=65.9);
		union() {
			translate([32,0,0]) difference() {
				tab();
				translate([-1.2,0,0]) cylinder(h=0.5,d=2); 
			};
			rotate(120,[0,0,1]) translate([32,0,0]) tab();
			rotate(-120,[0,0,1]) translate([32,0,0]) tab();
		};
	};
}

module clip() {		
	translate ([2.5,-8.55,0]) 
		rotate (-90,[0,1,0])
			linear_extrude(height = 5, center = false, convexity = 10) 
				polygon(
					points=[
						[0,0],
						[3.5,3.5],
						[3.5,5],
						[3,5.3],
						[2.5,5.3],
						[1,5],
						[1,12.1],
						[2.5,11.8],
						[3.0,11.8],
						[3.5,12.1],
						[3.5,13.6],
						[0,17.1],
					],
					paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]
				);
};

module clip_set() {
	intersection(){
		ring(64.5,59.7,5);
		union() {
			rotate(-60,[0,0,1]) translate([30,0,0]) clip();
			rotate(60,[0,0,1]) translate([30,0,0]) clip();
			rotate(180,[0,0,1]) translate([30,0,0]) clip();
		};
	};
};

module cut() {
	translate([0,-11.5,0])
		linear_extrude(height = 5, center = false, convexity = 10) 
			polygon ( 
				points=[
					[0,10],
					[35,23],
					[35,0]
				],
				paths=[[0,1,2]]
			);
};

module cut_set() {
	difference() {
		union(){
			rotate(-8.5,[0,0,1]) cut();
			rotate(-120-8.5,[0,0,1]) cut();
			rotate(120-8.5,[0,0,1]) cut();
		};
		cylinder(h=5,d=58.5);	
	};
};

module adapter(text) {
	difference(){
		union() {
			ring(59.5,54.9,2.9);
			tab_set();
			difference(){
				union(){
					difference() {
						translate([0,-ipd_incrase,0]) ring(64.5,55.3,2.9); 
						cut_set();
					};					
					translate([0,-ipd_incrase,1.9]) clip_set();
				};							
				difference(){
					difference() {			
						rotate(97,[0,0,1]) 
							linear_extrude(height=10, center=false, convexity=10) 
								polygon ( 
									points=[
										[0,0],
										[40,25],
										[40,-25]
									],
									paths=[[0,1,2]]
								);
						translate([0,0,0]) cube([20,31,10]);
					};
					translate([0,-1.5,0]) cylinder(h=10,d=65.5);	
				};
			};
	
		};
		translate([0,-ipd_incrase,0.7]) cylinder(h=5,d=55.3);
	};
};

