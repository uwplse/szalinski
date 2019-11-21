cone_height = 21;
rim_height = 21;
rim_radius = 21;
dome_radius = 9;
thickness = 2;
cone_height = 14;
handle_height = 1.75;
handle_width = 9;
handle_length = 130;
handle_radius = 1.2;
hole = "yes"; // [yes,no]
hole_radius = 3.95;
cup_resolution = 90;
bullnose_resolution = 12; // [8:14]
         /* applies to minkowski input only.  
            anything above 16 chokes openscad.
            customizer engine seems way faster,
            but still can't handle higher numbers.   
            odd numbers bad?  */

  module halfcircle(r) {   // these two modules are to try to speed up the minkowski
    difference() {
      circle(r);
      translate([-r,0])square([r*2,r]);    }  }

  module sphere_alternate(r) {   /* Thanks to Giles Bathgate: 
                  http://forum.openscad.org/Minkowski-sum-slowness-tp929p930.html  */
    rotate_extrude()
      rotate([0,0,90])halfcircle(r);  }

module handle_blank (w,l,h,o) {  // build base handle for bullnosing with minkowski sum
 difference (){
  union () {
   cube ([w,l,h]);
   translate ([w/2,l,0])
    cylinder (r=w/2, h=h);
           }
  if (hole=="yes") {
   translate ([w/2,l,0])
    cylinder (r=o, h=h);  } } }

$fn=bullnose_resolution;

translate ([handle_length/2,0,0])   // position for printing
rotate ([0,0,90])

difference () {
 union () {
  hull() {
   cylinder (r=rim_radius, h=rim_height, $fn=cup_resolution);
   translate ([0,0,rim_height+cone_height])
   sphere (r=dome_radius, $fn=cup_resolution);
         }
  translate ([-handle_width/2, rim_radius-thickness, handle_radius])
   minkowski (){         // still takes forever on local machine.
    handle_blank (handle_width, handle_length, handle_height, hole_radius);
    sphere_alternate (handle_radius);
               }
           }
 hull() {
  cylinder (r=rim_radius-thickness, h=rim_height, $fn=cup_resolution);
  translate ([0,0,rim_height+cone_height])
   sphere (r=dome_radius-thickness, $fn=cup_resolution);
        }
              }
