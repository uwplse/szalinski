$fn = 50*1;
//Desk thikness
desk_thikness = 32.8;
//Clip width
clip_width = 12;


difference(){
	union(){	
		cube([desk_thikness+8,27,clip_width]);
		hull(){
			translate([0,27,3]) rotate ([0,90,0]) cylinder(desk_thikness+8,r=3);
			translate([0,27,clip_width-3]) rotate ([0,90,0]) cylinder(desk_thikness+8,r=3);
		}	
	}
		translate([4,4,0]) cube([desk_thikness,27,clip_width]);
}

difference() { 
	hull(){
			cube([0.1,20,clip_width]);
			translate([-9,5,clip_width/2]) cylinder(clip_width,r = 10,center = true);
		}
	translate([-9,5,0]) cylinder(clip_width,r = 6);
	linear_extrude(clip_width){
		translate([-9,5,0]) polygon([[9,-5],[6, 0],[0, -6],[0, -10],[0, -6],[9, -10]]);}

	
}
difference(){
	hull(){
		translate([-9,-1,clip_width-3]) rotate ([90,0,0]) cylinder(4,r=3);
		translate([-9,-1,3]) rotate ([90,0,0]) cylinder(4,r=3);
	}
	translate([-12,-1,0]) rotate ([90,0,0]) cube([2.9,clip_width,5]);
}