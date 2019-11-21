BendRaduis=20;
height=10;
thickness=3;
Gap=15;

module TopJaw(){
	scale([1,.5,1])difference(){
		cylinder(r=BendRaduis,h=height);
		cylinder(r=BendRaduis-thickness*2,h=height);
		translate([-BendRaduis,0,-height])cube([BendRaduis*3,BendRaduis*3,height*3]);
	}
}
module BottomJaw(){
	difference(){
		scale([1,.5,1])cylinder(r=BendRaduis,h=height);
		scale([1,.5,1])cylinder(r=BendRaduis-thickness*2,h=height);
		translate([-BendRaduis,-BendRaduis*3,-height])cube([BendRaduis*3,BendRaduis*3,height*3]);
	}
}
module clip(){
	difference(){
		union(){
			translate([0,Gap/2,0])BottomJaw();
			translate([0,-Gap/2,0])TopJaw();
			translate([BendRaduis+Gap/2,0,0])cylinder(r=.75*BendRaduis,h=height);
		}
			
		translate([BendRaduis+Gap/2,0,0])cylinder(r=.75*BendRaduis-thickness,h=height);
		translate([1.3*BendRaduis+Gap/2,-BendRaduis*2,-height])cube([BendRaduis*4,BendRaduis*4,height*3]);

	}
}
clip();
