// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Length=143;
// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Width=74;
// Depending on your printer, you should add an extra 1 to 2 mm.
Phone_Thickness = 10;

// Diameter of the bar where the holder is to be mounted.
Handle_Bar_Diameter = 36;
// Distance from the handle bar to the back of the phone. A smaller number will give a lower profile.
Holder_Height = 17; // [11:17]
// Offset from the center on the vertical part
Vertical_Offset = -15;

/* [Hidden] */
$fs = 1;

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
 union(){
  translate([23,Phone_Length/2+2.5,0]) cylinder(r=2.5,h=5);
  translate([18.5,Phone_Length/2,0]) cube([4.5,5,5]);
  copy_mirror([0,1,0]) rounded_corner([18.5,Phone_Length/2-1.5,0]);
  translate([12,-Phone_Length/2+1.5,0]) cube([5,Phone_Length-3,5]);
  translate([18.5,-Phone_Length/2-5,0]) cube([Phone_Thickness-1.5,5,5]);
  translate([17+Phone_Thickness,-Phone_Length/2-2.5,0]) cylinder(r=2.5,h=5);
  linear_extrude(height=5) polygon([[12,-39+Vertical_Offset],[12,39+Vertical_Offset],[10.3923,33+Vertical_Offset],[0,15+Vertical_Offset],[0,-15+Vertical_Offset],[10.3923,-33+Vertical_Offset]]);
 };
 translate([0, Vertical_Offset, 0]) copy_mirror([0,1,0]) translate([0,39,0]) cylinder(r=12,h=5);
 translate([0, Vertical_Offset, 0]) copy_mirror([0,1,0]) translate([9,12.5,0]) cube([5,10,5]);
 translate([17-Holder_Height,-5.5/2 + Vertical_Offset,0]) cube([Holder_Height/2+0.2,5.5,5]);
 translate([-Holder_Height,-30,0]) cube([17,60,5]);
};

// Horizontal Piece
//translate([0,2.5,0]) rotate([90,0,0]) copy_mirror([1,0,0]) difference(){
translate([-30,Vertical_Offset,0]) rotate([0,0,-90]) copy_mirror([1,0,0]) difference(){
 union(){
  linear_extrude(height=5) polygon([[0,-3],[10,-3],[14.6768,10.0145],[17.5,12],[Phone_Width/2-1.5,12],[Phone_Width/2-1.5,17],[0,17]]);
  rounded_corner([Phone_Width/2-1.5,18.5,0],180);
  translate([Phone_Width/2,18.5,0]) cube([5,Phone_Thickness-3,5]);
  rounded_corner([Phone_Width/2-1.5,17+Phone_Thickness-1.5,0],-90);
  translate([Phone_Width/2-1.5,17+Phone_Thickness+1.5,0]) cylinder(r=1.5,h=5);
  translate([Phone_Width/2-1.5,17+Phone_Thickness+5-1.5,0]) cylinder(r=1.5,h=5);
  translate([Phone_Width/2-3,17+Phone_Thickness+1.5,0]) cube([1.5,2,5]);
  translate([5.5/2,17,5/2]) rotate([90,0,0]) linear_extrude(height=20) polygon([[0,0],[5,0],[0,5]]);
 };
 translate([17.5,9,0]) cylinder(r=3,h=5);
 translate([0,-Handle_Bar_Diameter/2-Holder_Height+17,0]) cylinder(r=Handle_Bar_Diameter/2,h=10);
 translate([-5.5/2,17-(Holder_Height/2+0.2),0]) cube([5.5,Holder_Height/2+0.2,5]);
};
