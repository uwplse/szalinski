//src=http://www.thingiverse.com/thing:225188
//modified by aqee@msn.com

HasGrip=1; //set  0 to render faster while debugging. 

$fn=80;
// radius of thumbwheel
rw=20;
// hight of thumbwheeel
hw=4;

//aqee
screw_radius=15/2+0.05; //if 0, then use M3 nut as default
screw_height=3.3;

//size of nut
rm4_ac=5.5/2/cos(360/12)-0.1;
// height of the nut
hm4=2.5;
// hole for the screw to go through without toughing
rm4free=4/2;
// hight of nut trapp 90% of nut height
h1=hm4*.9;
// outer radius of nut trapp
r1=rm4_ac+1.5;

//scale in or out
scale_type=2; //1=out 2=in

//height of scale
hs=.5;
//width of scale
ws=.5;
// number of major ticks
nm=5;
// small number for overlapp
e=0.01;
e2=1.4;
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
    //echo("r1111",r1+1+((rw-r1)-2)/2);
	union(){
    for(i=[0:nm-1])
		rotate(360/nm*i)
			translate([r1+1+((rw-r1)-2)/8*5.2,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
	for(i=[1:nm])
		rotate(360/nm*(i+0.5))
			translate([r1+1+((rw-r1)-2)/2+1,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
     	
    for(i=[0:nm-1])
		rotate(360/nm*(i+0.5)) {
           translate([r1+1+((rw-r1)-2)/2+0.5,-1.8,hw]) rotate([0,0,90]) linear_extrude(height = hs) text(text = str(i),font="Microsoft YaHei UI", size=3.5);//"DejaVu Sans Mono:style=Bold"
        }
	   }
    for(i=[0:nm*10-1])
		rotate(360/nm/10*i)
			translate([r1+1+((rw-r1)-2)/4*3,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
    

    }
    
module ThumbWheelM3(){
	//color("lime")
	difference(){
		union(){
			cylinder(hw,rw,rw,$fn=nm*30);
			translate([0,0,hw-e-e2])
            if(screw_radius>0)
                cylinder(h1+e,screw_radius+0.5+2,screw_radius+0.5);
            else
                cylinder(h1+e,r1+2,r1);
		}
        if(screw_radius>0){
                translate([0,0,hw-screw_height])
                cylinder(screw_height*2, screw_radius, screw_radius, $fn=24);
            }
            else{
            translate([0,0,-1])cylinder(hw+h1+2,rm4free,rm4free,$fn=24);
            translate([0,0,0])cylinder(hm4,rm4_ac,rm4_ac,$fn=6);
    //		translate([0,0,hw-e2])cylinder(hm4,rm4_ac,rm4_ac,$fn=6);
            }
        
        if(HasGrip)
        {
            for (i=[0:grip]) {
                rotate([0,0,360/grip*i]) translate([rw+0.5-grip_depth,0,hw/2]) Grip2(); 
            }
        }
        if(scale_type==2) {
           translate([0,0,-hs+0.02]) Scale();
        }
        }
        if(scale_type==1) {
            color("black") Scale();
        }
}

ThumbWheelM3();
