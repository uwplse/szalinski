// bearing model : 693zz (3x8x4)  or 623zz (3x10x4)
bearing = "693zz"; // ["693zz", "623zz"]
// play with this value to trim the radius of the rod (negative value = reduce the radius)
trim = -0.05; //[-0.15,-0.1, -0.05, 0, 0.05, 0.1]
// which thing ? top or bottom ?
part = "top"; // ["bottom", "top"]
// do you want intermediate nuts ?
nuts = "no" ; //["yes","no"]


/* [Hidden] */
$fn = 100;
diam_vis = 3.1;
epsilon = 0.1;


// perform a test and assign a variable (if statement does not work ...)
bearing_radius =   ((bearing == "693zz") ? 4 : 5) +trim ;






module 693ZZ() {
    union () {
        #cylinder (d=9, h = 4,center = true);
   difference() { translate ([10-4.5,0,0] )  cube([22,2*bearing_radius+1,5.5], center = true);
       
       translate  ([0,0,2.55])cylinder(d=5, h = 1, center = true);
       translate  ([0,0,-2.55])cylinder(d=5, h = 1, center = true);
   }    // end diff
   } // end union
       
       # cylinder (d=3, h = 19, center = true);
    }


module top_bearings() {
  rotate ([90,0,120]) translate  ([4+bearing_radius,0,0])  693ZZ();

rotate ([90,0,-120]) translate  ([4+bearing_radius,0,0])  693ZZ();
    
    *rotate ([90,0,0]) translate  ([4+bearing_radius,0,0])  693ZZ();

    }
    
    module bottom_bearing() {
  *rotate ([90,0,120]) translate  ([4+bearing_radius,0,0])  693ZZ();

*rotate ([90,0,-120]) translate  ([4+bearing_radius,0,0])  693ZZ();
    
    rotate ([90,0,0]) translate  ([4+bearing_radius,0,0])  693ZZ();

    }
    
module four_screws(diam, faces) {
    translate  ([0,12,9]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);
 translate  ([0,12,-9]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);
 translate  ([0,-12,9]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);translate  ([0,-12,-9]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);
}
 
module top(){
difference(){
rotate ([0,0,-90])cube ([32,22,29],center = true);
 top_bearings();

 four_screws(diam_vis, 100);
 if (nuts == "yes") translate  ([14.5,0,0])   four_screws(6.1, 6);

cylinder (d=9, h = 50,center = true);
    
  translate([12,0,0])  cube ([20,50,50],center = true);
  translate([10,0,0])  cube ([20,9,50],center = true);
}
}
module bottom (){
difference(){
rotate ([0,0,-90])cube ([32,23,29],center = true);
 bottom_bearing();

 four_screws(diam_vis, 100);

cylinder (d=9, h = 50,center = true);
    
  translate([-8+epsilon,0,0])  cube ([20,50,50],center = true);
    translate([11,12,0])  cube ([10,10,50],center = true);
    translate([11,-12,0])  cube ([10,10,50],center = true);
}
}


if (part == "top") { rotate([0,-90,0])top();}
else {rotate([0,-90,0])bottom();}

