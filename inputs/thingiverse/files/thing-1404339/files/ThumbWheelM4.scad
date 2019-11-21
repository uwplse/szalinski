//src=http://www.thingiverse.com/thing:225188
//M3 to M4 Size & Flat Print - Edited 10/3/2016

// Radius of thumbwheel (mm)
rw=12;
// Height of thumbwheel (mm)
hw=3;

// Width of nut (Flat to Flat in mm)
rm4_ac=7/2/cos(360/12)-0.1;
// Height of the nut (mm)
hm4=5;
// Hole for the screw to go through (mm)
// eg. M4 = 4mm Bolt + 1mm = 5
rm4free=5/2;
// Height of nut trap 90% of nut height (mm)
h1=hm4*.9;
// outer radius of nut trap (mm)
r1=rm4_ac+1.5;

// Scale 1=out 2=in
scale_type=2;

//height of scale
hs=.5;
//width of scale
ws=.5;
// number of major ticks
nm=5;
// small number for overlapp
e=0.1;
e2=2.0;
echo(hw+h1);

grip=30;
grip_gap=1.8;
grip_depth=0.6;
grip_angle=55;

module Grip() {
    rotate([grip_angle,0,0]) cube([1,grip_gap,hw*2],center=true); 
    rotate([-grip_angle,0,0]) cube([1,grip_gap,hw*2],center=true); 
}
module Grip2() {
    for (angle=[-grip_angle,grip_angle]) {
    hull(){
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
		rotate(360/nm*(i+0.59)) {
           translate([r1+1+((rw-r1)-2)/2+0.5,-1.8,hw]) rotate([0,0,90]) linear_extrude(height = hs) text(text = str(i+1),font="DejaVu Sans Mono:style=Bold", size=2.0);
        }
	
    }
    
module ThumbWheelM4(){
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

ThumbWheelM4();