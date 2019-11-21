// euro platine pcb framing by zeus - zeus@ctdo.de - 2014-11-20
// 160x100mm is 1 full-sized euro platine
//  80x100mm is 1 half-sized euro platine
//  80x50mm  is 1 quarter-sized euro platine

// =====================================

// height
h=15; // [1:200]
// length
l=80; // [1:200]
// width
b=50; // [1:200]
// material thickness
mt=2; // [1:200]
// standoff spacing (10mm is good for m3 and m4 standoffs)
spare=10; // [1:200]

// =====================================

translate([0,0,h/2]){
	difference(){
		cube([l,b,h],center=true);
		cube([l-mt*2,b-mt*2,h+1],center=true);
	}
	for(x=[-l/2+spare/2+mt,l/2-spare/2-mt],y=[-b/2+spare/2+mt,b/2-spare/2-mt]){
		translate([x,y,0]){
			difference(){
				cube([spare+mt*2,spare+mt*2,h],center=true);
				cube([spare,spare,h+1],center=true);
			}
		}
	}
}