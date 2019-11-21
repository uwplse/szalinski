// Experimental <<SIN*U*SOID*AL>> Venturi for Flow Measurement
// Seems like a sine wave should be good...
// Copyright <senorjp@gmail.com> April 2019
//
// Whole part or split for printing
split = 1; // [1:Split,0:Whole]
// Outside (unrestricted) Diameter
od=100; // [10:300]
// Area ratio (higher number smaller throat)
ratio=3; // [1:20]
// Overall length
length=250; // [20:400]
// Trim fragile ends
crop=2; // [0:10]
// Diameter of tap hole in throat
tap_d=10; // [0:50]
// Tolerance for mating pins
pin_tol=1; // [0:2]
// Smoothness
$fa=2; // [.1:5]

/* [Hidden] */
initial_length=length+crop*2;
pi=3.14159;
step=10; // smoothness of sine wave
big_a=pi*pow(od/2,2);
small_a=big_a/ratio;
id=2*sqrt(small_a/pi);
height=(od-id)/4; // we are looking at the sine wave from top to bottom
//height=-100;

module venturi() {
    
difference() {
    rotate_extrude( convexity=10)
    translate([height+id/2,-initial_length/2]) 
    // sine wave is created as a polygon
	polygon(
        [
/*
		 // CODE FOR OPENSCAD-NIGHTLY
        for (a = [0 : step : 180])
        [ height*sin(a+90) , a * (initial_length/360)-tap_d/2],
        for (a = [180 : step : 360])
        [ height*sin(a+90) , a * (initial_length/360)+tap_d/2]
*/
//////// CODE FOR CUSTOMIZER ///////////////////////////
// Not sure why, but customizer and openscad 2014.03 give 
// syntax error on the for loops, above.
// As a work-around, the for loop is evaluated and
// included, below.  This is the bash script to do that:
/*
step=10
a=0
while [ $a -le 180 ]; do
  echo "[ height*sin($a+90) , $a * (initial_length/360)-tap_d/2],"
  a=$(( $a+$step ))
done
while [ $a -le 360 ]; do
  echo "[ height*sin($a+90) , $a * (initial_length/360)+tap_d/2],"
  a=$(( $a+$step ))
done
*/
[ height*sin(0+90) , 0 * (initial_length/360)-tap_d/2],
[ height*sin(10+90) , 10 * (initial_length/360)-tap_d/2],
[ height*sin(20+90) , 20 * (initial_length/360)-tap_d/2],
[ height*sin(30+90) , 30 * (initial_length/360)-tap_d/2],
[ height*sin(40+90) , 40 * (initial_length/360)-tap_d/2],
[ height*sin(50+90) , 50 * (initial_length/360)-tap_d/2],
[ height*sin(60+90) , 60 * (initial_length/360)-tap_d/2],
[ height*sin(70+90) , 70 * (initial_length/360)-tap_d/2],
[ height*sin(80+90) , 80 * (initial_length/360)-tap_d/2],
[ height*sin(90+90) , 90 * (initial_length/360)-tap_d/2],
[ height*sin(100+90) , 100 * (initial_length/360)-tap_d/2],
[ height*sin(110+90) , 110 * (initial_length/360)-tap_d/2],
[ height*sin(120+90) , 120 * (initial_length/360)-tap_d/2],
[ height*sin(130+90) , 130 * (initial_length/360)-tap_d/2],
[ height*sin(140+90) , 140 * (initial_length/360)-tap_d/2],
[ height*sin(150+90) , 150 * (initial_length/360)-tap_d/2],
[ height*sin(160+90) , 160 * (initial_length/360)-tap_d/2],
[ height*sin(170+90) , 170 * (initial_length/360)-tap_d/2],
[ height*sin(180+90) , 180 * (initial_length/360)-tap_d/2],
[ height*sin(190+90) , 190 * (initial_length/360)+tap_d/2],
[ height*sin(200+90) , 200 * (initial_length/360)+tap_d/2],
[ height*sin(210+90) , 210 * (initial_length/360)+tap_d/2],
[ height*sin(220+90) , 220 * (initial_length/360)+tap_d/2],
[ height*sin(230+90) , 230 * (initial_length/360)+tap_d/2],
[ height*sin(240+90) , 240 * (initial_length/360)+tap_d/2],
[ height*sin(250+90) , 250 * (initial_length/360)+tap_d/2],
[ height*sin(260+90) , 260 * (initial_length/360)+tap_d/2],
[ height*sin(270+90) , 270 * (initial_length/360)+tap_d/2],
[ height*sin(280+90) , 280 * (initial_length/360)+tap_d/2],
[ height*sin(290+90) , 290 * (initial_length/360)+tap_d/2],
[ height*sin(300+90) , 300 * (initial_length/360)+tap_d/2],
[ height*sin(310+90) , 310 * (initial_length/360)+tap_d/2],
[ height*sin(320+90) , 320 * (initial_length/360)+tap_d/2],
[ height*sin(330+90) , 330 * (initial_length/360)+tap_d/2],
[ height*sin(340+90) , 340 * (initial_length/360)+tap_d/2],
[ height*sin(350+90) , 350 * (initial_length/360)+tap_d/2],
[ height*sin(360+90) , 360 * (initial_length/360)+tap_d/2]
        ]
    );
    // Crop thin ends
    translate([0,0,length/2+od/2])
    cube([od*2,od*2,od], center=true);
    translate([0,0,-length/2-od/2])
    cube([od*2,od*2,od], center=true);

    // Tap
    translate([0,-od/2])
    rotate(90,[1,0,0])
    cylinder(r=tap_d, h=od, center=true);
}

}

module venturi_top() {
difference() {
    venturi();
    translate([0,length,0])
    cube([length*2,length*2,length*2], center=true);
}
translate([od/2-height,0,length/6])
rotate(90,[1,0,0])
cylinder(r=height/4, h=height/4, center=true);
translate([-od/2+height,0,length/6])
rotate(90,[1,0,0])
cylinder(r=height/4, h=height/4, center=true);
translate([od/2-height,0,-length/6])
rotate(90,[1,0,0])
cylinder(r=height/4, h=height/4, center=true);
translate([-od/2+height,0,-length/6])
rotate(90,[1,0,0])
cylinder(r=height/4, h=height/4, center=true);
}

module venturi_bottom() {
difference() {
    venturi();
    translate([0,-length,0])
    cube([length*2,length*2,length*2], center=true);

translate([od/2-height,0,length/6])
rotate(90,[1,0,0])
cylinder(r=height/4+pin_tol/2, h=height/4+pin_tol, center=true);
translate([-od/2+height,0,length/6])
rotate(90,[1,0,0])
cylinder(r=height/4+pin_tol/2, h=height/4+pin_tol, center=true);
translate([od/2-height,0,-length/6])
rotate(90,[1,0,0])
cylinder(r=height/4+pin_tol/2, h=height/4+pin_tol, center=true);
translate([-od/2+height,0,-length/6])
rotate(90,[1,0,0])
cylinder(r=height/4+pin_tol/2, h=height/4+pin_tol, center=true);
}
}

module venturi_pair_print() {
    translate([od/2+3,0,od/2])
    rotate(90,[1,0,0])
    venturi_top();

    translate([-od/2-3,0,od/2])
    rotate(-90,[1,0,0])
    venturi_bottom();
}
//venturi_top();
//venturi_bottom();
if (split == 1) {
    venturi_pair_print();
}
else {
    venturi();
}
