// papier-op-de-goede-plek-houd-ding voor gaatjes-maak-ding
//  Based on http://www.thingiverse.com/thing:831545
// Updated by NPO 03-2017

$fn=24;

Width = 15; 
Lenght = 130; 


module fillet(r, h) { // thanks to nop_head
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}


// use # to highlight parts
difference(){
union(){

translate([0,1,0])   difference(){ 
    cube([Lenght,2,Width]);
    translate([0,2,Width/2]) rotate([0,0,-90]) fillet(2,Width);

}
translate([125,1,0]) difference(){
    cube ([5,20,Width]);
    translate([-Width+1,Width+6,Width/2]) rotate([90,0,0]) cylinder(h=Width+5,r=Width);
	translate([5,21.1,Width/2]) rotate([0,0,180]) fillet(5,Width);
	translate([0,12,0]) rotate([90,0,0]) fillet(2,Width+5);
	translate([0,12,Width]) rotate([-90,0,0]) fillet(2,Width+5);
}

translate([0,0,0])  cube([Lenght,1,3]);
    translate([0,0,Width-3]) cube([Lenght,1,3]);
	

difference(){
	union(){
	translate([105,-2,0])  cube([25,2,3]);
	translate([105,-2,Width-3]) cube([25,2,3]);
		}
translate([105,-2,Width/2]) rotate([0,0,0]) fillet(4,Width);
}
cube([3,1,Width]);

translate([16,1,Width/2]) rotate([90,0,0]) cylinder(h=1,r=2, r2=1.6);
translate([16,0.5,Width/2]) rotate([90,0,0]) sphere(1.7);

}
	translate([Lenght,10,0]) rotate([90,-90,0]) fillet(1,30);
    translate([Lenght,10,Width]) rotate([-90,90,0]) fillet(1,30);
    translate([Lenght,-2,(Width+2)/2]) rotate([0,0,90]) fillet(2,Width+2);
  	translate([Lenght,-0.5,3]) rotate([-90,90,0]) fillet(1,3);
    translate([Lenght,-0.5,Width-3]) rotate([90,-90,0]) fillet(1,3);
}



*translate([0,1,0]) rotate([90,0,0]) fillet(2,4);