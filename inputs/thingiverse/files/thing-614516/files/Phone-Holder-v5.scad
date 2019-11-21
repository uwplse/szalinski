// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Length=145;
// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Width=72;
// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Thickness = 8.3;
// Offset the phone vertically. This is useful if your phone have side buttons at the middle that is blocked by the side grip. A positive value will shift the phone upwards, while a negative value shifts it downwards.
Vertical_Offset = 0;
// Allow you to attach two vertical pieces instead of one. This can be useful if you want to charge your phone while it's in the holder. This option is affected by the Swap_Catches option.
Dual_Vertical = 0; // [1:True, 0:False]
// Trade off between improved grip and ease of insertion/removal. Increasing this number will increase height of the top catch, improving grip but making it harder to remove the phone. The default should be fine for most cases.
Grip = 0;
// Swap the vertical and horizontal catches. Use this if you need to mount the holder on a horizontal bar. This option will affect which part is considered the vertical piece for the Dual_Vertical option.
Swap_Catches = 0; // [1:True, 0:False]

// Diameter of the bar where the holder is to be mounted.
Handle_Bar_Diameter = 35;
// Distance from the handle bar to the back of the phone. A smaller number will give a lower profile.
Holder_Height = 17; // [11:20]



/* [Hidden] */
$fs = 0.5;
$fa = 6;

module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

module rounded_corner(vec=[0,0,0],rot=0) {
 translate(vec) rotate([0,0,rot]) difference(){
  intersection(){
   cylinder(r=6.5,h=5);
   translate([-6.5,0,0]) cube([6.5,6.5,5]);
  };
  cylinder(r=1.5,h=5);
 };
};

// Vertical Piece
//translate([2.5,0,0]) rotate([0,-90,0]) difference(){
difference(){
 union() {
  translate ([0,Vertical_Offset,0]) union(){
   copy_mirror([0,1,0]) rounded_corner([18.5,Phone_Length/2-1.5,0]);
   translate([12,-Phone_Length/2+1.5,0]) cube([5,Phone_Length-3,5]);
   if (Swap_Catches == 0) {
    translate([18.5,Phone_Length/2,0]) cube([Phone_Thickness/2+Grip,5,5]);
    translate([18.5+Phone_Thickness/2+Grip,Phone_Length/2+2.5,0]) cylinder(r=2.5,h=5);
    translate([18.5,-Phone_Length/2-5,0]) cube([Phone_Thickness/2+1,5,5]);
    translate([19.5+Phone_Thickness/2,-Phone_Length/2-2.5,0]) cylinder(r=2.5,h=5);
   } else {
    copy_mirror([0,1,0]) {
     translate([18.5,Phone_Length/2,0]) cube([Phone_Thickness-3,5,5]);
     rounded_corner([17+Phone_Thickness-1.5,Phone_Length/2-1.5,0],-90);
     translate([17+Phone_Thickness+1.5,Phone_Length/2-1.5,0]) cylinder(r=1.5,h=5);
     translate([17+Phone_Thickness+5-1.5,Phone_Length/2-1.5,0]) cylinder(r=1.5,h=5);
     translate([17+Phone_Thickness+1.5,Phone_Length/2-3,0]) cube([1.5,2,5]);
    }
   }
  };
  linear_extrude(height=5) polygon([[12,-39],[12,39],[10.3923,33],[0,15],[0,-15],[10.3923,-33]]);
 };
 copy_mirror([0,1,0]) translate([0,39,0]) cylinder(r=12,h=5);
 if (Dual_Vertical == 1 && Swap_Catches == 1) {
    copy_mirror([0,1,0]) translate([9,14.5,0]) cube([5,10,5]);
    copy_mirror([0,1,0]) translate([17-Holder_Height,-5.5/2+8,0]) cube([Holder_Height/2+0.2,5.5,5]);
 } else {
    copy_mirror([0,1,0]) translate([9,12.5,0]) cube([5,10,5]);
    translate([17-Holder_Height,-5.5/2,0]) cube([Holder_Height/2+0.2,5.5,5]);
 }
 translate([-Holder_Height,-30,0]) cube([17,60,5]);
};

// Horizontal Piece
//translate([0,2.5,0]) rotate([90,0,0]) copy_mirror([1,0,0]) difference(){
translate([-20 - Phone_Thickness,0,0]) rotate([0,0,-90]) difference(){
 union(){
  copy_mirror([1,0,0]) {
   linear_extrude(height=5) polygon([[0,-3],[10,-3],[18.84,10.4],[21.5,12],[Phone_Width/2-1.5,12],[Phone_Width/2-1.5,17],[0,17]]);
   rounded_corner([Phone_Width/2-1.5,18.5,0],180);
  }
  if (Swap_Catches == 0) {
   copy_mirror([1,0,0]) {
    translate([Phone_Width/2,18.5,0]) cube([5,Phone_Thickness-3,5]);
    rounded_corner([Phone_Width/2-1.5,17+Phone_Thickness-1.5,0],-90);
    translate([Phone_Width/2-1.5,17+Phone_Thickness+1.5,0]) cylinder(r=1.5,h=5);
    translate([Phone_Width/2-1.5,17+Phone_Thickness+5-1.5,0]) cylinder(r=1.5,h=5);
    translate([Phone_Width/2-3,17+Phone_Thickness+1.5,0]) cube([1.5,2,5]);
   }
  } else {
    translate([Phone_Width/2,18.5,0]) cube([5,Phone_Thickness/2+Grip,5]);
    translate([Phone_Width/2+2.5,18.5+Phone_Thickness/2+Grip,0]) cylinder(r=2.5,h=5);
    translate([-Phone_Width/2-5,18.5,0]) cube([5,Phone_Thickness/2+1,5]);
    translate([-Phone_Width/2-2.5,19.5+Phone_Thickness/2,0]) cylinder(r=2.5,h=5);
  }
 }
 copy_mirror([1,0,0]) {
  translate([21.5,9,0]) cylinder(r=3,h=5);
  translate([0,-Handle_Bar_Diameter/2-Holder_Height+17,0]) cylinder(r=Handle_Bar_Diameter/2,h=10);
  if (Dual_Vertical == 1 && Swap_Catches == 0) {
    translate([-5.5/2+8,17-(Holder_Height/2+0.2),0]) cube([5.5,Holder_Height/2+0.2,5]);
  } else {
    translate([-5.5/2,17-(Holder_Height/2+0.2),0]) cube([5.5,Holder_Height/2+0.2,5]);
  }
 }
};
