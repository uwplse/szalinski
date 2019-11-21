// Mo.scad - a mustache ornament for Movember
// by Nicholas C. Lewis (A RepRap Breeding Program)
// www.NicholasCLewis.com
//
// It is licensed under the Creative Commons Attribution license 
// CC-BY 2010 by Nicholas C. Lewis
// http://www.thingiverse.com/thing:4648


a1 = 12;
w1 = 15;
l1 = 25;
a2 = -12;
w2 = 12;
l2 = 20;
a3 = -22;
w3 = 8;
l3 = 10;
a4 = -18;
w4 = 5;
l4 = 10;
a5 = -20;
w5 = 3;
l5 = 15;


//scale([0.8,0.8,0.4]){  // uncomment for MoSmall.stl or uncomment and change scale for other size
	union(){
		mirror()
			HalfMo();
	
		HalfMo();
	}
//}

module HalfMo(){
	intersection(){
		translate([12,18,0])
		union(){ 	
			sphere(15);
			rotate([0,90,0])
			union(){ 
				rotate([a1,0,0]){
					cylinder(r1 = w1, r2=w2,h=l1);
					translate([0,0,l1+sin(a2)*w2]){
						rotate([a2,0,0]){
							cylinder(r1 = w2/cos(a2), r2=w3,h=l2);
							translate([0,0,l2+sin(a3)*w3]){
								rotate([a3,0,0]){
									cylinder(r1 = w3/cos(a3), r2=w4,h=l3);
									translate([0,0,l3+sin(a4)*w4]){
										rotate([a4,0,0]){
											cylinder(r1 = w4/cos(a4), r2=w5,h=l4);
											translate([0,0,l4+sin(a5)*w5])
												rotate([a5,0,0])
													cylinder(r1 = w5/cos(a4), r2=0,h=l5);
										}
									}
								}
							}
						}
					}
				}
			}
		}
		cube(75);
	}
}