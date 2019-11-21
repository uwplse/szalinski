
use <write/Write.scad>
// preview[view:west, tilt:side]
text_on_pencil_identifier="cool story bro";
letter_height=5;//[3:8]
angle=10;//[-25:25]

difference(){
translate([0,0,0])
cylinder(r1=6,r2=7,h=25,center=true, $fn=128);

cylinder(r1=3.5,r2=4,h=50,center=true,$fn=6);

}

color([1,0,1])
writecylinder(text_on_pencil_identifier,[0,0,0],h=letter_height,6.5,25,space=1.2,rotate=angle,east=90,center=true );

