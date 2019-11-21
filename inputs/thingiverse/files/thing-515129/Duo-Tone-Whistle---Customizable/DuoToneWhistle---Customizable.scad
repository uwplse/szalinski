/* Dual Tone Whistle - Customizable */
/* 2014-10-25 Roman Hegglin */

/* [Main Settings] */
//Diameter of the first loop
dia1=54;

//Diameter of the second loop
dia2=34;

//Height
height=14;

/* [Advanced Settings] */

// The mesh resolution

mesh_resolution=50; // [20:120]


$fn=mesh_resolution; 

difference()
{
//translate([0,0,-3])
//body
union(){
//loop 1 near Mouthpiece
translate([0,dia1/2-3.5,0])
difference() {
cylinder(r=dia1/2, h=height,center=true);
cylinder(r=dia1/2-7, h=height+1,center=true);
}
//loop 2
translate([0,-dia2/2+3.5,0])
difference() {
cylinder(r=dia2/2, h=height,center=true);
cylinder(r=dia2/2-7, h=height+1,center=true);
}
//Mouthpiece
difference() {
translate([dia1/4,dia1/4*3-3.5,0])
cube(size = [dia1/2,dia1/2,height], center = true);
translate([0,dia1/2-3.5,0])
cylinder(r=dia1/2-7, h=height+1,center=true);
}

translate([(dia1/2+17)/2,dia1-7,0])
cube(size = [dia1/2+17,7,height], center = true);


}

//cavity
difference() {
union(){
//loop 1 near Mouthpiece
translate([0,dia1/2-3.5,0])
difference() {
cylinder(r=dia1/2-1, h=height-3,center=true);
cylinder(r=dia1/2-7+1, h=height+1-3,center=true);
}
//loop 2
translate([0,-dia2/2+3.5,0])
difference() {
cylinder(r=dia2/2-1, h=height-3,center=true);
cylinder(r=dia2/2-7+1, h=height+1-3,center=true);
}
//Mouthpiece
difference() {
translate([dia1/4,dia1/4*3-3.5,0])
cube(size = [dia1/2-2,dia1/2-2,height-3], center = true);
translate([0,dia1/2-3.5,0])
cylinder(r=dia1/2-7+1, h=height+1,center=true);
}

hole1 ();
hole2 ();

}
add1 ();
add2 ();
}
}

module hole1 () 
{
hull() {//blowcanal
translate([dia1/2+17,dia1-7,0])
cube(size = [0.1,5,height-3], center = true);

translate([dia1/2-2,dia1-7,0])
cube(size = [0.1,2,height-3], center = true);
}
}

module hole2 ()
{
hull() {//whislte hole
translate([dia1/2-7,dia1-3.5,0])
cube(size = [10,0.1,height-3], center = true);
translate([dia1/2-3,dia1-4-2,0])
cube(size = [2.5,0.1,height-3], center = true);
}
translate([dia1/2-3,dia1-5.5,0])
cube(size = [2.5,7-2,height-3], center = true);
}

module add1 ()
{
difference () {
hull() {
translate([dia1/4,dia1-3.5-1,0])
cube(size = [dia1/3,0.1,height-2], center = true);
translate([dia1/2-7,dia1-3.5-2.5,0])
cube(size = [7.5,0.1,height-2], center = true);
}
hole2 ();
}
}

module add2 ()
{
difference () {
translate([dia1/2-1.5,dia1-7,0])
cube(size = [1,7,height-2], center = true);

hole1 ();
}
}

