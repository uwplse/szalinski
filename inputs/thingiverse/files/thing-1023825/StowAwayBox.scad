// Customizable Connectors
// Author Mathias Dietz
// http://gcodeprintr.dietzm.de

//Width
x=115;
//Length
y=230;
//Height
h=100;
//Wall thickness
thx=2;
//Bottom thickness
bt=1.60;
//Radius handles 
l2=16;

//Handle inset
inset=0;// [0:yes,1:no]

/* [Hidden] */
//l=0; //Save material by adding holes to the bottom

box(); 
if ( inset==0 ){
 translate([x+l2*2,y/2-l2*2,0]) griffeinsatz();
 translate([x+l2*2,y/2+l2*2,0]) griffeinsatz();
}

module box(){
difference(){
cube([x,y,h]);
//innere kante
translate([thx,thx,bt]) cube([x-(2*thx),y-(2*thx),h]);

//BODENLÖCHER
//translate([x/2,y/2,0])  cylinder(r=l,h=bt);
//translate([x/4,y-y/4,0])  cylinder(r=l,h=bt);
//translate([x/4,y/4,0])  cylinder(r=l,h=bt);
//translate([x-x/4,y/4,0])  cylinder(r=l,h=bt);
//translate([x-x/4,y-y/4,0])  cylinder(r=l,h=bt);

//GRIFFE
translate([x/2,-0.5,h-l2-(3*thx)]) rotate([-90,0,0]) cylinder(r=l2,h=y+2);
}
}

module griffeinsatz(){
$fn=90;
difference(){
union(){
cylinder(r=l2-0.6,h=3);
cylinder(r=l2+2,h=1);
}
cylinder(r=l2-3,h=3);

}
}