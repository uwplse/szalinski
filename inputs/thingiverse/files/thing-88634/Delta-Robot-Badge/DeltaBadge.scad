// rrhb 5/14/2013 creative commons

text="Delta  Robot  Fan"; // border text
size=6;                   // overall size in cm
letter_scale=1.0;         // scale of the letters   
project=[30,-50,10];      // projection angle deltabot model in badge
zraise=2;                 // amount to raise each layer
backh=3;                  // height of the back

offset=[0]; 
     
// these are not in the scaled units
ring_thickness=8; // how thick the is the ring
ring_start=140;  // distance from radius ring starts

// kossel 'model' parameters
// thx to my friend jrocholl for introducing delta printers to reprap
h=200;   // height
r=100;   // radius
base_sides=3;   // 3 for "kossel", a big number for a 'round' top and bottom
t=10;    // thickness of top and bottom
beam=10; // thickness of 'pillars'
rod=4;   // thickness of 'carbon rods'
ang=220; // angle of rods
arm=120; // arm length

include <spiffsans.scad>; // thx stuartpb spiffsans http://www.thingiverse.com/thing:13347


//deltabot();
scale(size*.025,size*.025,1) badge();

module badge() {
  linear_extrude(height=backh) back();
  linear_extrude(height=backh+zraise) rings();
  linear_extrude(height=backh+zraise*2) letters(text);
  linear_extrude(height=backh+zraise*2) projection(cut=false) rotate(project) deltabot(all=false,bottom=true);
  linear_extrude(height=backh+zraise*3) projection(cut=false) rotate(project) deltabot(all=false,effector=true);
  linear_extrude(height=backh+zraise*4) projection(cut=false) rotate(project) deltabot(all=false,pillars=true);
  linear_extrude(height=backh+zraise*5) projection(cut=false) rotate(project) deltabot(all=false,top=true);
}

// render badge back
module back() {
     circle(r=ring_start+letter_scale*50+ring_thickness);
}

// render rings
module rings() {
  difference() { // inner ring
     circle(r=ring_start+ring_thickness);
     circle(r=ring_start);
    }
  difference() {  // outer ring
     circle(r=ring_start+letter_scale*50+ring_thickness);
     circle(r=ring_start+letter_scale*50);
    }
}

// render letters
module letters(text,orientation=270) {
  for (i=[0:len(text)]) {
		rotate([0,0,orientation-i*15]) translate([0,145,0]) 
        scale([letter_scale*5,letter_scale*5,letter_scale*5]) spiffsans_puts(text[i],1,offset);
  }
}

// a tiny model of a deltabot.  
// it's a bit hideus but serves the purpose
// the rendering flags are set to render the projection in layers
module deltabot(all=true,bottom=false,top=false,pillars=false,effector=false) {
  translate([0,0,-h/2]) {
    if (all || bottom) cylinder(r=100,h=t,$fn=base_sides);  // bottom
    // if (all || bottom) cylinder(r=50,h=t);  // "round" heating plate if you want it
    for (i=[0:120:240]) {
     translate([r*cos(i),r*sin(i),0]) translate([0,0,h/2]) { 
       if (all || pillars) cube([beam,beam,h],true);
       if (all || effector) { translate([0,0,h/3])
         rotate([0,0,i]) rotate([0,ang,0]) { 
           translate([0,beam/2,0]) cylinder(r=rod/2,h=arm);
           translate([0,-beam/2,0])cylinder(r=rod/2,h=arm);
         }
       }
     }
  }
  if (all || effector) translate([0,0,h/2+h/3-arm*cos(ang-180)]) rotate([0,0,30]) cylinder(r=30,h=5,$fn=6); // effector

  if (all || top) translate([0,0,h-t]) difference() {
        cylinder(r=100,h=t,$fn=base_sides);  // top
        cylinder(r=100-beam,h=t,$fn=base_sides);  // comment out if you want a solid top
     }

  }
}