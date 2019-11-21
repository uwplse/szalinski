//src=http://www.thingiverse.com/thing:225188


$fn=80;

// radius of thumbwheel
rw=12; // [4:24]

// height (thickness) of thumbwheeel
hw=3; // [0.2:0.2:10]

//nut size
nut_size=5.5;  // [3:0.1:12]

// height of the nut
hm4=2.5; // [0.2:0.1:8]

// hole for the screw to go through without toughing
rm4free=2; // [1:0.1:4]

nut_depth_percentage=90;   // [10:10:120]

// nut trapp wall strength
nut_trapp_wall_strength=1.5;  // [0.5:0.1:5]

//scale in or out
scale_type=2; // [1:out, 2:in]

//height of scale
hs=0.5; // [0:0.1:3]

//width of scale
ws=0.5; // [0.2:0.2:3]

// number of major ticks
nm=5; // [2:12]

// *******************************************************

rm4_ac=nut_size/(2*cos(360/12))-0.1;

// height of nut trapp 90% of nut height
h1=hm4*nut_depth_percentage/100;

// outer radius of nut trapp
r1=rm4_ac+nut_trapp_wall_strength;

e=0.01+0;
e2=1.4+0;

grip=30+0;
grip_gap=1.8+0;
grip_depth=0.6+0;
grip_angle=55+0;


module Grip() {
    rotate([grip_angle,0,0]) cube([1,grip_gap,hw*2],center=true); 
    rotate([-grip_angle,0,0]) cube([1,grip_gap,hw*2],center=true); 
}
module Grip2() {
    for (angle=[-grip_angle,grip_angle]) {
    	hull() {
    		rotate([angle,0,0]) cube([grip_depth*2,0.1,hw*2],center=true); 
    		rotate([angle,0,0]) translate([1,0,0]) cube([1,grip_gap,hw*2],center=true); 
    		}
	}
}

module Scale() {
	for(i=[0:nm-1])
		rotate(360/nm*i)
			translate([r1,-ws/2,hw])cube([(rw-r1)-1,ws,hs]);
	for(i=[0:nm*2-1])
		rotate(360/nm/2*i)
			translate([r1+1+((rw-r1)-2)/2+1,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
	for(i=[0:nm*10-1])
		rotate(360/nm/10*i)
			translate([r1+1+((rw-r1)-2)/4*3,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
    
    	for(i=[0:nm-1])
		rotate(360/nm*(i+0.5)) {
           translate([r1+1+((rw-r1)-2)/2+0.5,-1.8,hw]) rotate([0,0,90]) linear_extrude(height = hs) text(text = str(i+1),font="DejaVu Sans Mono:style=Bold", size=3.8);
        }
	
    }
    
module ThumbWheelM3(){
	//color("lime")
	difference(){
		union(){
			cylinder(hw,rw,rw,$fn=nm*30);
			translate([0,0,hw-e-e2])cylinder(h1+e,r1+2,r1);
		}
		translate([0,0,-1])cylinder(hw+h1+2,rm4free,rm4free,$fn=24);
		translate([0,0,0])cylinder(hm4,rm4_ac,rm4_ac,$fn=6);
//		translate([0,0,hw-e2])cylinder(hm4,rm4_ac,rm4_ac,$fn=6);
        
 
        for (i=[0:grip]) {
            rotate([0,0,360/grip*i]) translate([rw+0.5-grip_depth,0,hw/2]) Grip2(); 
        }
	if(scale_type==2) {
       translate([0,0,-hs+0.02]) Scale();
    }
        }
        if(scale_type==1) {
            color("black"){
	Scale();
            }
        }
}

ThumbWheelM3();
