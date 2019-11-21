// Licence: Creative Commons, Attribution
// Created: 16-02-2013 by bmcage http://www.thingiverse.com/bmcage

// An attempt at customizable math art: Stick Bowl

//Make it a bowl or not
add_bottom = "yes";  //[yes, no]
//If a bowl, size of the bottom
bottom_height = 2; //[1:20]

//Form of the sticks to use
base_form = "beam";  // [beam, cylinder, hexagon, triangle]
//Size of the sticks
size = 4; //[1:20]
//Scaling in second direction of sticks
scale_second_dir = 1; // [0.1, 0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5]

//start radius
r0 = 30; //[2:200]

// number of sticks per ring
nrsticks = 10; //[4:50]
grad_per_stick = 360 / nrsticks;

// radius of the first ring
first_radius = 50; // [0:200]
// height if the first ring
first_height = 40;  // [0:300]
// extend beyond radius of first sticks
first_extend = 1;  //[0:100]
//how skewed (rotated) first ring is in degrees
first_skew = 9;    //[-170:170]

// radius of the second ring (0 for no ring)
second_radius = 30; // [0:200]
// height if the second ring
second_height = 1;  // [0:300]
// extend beyond radius of second sticks
second_extend = 1;  //[0:100]
//how skewed (rotated) second ring is in degrees
second_skew = 9;    //[-170:170]

// radius of the third ring (0 for no ring)
third_radius = 50; // [0:200]
// height if the third ring
third_height = 40;  // [0:300]
// extend beyond radius of third sticks
third_extend = 1;  //[0:100]
//how skewed (rotated) third ring is in degrees
third_skew = 9;    //[-170:170]

// radius of the fourth ring (0 for no ring)
fourth_radius = 30; // [0:200]
// height if the fourth ring
fourth_height = 1;  // [0:300]
// extend beyond radius of fourth sticks
fourth_extend = 1;  //[0:100]
//how skewed (rotated) first ring is in degrees
fourth_skew = 9;    //[-170:170]

// radius of the fifth ring (0 for no ring)
fifth_radius = 0; // [0:200]
// height if the fifth ring
fifth_height = 20;  // [0:300]
// extend beyond radius of fifth sticks
fifth_extend = 2;  //[0:100]
//how skewed (rotated) fifth ring is in degrees
fifth_skew = -27;    //[-170:170]

// radius of the sixth ring (0 for no ring)
sixth_radius = 0; // [0:200]
// height if the sixth ring
sixth_height = 40;  // [0:300]
// extend beyond radius of sixth sticks
sixth_extend = 5;  //[0:100]
//how skewed (rotated) sixth ring is in degrees
sixth_skew = 90;    //[-170:170]

//maximum height of the object (object cut there)
max_height = 150; // [100:400]
//maximum width of the object (object cut there)
max_width = 145;  // [100:400]

use <MCAD/regular_shapes.scad>;
use <utils/build_plate.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 

bottomstart = -bottom_height; //-first_extend*first_radius/sqrt(pow(first_height,2)+pow(first_radius,2));

module baseform(length){
  scale([1,scale_second_dir,1]){
  if (base_form == "beam") {
    translate([-size/2, -size/2, 0]) cube(size=[size, size, length]);
  } 
  if (base_form == "cylinder") {
    cylinder(r=size, h=length, $fn=20);
  }
  if (base_form == "hexagon") {
    linear_extrude(height=length) hexagon(size);
  }
  if (base_form == "triangle") {
    linear_extrude(height=length) triangle(size);
  }
  }
}

module ringbaseform(r1, h1, skew1, r2, h2, skew2, extend){
  // a form with correct length if first ring is at r1, h1, and 
  // second at r2, h2, and extend is extend
  //
  // P = (r1, 0, h1), Q = (r2 cos(skew2), r2 sin(skew2), h2)
  // dir_new = (P-Q) / norm(P-Q) = (a,b,c)
  // rotate to new direction, euler angles
  // th_x = atan2(b,c); th_y = atan(-a, sqrt(b*b+c*c)) ; th_z = 0
  rotate([0,0,skew1])
  translate([r1, 0, h1]) 
  help_ringbaseform(r2*cos(-skew2)-r1, r2*sin(-skew2), h2-h1, extend);
}

module help_ringbaseform(a, b, c, extend)
{ 
  rotate([atan2(b/sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2)), 
                c/sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))), 0, 0])
  rotate([0, atan2(a/sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2)),
     sqrt(b*b/(pow(a, 2) + pow(b, 2) + pow(c, 2))
          +c*c/(pow(a, 2) + pow(b, 2) + pow(c, 2)))), 0])
  translate([0,0,-extend]) 
  baseform(sqrt(pow(a, 2) + pow(b, 2) 
                    + pow(c, 2)) + 2*extend);
}

module ring(ringnr){
  union() {
    for (i = [0:nrsticks]) {
      rotate([0,0,i*grad_per_stick]) {
        if (ringnr == 1) {
          ringbaseform(r0, 0, 0, first_radius, first_height, 
                       first_skew,  first_extend);}
        if (ringnr == 2){
          ringbaseform(first_radius, first_height, first_skew,
                       second_radius, second_height, second_skew,  
							  second_extend);}
        if (ringnr == 3)
          ringbaseform(second_radius, second_height, 
                       first_skew + second_skew,  
                       third_radius, third_height, third_skew,
							  third_extend);
        if (ringnr == 4)
          ringbaseform(third_radius, third_height,
							  first_skew + second_skew + third_skew,  
                       fourth_radius, fourth_height, fourth_skew,
							  fourth_extend);
        if (ringnr == 5)
          ringbaseform(fourth_radius, fourth_height,
  first_skew + second_skew + third_skew + fourth_skew,  
                       fifth_radius, fifth_height, fifth_skew,
							  fifth_extend);
        if (ringnr == 6)
          ringbaseform(fifth_radius, fifth_height, 
  first_skew + second_skew + third_skew + fourth_skew + fifth_skew,  
                       sixth_radius, sixth_height, sixth_skew,
							  sixth_extend);
      }
    }
  }
}

module bottom(){
  if (add_bottom == "yes") {
    translate([0,0,bottomstart]) 
      cylinder(r = r0+size, h=bottom_height);
  }
}

module bowl(){
union() {
  bottom();
  ring(1);
  if (second_radius > 0) {
  ring(2);}
  if (third_radius > 0) {
  ring(3);}
  if (fourth_radius > 0) {
  ring(4);}
  if (fifth_radius > 0) {
  ring(5);}
  if (sixth_radius > 0) {
  ring(6);}
}
}

intersection(){
  translate([0,0,-bottomstart]) bowl(); 
  translate([-max_width/2,-max_width/2,0]) 
    cube(size=[max_width,max_width,max_height]);
}
//echo(r0, 0, 0, first_radius, first_height,first_skew,  first_extend);
//ringbaseform(r0, 0, 0, first_radius, first_height, first_skew,  first_extend);
//echo(first_radius, first_height, first_skew, second_radius, second_height, second_skew, second_extend);
//ringbaseform(first_radius, first_height, first_skew, second_radius, second_height, second_skew, second_extend);



