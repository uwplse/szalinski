/* Crock Pot Knob Customizer version 1, by cpayne3d January 7, 2019 [prev ver Dec 25, 2016]  Creative commons - Non Commercial - share alike license. */

// preview[view:south, tilt:top]

/* [Knob Base Settings] */
// - Outer Diameter of knob base(def=30)
Outer_D = 30; //[15:100]    
outer_rad = Outer_D /2;

// - Height of knob base(def=9)
Outer_h = 9;  //[5:30]         

/* [Knob Finger Hold Settings] */
// - Diam of the finger hold(def=10)
Top_Part_Diam = 10; //[3:15]       
top_part_rad = Top_Part_Diam /2;

// - Height of the Finger Hold(def=10)
Top_Part_H = 10; //[4:20]       

// - Diam of Knob Dot(def=4)
Dot_Diam = 4; //[2:8]
dot_rad = Dot_Diam /2;

/* [Rotary D_Stem Settings] */
// - View Rotary Stem, *disable before exporting*
Preview_D_Stem = "second"; // [first:Preview,second:No Preview]

// - Raise Preview of D_Stem marker(def=0)
D_marker_H_offset = 0; //[0:5]

// - Degree of Rotation of Stem post(def=0)
Stem_Rotate = 0; //[0:270]     

// - Height of D_Stem Post(def=10)
D_Stem_Len = 10;  //[5:40]  

/* [Hidden] */
// - Diameter of the D-stem
d_stem_d = 6.8  /2;  
D_stem_preview_height = 4;

// - Offset of keyway cut
keyway_x_offset = d_stem_d /2;  



difference() {
union() {    // create the knob base, then chamfer the top edge
difference() {   
  cylinder(h=Outer_h, r=outer_rad*2, $fn=100);   // knob base cylinder

// difference a chamfer on edge of base
translate([0, 0, Outer_h - 0.5]) for (n=[0:40])
 rotate([0, 0, n * 15])
    {
        translate([outer_rad *2 , 0, 0])
        scale([1.2, 1.25, 1]) rotate([0, -30, 180]) cylinder(h=2, r=outer_rad*2 /3, $fn=3);
    } 
} // end local difference for the chamfer on the knob base


// Create the finger hold on top of the knob.
minkowski() {
 hull() {  // hull together two cylinders to make the top finger hold
  translate([-(outer_rad*2 - top_part_rad*2 *1.5), 0, Outer_h])  // top part x-- side
    cylinder(h=Top_Part_H, r=top_part_rad*2, $fn=100);   // knob top cylinder

  translate([(outer_rad*2 - top_part_rad*2 *1.5), 0, Outer_h])  // top part x++ side
    cylinder(h=Top_Part_H, r=top_part_rad*2, $fn=100);   // knob top cylinder
  }  // end hull
  
rotate([0, 90, 0]) cylinder(h=1, r=1, $fn=30); // the cylinder for minkowski function
} // end minkowski

/////////////////////////////////////////
// PREVIEW D_Stem direction marker
 if (Preview_D_Stem == "first") {
 difference() {
translate([0, 0, Outer_h + Top_Part_H + D_marker_H_offset -2]) rotate(Stem_Rotate) scale(1.25) show_d_stem(D_stem_preview_height); 
  
translate([0, 0, Outer_h + Top_Part_H + D_marker_H_offset -1])  rotate(Stem_Rotate)  show_d_stem(D_stem_preview_height); 
 } // end diff
} // end - if

} // end primary union



//////////////////////////////////
// The difference section
union() {  

// add D stem
// Rotate the D shape insert...
 rotate(Stem_Rotate) union() {  
    show_d_stem(D_Stem_Len); 
 } // end rotate union

// hollow out the underside of knob with triangles. Keeps the knob cool as the crock pot radiates heat.
translate([0, 0, -0.25]) for (n=[0:12])
 rotate([0, 0, n * 60])
    {
        translate([outer_rad*2 / 1.7 + 2, 0, 0])
          scale([1.2, 1.25, 1]) rotate([0, 0, 180]) cylinder(h=Outer_h - 2, r=outer_rad*2 /4, $fn=3);
          // scale([1.2, 1.25, 1]) rotate([0, 0, 180]) cylinder(h=outer_h - 2, r=4, $fn=3); // original
    } 
        
    
// DOT marker in knob top part
translate([(outer_rad*2 - Top_Part_Diam) - (dot_rad), 0, Outer_h + Top_Part_H]) cylinder(h= 2, r=dot_rad, $fn=30);
 
} // end diff union
} // end difference function


// create D stem
module show_d_stem(d_height) {
difference() {  // create the "D" shape hole in the knob base  
  translate([0, 0, -0.25]) cylinder(h=d_height, r=d_stem_d, $fn=50); // d_stem 

  translate([keyway_x_offset, -d_stem_d, -0.5]) cube([d_stem_d *2, d_stem_d *2, d_height +0.5]);   // trim off flat side of key way of the stem
     } // end local difference

 }  // end module - show D stem