// Licence: Creative Commons, Attribution
// Created: 16-02-2013 by bmcage http://www.thingiverse.com/bmcage

// An attempt at customizable math art: Stick Bowl

//Make it a bowl or not
add_bottom = "no";  //[yes, no]
//If a bowl, size of the bottom
bottom_height = 2; //[1:20]

//Form of the sticks to use
base_form = "beam";  // [beam, cylinder, hexagon, triangle]
//Size of the sticks
size = 4; //[1:20]
//Scaling in second direction of sticks
scale_second_dir = 1; // [0.1, 0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5]

//dualstrusion pattern. Every ring another color, or even/odd coloring in a ring
dual_pat = "even_odd";  // [ring, even_odd]

//what part to show. Both, first dualstusion, or second dualstrusion, and finally bothorig which drops the scalefirst parameter.
part = "both";     // [both, bothorig, first, second]

//Paremeter to beat openscad dualstrusion generation into submission. In essense, part 'first' is scaled with this value, and 'second' part not. This removes the problem of differences of parts which share surfaces. If you did not understand this, don't worry, just leave it alone :-)
scalefirst = 1.005; //
//showcolor when both parts are shown. This gives a nice view of the final result, but requires more computing. Set to no before producing an stl!
showcolor = "no";   // [yes, no]
//start radius
r0 = 5; //[2:200]

// number of sticks per ring
nrsticks = 18; //[4:50]
grad_per_stick = 360 / nrsticks;

// radius of the first ring
01_radius = 50; // [0:200]
// height if the first ring
01_height = 0;  // [0:300]
// extend beyond radius of first sticks
01_extend = 1;  //[0:100]
//how skewed (rotated) first ring is in degrees
01_skew = 0;    //[-170:170]

// radius of the second ring (0 for no ring)
02_radius = 50; // [0:200]
// height if the second ring
02_height = 120;  // [0:300]
// extend beyond radius of second sticks
02_extend = 1;  //[0:100]
//how skewed (rotated) second ring is in degrees
02_skew = 0;    //[-170:170]

// radius of the third ring (0 for no ring)
03_radius = 60; // [0:200]
// height if the third ring
03_height = 40;  // [0:300]
// extend beyond radius of third sticks
03_extend = 1;  //[0:100]
//how skewed (rotated) third ring is in degrees
03_skew = 0;    //[-170:170]

// radius of the fourth ring (0 for no ring)
04_radius = 30; // [0:200]
// height if the fourth ring
04_height = 1;  // [0:300]
// extend beyond radius of fourth sticks
04_extend = 1;  //[0:100]
//how skewed (rotated) first ring is in degrees
04_skew = 0;    //[-170:170]

// radius of the fifth ring (0 for no ring)
05_radius = 0; // [0:200]
// height if the fifth ring
05_height = 20;  // [0:300]
// extend beyond radius of fifth sticks
05_extend = 2;  //[0:100]
//how skewed (rotated) fifth ring is in degrees
05_skew = -27;    //[-170:170]

// radius of the sixth ring (0 for no ring)
06_radius = 0; // [0:200]
// height if the sixth ring
06_height = 40;  // [0:300]
// extend beyond radius of sixth sticks
06_extend = 5;  //[0:100]
//how skewed (rotated) sixth ring is in degrees
06_skew = 90;    //[-170:170]

// radius of the 7th ring (0 for no ring)
07_radius = 0; // [0:200]
// height if the 7th ring
07_height = 40;  // [0:300]
// extend beyond radius of 7th sticks
07_extend = 5;  //[0:100]
//how skewed (rotated) 7th ring is in degrees
07_skew = 90;    //[-170:170]

// radius of the 8th ring (0 for no ring)
08_radius = 0; // [0:200]
// height if the 8th ring
08_height = 40;  // [0:300]
// extend beyond radius of 8th sticks
08_extend = 5;  //[0:100]
//how skewed (rotated) 8th ring is in degrees
08_skew = 90;    //[-170:170]

// radius of the 9th ring (0 for no ring)
09_radius = 0; // [0:200]
// height if the 9th ring
09_height = 40;  // [0:300]
// extend beyond radius of 9th sticks
09_extend = 5;  //[0:100]
//how skewed (rotated) 9th ring is in degrees
09_skew = 90;    //[-170:170]

// radius of the 10th ring (0 for no ring)
10_radius = 0; // [0:200]
// height if the 10th ring
10_height = 40;  // [0:300]
// extend beyond radius of 10th sticks
10_extend = 5;  //[0:100]
//how skewed (rotated) 10th ring is in degrees
10_skew = 90;    //[-170:170]

// radius of the 11th ring (0 for no ring)
11_radius = 0; // [0:200]
// height if the 11th ring
11_height = 40;  // [0:300]
// extend beyond radius of 11th sticks
11_extend = 5;  //[0:100]
//how skewed (rotated) 11th ring is in degrees
11_skew = 90;    //[-170:170]

// radius of the 12th ring (0 for no ring)
12_radius = 0; // [0:200]
// height if the 12th ring
12_height = 40;  // [0:300]
// extend beyond radius of 12th sticks
12_extend = 5;  //[0:100]
//how skewed (rotated) 12th ring is in degrees
12_skew = 90;    //[-170:170]

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

module ring(ringnr, curpart){
if (curpart == "both" || (dual_pat == "ring" && curpart == "first" && ringnr%2 == 0) 
   ||  (dual_pat == "ring" && curpart == "second" && ringnr%2 == 1) 
   ||  (dual_pat == "even_odd"))
{
  union() {
    for (i = [0:nrsticks]) {
     if (curpart == "both" || dual_pat == "ring" || 
         (dual_pat == "even_odd" && curpart == "first" && i%2 == 0) ||
         (dual_pat == "even_odd" && curpart == "second" && i%2 == 1)
        ) {
      rotate([0,0,i*grad_per_stick]) {
        if (ringnr == 1) {
          ringbaseform(r0, 0, 0, 01_radius, 01_height, 
                       01_skew,  01_extend);}
        if (ringnr == 2){
          ringbaseform(01_radius, 01_height, 01_skew,
                       02_radius, 02_height, 02_skew,  
							  02_extend);}
        if (ringnr == 3)
          ringbaseform(02_radius, 02_height, 
                       01_skew + 02_skew,  
                       03_radius, 03_height, 03_skew,
							  03_extend);
        if (ringnr == 4)
          ringbaseform(03_radius, 03_height,
							  01_skew + 02_skew + 03_skew,  
                       04_radius, 04_height, 04_skew,
							  04_extend);
        if (ringnr == 5)
          ringbaseform(04_radius, 04_height,
  01_skew + 02_skew + 03_skew + 04_skew,  
                       05_radius, 05_height, 05_skew,
							  05_extend);
        if (ringnr == 6)
          ringbaseform(05_radius, 05_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew,  
                       06_radius, 06_height, 06_skew,
							  06_extend);
        if (ringnr == 7)
          ringbaseform(06_radius, 06_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew,  
                       07_radius, 07_height, 07_skew,
							  07_extend);
        if (ringnr == 8)
          ringbaseform(07_radius, 07_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew + 07_skew,  
                       08_radius, 08_height, 08_skew,
							  08_extend);
        if (ringnr == 9)
          ringbaseform(08_radius, 08_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew + 07_skew + 08_skew,  
                       09_radius, 09_height, 09_skew,
							  09_extend);
        if (ringnr == 10)
          ringbaseform(09_radius, 09_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew + 07_skew + 08_skew + 09_skew,  
                       10_radius, 10_height, 10_skew,
							  10_extend);
        if (ringnr == 11)
          ringbaseform(10_radius, 10_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew + 07_skew + 08_skew + 09_skew + 10_skew,  
                       11_radius, 11_height, 11_skew,
							  11_extend);
        if (ringnr == 12)
          ringbaseform(11_radius, 11_height, 
  01_skew + 02_skew + 03_skew + 04_skew + 05_skew + 06_skew + 07_skew + 08_skew + 09_skew + 10_skew + 11_skew,  
                       12_radius, 12_height, 12_skew,
							  12_extend);
       }
      }
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

module bowl(curpart){
union() {
  if (curpart == "both" || curpart == "first") {
    bottom();
    }
  ring(1, curpart);
  if (02_radius > 0) {
    ring(2, curpart);}
  if (03_radius > 0) {
    ring(3, curpart);}
  if (04_radius > 0) {
    ring(4, curpart);}
  if (05_radius > 0) {
    ring(5, curpart);}
  if (06_radius > 0) {
    ring(6, curpart);}
  if (07_radius > 0) {
    ring(7, curpart);}
  if (08_radius > 0) {
    ring(8, curpart);}
  if (09_radius > 0) {
    ring(9, curpart);}
  if (10_radius > 0) {
    ring(10, curpart);}
  if (11_radius > 0) {
    ring(11, curpart);}
  if (12_radius > 0) {
    ring(12, curpart);}
}
}

intersection(){
  translate([0,0,-bottomstart]) {
    if (part == "bothorig") {
      if (showcolor == "no") {
        bowl(part); 
        } else {
        color("DarkSalmon")
        difference() {
          bowl("second");
          bowl("first");
          }
        color("Orange")
        bowl("first");
        }
      } 
    if (part == "both") {
      if (showcolor == "no") {
        //bowl(both);
          scale([scalefirst,scalefirst,scalefirst]) bowl("first");
          bowl("second");
        } else {
        color("DarkSalmon")
        difference() {
          bowl("second");
          scale([scalefirst,scalefirst,scalefirst]) bowl("first");
          }
        color("Orange")
        scale([scalefirst,scalefirst,scalefirst]) bowl("first");
        }
      }
    if (part == "first") {
      color("Orange")
      scale([scalefirst,scalefirst,scalefirst]) bowl(part);
      } 
    if (part == "second") {
      color("DarkSalmon")
      difference() {
        bowl("second");
        render()
        scale([scalefirst,scalefirst,scalefirst]) bowl("first");
        }
      }
    }
  translate([-max_width/2,-max_width/2,0]) 
    cube(size=[max_width,max_width,max_height]);
}



