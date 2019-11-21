/* [Holes Spacing] */

vertical = 11;
horizontal = 22.3;

holes_offset = 15;

hole_radius = 1.5;

axel_radius = 8.1;

axel_support_height = 21;

difference() {
	union() {
		cube([4,23++holes_offset,10]);  //4,45,10
        translate([0,22+holes_offset,0]) cube([4,10+horizontal,8+vertical]);
		translate([axel_radius, 15,0]) cylinder(h = axel_support_height, r = axel_radius, $fn = 50);
        cube([axel_radius*2, 15,10]);
		
    
        
        color("Blue",0.4);
        //bevel([0,22,20],4,20,1);
       add_bottom_right([0,22+holes_offset,10],4,4);

	}
       bevel_top_left([0,22+holes_offset,8+vertical],4,100);
       bevel_top_right([0,32+horizontal+holes_offset,8+vertical],4,100);
       bevel_top_left([0,0,10],2,100);


	translate([axel_radius, 15,0]) cylinder(h = axel_support_height, r = axel_radius/2, $fn = 50);
	translate([axel_radius/2+0.1, 0, 0]) cube([axel_radius-0.2, 13,axel_support_height]);
	translate([-10, 6, 5]) rotate(a=[0, 90, 0]) cylinder(h = 200, r = hole_radius, $fn= 20);
    
    //holes
	translate([-10, 28+holes_offset, 5]) rotate(a=[0, 90, 0]) cylinder(h = 30, r = hole_radius, $fn= 20);
	translate([-10, 28+horizontal+holes_offset, 5]) rotate(a=[0, 90, 0]) cylinder(h = 30, r = hole_radius, $fn= 20);
    translate([-10, 28+holes_offset, 5+vertical]) rotate(a=[0, 90, 0]) cylinder(h = 30, r = hole_radius, $fn= 20);
	translate([-10, 28+horizontal+holes_offset, 5+vertical]) rotate(a=[0, 90, 0]) cylinder(h = 30, r = hole_radius, $fn= 20);
    
	translate([axel_radius*2,6,5]) cube([2,3.5,6], center=true);
	translate([axel_radius*2,6,5]) rotate(a=[60,0,0]) cube([2,3.5,6], center=true);
	translate([axel_radius*2,6,5]) rotate(a=[120,0,0]) cube([2,3.5,6], center=true);
}

module bevel1(pos=[0,0,0],radius=2,depth=10) {
    difference() {
        difference () {
            translate([0,0,radius*2]) cube([depth,radius*2,radius*2]);
            translate([0,radius,0-radius]) rotate(a=[0, 90, 0]) cylinder(h = depth, r = radius, $fn= 20);
        }
       // translate([0,radius,0-radius*2]) cube([depth,radius,radius*2]);
         //translate([0,0,0-radius*2]) cube([depth,radius*2,radius]);
    }
}

module bevel_top_left(pos=[0,0,0],radius=20,depth=10) {
    bevel(pos,radius,depth,[1,-1],[-1,0]);
}
module bevel_top_right(pos=[0,0,0],radius=20,depth=10) {
    bevel(pos,radius,depth,[-1,-1],[0,0]);
}

module add_bottom_right(pos=[0,0,0],radius=20,depth=10) {
    bevel(pos,radius,depth,[-1,1],[0,-1]);
}

module bevel(pos=[0,0,0],radius=20,depth=10,factor=[1,-1],t=[-1,0]) {
    
    translate([pos[0],pos[1]+radius*factor[0],pos[2]+radius*factor[1]])
    difference(){
        difference(){
            translate([0,-radius,-radius]) cube([depth,radius*2,radius*2]);
            difference(){
                translate([0,-radius,-radius]) cube([depth,radius*2,radius*2]);
                translate([0,radius*t[0],radius*t[1]]) cube([depth,radius,radius]);
            }
        }
        rotate(a=[0, 90, 0]) cylinder(h = depth, r = radius, $fn= 50);
    }
}