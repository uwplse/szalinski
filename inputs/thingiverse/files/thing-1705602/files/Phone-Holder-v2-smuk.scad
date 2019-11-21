// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Length=128;

// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Width=63;

// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Thickness = 11.4;

// Offset the phone vertically. This is useful if your phone have side buttons at the middle that is blocked by the side grip. A positive value will shift the phone upwards, while a negative value shifts it downwards.
Vertical_Offset = 15;

// Allow you to attach two vertical pieces instead of one. This can be useful if you want to charge your phone while it's in the holder.
Dual_Vertical = 10; // [0:10]

// Trade off between improved grip and ease of insertion/removal. Increasing this number will increase height of the top catch, improving grip but making it harder to remove the phone. The default should be fine for most cases.
Grip = -3; // [-10:10]

// Diameter of the bar where the holder is to be mounted.
Handle_Bar_Diameter = 32;
// Distance from the handle bar to the back of the phone. A smaller number will give a lower profile.
Holder_Height = 15; // [11:20]

// Fatness of Handlebarholder
Holder_Fat = 15; // [5:15]

// Scale. Have to scale for ABS shrinking
scaleing = 1.013;


/* [Hidden] */
$fs = 0.5;
$fa = 6;

scale([scaleing,scaleing,scaleing]) {
 translate([0,0,0])   Vertical_Piece();
    if(Dual_Vertical > 0) {
 translate([35+Holder_Height+Phone_Thickness,0,0])  mirror([1,0,0]) Vertical_Piece();
    }
translate([-30,0,0])    Horizontal_Piece();
}




module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

module rounded_corner(vec=[0,0,0],rot=0,h=5) {
 translate(vec) rotate([0,0,rot]) difference(){
  intersection(){
   cylinder(r=6.5,h=h);
   translate([-6.5,0,0]) cube([6.5,6.5,h]);
  };
  translate([0,0,-1]) cylinder(r=1.5,h=h+2);
 };
};



module Vertical_Piece() {
// Vertical Piece
//translate([2.5,0,0]) rotate([0,-90,0]) difference(){
difference(){
 union() {
  translate ([0,Vertical_Offset,0]) union(){
   translate([18.5,Phone_Length/2,0]) cube([Phone_Thickness/2+Grip,5,5]);
   translate([18.5+Phone_Thickness/2+Grip,Phone_Length/2+2.5,0]) cylinder(r=2.5,h=5);
   copy_mirror([0,1,0]) rounded_corner([18.5,Phone_Length/2-1.5,0]);
   translate([12,-Phone_Length/2+1.5,0]) cube([5,Phone_Length-3,5]);
   translate([18.5,-Phone_Length/2-5,0]) cube([Phone_Thickness/2+1,5,5]);
   translate([19.5+Phone_Thickness/2,-Phone_Length/2-2.5,0]) cylinder(r=2.5,h=5);
//   translate([18.5,-Phone_Length/2-5,0]) cube([Phone_Thickness-1.5,5,5]);
//   translate([17+Phone_Thickness,-Phone_Length/2-2.5,0]) cylinder(r=2.5,h=5);
  };
  linear_extrude(height=5) polygon([[12,-39],[12,39],[10.3923,33],[-10,10],[-10,-10],[10.3923,-33]]);
 }
 copy_mirror([0,1,0]) translate([0,39,-1]) cylinder(r=12,h=5+2);
 copy_mirror([0,1,0]) translate([9,12.5,-1]) cube([5,10,5+2]);
 translate([17-Holder_Height-15,-(Holder_Fat+0.5)/2,-1]) cube([Holder_Height/2+0.2+15,Holder_Fat+0.5,5+2]);
 //%translate([-Holder_Height,-30,-1]) cube([17,60,5+2]);

 translate([17-Holder_Height-Handle_Bar_Diameter/2,-30,5/2+Dual_Vertical]) rotate([-90,0,0]) cylinder(r=Handle_Bar_Diameter/2,h=60);
}

}


module Horizontal_Piece() {
// Horizontal Piece
//translate([0,2.5,0]) rotate([90,0,0]) copy_mirror([1,0,0]) difference(){
 rotate([0,0,-90]) copy_mirror([1,0,0]) difference(){
 union(){
//  linear_extrude(height=5) polygon([[0,-3],[10,-3],[14.6768,10.0145],[17.5,12],[Phone_Width/2-1.5,12],[Phone_Width/2-1.5,17],[0,17]]);
  linear_extrude(height=Holder_Fat) polygon([[0,-3],[10,-3],[18.84,10.4],[21.5,12],[Phone_Width/2-1.5,12],[Phone_Width/2-1.5,17],[0,17]]);
  rounded_corner([Phone_Width/2-1.5,18.5,0],180,h=Holder_Fat);
  translate([Phone_Width/2,18.5,0]) cube([5,Phone_Thickness-3,Holder_Fat]);
  rounded_corner([Phone_Width/2-1.5,17+Phone_Thickness-1.5,0],-90,h=Holder_Fat);
  translate([Phone_Width/2-1.5,17+Phone_Thickness+1.5,0]) cylinder(r=1.5,h=Holder_Fat);
  translate([Phone_Width/2-1.5,17+Phone_Thickness+5-1.5,0]) cylinder(r=1.5,h=Holder_Fat);
  translate([Phone_Width/2-3,17+Phone_Thickness+1.5,0]) cube([1.5,2,Holder_Fat]);
//  translate([5.5/2,17,5/2]) rotate([90,0,0]) linear_extrude(height=20) polygon([[0,0],[5,0],[0,5]]);
 };
 translate([21.5,9,-1]) cylinder(r=3,h=Holder_Fat+2);
 translate([0,-Handle_Bar_Diameter/2-Holder_Height+17,-1]) cylinder(r=Handle_Bar_Diameter/2,h=Holder_Fat+2);
 
 translate([-5.5/2+Dual_Vertical,17-(Holder_Height/2+0.2),-1]) cube([5.5,Holder_Height/2+0.2+1,Holder_Fat+2]); // The poorly named Dual_Vertical contains the horizontal offset for the slot.
};
}