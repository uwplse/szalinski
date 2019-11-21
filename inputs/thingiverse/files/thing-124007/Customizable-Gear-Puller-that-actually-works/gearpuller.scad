// Created by Jakub Husak, Poland, 27.07.2013
// Licence: Attribution - Non-Commercial - Share Alike
// Script to create a customizable gear puller. It could be important that
// the gear fits tightly and the lower part is as thick as the gap between
// motor and gear.

// Thick of bottom collar
hbottom=5; // [3:10

// Height of the lower part of the gear
hgear=7;

// Radius of the lower part of the gear
rgear=7; // [4:20]

// Height of the upper part of the gear
hgeart=7; // [0:20]

// Radius of the uppper part of the gear
rgeart=8.5; // [4:20]

// Thick of the top (must be more thick as the pins and nut together plus 2 mm)
htop=11; // [5:20]

// Radius of the motor shaft
rshaft=2.8; 

// Radius of the pins
rrivet=1.2;

// Thick of the nut
hnut=4; // [3:6]

// Nut size 
snut=8; // [6:13]

/* */
oheight=hbottom+hgear+hgeart+htop;
$fn=32;


rotate([0,-90,0])
difference()
{
cube([4*rgear,5*rgear,oheight]);
translate([2*rgear,2.5*rgear,0])
dig();
}

module dig()
{
niche();
shaft();
translate([0,0,hbottom+hgear+hgeart+hnut])
rivetholes(1,32,1);
rotate([0,0,70])
translate([0,0,hbottom])
rivetholes(-1,4,1.415);
}

module niche()
{
minkowski(){
hole();
cube([2*rgear,0.001,0.001]);
}

}
module hole()
{
cylinder(h=hbottom, r=rshaft);
translate([0,0,hbottom])
cylinder(h=hgear, r=rgear);
translate([0,0,hbottom+hgear])
cylinder(h=hgeart, r=rgeart);
}

module shaft()
{
cylinder(h=oheight, r=rshaft);
translate([0,0,hbottom+hgear+hgeart])
rotate([0,0,30])
cylinder(h=hnut, r=snut/2/0.87+0.2, $fn=6);

}

module rivetholes(off,c,d)
{
$fn=c;
for (i=[-1,1])
rotate([90,0,90])
translate([i*(rshaft+rrivet),off*rrivet,0])
rotate([0,0,45])
cylinder(r=rrivet*d,h=100,center=true);


}
