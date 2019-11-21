//
// Title:           Parametric spoked Wheel
// Version:      1.009
// Release Date: 20170521 (ISO)
// Author:        David Larsson
// License:      Creative Commons - Attribution - Non-Commercial - Share Alike
//
// customizable as filament spool hub (need two of them)
// adjustable diameter, number of spokes, center hole diameter etc

// 20170521 more tolerance for spool diameter

// #################################
// customizer notation by David Larsson 20170426

// make a filament spool hub
fil_hub=0; // [0:"no",1:"yes"]

// wheel diameter
wheel_diam=52; // [10:180]

// number of spokes
no_of_spokes=16; // [4:4,8:16,12:24,16:32,20:40,24:48,28:56]

// wheel rim width
wheel_width=7; // [4:.1:20]

// center enlargement on one side
hub_offs=1; // [1:.1:3]

// center hole diameter
hole_diam=6; // [4:.1:12]

// generate center pin with washer and lock ring
pin=0; // [0:dont,1:generate center pin]

// pin extension on each side, only when pin selected 
axis_length=8; // [4:.1:12]

// #################################

echo(version=version());

eps=.1;

vstep=no_of_spokes/4;
fil_r=wheel_diam/2 - eps; 
fil_ri=fil_r - 2*eps; 
inner_r=fil_r-2;
aussen_r=fil_r+4;
aussen_h=2;

cyl_inner_r=hole_diam/2;
cyl_h=wheel_width+hub_offs;
cyl_aussen_r=cyl_inner_r+wheel_diam/20;
fil_height=2*wheel_width;

// Filament hub
difference() {
  union() {
    if( fil_hub==0 ) {
//    rim
      color("blue")
		translate([0,0,0])
		  cylinder(wheel_width,fil_r,fil_r, $fn=60,$fa=3,center=false);
	}
	if( fil_hub==1 ) {
//    rim
      color("blue")
		translate([0,0,0])
		  cylinder(wheel_width,fil_r,fil_ri, $fn=60,$fa=3,center=false);
//    fit cone
      color("green")
      translate([0,0,wheel_width])
      cylinder(wheel_width/2,fil_ri,inner_r+1, $fa=3,center=false);
//    outer rim
      color("blue")
      cylinder(aussen_h,r=aussen_r,$fa=3,center=false);
    }
  }
  translate([0,0,-1])
    cylinder(wheel_width+34,r=inner_r,center=false);
}

//center
difference() {
//  translate([0,0,cyl_h])
    cylinder(cyl_h,cyl_aussen_r,cyl_aussen_r,center=false);
  translate([0,0,-1])
    cylinder(cyl_h+4,cyl_inner_r,cyl_inner_r, $fn=60,center=false);
}

module spoke(c,z,t) {
    st=fil_r/32;
    echo(st);
    ex=wheel_width/2+.2; 
   if(z==0) {
        ex=wheel_width/2; 
    }
    if(z!=0) {
        zz=2*cyl_h/3;
        ex=wheel_width/2; 
    }
intersection() {
//bounding cylinder
    translate([0,0,-eps])
      cylinder(wheel_width,inner_r+eps,inner_r+eps, $fa=3,center=false);
union() {
  color(c)
    translate([-fil_r,t-st,z])
        linear_extrude(ex)
          square([2*fil_r,st]);
  color(c)
    translate([-fil_r,-t,z])
        linear_extrude(ex)
          square([2*fil_r,st]);
}
}
}

//spokes
vleap=180/vstep;
for(v=[0:vleap:179])
rotate([0,0,v])
spoke("red",0,cyl_aussen_r);
for(v=[0:vleap:179])
rotate([0,0,v+vleap/2])
spoke("orange",wheel_width/2,cyl_aussen_r);

//optional center pin
if( pin == 1) {
//pin
  translate([fil_r+hole_diam+3,0,0])
    cylinder(2,cyl_aussen_r,cyl_aussen_r,center=false);
  translate([fil_r+hole_diam+3,0,0])
    cylinder(cyl_h+2*axis_length,cyl_inner_r-.17,cyl_inner_r-.17, $fn=60,center=false);

//pin washer
  translate([0,fil_r+hole_diam+3,0])
difference() {
    cylinder(hub_offs,cyl_aussen_r,cyl_aussen_r,center=false);
  translate([0,0,-1.2])
    cylinder(cyl_h+axis_length,cyl_inner_r+.3,cyl_inner_r+.3, $fn=60,center=false);
}
//pin locker
  translate([-(fil_r+hole_diam+3),0,0])
difference() {
    cylinder(hub_offs,cyl_aussen_r,cyl_aussen_r,center=false);
  translate([0,0,-1.2])
    cylinder(cyl_h+axis_length,cyl_inner_r+.1,cyl_inner_r+.1, $fn=60,center=false);
}
}

