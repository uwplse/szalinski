// Customizable Cube Gears
// Note: the assembly is animated

use <MCAD/involute_gears.scad>
//use <../pins.scad>
use <write/Write.scad>

choose(i=object);

//Choose which part to render (assembly is only for viewing)
object=1;//[0:Center,1:Large Gear,2:Small Gear,3:Pin,5:Assembly]
//Numbers of teeth on gears
type=2;//[0:18 & 9,1:9 & 6,2:18 & 15]
//Length of cube edges
size=50;
//Tolerance only affects pins (larger is looser)
tol=0.5;
//Ratio of length of pin gap to pin diameter (smaller is stiffer)
gap=2;//[1:2]
//Space between gear teeth
Backlash=0.5;
//First word on large gear
word1="";
//Second word on large gear
word2="";
//Third word on large gear
word3="";
//Height of words
fontsize=6;
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

use <utils/build_plate.scad>
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1:Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

rf1=size;// distance from center of cube to end of gear 1 (before clipping)
pd=rf1*7/50;// pin shaft diameter
ph=pd*gap;// pin gap length
pc=rf1*0.35;// pin height clearance on gears
pL=rf1*0.54;// pin length
$fs=0.5*1;// adjust number of faces in holes

NR=[[18,9,0.7493,0.3746,1,0.24],
	[9,6,0.6860,0.4573,2,0.24],
	[18,15,0.6285,0.5238,5,0.3]];

Nr=NR[type];
n1=Nr[0];// number of teeth on gear 1
n2=Nr[1];// number of teeth on gear 2
r1=Nr[2];// these two numbers come from gearopt.m
r2=Nr[3];
nt=Nr[4];// number of turns per cycle
cp=Nr[5];// percentage of rf1 for the center block
dc=rf1/sqrt(1-pow(r1,2));
theta=asin(1/sqrt(3));
pitch=360*r1*dc/n1;
rf2=sqrt(pow(dc,2)-pow(r2*dc,2));

module choose(i=0){
	if(i==0)translate([0,0,rf1*cp])center();
	if(i==1)gear1();
	if(i==2)gear2();
	if(i==3)longpin();
	if(i==4){twogears();rotate([theta+90,0,0])center();}
	if(i==5)assembly();
	if(i<4)build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}

module assembly()
rotate([0,0,45]){
	rotate([theta+90,0,0])center();
	twogears();
	rotate([0,0,180])twogears();
	rotate([180,0,90])twogears();
	rotate([180,0,-90])twogears();
}

module twogears(){
	rotate(a=[0,90-theta,90])rotate([0,0,nt*120*$t])translate([0,0,rf1*cp])gear1();
	rotate(a=[0,90-theta,0])rotate([0,0,-nt*n1/n2*120*$t])translate([0,0,rf2*cp])gear2();
}

module longpin()
union(){
	translate([0,pL/2-ph,0])pin_horizontal(r=pd/2,h=ph,t=tol);
	pinshaft(r=pd/2,h=pL-2*ph+0.2,side=true,t=tol);
	rotate([0,0,180])translate([0,pL/2-ph,0])pin_horizontal(r=pd/2,h=ph,t=tol);
}

module center(){
intersection(){
	box();
	rotate([2*(90-theta),0,0])box();
	rotate([2*(90-theta),0,120])box();
	rotate([2*(90-theta),0,-120])box();
	rotate(-[theta+90,0,0])rotate([0,0,45])cube(0.85*size,center=true);
}}

module box(){
//render(convexity=2)
translate([0,0,(rf2-rf1)*cp/2])difference(){
	cube(size=[dc,dc,(rf1+rf2)*cp],center=true);
	translate([0,0,-(rf1+rf2)*cp/2])pinhole(h=pL-(rf1*(1-cp)-pc),r=pd/2,fixed=true);
	rotate([180,0,0])translate([0,0,-(rf1+rf2)*cp/2])pinhole(h=pL-(rf1-rf2*cp-pc),r=pd/2,fixed=true);
}}

module gear1(){
//render()
intersection(){
	translate([0,0,-rf1*cp])rotate([0,theta-90,0])rotate([0,0,45])difference(){
		cube(size=size, center=true);	
		rotate([0,0,45-180])translate([0,rf1/sqrt(2)-3,rf1/2])monogram(h=2);
		text(word1);
		rotate([-90,0,-90])text(word2);
		rotate([90,-90,0])text(word3);
	}
	difference(){	
		translate([0,0,rf1*(1-cp)])rotate([180,0,90/n1])
		bevel_gear (number_of_teeth=n1,
			outside_circular_pitch=pitch,
			cone_distance=dc,
			face_width=dc*(1-cp),
			bore_diameter=0,
			backlash=Backlash,
			finish=0);	
		pinhole(h=rf1*(1-cp)-pc,r=pd/2,tight=false);	
	}
}}

module gear2(){
//render()
intersection(){
	translate([0,0,-rf2*cp])rotate([0,theta-90,0])rotate([0,0,45])cube(size=size, center=true);
	difference(){
		translate([0,0,rf2*(1-cp)])rotate([180,0,90/n2])
		bevel_gear (number_of_teeth=n2,
			outside_circular_pitch=pitch,
			cone_distance=dc,
			face_width=dc*(1-cp),
			bore_diameter=0,
			backlash=Backlash,
			finish=0);
		pinhole(h=rf1-rf2*cp-pc,r=pd/2,tight=false);
	}
}}

module text(word)
rotate([0,0,45-180])translate([0,rf1*0.35,rf1/2])
	write(word,t=2,h=fontsize,center=true,font=Font);

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[2,5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}

// This is Pins V3, copied here because V2 is all customizer has to offer.

module pinhole(h=10, r=4, lh=3, lt=1, t=0.3, tight=true, fixed=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = extra tolerance for loose fit
  // tight = set to false if you want a joint that spins easily
  // fixed = set to true so pins can't spin
  
intersection(){
  union() {
	if (tight == true || fixed == true) {
      pin_solid(h, r, lh, lt);
	  translate([0,0,-t/2])cylinder(h=h+t, r=r, $fn=30);
	} else {
	  pin_solid(h, r+t/2, lh, lt);
	  translate([0,0,-t/2])cylinder(h=h+t, r=r+t/2, $fn=30);
	}
    
    
    // widen the entrance hole to make insertion easier
    //translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2),$fn=30);
  }
  if (fixed == true) {
	translate([-r*2, -r*0.75, -1])cube([r*4, r*1.5, h+2]);
  }
}}

module pin(h=10, r=4, lh=3, lt=1, t=0.2, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally

  if (side) {
    pin_horizontal(h, r, lh, lt, t);
  } else {
    pin_vertical(h, r, lh, lt, t);
  }
}

module pintack(h=10, r=4, lh=3, lt=1, t=0.2, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt, t);
  }
}

module pinpeg(h=20, r=4, lh=3, lt=1, t=0.2) {
  union() {
    translate([0,-0.05, 0]) pin(h/2+0.1, r, lh, lt, t, side=true);
    translate([0,0.05, 0]) rotate([0, 0, 180]) pin(h/2+0.1, r, lh, lt, t, side=true);
  }
}

// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=10, r=4, lh=3, lt=1, t=0.2) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r-t/2, lh, lt);
    
    // center cut
    translate([-lt*3/2, -(r*2+lt*2)/2, h/5+lt*3/2]) cube([lt*3, r*2+lt*2, h]);
    //translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    translate([0, 0, h/5+lt*3/2]) rotate([90, 0, 0]) cylinder(h=r*2, r=lt*3/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -r-r*0.75+t/2, -1]) cube([r*4, r, h+2]);
    translate([-r*2, r*0.75-t/2, -1]) cube([r*4, r, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=10, r=4, lh=3, lt=1, t=0.2) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  translate([0, 0, r*0.75-t/2]) rotate([-90, 0, 0]) pin_vertical(h, r, lh, lt, t);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}

module pinshaft(h=10, r=4, t=0.2, side=false){
flip=side ? 1 : 0;
translate(flip*[0,h/2,r*0.75-t/2])rotate(flip*[90,0,0])
intersection(){
	cylinder(h=h, r=r-t/2, $fn=30);
	translate([-r*2, -r*0.75+t/2, -1])cube([r*4, r*1.5-t, h+2]);
}
}