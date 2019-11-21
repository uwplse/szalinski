// Svarta (tm) bunk bed replacement feet 
// dmt June 2016
//https://www.thingiverse.com/thing:2884738

/* [Pad] */
// height of pad
t_cap = 5;
// radius of pad 
r_cap = 19; //[15:0.1:35]

/* [Body] */

// height of shaft
t_shaft = 22; // [1:0.5:33]

// radius of shaft
r_shaft = 15; //[15:0.1:25]
shaft_inset = 1.5; //[.5:0.01:25]


/* [Flange] */
// additional radius of flange ( 0 for no flange)
additional_r_flange = 3.75; //[0:0.05:7]
// height each flange
t_flange = 3; //[1:0.1:10]
//  flange distance from opening
x_flange = 6; // [2:0.5:16] 
// number of flanges
n_flange = 3; //[2,3,4,5,6,7,8]

/* [Extra] */
// radius of cut through center (0 for no cut)
r_cut = 7; // [0:0.1:7]
// number of faces
$fn=66; // [22:1:88]
r_flange = r_shaft + additional_r_flange;


/* [Hidden] */
l_cut = max(r_shaft,r_flange)*2;
fix = 0.01;
ri_shaft = r_shaft - shaft_inset;


difference(){
  union(){
    cylinder(h=t_cap, r=r_cap);
    translate([0,0,t_cap]){
      difference(){
        union(){
          cylinder(h=t_shaft, r=r_shaft);
          for(move= [1:n_flange]){
            translate([0,0,move*((t_shaft-x_flange)/n_flange)-t_flange/2]){
              cylinder(r1=r_flange, r2= r_shaft,h=t_flange);
            }
          }
        } //end union 2 
        cylinder(h=fix+t_shaft, r=ri_shaft); 
     } // end difference 2
   } 
  } // end union 1
  translate([0,l_cut/2,t_shaft*5/6])rotate([90,0,0])cylinder(r=r_cut,h=l_cut);
}  //end difference 1